import 'package:audio_service/audio_service.dart';

import 'web_bridge.dart';

/// Mirrors the web player into the Android media session: notification, lock
/// screen, headset and Bluetooth buttons. The foreground service it runs also
/// keeps the process (and so the WebView) alive while the screen is off.
class WebPlayerAudioHandler extends BaseAudioHandler with SeekHandler {
  WebPlayerAudioHandler(this._bridge) {
    _bridge.state.addListener(_sync);
  }

  final WebBridge _bridge;
  String? _itemKey;

  void _sync() {
    final state = _bridge.state.value;
    if (!state.hasTrack) {
      _itemKey = null;
      if (playbackState.value.processingState != AudioProcessingState.idle) {
        playbackState.add(PlaybackState());
      }
      return;
    }

    final key = [state.title, state.artist, state.artwork, state.durationMs].join('\u0000');
    if (key != _itemKey) {
      _itemKey = key;
      mediaItem.add(
        MediaItem(
          id: key,
          title: state.isAd ? 'Publicité' : state.title,
          artist: state.artist,
          album: state.album,
          artUri: state.artwork.isEmpty ? null : Uri.tryParse(state.artwork),
          duration: state.durationMs == null ? null : state.duration,
        ),
      );
    }

    final next = PlaybackState(
      controls: [
        MediaControl.skipToPrevious,
        state.playing ? MediaControl.pause : MediaControl.play,
        MediaControl.skipToNext,
      ],
      systemActions: {if (state.canSeek) MediaAction.seek},
      androidCompactActionIndices: const [0, 1, 2],
      processingState: AudioProcessingState.ready,
      playing: state.playing,
      updatePosition: state.positionNow(),
    );
    // Android extrapolates the position itself: only push discontinuities,
    // not every report, so the notification isn't rebuilt every second.
    final current = playbackState.value;
    final drift = (current.position - next.updatePosition).inMilliseconds.abs();
    if (current.playing != next.playing ||
        current.processingState != next.processingState ||
        current.systemActions.length != next.systemActions.length ||
        drift > 1500) {
      playbackState.add(next);
    }
  }

  @override
  Future<void> play() async => _bridge.play();

  @override
  Future<void> pause() async => _bridge.pause();

  @override
  Future<void> stop() async {
    await _bridge.pause();
    await super.stop();
  }

  /// Swiping the app away destroys the activity, and the WebView with it:
  /// drop the notification instead of leaving a player that can't play.
  @override
  Future<void> onTaskRemoved() => stop();

  @override
  Future<void> skipToNext() async => _bridge.next();

  @override
  Future<void> skipToPrevious() async => _bridge.previous();

  @override
  Future<void> seek(Duration position) async => _bridge.seek(position);
}
