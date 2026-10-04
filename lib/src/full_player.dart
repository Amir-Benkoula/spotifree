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
                    _Header(album: state.album, onClose: onClose),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 32, offset: Offset(0, 12))],
                            ),
                            child: Artwork(url: state.artwork, radius: 8),
                          ),
                        ),
                      ),
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

class _Header extends StatelessWidget {
  const _Header({required this.album, required this.onClose});

  final String album;
  final VoidCallback onClose;

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
          // Balances the close button so the title stays centered.
          const SizedBox(width: 48),
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
                state.isAd ? 'Publicité' : state.title,
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
