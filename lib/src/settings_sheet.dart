import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_actions.dart';
import 'player_state.dart';
import 'reinstall_dialog.dart';
import 'updater.dart';
import 'web_bridge.dart';

/// The app's settings, and ways out when one of its screens shows the page
/// badly: the page itself, or a report of it to send.
Future<void> showSettings(BuildContext context, AppActions app) => showModalBottomSheet<void>(
  context: context,
  useRootNavigator: true,
  showDragHandle: true,
  backgroundColor: const Color(0xFF242424),
  builder: (context) => ValueListenableBuilder<PlayerState>(
    valueListenable: app.bridge.state,
    builder: (context, state, _) => SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              secondary: const Icon(Icons.block_rounded),
              title: const Text('Bloquer les pubs'),
              subtitle: const Text("Les pubs sont coupées dès qu'elles démarrent"),
              value: state.adBlock,
              onChanged: app.bridge.setAdBlock,
            ),
            SwitchListTile(
              secondary: const Icon(Icons.web_rounded),
              title: const Text('Interface web'),
              subtitle: const Text("Le site de Spotify tel quel, plutôt que les écrans de l'app"),
              value: state.webUi,
              onChanged: (on) {
                Navigator.of(context).pop();
                if (on) app.content.showWeb();
                app.bridge.setWebUi(on);
              },
            ),
            if (!state.webUi)
              ListTile(
                leading: const Icon(Icons.public_rounded),
                title: const Text('Voir la page web'),
                subtitle: const Text("Pour ce que l'app n'affiche pas"),
                onTap: () {
                  Navigator.of(context).pop();
                  app.openWeb();
                },
              ),
            ListTile(
              leading: const Icon(Icons.fact_check_outlined),
              title: const Text('Diagnostic'),
              subtitle: const Text("Essayer chaque fonction de l'app sur la vraie page"),
              onTap: () {
                Navigator.of(context).pop();
                app.openDiagnostic();
              },
            ),
            ListTile(
              leading: const Icon(Icons.bug_report_outlined),
              title: const Text('Copier le rapport de la page'),
              subtitle: const Text("À envoyer quand un écran s'affiche mal"),
              onTap: () async {
                Navigator.of(context).pop();
                try {
                  final report = await app.content.report();
                  await Clipboard.setData(ClipboardData(text: report));
                  app.notify('Rapport copié dans le presse-papiers');
                } on WebError catch (error) {
                  app.notify(error.message);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.refresh_rounded),
              title: const Text('Recharger la page'),
              onTap: () {
                Navigator.of(context).pop();
                app.bridge.reload();
              },
            ),
            _VersionTile(app: app),
          ],
        ),
      ),
    ),
  ),
);

/// The app's version; a tap looks for a newer one (or installs it).
class _VersionTile extends StatelessWidget {
  const _VersionTile({required this.app});

  final AppActions app;

  Future<void> _onTap(BuildContext context) async {
    final updater = app.updater;
    if (updater.state.value case UpdateAvailable(:final release)) {
      if (updater.installsOver(release)) {
        await updater.install();
      } else {
        await showReinstallHelp(context, updater, release);
      }
      return;
    }
    await updater.check(manual: true);
    switch (updater.state.value) {
      case UpToDate():
        app.notify('Tu as la dernière version');
      case UpdateFailed(:final message):
        app.notify(message);
      case UpdateAvailable(:final release):
        app.notify('Version ${release.name} disponible');
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final updater = app.updater;
    return ValueListenableBuilder<UpdateState>(
      valueListenable: updater.state,
      builder: (context, state, _) => ListTile(
        leading: const Icon(Icons.info_outline_rounded),
        title: Text('Version $appVersionLabel'),
        subtitle: Text(switch (state) {
          _ when !updater.enabled => 'Construite hors de GitHub : pas de mises à jour',
          UpdateChecking() => 'Recherche de mises à jour…',
          UpToDate() => 'À jour',
          UpdateAvailable(:final release) when !updater.installsOver(release) =>
            'Version ${release.name} disponible, à réinstaller : toucher pour savoir comment',
          UpdateAvailable(:final release) => 'Version ${release.name} disponible : toucher pour installer',
          UpdateDownloading(:final release) => 'Téléchargement de la version ${release.name}…',
          UpdateFailed(:final message) => message,
          UpdateIdle() => 'Toucher pour chercher une mise à jour',
        }),
        onTap: updater.enabled && state is! UpdateChecking && state is! UpdateDownloading
            ? () => _onTap(context)
            : null,
      ),
    );
  }
}
