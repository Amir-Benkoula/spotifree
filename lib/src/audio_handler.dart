import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';

import 'web_bridge.dart';

/// Mirrors the web player into the Android media session: notification, lock
/// screen, headset, Bluetooth and car controls. The foreground service it runs
/// also keeps the process (and so the WebView) alive while the screen is off.
class WebPlayerAudioHandler extends BaseAudioHandler with SeekHandler {
  /// [interruptions] and [setAudioActive] come from the audio session, which
  /// holds the audio focus (see [_requestFocus]).
  WebPlayerAudioHandler(
    this._bridge, {
    Stream<AudioInterruptionEvent> interruptions = const Stream.empty(),
    this._setAudioActive,
  }) {
    _bridge.state.addListener(_sync);
    interruptions.listen(_onInterruption);
  }

  /// How long the page may go without a track (between two tracks, reloading…)
  /// before the media session goes: Android 12+ doesn't let the service start
  /// again from the background.
  static const idleDelay = Duration(seconds: 10);

  final WebBridge _bridge;
  final Future<bool> Function(bool active)? _setAudioActive;
  String? _itemKey;
  bool _playing = false;
  bool _resumeAfterInterruption = false;
  Timer? _idleTimer;

  void _sync() {
    final state = _bridge.state.value;
    if (state.playing != _playing) {
      _playing = state.playing;
      if (_playing) {
        _resumeAfterInterruption = false;
        _requestFocus();
      }
    }

    if (!state.hasTrack) {
      if (playbackState.value.processingState != AudioProcessingState.idle) {
        _idleTimer ??= Timer(idleDelay, _goIdle);
      }
      return;
    }
    _idleTimer?.cancel();
    _idleTimer = null;

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

  void _goIdle() {
    _idleTimer = null;
    _itemKey = null;
    playbackState.add(PlaybackState());
    _setAudioActive?.call(false);
  }

  /// GeckoView doesn't take the audio focus by itself: without it, calls and
  /// other players wouldn't pause the music, nor navigation prompts lower it.
  Future<void> _requestFocus() async {
    final setActive = _setAudioActive;
    if (setActive == null) return;
    // Refused (during a call): drop the request, so that the next one asks again.
    if (!await setActive(true)) await setActive(false);
  }

  void _onInterruption(AudioInterruptionEvent event) {
    if (event.begin) {
      // Ducking (a navigation prompt…) is left to Android, which lowers the volume.
      if (event.type == AudioInterruptionType.duck) return;
      // A call or an assistant (pause) ends and the music comes back; another
      // player taking over (unknown) is for good.
      if (event.type == AudioInterruptionType.unknown) _resumeAfterInterruption = false;
      if (!_playing) return;
      _resumeAfterInterruption = event.type == AudioInterruptionType.pause;
      _bridge.pause();
    } else if (event.type == AudioInterruptionType.pause && _resumeAfterInterruption) {
      _resumeAfterInterruption = false;
      _bridge.play();
    }
  }

  @override
  Future<void> play() async => _bridge.play();

  @override
  Future<void> pause() async => _bridge.pause();

  @override
  Future<void> stop() async {
    _idleTimer?.cancel();
    _idleTimer = null;
    await _bridge.pause();
    await _setAudioActive?.call(false);
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
