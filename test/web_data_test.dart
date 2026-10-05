import 'package:flutter_test/flutter_test.dart';
import 'package:spotiweb/src/player_state.dart';
import 'package:spotiweb/src/web_data.dart';

import 'support/fake_page.dart';

// What reader.js answers (test/fixtures/reader.json, from a Spotify-like page)
// read into the app's models.
void main() {
  test('a playlist: header, controls and tracks', () {
    final page = WebPage.fromJson(fixture('playlist'));
    expect(page.kind, 'playlist');
    expect(page.title, 'Petite playlist');
    expect(page.label, 'Playlist');
    expect(page.links.single.path, '/user/me');
    expect(page.canPlay && page.hasMenu, isTrue);
    expect(page.saved, isTrue);
    final list = page.blocks.firstWhere((block) => block.isTracks);
    expect(list.total, 8);
    final track = list.tracks.first;
    expect(track.uri, 'spotify:track:p2t0');
    expect(track.index, 2);
    expect(track.artists.map((artist) => artist.path), ['/artist/ar0', '/artist/ar3']);
    expect(track.artistNames, 'Artiste 0, Artiste 3');
    expect(track.album?.path, '/album/p2al0');
    expect(track.duration, '2:30');
  });

  test('the home page: shortcuts, then titled shelves of cards', () {
    final page = WebPage.fromJson(fixture('home'));
    expect(page.kind, 'home');
    expect(page.blocks.first.title, isEmpty);
    expect(page.blocks.first.cards.first.kind, 'collection');
    final shelf = page.blocks[1];
    expect(shelf.title, 'Section 0');
    expect(shelf.path, '/section/s0');
    final card = shelf.cards.first;
    expect(card.path, '/playlist/h0x0');
    expect(card.subtitle, 'Par Artiste 0');
    expect(card.image, isNotEmpty);
    expect(page.complete, isFalse);
  });

  test('an artist: round cards, popular tracks without artists', () {
    final page = WebPage.fromJson(fixture('artist'));
    expect(page.image, contains('banner'));
    expect(page.blocks.first.title, 'Populaires');
    expect(page.blocks.first.tracks, isNotEmpty);
    final fans = page.blocks.firstWhere((block) => block.title == 'Les fans aiment aussi');
    expect(fans.cards.first.round, isTrue);
  });

  test('search results and categories', () {
    final results = WebPage.fromJson(fixture('search'));
    expect(results.blocks.map((block) => block.title), ['Meilleur résultat', 'Titres', 'Artistes', 'Playlists']);
    expect(results.blocks[2].path, '/search/daft punk/artists');
    final browse = WebPage.fromJson(fixture('browse'));
    expect(browse.blocks.single.cards.every((card) => card.kind == 'genre'), isTrue);
  });

  test('the library', () {
    final items = LibraryItem.listFrom(fixture('library'));
    expect(items.first.kind, 'collection');
    expect(items.first.path, '/collection/tracks');
    final folder = items.firstWhere((item) => item.kind == 'folder');
    expect(folder.path, isEmpty);
    expect(items.firstWhere((item) => item.kind == 'artist').path, startsWith('/artist/'));
  });

  test('menus and what picking in them did', () {
    final menu = WebMenu.fromJson(fixture('menu'));
    expect(menu.level, 0);
    expect(menu.entries.first.label, 'Ajouter à la playlist');
    expect(menu.entries.first.submenu, isTrue);
    expect(menu.entries.where((entry) => entry.separated), isNotEmpty);
    final submenu = WebMenu.fromJson(fixture('submenu'));
    expect(submenu.level, 1);
    expect(MenuOutcome.fromJson(fixture('outcome')).message, 'Ajouté à Playlist 1');
  });

  test('the queue and the lyrics', () {
    final queue = QueueData.fromJson(fixture('queue'));
    expect(queue.sections.first.title, 'En cours de lecture');
    expect(queue.sections.first.tracks.single.uri, queue.current);
    expect(queue.sections.last.tracks.first.artistNames, 'Artiste 1');
    final lyrics = LyricsData.fromJson(fixture('lyrics'));
    expect(lyrics.lines.first, 'Ligne 1 des paroles');
    expect(lyrics.active, greaterThanOrEqualTo(0));
  });

  test('the player state links to the pages of the track playing', () {
    final state = PlayerState.fromJson(fixture('state'));
    expect(state.trackUri, 'spotify:track:p2t0');
    expect(state.albumPath, '/album/p2al0');
    expect(state.artists.first.path, '/artist/ar0');
    expect(state.contextPath, '/playlist/p2');
    expect(state.webUi, isFalse);
  });

  test('menu targets as the page expects them', () {
    const track = WebTrack(title: 'A', uri: 'spotify:track:a', index: 4);
    expect(const TrackTarget(track).toJson(), {'type': 'track', 'uri': 'spotify:track:a', 'index': 4});
    expect(const QueueTarget(track, section: 1, position: 2).toJson(), {
      'type': 'queue',
      'uri': 'spotify:track:a',
      'section': 1,
      'index': 2,
    });
    expect(const NowPlayingTarget().toJson(), {'type': 'nowPlaying'});
  });
}
