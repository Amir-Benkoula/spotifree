import 'dart:async';

import 'package:flutter/material.dart';

import 'app_actions.dart';
import 'player_state.dart';
import 'tiles.dart';
import 'web_data.dart';
import 'widgets.dart';

/// The lyrics of the track playing, from the web player's lyrics view: the
/// line being sung stands out and stays in sight; a tap on a line goes there.
class LyricsScreen extends StatefulWidget {
  const LyricsScreen({super.key, required this.app});

  final AppActions app;

  @override
  State<LyricsScreen> createState() => _LyricsScreenState();
}

class _LyricsScreenState extends State<LyricsScreen> {
  StreamSubscription<LyricsData>? _subscription;
  LyricsData? _data;
  Object? _error;
  List<GlobalKey> _keys = const [];

  /// The lines follow the song: once a line has been sung in this track.
  String _syncedTrack = '';

  @override
  void initState() {
    super.initState();
    _listen();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _listen() {
    _subscription?.cancel();
    _error = null;
    _subscription = widget.app.content.lyrics().listen(
      _onData,
      onError: (Object error) => setState(() => _error = error),
    );
  }

  void _onData(LyricsData data) {
    final previous = _data;
    setState(() {
      if (previous == null || previous.lines.length != data.lines.length || previous.uri != data.uri) {
        _keys = [for (final _ in data.lines) GlobalKey()];
      }
      if (data.active >= 0) _syncedTrack = data.uri;
      _data = data;
      _error = null;
    });
    if (data.active >= 0 && data.active != previous?.active) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _reveal(data.active));
    }
  }

  void _reveal(int line) {
    final context = line < _keys.length ? _keys[line].currentContext : null;
    if (context == null || !mounted) return;
    Scrollable.ensureVisible(
      context,
      alignment: 0.35,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ValueListenableBuilder<PlayerState>(
      valueListenable: widget.app.bridge.state,
      builder: (context, state, _) => ArtworkColorBuilder(
        url: state.artwork,
        builder: (context, color) {
          final background = Color.lerp(color, Colors.black, 0.2)!;
          return Scaffold(
            backgroundColor: background,
            appBar: AppBar(
              backgroundColor: background,
              surfaceTintColor: Colors.transparent,
              leading: IconButton(
                tooltip: 'Fermer',
                icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 32),
                onPressed: () => Navigator.of(context).pop(),
              ),
              centerTitle: true,
              title: Column(
                children: [
                  Text(state.displayTitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: textTheme.titleMedium),
                  Text(
                    state.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  tooltip: state.playing ? 'Pause' : 'Lecture',
                  icon: Icon(state.playing ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded),
                  iconSize: 36,
                  onPressed: widget.app.bridge.toggle,
                ),
              ],
            ),
            body: _body(context, state),
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context, PlayerState state) {
    final data = _data;
    if (data == null) {
      final error = _error;
      return error == null
          ? const LoadingView()
          : FailureView(
              error: error,
              onRetry: () => setState(_listen),
              onWeb: () {
                Navigator.of(context).pop();
                widget.app.bridge.openLyrics();
                widget.app.openWeb(view: 'panel');
              },
            );
    }
    if (data.lines.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            data.message.isNotEmpty ? data.message : 'Pas de paroles pour ce titre',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      );
    }
    final synced = _syncedTrack.isNotEmpty && _syncedTrack == data.uri;
    final style = Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800, height: 1.25);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 240),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (i, line) in data.lines.indexed)
            GestureDetector(
              key: i < _keys.length ? _keys[i] : null,
              behavior: HitTestBehavior.opaque,
              onTap: () => widget.app.content.seekToLyric(i),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  style: style!.copyWith(
                    color: !synced || i <= data.active ? Colors.white : Colors.black.withValues(alpha: 0.55),
                  ),
                  child: Text(line),
                ),
              ),
            ),
          if (data.uri.isNotEmpty && data.uri != state.trackUri)
            const Padding(padding: EdgeInsets.only(top: 24), child: LinearProgressIndicator(minHeight: 2)),
        ],
      ),
    );
  }
}
