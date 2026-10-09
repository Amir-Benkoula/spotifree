import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spotiweb/src/diagnostic.dart';
import 'package:spotiweb/src/diagnostic_screen.dart';
import 'package:spotiweb/src/web_bridge.dart';

import 'support/fake_page.dart';

void main() {
  late FakePage page;
  late TestApp app;

  const playing = {'hasTrack': true, 'title': 'Titre p2 1', 'playing': true, 'trackUri': 'spotify:track:p2t0'};

  /// The playlist as first read (part of it), then all of it.
  Map<String, dynamic> playlist({bool complete = false}) {
    final json = withoutImages(fixture('playlist'));
    final blocks = [for (final block in json['blocks'] as List) Map<String, dynamic>.from(block as Map)];
    final tracks = blocks.firstWhere((block) => block['type'] == 'track');
    final items = [for (final item in tracks['items'] as List) Map<String, dynamic>.from(item as Map)];
    tracks['items'] = complete
        ? [
            ...items,
            for (final item in items)
              {...item, 'index': (item['index'] as int) + items.length, 'uri': '${item['uri']}b'},
          ]
        : items;
    return {...json, 'blocks': blocks, 'complete': complete};
  }

  Future<void> start(WidgetTester tester, Map<String, Object?> state) async {
    page = FakePage(tester);
    app = TestApp(WebBridge());
    await page.state(state);
    page.answers['read'] = (arg) => switch (arg['path'] as String) {
      '/' => withoutImages(fixture('home')),
      final path when path.startsWith('/playlist/') => playlist(),
      final path when path.startsWith('/artist/') => withoutImages(fixture('artist')),
      final path when path.startsWith('/search/') => withoutImages(fixture('search')),
      final path => throw 'unexpected $path',
    };
    page.answers['more'] = (_) => playlist(complete: true);
    page.answers['readLibrary'] = (_) => withoutImages(fixture('library'));
    page.answers['menu'] = (_) => fixture('menu');
    page.answers['watchQueue'] = (_) => withoutImages(fixture('queue'));
    page.answers['watchLyrics'] = (_) => fixture('lyrics');
    page.answers['report'] = (arg) => 'RAPPORT ${arg['lines']}';
    page.answers['playTrack'] = (_) => true;
  }

  Future<void> finish(WidgetTester tester, Diagnostic diagnostic) async {
    for (var i = 0; i < 100 && diagnostic.running.value; i++) {
      await page.flush();
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  CheckResult result(Diagnostic diagnostic, String title) =>
      diagnostic.results.value.firstWhere((result) => result.title == title);

  testWidgets('every function works: all checks pass', (tester) async {
    await start(tester, playing);
    final diagnostic = Diagnostic(app.content, version: '1.0.7');
    diagnostic.run();
    await finish(tester, diagnostic);
    final statuses = {for (final r in diagnostic.results.value) r.title: '${r.status.name} ${r.detail}'};
    expect(statuses.values.where((s) => s.startsWith('ok')), hasLength(10), reason: statuses.toString());
    expect(result(diagnostic, 'Playlist').detail, contains('« Petite playlist »'));
    expect(result(diagnostic, "Suite d'une longue liste").detail, '4 → 8 titres en faisant défiler');
    expect(result(diagnostic, 'Recherche').detail, startsWith('« Artiste ar3 »'));
    expect(page.argsOf('read').map((arg) => arg['path']), [
      '/',
      '/playlist/lib0',
      '/artist/ar3',
      '/search/Artiste ar3',
    ]);
    expect(page.names, containsAllInOrder(['menu', 'menuClose', 'watchQueue', 'watchQueue', 'watchLyrics']));
    expect(page.argsOf('watchQueue').last, {'live': false}, reason: 'the queue is no longer followed');
    expect(page.argsOf('watchLyrics').last, {'live': false});
    expect(result(diagnostic, Diagnostic.playbackTitle).status, CheckStatus.waiting, reason: 'only on request');

    final report = diagnostic.report();
    expect(report, contains('Version 1.0.7'));
    expect(report, contains('✓ Accueil — 4 sections'));
    expect(report, contains('## Page à la fin\nRAPPORT 150'));

    // The playback test, on request: the track starts.
    diagnostic.testPlayback();
    await page.flush();
    await page.state({...playing, 'title': 'Titre p2 2', 'trackUri': 'spotify:track:p2t0'});
    await finish(tester, diagnostic);
    expect(page.argsOf('playTrack').single['uri'], 'spotify:track:p2t0');
    expect(result(diagnostic, Diagnostic.playbackTitle).status, CheckStatus.ok);
  });

  testWidgets('what fails is reported with the page where it did', (tester) async {
    await start(tester, {});
    page.answers['read'] = (arg) => arg['path'] == '/' ? throw 'could not open /' : playlist(complete: true);
    page.answers['readLibrary'] = (_) => {'items': <Object>[]};
    final diagnostic = Diagnostic(app.content);
    diagnostic.run();
    await finish(tester, diagnostic);
    final home = result(diagnostic, 'Accueil');
    expect(home.status, CheckStatus.failed);
    expect(home.detail, 'could not open /');
    expect(home.outline, 'RAPPORT 250');
    expect(result(diagnostic, 'Bibliothèque').status, CheckStatus.partial);
    expect(page.argsOf('read')[1]['path'], '/collection/tracks', reason: 'Liked Songs, failing all else');
    expect(result(diagnostic, "Suite d'une longue liste").status, CheckStatus.skipped);
    expect(result(diagnostic, "File d'attente").status, CheckStatus.skipped, reason: 'nothing plays');
    expect(result(diagnostic, 'Paroles').status, CheckStatus.skipped);
    expect(diagnostic.report(), contains('✗ Accueil — could not open /\n'));
    expect(diagnostic.report(), contains('## Accueil\nRAPPORT 250'));
  });

  testWidgets('the screen shows each check, and copies the report', (tester) async {
    await start(tester, playing);
    final copied = <String>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') copied.add((call.arguments as Map)['text'] as String);
      return null;
    });
    // Tall enough for every row.
    tester.view.physicalSize = const Size(800, 2000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MaterialApp(home: DiagnosticScreen(app: app)));
    final copy = find.widgetWithText(FilledButton, 'Copier le rapport');
    for (var i = 0; i < 100 && tester.widget<FilledButton>(copy).onPressed == null; i++) {
      await page.flush();
      await tester.pump(const Duration(milliseconds: 50));
    }
    expect(find.text('Bibliothèque'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle_rounded), findsNWidgets(10));
    expect(find.text('Tester'), findsOneWidget);
    await tester.tap(find.text('Copier le rapport'));
    await tester.pump();
    expect(copied.single, contains('✓ Page Spotify'));
    expect(app.notices.single, startsWith('Rapport copié'));
  });
}
