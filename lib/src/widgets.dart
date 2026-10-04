import 'dart:async';

import 'package:flutter/material.dart';

import 'player_state.dart';

const spotifyGreen = Color(0xFF1ED760);

String formatDuration(Duration duration) {
  final minutes = duration.inMinutes;
  final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
  if (minutes < 60) return '$minutes:$seconds';
  return '${minutes ~/ 60}:${(minutes % 60).toString().padLeft(2, '0')}:$seconds';
}

/// Cover art with a neutral placeholder while loading or when missing.
class Artwork extends StatelessWidget {
  const Artwork({super.key, required this.url, this.radius = 4, this.decodeWidth});

  final String url;
  final double radius;

  /// Decode at this width (in physical pixels) for small thumbnails.
  final int? decodeWidth;

  @override
  Widget build(BuildContext context) {
    const placeholder = ColoredBox(
      color: Color(0xFF333333),
      child: Center(child: Icon(Icons.music_note_rounded, color: Colors.white38)),
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: AspectRatio(
        aspectRatio: 1,
        child: url.isEmpty
            ? placeholder
            : Image.network(
                url,
                fit: BoxFit.cover,
                cacheWidth: decodeWidth,
                gaplessPlayback: true,
                errorBuilder: (_, _, _) => placeholder,
              ),
      ),
    );
  }
}

/// Dark, saturated color picked from a cover, to tint the player like Spotify does.
class ArtworkColor {
  static final _cache = <String, Future<Color?>>{};

  static Future<Color?> of(String url) {
    if (url.isEmpty) return Future.value(null);
    if (_cache.length > 64) _cache.clear();
    return _cache.putIfAbsent(url, () async {
      try {
        final scheme = await ColorScheme.fromImageProvider(
          provider: ResizeImage(NetworkImage(url), width: 48, height: 48),
          brightness: Brightness.dark,
        );
        return scheme.primaryContainer;
      } catch (_) {
        return null;
      }
    });
  }
}

/// Rebuilds with the cover's color, animating between tracks.
class ArtworkColorBuilder extends StatefulWidget {
  const ArtworkColorBuilder({super.key, required this.url, required this.builder});

  static const fallback = Color(0xFF3A3A3A);

  final String url;
  final Widget Function(BuildContext context, Color color) builder;

  @override
  State<ArtworkColorBuilder> createState() => _ArtworkColorBuilderState();
}

class _ArtworkColorBuilderState extends State<ArtworkColorBuilder> {
  Color? _color;

  @override
  void initState() {
    super.initState();
    _resolve();
  }

  @override
  void didUpdateWidget(ArtworkColorBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) _resolve();
  }

  void _resolve() {
    final url = widget.url;
    ArtworkColor.of(url).then((color) {
      if (mounted && url == widget.url) setState(() => _color = color);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(end: _color ?? ArtworkColorBuilder.fallback),
      duration: const Duration(milliseconds: 450),
      builder: (context, color, _) => widget.builder(context, color ?? ArtworkColorBuilder.fallback),
    );
  }
}

/// Rebuilds periodically while playing, so progress moves between page reports.
class PositionBuilder extends StatefulWidget {
  const PositionBuilder({
    super.key,
    required this.state,
    required this.builder,
    this.interval = const Duration(milliseconds: 250),
  });

  final PlayerState state;
  final Duration interval;
  final Widget Function(BuildContext context, Duration position, Duration duration) builder;

  @override
  State<PositionBuilder> createState() => _PositionBuilderState();
}

class _PositionBuilderState extends State<PositionBuilder> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _restart();
  }

  @override
  void didUpdateWidget(PositionBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state.playing != widget.state.playing || oldWidget.interval != widget.interval) _restart();
  }

  void _restart() {
    _timer?.cancel();
    _timer = widget.state.playing ? Timer.periodic(widget.interval, (_) => setState(() {})) : null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, widget.state.positionNow(), widget.state.duration);
}

/// Icon that turns green with a dot underneath when active (shuffle, repeat).
class ToggleIcon extends StatelessWidget {
  const ToggleIcon({super.key, required this.icon, required this.active});

  final IconData icon;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: active ? spotifyGreen : null),
        const SizedBox(height: 2),
        Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: active ? spotifyGreen : Colors.transparent,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
