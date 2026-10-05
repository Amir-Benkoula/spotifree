import 'dart:async';

import 'package:flutter/material.dart';

import 'player_state.dart';
import 'web_bridge.dart';
import 'widgets.dart';

/// Native "Now playing" screen, driven by the hidden desktop player bar.
class FullPlayer extends StatelessWidget {
  const FullPlayer({
    super.key,
    required this.bridge,
    required this.onClose,
    required this.onDragUpdate,
    required this.onDragEnd,
  });

  final WebBridge bridge;
  final VoidCallback onClose;
  final GestureDragUpdateCallback onDragUpdate;
  final GestureDragEndCallback onDragEnd;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PlayerState>(
      valueListenable: bridge.state,
      builder: (context, state, _) => GestureDetector(
        onVerticalDragUpdate: onDragUpdate,
        onVerticalDragEnd: onDragEnd,
        child: ArtworkColorBuilder(
          url: state.artwork,
          builder: (context, color) => DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [color, Color.lerp(color, Colors.black, 0.8)!, Colors.black],
                stops: const [0, 0.65, 1],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _Header(album: state.album, adBlock: state.adBlock, onClose: onClose, onAdBlock: bridge.setAdBlock),
                    Expanded(
                      child: _SwipeArtwork(state: state, onNext: bridge.next, onPrevious: bridge.previousTrack),
                    ),
                    _TitleRow(
                      state: state,
                      onLike: bridge.toggleLike,
                      onArtist: () {
                        onClose();
                        bridge.openArtist();
                      },
                    ),
                    const SizedBox(height: 12),
                    _SeekBar(state: state, onSeek: bridge.seek),
                    _Controls(state: state, bridge: bridge),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          tooltip: 'Paroles',
                          icon: const Icon(Icons.lyrics_outlined),
                          onPressed: () {
                            onClose();
                            bridge.openLyrics();
                          },
                        ),
                        IconButton(
                          tooltip: "File d'attente",
                          icon: const Icon(Icons.queue_music_rounded),
                          onPressed: () {
                            onClose();
                            bridge.openQueue();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The cover, swiped sideways to the next track (left) or the previous one
/// (right), like the official app: it follows the finger, leaves the screen
/// and comes back in with the new track.
class _SwipeArtwork extends StatefulWidget {
  const _SwipeArtwork({required this.state, required this.onNext, required this.onPrevious});

  final PlayerState state;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  @override
  State<_SwipeArtwork> createState() => _SwipeArtworkState();
}

class _SwipeArtworkState extends State<_SwipeArtwork> with SingleTickerProviderStateMixin {
  /// Horizontal offset, in widths of the area: off screen past ±1.
  late final AnimationController _offset = AnimationController.unbounded(vsync: this);
  double _width = 1;

  /// While a skip waits for its track: its direction (-1 next, 1 previous) and
  /// the cover it takes away.
  double _skip = 0;
  String _leaving = '';
  bool _returning = false;
  TickerFuture? _out;
  Timer? _giveUp;

  static String _track(PlayerState state) => '${state.title}\n${state.artist}\n${state.artwork}';

  bool _canGo(double direction) => direction < 0 ? widget.state.canNext : widget.state.canPrevious;

  @override
  void didUpdateWidget(_SwipeArtwork oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_skip != 0 && _track(widget.state) != _track(oldWidget.state)) _comeBack();
  }

  @override
  void dispose() {
    _giveUp?.cancel();
    _offset.dispose();
    super.dispose();
  }

  void _drag(DragUpdateDetails details) {
    if (_skip != 0) return;
    var delta = (details.primaryDelta ?? 0) / _width;
    final direction = (_offset.value + delta).sign;
    // Hardly moves where there is nowhere to go.
    if (direction != 0 && !_canGo(direction)) delta *= 0.25;
    _offset.value += delta;
  }

  void _release(DragEndDetails details) {
    if (_skip != 0) return;
    final velocity = details.primaryVelocity ?? 0;
    // Thrown, or dragged far enough.
    final direction = velocity.abs() > 700
        ? velocity.sign
        : _offset.value.abs() > 0.3
        ? _offset.value.sign
        : 0.0;
    if (direction == 0 || !_canGo(direction)) {
      _settle();
      return;
    }
    setState(() {
      _skip = direction;
      _leaving = widget.state.artwork;
    });
    _out = _offset.animateTo(direction * 1.2, duration: const Duration(milliseconds: 180), curve: Curves.easeIn);
    direction < 0 ? widget.onNext() : widget.onPrevious();
    // The new track usually shows up well before; if not, come back as is.
    _giveUp = Timer(const Duration(milliseconds: 1500), _comeBack);
  }

  void _settle() => _offset.animateTo(0, duration: const Duration(milliseconds: 250), curve: Curves.easeOutCubic);

  Future<void> _comeBack() async {
    if (_skip == 0 || _returning) return;
    _returning = true;
    _giveUp?.cancel();
    final direction = _skip;
    // Gone first, and the new cover loaded (or not for long), before it comes in.
    final out = Completer<void>();
    (_out ?? TickerFuture.complete()).whenCompleteOrCancel(out.complete);
    final url = widget.state.artwork;
    await Future.wait([
      out.future,
      if (url.isNotEmpty)
        precacheImage(
          NetworkImage(url),
          context,
          onError: (_, _) {},
        ).timeout(const Duration(milliseconds: 800), onTimeout: () {}),
    ]);
    if (!mounted) return;
    setState(() {
      _skip = 0;
      _returning = false;
    });
    _offset.value = -direction * 1.2;
    _settle();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _width = constraints.maxWidth;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onHorizontalDragUpdate: _drag,
          onHorizontalDragEnd: _release,
          onHorizontalDragCancel: () {
            if (_skip == 0) _settle();
          },
          child: AnimatedBuilder(
            animation: _offset,
            builder: (context, child) => Transform.translate(
              offset: Offset(_offset.value * _width, 0),
              child: Opacity(opacity: (1 - _offset.value.abs() * 0.5).clamp(0.0, 1.0), child: child),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 32, offset: Offset(0, 12))],
                  ),
                  child: Artwork(url: _skip != 0 ? _leaving : widget.state.artwork, radius: 8),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.album, required this.adBlock, required this.onClose, required this.onAdBlock});

  final String album;
  final bool adBlock;
  final VoidCallback onClose;
  final ValueChanged<bool> onAdBlock;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Réduire',
            iconSize: 32,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            onPressed: onClose,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  'EN COURS DE LECTURE',
                  style: textTheme.labelSmall?.copyWith(letterSpacing: 1.2, color: Colors.white70),
                ),
                const SizedBox(height: 2),
                Text(
                  album,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          // Also balances the close button, so the title stays centered.
          PopupMenuButton<void>(
            tooltip: 'Options',
            icon: const Icon(Icons.more_vert_rounded),
            itemBuilder: (context) => [
              CheckedPopupMenuItem(
                checked: adBlock,
                onTap: () => onAdBlock(!adBlock),
                child: const Text('Bloquer les pubs'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TitleRow extends StatelessWidget {
  const _TitleRow({required this.state, required this.onLike, required this.onArtist});

  final PlayerState state;
  final VoidCallback onLike;
  final VoidCallback onArtist;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.displayTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: state.isAd ? null : onArtist,
                child: Text(
                  state.artist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium?.copyWith(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
        if (state.canLike)
          IconButton(
            iconSize: 28,
            onPressed: onLike,
            icon: state.liked == true
                ? const Icon(Icons.check_circle_rounded, color: spotifyGreen)
                : const Icon(Icons.add_circle_outline_rounded),
          ),
      ],
    );
  }
}

class _SeekBar extends StatefulWidget {
  const _SeekBar({required this.state, required this.onSeek});

  final PlayerState state;
  final ValueChanged<Duration> onSeek;

  @override
  State<_SeekBar> createState() => _SeekBarState();
}

class _SeekBarState extends State<_SeekBar> {
  /// Fraction shown while dragging, and briefly after release until the page
  /// reports the new position.
  double? _override;

  void _release(double value) {
    final target = Duration(milliseconds: (value * widget.state.duration.inMilliseconds).round());
    widget.onSeek(target);
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) setState(() => _override = null);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final textTheme = Theme.of(context).textTheme;
    return PositionBuilder(
      state: state,
      builder: (context, position, duration) {
        final total = duration.inMilliseconds;
        final fraction = _override ?? (total > 0 ? (position.inMilliseconds / total).clamp(0.0, 1.0) : 0.0);
        final shown = _override == null ? position : Duration(milliseconds: (fraction * total).round());
        final canSeek = state.canSeek && total > 0 && !state.isAd;
        return Column(
          children: [
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 4,
                activeTrackColor: Colors.white,
                inactiveTrackColor: Colors.white24,
                disabledActiveTrackColor: Colors.white,
                disabledInactiveTrackColor: Colors.white24,
                thumbColor: Colors.white,
                disabledThumbColor: Colors.transparent,
                overlayColor: Colors.white24,
                trackShape: const RoundedRectSliderTrackShape(),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                padding: EdgeInsets.zero,
              ),
              child: SizedBox(
                height: 32,
                child: Slider(
                  value: fraction,
                  onChanged: canSeek ? (value) => setState(() => _override = value) : null,
                  onChangeEnd: canSeek ? _release : null,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatDuration(shown), style: textTheme.bodySmall?.copyWith(color: Colors.white70)),
                Text(formatDuration(duration), style: textTheme.bodySmall?.copyWith(color: Colors.white70)),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _Controls extends StatelessWidget {
  const _Controls({required this.state, required this.bridge});

  final PlayerState state;
  final WebBridge bridge;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          tooltip: 'Lecture aléatoire',
          onPressed: state.canShuffle ? bridge.toggleShuffle : null,
          icon: ToggleIcon(icon: Icons.shuffle_rounded, active: state.shuffle),
        ),
        IconButton(
          tooltip: 'Précédent',
          iconSize: 44,
          onPressed: state.canPrevious ? bridge.previous : null,
          icon: const Icon(Icons.skip_previous_rounded),
        ),
        SizedBox.square(
          dimension: 68,
          child: IconButton.filled(
            tooltip: state.playing ? 'Pause' : 'Lecture',
            style: IconButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
            iconSize: 40,
            onPressed: bridge.toggle,
            icon: Icon(state.playing ? Icons.pause_rounded : Icons.play_arrow_rounded),
          ),
        ),
        IconButton(
          tooltip: 'Suivant',
          iconSize: 44,
          onPressed: state.canNext ? bridge.next : null,
          icon: const Icon(Icons.skip_next_rounded),
        ),
        IconButton(
          tooltip: 'Répéter',
          onPressed: state.canRepeat ? bridge.cycleRepeat : null,
          icon: ToggleIcon(
            icon: state.repeat == RepeatState.one ? Icons.repeat_one_rounded : Icons.repeat_rounded,
            active: state.repeat != RepeatState.off,
          ),
        ),
      ],
    );
  }
}
