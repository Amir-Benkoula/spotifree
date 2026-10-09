import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_actions.dart';
import 'diagnostic.dart';
import 'tiles.dart';
import 'updater.dart';
import 'widgets.dart';

/// Tries each function of the app on the real page and says what works, with a
/// report to send when something doesn't.
class DiagnosticScreen extends StatefulWidget {
  const DiagnosticScreen({super.key, required this.app});

  final AppActions app;

  @override
  State<DiagnosticScreen> createState() => _DiagnosticScreenState();
}

class _DiagnosticScreenState extends State<DiagnosticScreen> {
  late final Diagnostic _diagnostic = Diagnostic(widget.app.content, version: appVersionLabel);

  @override
  void initState() {
    super.initState();
    _diagnostic.run();
  }

  @override
  void dispose() {
    _diagnostic.dispose();
    super.dispose();
  }

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: _diagnostic.report()));
    widget.app.notify('Rapport copié : colle-le dans ton message');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: surfaceColor,
      appBar: AppBar(
        backgroundColor: surfaceColor,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          tooltip: 'Fermer',
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Diagnostic'),
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: _diagnostic.running,
        builder: (context, running, _) => ValueListenableBuilder<List<CheckResult>>(
          valueListenable: _diagnostic.results,
          builder: (context, results, _) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                child: Text(
                  "Chaque fonction de l'app est essayée sur la vraie page Spotify, qui change derrière cet écran. "
                  'Rien ne change dans ton compte. Copie le rapport et envoie-le pour corriger ce qui ne va pas.',
                  style: textTheme.bodySmall?.copyWith(color: Colors.white70),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (final result in results)
                      ListTile(
                        leading: _StatusIcon(status: result.status),
                        title: Text(result.title),
                        subtitle: result.detail.isEmpty
                            ? null
                            : Text(result.detail, style: textTheme.bodySmall?.copyWith(color: Colors.white60)),
                        trailing: result.title == Diagnostic.playbackTitle && !running
                            ? TextButton(onPressed: _diagnostic.testPlayback, child: const Text('Tester'))
                            : null,
                      ),
                  ],
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: running ? null : _diagnostic.run,
                          child: const Text('Relancer'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: running || results.isEmpty ? null : _copy,
                          icon: const Icon(Icons.copy_rounded, size: 18),
                          label: const Text('Copier le rapport'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusIcon extends StatelessWidget {
  const _StatusIcon({required this.status});

  final CheckStatus status;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 24,
      child: switch (status) {
        CheckStatus.running => const Padding(
          padding: EdgeInsets.all(3),
          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white70),
        ),
        CheckStatus.ok => const Icon(Icons.check_circle_rounded, color: spotifyGreen),
        CheckStatus.partial => const Icon(Icons.warning_amber_rounded, color: Colors.amber),
        CheckStatus.failed => const Icon(Icons.cancel_rounded, color: Colors.redAccent),
        CheckStatus.skipped => const Icon(Icons.remove_circle_outline_rounded, color: Colors.white38),
        CheckStatus.waiting => const Icon(Icons.radio_button_unchecked_rounded, color: Colors.white24),
      },
    );
  }
}
