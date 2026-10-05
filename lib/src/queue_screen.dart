import 'dart:async';

import 'package:flutter/material.dart';

import 'app_actions.dart';
import 'player_state.dart';
import 'tiles.dart';
import 'web_bridge.dart';
import 'web_data.dart';

/// The queue, as the web player's queue panel shows it, kept up to date.
class QueueScreen extends StatefulWidget {
  const QueueScreen({super.key, required this.app});

  final AppActions app;

  @override
  State<QueueScreen> createState() => _QueueScreenState();
}

class _QueueScreenState extends State<QueueScreen> {
  StreamSubscription<QueueData>? _subscription;
  QueueData? _data;
  Object? _error;

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
    _subscription = widget.app.content.queue().listen(
      (data) => setState(() {
        _data = data;
        _error = null;
      }),
      onError: (Object error) => setState(() => _error = error),
    );
  }

  Future<void> _play(QueueTarget target) async {
    try {
      await widget.app.content.playFromQueue(target);
    } on WebError catch (error) {
      if (!error.cancelled) widget.app.notify('Lecture impossible : ${error.message}');
    }
  }

  void _openWeb() {
    Navigator.of(context).pop();
    widget.app.bridge.openQueue();
    widget.app.openWeb(view: 'panel');
  }

  @override
  Widget build(BuildContext context) {
    final data = _data;
    return Scaffold(
      backgroundColor: surfaceColor,
      appBar: AppBar(
        backgroundColor: surfaceColor,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          tooltip: 'Fermer',
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 32),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("File d'attente"),
        actions: [
          PopupMenuButton<void>(
            tooltip: 'Options',
            itemBuilder: (context) => [PopupMenuItem(onTap: _openWeb, child: const Text('Voir la page web'))],
          ),
        ],
      ),
      body: ValueListenableBuilder<PlayerState>(
        valueListenable: widget.app.bridge.state,
        builder: (context, state, _) {
          if (data == null) {
            final error = _error;
            return error == null
                ? const LoadingView()
                : FailureView(error: error, onRetry: () => setState(_listen), onWeb: _openWeb);
          }
          final sections = [
            for (final section in data.sections)
              if (section.tracks.isNotEmpty) section,
          ];
          if (sections.isEmpty) return const Center(child: Text("La file d'attente est vide"));
          return ListView(
            padding: const EdgeInsets.only(bottom: 32),
            children: [
              for (final (s, section) in data.sections.indexed)
                if (section.tracks.isNotEmpty) ...[
                  if (section.title.isNotEmpty) SectionHeader(title: section.title),
                  for (final (i, track) in section.tracks.indexed)
                    TrackTile(
                      track: track,
                      current: track.uri.isNotEmpty && track.uri == state.trackUri && s == 0,
                      onTap: () => _play(QueueTarget(track, section: s, position: i + 1)),
                      onMore: () => widget.app.showMenu(
                        QueueTarget(track, section: s, position: i + 1),
                        header: MenuHeader.track(track),
                      ),
                    ),
                ],
            ],
          );
        },
      ),
    );
  }
}
