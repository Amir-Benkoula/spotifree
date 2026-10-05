# spotiweb

Spotify web player, interface mobile

## Installer sur le téléphone

Chaque push sur `main` ou une branche `claude/…` construit l'APK sur GitHub
(workflow `APK`, aussi lançable à la main depuis l'onglet Actions) et le publie
ici, à ouvrir depuis le téléphone :
<https://github.com/Amir-Benkoula/spotifree/releases/download/apk/spotiweb.apk>

Android n'installe une mise à jour que si elle est signée avec la même clé : la
première fois, désinstaller une version construite sur l'ordinateur. Pour que
les deux se mettent à jour l'une l'autre, ajouter le secret `DEBUG_KEYSTORE`
(le `~/.android/debug.keystore` de l'ordinateur, en base64) au dépôt.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
