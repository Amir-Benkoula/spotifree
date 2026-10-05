import 'package:flutter_test/flutter_test.dart';
import 'package:spotiweb/src/player_state.dart';

void main() {
  test('parses a state report from bootstrap.js', () {
    final state = PlayerState.fromJson({
      'appReady': true,
      'loggedIn': true,
      'path': '/playlist/abc',
      'hasTrack': true,
      'title': 'Titre',
      'artist': 'Artiste',
      'playing': true,
      'positionMs': 1000,
      'positionAt': 0,
      'durationMs': 180000.0,
      'shuffle': 1,
      'repeat': 2,
      'liked': false,
      'canSeek': true,
    });
    expect(state.title, 'Titre');
    expect(state.shuffle, isTrue);
    expect(state.repeat, RepeatState.one);
    expect(state.duration, const Duration(minutes: 3));
    expect(state.isHomeRoute, isFalse);
  });

  test('ads show as such, cut short when the blocker is on', () {
    final ad = PlayerState.fromJson({'hasTrack': true, 'title': 'Annonceur', 'isAd': true, 'adBlock': true});
    expect(ad.adBlock, isTrue);
    expect(ad.displayTitle, 'Publicité passée');
    expect(const PlayerState(title: 'Annonceur', isAd: true).displayTitle, 'Publicité');
    expect(const PlayerState(title: 'Titre', adBlock: true).displayTitle, 'Titre');
  });

  test('extrapolates the position while playing, clamped to the duration', () {
    const state = PlayerState(playing: true, positionMs: 10000, positionAt: 1000, durationMs: 20000);
    expect(state.positionNow(DateTime.fromMillisecondsSinceEpoch(6000)), const Duration(seconds: 15));
    expect(state.positionNow(DateTime.fromMillisecondsSinceEpoch(60000)), const Duration(seconds: 20));
    const paused = PlayerState(positionMs: 10000, positionAt: 1000, durationMs: 20000);
    expect(paused.positionNow(DateTime.fromMillisecondsSinceEpoch(6000)), const Duration(seconds: 10));
  });

  test('recognises home and search routes, with or without locale prefix', () {
    for (final path in ['/', '/intl-fr/', '/intl-fr']) {
      expect(PlayerState(path: path).isHomeRoute, isTrue, reason: path);
    }
    for (final path in ['/search', '/search/daft%20punk', '/intl-fr/search']) {
      expect(PlayerState(path: path).isSearchRoute, isTrue, reason: path);
    }
    expect(const PlayerState(path: '/searching').isSearchRoute, isFalse);
  });
}
