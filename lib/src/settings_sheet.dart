import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_actions.dart';
import 'player_state.dart';
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
          ],
        ),
      ),
    ),
  ),
);
