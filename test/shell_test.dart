import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spotiweb/src/shell.dart';
import 'package:spotiweb/src/updater.dart';
import 'package:spotiweb/src/web_bridge.dart';

import 'support/fake_page.dart';

void main() {
  late FakePage page;
  late WebBridge bridge;

  const webView = ColoredBox(key: Key('web'), color: Colors.red);

  Map<String, dynamic> complete(String name) => {...withoutImages(fixture(name)), 'complete': true};

  Future<void> start(WidgetTester tester, Map<String, Object?> state) async {
    page = FakePage(tester);
    page.answers['read'] = (arg) => arg['path'] == '/' ? complete('home') : complete('playlist');
    page.answers['readLibrary'] = (_) => withoutImages(fixture('library'));
    page.answers['playTrack'] = (_) => true;
    page.answers['showWeb'] = (_) => true;
    bridge = WebBridge();
    await tester.pumpWidget(
      MaterialApp(
        home: Shell(bridge: bridge, webView: webView),
      ),
    );
    await page.state(state);
    await page.settle();
  }

  /// Shown, not just in the tree (the tabs keep their screens offstage).
  Finder shown(Finder finder) => finder.hitTestable();

  testWidgets('the app shows its own screens, fed by the page behind them', (tester) async {
    await start(tester, {});
    expect(shown(find.text('Section 0')), findsOneWidget);
    expect(find.byKey(const Key('web')), findsOneWidget, reason: 'the page keeps running behind');
    expect(shown(find.byKey(const Key('web'))), findsNothing);

    // A card opens its page over the tab; back comes back.
    await tester.tap(find.text('Playlist 0.1'));
    await page.settle();
    await tester.pump(const Duration(milliseconds: 400));
    expect(page.argsOf('read').last['path'], '/playlist/h0x1');
    expect(shown(find.text('Titre p2 1')), findsOneWidget);
    await tester.tap(find.text('Titre p2 1'));
    await page.settle();
    expect(page.argsOf('playTrack').single['path'], '/playlist/h0x1');

    await tester.binding.handlePopRoute();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(shown(find.text('Section 0')), findsOneWidget);

    // Another tab, then back to the first.
    await tester.tap(find.text('Bibliothèque'));
    await page.settle();
    expect(shown(find.text('Titres likés')), findsOneWidget);
    await tester.binding.handlePopRoute();
    await tester.pump();
    expect(shown(find.text('Section 0')), findsOneWidget);
  });

  testWidgets('the web page shows for what the app has no screen for', (tester) async {
    await start(tester, {});
    await tester.tap(find.text('Bibliothèque'));
    await page.settle();
    await tester.tap(find.text('Dossier'));
    await page.settle();
    expect(page.argsOf('showWeb').single, containsPair('view', 'library'));
    expect(shown(find.byKey(const Key('web'))), findsOneWidget);
    expect(shown(find.text('Titres likés')), findsNothing);

    await tester.tap(find.text("Retour à l'app"));
    await tester.pump();
    expect(shown(find.text('Titres likés')), findsOneWidget);
  });

  testWidgets('a newer build: a banner to install it', (tester) async {
    final installed = <String>[];
    final updater = Updater(
      build: 5,
      ios: false,
      fetchJson: (_) async => {'build': 7, 'notes': 'Diagnostic et mises à jour'},
      download: (url, release, onProgress) async => '/cache/spotiweb-${release.build}.apk',
      installApk: (path) async => installed.add(path),
    );
    addTearDown(updater.dispose);
    page = FakePage(tester);
    page.answers['read'] = (arg) => complete('home');
    bridge = WebBridge();
    await tester.pumpWidget(
      MaterialApp(
        home: Shell(bridge: bridge, webView: webView, updater: updater),
      ),
    );
    await page.state({});
    await page.settle();
    expect(find.text('Nouvelle version 1.0.7'), findsNothing);

    await updater.check();
    await tester.pump();
    expect(find.text('Nouvelle version 1.0.7'), findsOneWidget);
    expect(find.text('Diagnostic et mises à jour'), findsOneWidget);
    await tester.tap(find.text('Installer'));
    await tester.pump();
    expect(installed, ['/cache/spotiweb-7.apk']);

    await tester.tap(find.byTooltip('Plus tard'));
    await tester.pump();
    expect(find.text('Nouvelle version 1.0.7'), findsNothing);
  });

  testWidgets('the web interface, when chosen: the page with the bottom bar', (tester) async {
    await start(tester, {'webUi': true});
    expect(find.text('Section 0'), findsNothing);
    expect(shown(find.byKey(const Key('web'))), findsOneWidget);
    expect(find.text('Réglages'), findsOneWidget);
    await tester.tap(find.text('Rechercher'));
    expect(page.names, contains('search'));
  });

  testWidgets('logged out: the page, to log in', (tester) async {
    await start(tester, {'loggedIn': false});
    expect(find.text('Section 0'), findsNothing);
    expect(find.text('Se connecter'), findsOneWidget);
    await tester.tap(find.text('Se connecter'));
    expect(page.names, contains('login'));
  });

  testWidgets('the full player opens the app’s queue and lyrics', (tester) async {
    await start(tester, {'hasTrack': true, 'title': 'Titre p2 1', 'artist': 'Artiste 0', 'canNext': true});
    page.answers['watchQueue'] = (_) => withoutImages(fixture('queue'));
    await tester.tap(find.text('Titre p2 1').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip("File d'attente"));
    await page.settle();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('En cours de lecture'), findsOneWidget);
    expect(page.argsOf('watchQueue').single, containsPair('live', true));
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(page.argsOf('watchQueue').last, {'live': false});
  });
}
