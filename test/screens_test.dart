import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spotiweb/src/app_actions.dart';
import 'package:spotiweb/src/home_screen.dart';
import 'package:spotiweb/src/library_screen.dart';
import 'package:spotiweb/src/lyrics_screen.dart';
import 'package:spotiweb/src/menu_sheet.dart';
import 'package:spotiweb/src/page_screen.dart';
import 'package:spotiweb/src/queue_screen.dart';
import 'package:spotiweb/src/search_screen.dart';
import 'package:spotiweb/src/web_bridge.dart';
import 'package:spotiweb/src/web_data.dart';

import 'support/fake_page.dart';

// The native screens, fed by a fake page answering like reader.js does.
void main() {
  late FakePage page;
  late TestApp app;

  Future<void> start(WidgetTester tester) async {
    page = FakePage(tester);
    app = TestApp(WebBridge());
    await page.state({});
  }

  Map<String, dynamic> complete(String name) => {...withoutImages(fixture(name)), 'complete': true};

  testWidgets('a page shows what the web page shows, and plays from it', (tester) async {
    await start(tester);
    page.answers['read'] = (_) => withoutImages(fixture('playlist'));
    page.answers['more'] = (_) => complete('playlist');
    page.answers['playTrack'] = (_) => true;
    page.answers['playPage'] = (_) => true;
    await tester.pumpWidget(
      MaterialApp(
        home: PageScreen(app: app, path: '/playlist/p2'),
      ),
    );
    await page.settle();
    expect(page.argsOf('read').first['path'], '/playlist/p2');
    expect(find.text('Petite playlist'), findsWidgets);
    expect(find.text('Playlist'), findsOneWidget);
    expect(find.text('Titre p2 1'), findsOneWidget);

    await tester.tap(find.text('Titre p2 2'));
    await page.settle();
    expect(page.argsOf('playTrack').single, containsPair('uri', 'spotify:track:p2t1'));
    expect(page.argsOf('playTrack').single, containsPair('index', 3));

    await tester.tap(find.byTooltip('Lecture'));
    await page.settle();
    expect(page.argsOf('playPage').single['path'], '/playlist/p2');

    await tester.tap(find.byTooltip("Plus d'options").first);
    expect(app.menus.single.$1, isA<PageTarget>());
    await tester.tap(find.byTooltip("Plus d'options").at(1));
    expect(app.menus.last.$1, isA<TrackTarget>());
    expect(app.menus.last.$2, '/playlist/p2');

    await tester.tap(find.widgetWithText(ActionChip, 'Moi'));
    expect(app.opened, ['/user/me']);
  });

  testWidgets('a page that fails to load offers to try again or to see the page', (tester) async {
    await start(tester);
    page.answers['read'] = (_) => throw 'could not open /album/x';
    await tester.pumpWidget(
      MaterialApp(
        home: PageScreen(app: app, path: '/album/x'),
      ),
    );
    await page.settle();
    expect(find.text('could not open /album/x'), findsOneWidget);
    await tester.tap(find.text('Voir la page web'));
    expect(app.webs.single.path, '/album/x');
    page.answers['read'] = (_) => complete('album');
    await tester.tap(find.text('Réessayer'));
    await page.settle();
    expect(find.text('Album al7'), findsWidgets);
  });

  testWidgets('home: shortcuts and shelves open their pages', (tester) async {
    await start(tester);
    page.answers['read'] = (_) => complete('home');
    await tester.pumpWidget(MaterialApp(home: HomeScreen(app: app)));
    await page.settle();
    expect(find.text('Raccourci 1'), findsOneWidget);
    expect(find.text('Section 0'), findsOneWidget);
    await tester.tap(find.text('Raccourci 1'));
    await tester.tap(find.text('Playlist 0.1'));
    expect(app.opened, ['/playlist/sc1', '/playlist/h0x1']);
    await tester.tap(find.text('Tout afficher').first);
    expect(app.opened.last, '/section/s0');
    await tester.longPress(find.text('Playlist 0.1'));
    expect((app.menus.single.$1 as CardTarget).card.path, '/playlist/h0x1');
  });

  testWidgets('search: categories, then results of what is typed', (tester) async {
    await start(tester);
    page.answers['read'] = (arg) => arg['path'] == '/search' ? complete('browse') : complete('search');
    page.answers['playTrack'] = (_) => true;
    await tester.pumpWidget(MaterialApp(home: SearchScreen(app: app)));
    await page.settle();
    expect(find.text('Parcourir tout'), findsOneWidget);
    expect(find.text('Genre 0'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'daft');
    await tester.enterText(find.byType(TextField), 'daft punk');
    await tester.pump(const Duration(milliseconds: 700));
    await page.settle();
    expect(page.argsOf('read').map((arg) => arg['path']), ['/search', '/search/daft punk']);
    expect(find.text('Meilleur résultat'), findsOneWidget);
    expect(find.text('daft punk s9 1'), findsOneWidget);

    await tester.tap(find.text('daft punk s9 1'));
    await page.settle();
    expect(page.argsOf('playTrack').single['path'], '/search/daft punk');

    await tester.tap(find.widgetWithText(ActionChip, 'Artistes'));
    expect(app.opened.last, '/search/daft punk/artists');
  });

  testWidgets('search: results in one list, a track plays, the rest opens', (tester) async {
    await start(tester);
    page.answers['read'] = (arg) => arg['path'] == '/search' ? complete('browse') : complete('searchList');
    page.answers['playCard'] = (_) => true;
    await tester.pumpWidget(MaterialApp(home: SearchScreen(app: app)));
    await page.settle();
    await tester.enterText(find.byType(TextField), 'daft');
    await tester.pump(const Duration(milliseconds: 700));
    await page.settle();
    // A list, as the page shows it: each result with what it is.
    expect(find.text('daft un'), findsOneWidget);
    expect(find.text('Titre • Artiste 1, Artiste 2'), findsOneWidget);
    expect(find.text('Album • Artiste 1'), findsOneWidget);
    expect(find.text('Vidéos'), findsOneWidget);

    await tester.tap(find.text('daft deux'));
    await page.settle();
    expect(
      page.argsOf('playCard').single,
      allOf(containsPair('path', '/search/daft'), containsPair('target', '/track/sv4t1')),
    );
    expect(app.opened, isEmpty);

    await tester.tap(find.text('Artiste 5'));
    expect(app.opened.single, '/artist/ar5');
  });

  testWidgets('the library: filters, pages, folders', (tester) async {
    await start(tester);
    page.answers['readLibrary'] = (_) => withoutImages(fixture('library'));
    await tester.pumpWidget(MaterialApp(home: LibraryScreen(app: app)));
    await page.settle();
    expect(find.text('Titres likés'), findsOneWidget);
    expect(find.text('Artiste 3'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilterChip, 'Artistes'));
    await tester.pump();
    expect(find.text('Titres likés'), findsNothing);
    await tester.tap(find.text('Artiste 3'));
    expect(app.opened, ['/artist/ar3']);

    await tester.tap(find.widgetWithText(FilterChip, 'Artistes'));
    await tester.pump();
    await tester.tap(find.text('Dossier'));
    expect(app.webs.single.view, 'library');
    await tester.longPress(find.text('Titres likés'));
    expect(app.menus.single.$1, isA<LibraryTarget>());
  });

  testWidgets('the queue follows the page, and plays from it', (tester) async {
    await start(tester);
    final queue = withoutImages(fixture('queue'));
    page.answers['watchQueue'] = (_) => queue;
    page.answers['queuePlay'] = (_) => true;
    await tester.pumpWidget(MaterialApp(home: QueueScreen(app: app)));
    await page.settle();
    expect(page.argsOf('watchQueue').single, containsPair('live', true));
    expect(find.text('En cours de lecture'), findsOneWidget);
    expect(find.text('Titre p2 3'), findsOneWidget);

    await tester.tap(find.text('Titre p2 3'));
    await page.settle();
    expect(page.argsOf('queuePlay').single, containsPair('uri', 'spotify:track:p2t2'));
    expect(page.argsOf('queuePlay').single, containsPair('section', 1));
    expect(page.argsOf('queuePlay').single, containsPair('index', 2));

    final sections = (queue['sections'] as List).take(1).toList();
    await page.live('queue', {...queue, 'sections': sections});
    await tester.pump();
    expect(find.text('Titre p2 3'), findsNothing);

    await tester.pumpWidget(const SizedBox());
    expect(page.argsOf('watchQueue').last, {'live': false});
  });

  testWidgets('lyrics: the line being sung, and a tap to go to a line', (tester) async {
    await start(tester);
    page.answers['watchLyrics'] = (_) => fixture('lyrics');
    await tester.pumpWidget(MaterialApp(home: LyricsScreen(app: app)));
    await page.settle();
    expect(find.text('Ligne 1 des paroles'), findsOneWidget);
    await tester.tap(find.text('Ligne 4 des paroles'));
    expect(page.argsOf('lyricsSeek').single, {'index': 3});
    await page.live('lyrics', {...fixture('lyrics'), 'active': 3});
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    Color colorOf(String line) => tester
        .widget<AnimatedDefaultTextStyle>(
          find.ancestor(of: find.text(line), matching: find.byType(AnimatedDefaultTextStyle)).first,
        )
        .style
        .color!;
    expect(colorOf('Ligne 4 des paroles'), Colors.white);
    expect(colorOf('Ligne 6 des paroles'), isNot(Colors.white));
    await tester.pumpWidget(const SizedBox());
    expect(page.argsOf('watchLyrics').last, {'live': false});
  });

  group('menus', () {
    late BuildContext context;

    Future<void> openMenu(WidgetTester tester) async {
      await start(tester);
      page.answers['menu'] = (_) => fixture('menu');
      page.answers['menuPick'] = (arg) =>
          arg['level'] == 0 && arg['index'] == 0 ? fixture('submenu') : fixture('outcome');
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (builderContext) {
              context = builderContext;
              return const Scaffold();
            },
          ),
        ),
      );
    }

    const track = WebTrack(title: 'Titre p2 2', uri: 'spotify:track:p2t1', index: 3);

    testWidgets('a context menu: entries, a submenu, what picking did', (tester) async {
      await openMenu(tester);
      final done = showWebMenu(
        context,
        app,
        const TrackTarget(track),
        path: '/playlist/p2',
        header: MenuHeader.track(track),
      );
      await page.settle();
      expect(page.argsOf('menu').single['target'], {'type': 'track', 'uri': 'spotify:track:p2t1', 'index': 3});
      expect(find.text('Titre p2 2'), findsOneWidget);
      expect(find.text("Accéder à l'album"), findsOneWidget);

      await tester.tap(find.text('Ajouter à la playlist'));
      await page.settle();
      expect(find.text('Playlist 1'), findsOneWidget);
      await tester.tap(find.text('Playlist 1'));
      await page.settle();
      await tester.pumpAndSettle();
      await done;
      expect(page.argsOf('menuPick').last, containsPair('level', 1));
      expect(page.argsOf('menuPick').last, containsPair('index', 2));
      expect(app.notices, ['Ajouté à Playlist 1']);
      expect(page.names, isNot(contains('menuClose')));
    });

    testWidgets('closing a menu without a pick closes it in the page', (tester) async {
      await openMenu(tester);
      final done = showWebMenu(context, app, const TrackTarget(track), path: '/playlist/p2');
      await page.settle();
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();
      await done;
      expect(page.names, contains('menuClose'));
    });

    test('entries get icons from their words', () {
      expect(menuIcon("Ajouter à la file d'attente"), Icons.queue_music_rounded);
      expect(menuIcon('Supprimer de cette playlist'), Icons.remove_circle_outline_rounded);
      expect(menuIcon('Ajouter à la playlist'), Icons.playlist_add_rounded);
      expect(menuIcon('Copy Song Link'), Icons.link_rounded);
    });
  });
}
