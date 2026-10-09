import 'package:flutter/material.dart';

import 'updater.dart';

/// [release] can't update this build (Updater.installsOver): how to install it
/// anew, the app removed first.
Future<void> showReinstallHelp(BuildContext context, Updater updater, Release release) => showDialog<void>(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('Version ${release.name} : à réinstaller'),
    content: const Text(
      "Elle est signée avec une autre clé que l'app installée, alors Android refuse de la mettre "
      "par-dessus. Pour l'avoir :\n"
      '1. Télécharge-la (bouton ci-dessous).\n'
      '2. Désinstalle SpotiWeb (appui long sur son icône).\n'
      "3. Ouvre le fichier téléchargé pour l'installer, puis reconnecte-toi à Spotify.",
    ),
    actions: [
      TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Plus tard')),
      FilledButton(
        onPressed: () {
          Navigator.of(context).pop();
          updater.openDownload();
        },
        child: const Text('Télécharger'),
      ),
    ],
  ),
);
