import 'package:flutter/material.dart';

import 'player_state.dart';
import 'web_bridge.dart';
import 'widgets.dart';

/// Bar above the navigation; tap or drag it up to open the full player.
class MiniPlayer extends StatelessWidget {
  const MiniPlayer({
    super.key,
    required this.bridge,
    required this.state,
    required this.onOpen,
    required this.onDragUpdate,
    required this.onDragEnd,
  });

  final WebBridge bridge;
  final PlayerState state;
  final VoidCallback onOpen;
  final GestureDragUpdateCallback onDragUpdate;
  final GestureDragEndCallback onDragEnd;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    return GestureDetector(
      onTap: onOpen,
      onVerticalDragUpdate: onDragUpdate,
      onVerticalDragEnd: onDragEnd,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
        child: ArtworkColorBuilder(
          url: state.artwork,
          builder: (context, color) => Container(
            height: 60,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Color.lerp(color, Colors.black, 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Artwork(url: state.artwork, decodeWidth: (44 * pixelRatio).round()),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.displayTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            state.artist,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodySmall?.copyWith(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    if (state.canLike)
                      IconButton(
                        onPressed: bridge.toggleLike,
                        icon: state.liked == true
                            ? const Icon(Icons.check_circle_rounded, color: spotifyGreen)
                            : const Icon(Icons.add_circle_outline_rounded),
                      ),
                    IconButton(
                      onPressed: bridge.toggle,
                      iconSize: 32,
                      icon: Icon(state.playing ? Icons.pause_rounded : Icons.play_arrow_rounded),
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
                Positioned(
                  left: 8,
                  right: 8,
                  bottom: 0,
                  height: 2,
                  child: PositionBuilder(
                    state: state,
                    interval: const Duration(milliseconds: 500),
                    builder: (context, position, duration) => LinearProgressIndicator(
                      value: duration.inMilliseconds > 0 ? position.inMilliseconds / duration.inMilliseconds : 0,
                      backgroundColor: Colors.white24,
                      color: Colors.white,
                      minHeight: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
