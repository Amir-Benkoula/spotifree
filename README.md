# spotiweb

Spotify web player, interface mobile

## Installer sur le téléphone

Chaque push sur `main` ou une branche `claude/…` construit l'APK sur GitHub
(workflow `APK`, aussi lançable à la main depuis l'onglet Actions) et le publie
ici, à ouvrir depuis le téléphone :
<https://github.com/Amir-Benkoula/spotifree/releases/download/apk/spotiweb.apk>

Ensuite, l'app se met à jour elle-même : une bannière propose chaque nouvelle
version, la télécharge et ouvre l'installation d'Android (la première fois,
Android demande d'autoriser SpotiWeb à installer des applis). Réglages (photo de
profil) > Version, pour vérifier tout de suite.

Android n'installe une mise à jour que si elle est signée avec la même clé.
GitHub garde celle des builds tant qu'il y en a au moins un par semaine ; sinon,
le build suivant en a une nouvelle, et l'app explique comment le réinstaller
(désinstaller SpotiWeb, installer le nouvel APK, se reconnecter à Spotify). Pour
une clé définitive, ajouter au dépôt le secret `DEBUG_KEYSTORE` : un keystore de
debug en base64, comme le `~/.android/debug.keystore` d'un ordinateur, dont les
builds et ceux de GitHub se mettent alors à jour les uns les autres (une
dernière réinstallation, au changement de clé).

## Installer sur iPhone

Apple ne laisse installer une app hors App Store qu'une fois signée avec un
compte Apple, depuis un Mac. Avec un compte gratuit, l'app doit être signée à
nouveau tous les 7 jours (sinon elle ne s'ouvre plus).

Avant la première installation, sur l'iPhone : Réglages > Confidentialité et
sécurité > Mode développeur (iOS 16 et plus), puis redémarrer.

**Le plus simple, sans Xcode** : chaque push construit l'app sur GitHub
(workflow `iOS`), non signée :
<https://github.com/Amir-Benkoula/spotifree/releases/download/ios/spotiweb-unsigned.ipa>

1. Installer [Sideloadly](https://sideloadly.io) sur le Mac et brancher l'iPhone.
2. Glisser l'IPA dans Sideloadly, entrer son Apple ID, puis Start.
3. Sur l'iPhone : Réglages > Général > VPN et gestion de l'appareil > faire
   confiance à son Apple ID.

**Depuis le code, avec Xcode** (et Flutter 3.47) :

1. `flutter pub get`, puis ouvrir `ios/Runner.xcworkspace` dans Xcode.
2. Cible Runner > Signing & Capabilities : choisir son équipe (son Apple ID) et
   changer le Bundle Identifier (`com.amirbenkoula.spotiweb`) pour un nom à soi.
3. Brancher l'iPhone, le choisir comme destination, puis Run (ou
   `flutter run --release`).

Sur iOS, les apps ne peuvent afficher le web qu'avec WebKit (Safari) : la page
y tourne dans une WKWebView (`ios/Runner/WebPlayer.swift`), avec les mêmes
scripts que sur Android. Que Spotify y joue la musique reste à vérifier :
l'iPhone n'a pas l'API de streaming qu'utilise le lecteur web, seulement sa
variante « gérée » (iOS 17.1 et plus), que l'app lui donne à la place ; l'iPad
a la vraie. En cas de souci, « Copier le rapport de la page » (réglages) donne
une ligne « Lecture », et Safari sur le Mac peut inspecter la page (menu
Développement > l'iPhone > SpotiWeb).

## Interface

L'app a ses propres écrans, comme l'app Spotify : accueil, recherche,
bibliothèque, playlists, albums, artistes, podcasts, file d'attente, paroles et
menus « … ». Tout ce qu'ils montrent vient du lecteur web (open.spotify.com),
qui tourne caché derrière : l'app le lit et clique dedans
(`assets/inject/reader.js`), sans passer par l'API de Spotify.

Si un écran s'affiche mal (Spotify change son site de temps en temps), la photo
de profil ouvre les réglages : « Diagnostic » essaie chaque fonction de l'app
sur la vraie page et dit ce qui marche, avec un rapport à copier pour corriger
le reste ; « Voir la page web » montre le site. Le site tel quel, à la place des
écrans de l'app, reste disponible : réglages > « Interface web ».

## Icône

Une note de musique dont la tête est un globe (la musique, depuis le web), en
verre avec un léger relief. Elle est dessinée dans `tool/icon/design.js` ;
`node tool/icon/make.js` en refait toutes les versions : icône adaptative
d'Android (et sa version monochrome pour les icônes à thème), icône de
notification, écran de démarrage, icône de l'iPhone (claire, sombre, teintée).

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
