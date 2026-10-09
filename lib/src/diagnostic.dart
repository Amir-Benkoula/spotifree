import 'dart:async';

import 'package:flutter/foundation.dart';

import 'player_state.dart';
import 'web_bridge.dart';
import 'web_content.dart';
import 'web_data.dart';

enum CheckStatus { waiting, running, ok, partial, failed, skipped }

/// One function of the app, tried on the real page.
@immutable
class CheckResult {
  const CheckResult(this.title, {this.status = CheckStatus.waiting, this.detail = '', this.outline = ''});

  final String title;
  final CheckStatus status;
  final String detail;

  /// The page as it was when the check went wrong (reader.js's report).
  final String outline;

  CheckResult copyWith({CheckStatus? status, String? detail, String? outline}) => CheckResult(
    title,
    status: status ?? this.status,
    detail: detail ?? this.detail,
    outline: outline ?? this.outline,
  );
}

/// Tries the app's reading of the web player on the real page, one function
/// after another (taking the page to each place), to tell what works and what
/// Spotify changed: the report shows the page wherever something went wrong.
/// Nothing is changed in the account; only [testPlayback], on request, plays.
class Diagnostic {
  Diagnostic(this.content, {this.version = ''});

  final WebContent content;

  /// The app's version, for the report.
  final String version;

  final results = ValueNotifier<List<CheckResult>>(const []);
  final running = ValueNotifier<bool>(false);
  bool _stopped = false;
  bool _disposed = false;
  DateTime? _startedAt;
  String _pageReport = '';

  static const playbackTitle = "Lecture d'un titre";

  // What the checks found, for the ones after them.
  WebPage? _home;
  List<LibraryItem> _library = const [];
  String _listPath = '';
  WebPage? _list;
  String _artistName = '';

  WebBridge get _bridge => content.bridge;
  PlayerState get _state => _bridge.state.value;

  late final List<(String, Future<CheckResult> Function(CheckResult))> _steps = [
    ('Page Spotify', _page),
    ('Accueil', _homeCheck),
    ('Bibliothèque', _libraryCheck),
    ('Playlist', _playlist),
    ("Suite d'une longue liste", _more),
    ("Page d'artiste", _artist),
    ('Recherche', _search),
    ('Menu « … » d\'un titre', _menu),
    ("File d'attente", _queue),
    ('Paroles', _lyrics),
  ];

  Future<void> run() async {
    if (running.value) return;
    running.value = true;
    _stopped = false;
    _startedAt = DateTime.now();
    _pageReport = '';
    results.value = [
      for (final (title, _) in _steps) CheckResult(title),
      const CheckResult(playbackTitle, detail: 'Lance un titre de la playlist essayée : touche « Tester »'),
    ];
    for (final (index, (_, check)) in _steps.indexed) {
      if (_stopped) break;
      await _run(index, check);
    }
    if (!_stopped) {
      try {
        _pageReport = await content.report(lines: 150);
      } catch (error) {
        _pageReport = 'Rapport indisponible : ${_message(error)}';
      }
    }
    if (!_disposed) running.value = false;
  }

  /// Plays a track of the playlist tried, to see the music start.
  Future<void> testPlayback() async {
    if (running.value || results.value.isEmpty) return;
    running.value = true;
    await _run(results.value.length - 1, _playback);
    if (!_disposed) running.value = false;
  }

  /// Stops after the check under way (the screen is gone).
  void stop() => _stopped = true;

  void dispose() {
    _stopped = true;
    _disposed = true;
    results.dispose();
    running.dispose();
  }

  Future<void> _run(int index, Future<CheckResult> Function(CheckResult) check) async {
    final waiting = results.value[index].copyWith(status: CheckStatus.running, outline: '');
    _set(index, waiting);
    CheckResult result;
    try {
      result = await check(waiting);
    } catch (error) {
      result = waiting.copyWith(status: CheckStatus.failed, detail: _message(error));
    }
    if (_disposed) return;
    if (result.status == CheckStatus.failed || result.status == CheckStatus.partial) {
      // Where it went wrong, to see what the page shows there.
      try {
        result = result.copyWith(outline: await content.report(lines: 250));
      } catch (error) {
        result = result.copyWith(outline: 'Rapport indisponible : ${_message(error)}');
      }
    }
    _set(index, result);
  }

  void _set(int index, CheckResult result) {
    if (_disposed || index >= results.value.length) return;
    results.value = [...results.value]..[index] = result;
  }

  static String _message(Object error) => error is WebError ? error.message : '$error';

  /// The first few of [names], and how many more.
  static String _some(Iterable<String> names, [int count = 4]) {
    final all = names.toList();
    final shown = all.take(count).join(', ');
    return all.length > count ? '$shown… (+${all.length - count})' : shown;
  }

  // -------------------------------------------------------------------- checks
  Future<CheckResult> _page(CheckResult r) async {
    final state = _state;
    if (!state.appReady) {
      return r.copyWith(status: CheckStatus.failed, detail: "Le lecteur web ne s'est pas affiché");
    }
    if (!await _bridge.command('sync')) {
      return r.copyWith(status: CheckStatus.failed, detail: 'La page ne répond pas aux commandes');
    }
    final login = switch (state.loggedIn) {
      true => 'connecté',
      false => 'non connecté',
      null => 'connexion non détectée',
    };
    final playing = state.hasTrack ? 'en lecture : ${state.title} — ${state.artist}' : 'rien en lecture';
    return r.copyWith(
      status: switch (state.loggedIn) {
        true => CheckStatus.ok,
        false => CheckStatus.failed,
        null => CheckStatus.partial,
      },
      detail: 'Lecteur prêt, $login, $playing',
    );
  }

  Future<CheckResult> _homeCheck(CheckResult r) async {
    final page = _home = await content.page('/', fresh: true).result;
    final blocks = [
      for (final block in page.blocks)
        if (block.tracks.isNotEmpty || block.cards.isNotEmpty) block,
    ];
    if (blocks.isEmpty) return r.copyWith(status: CheckStatus.failed, detail: 'Rien de lu sur la page');
    final items = blocks.fold(0, (n, block) => n + block.tracks.length + block.cards.length);
    final titles = _some(blocks.map((block) => block.title.isEmpty ? '(sans titre)' : block.title));
    return r.copyWith(status: CheckStatus.ok, detail: '${blocks.length} sections, $items éléments : $titles');
  }

  Future<CheckResult> _libraryCheck(CheckResult r) async {
    final items = _library = await content.library().result;
    if (items.isEmpty) {
      return r.copyWith(status: CheckStatus.partial, detail: 'Aucun élément lu (bibliothèque vide ?)');
    }
    const names = {
      'playlist': 'playlists',
      'collection': 'titres likés',
      'album': 'albums',
      'artist': 'artistes',
      'show': 'podcasts',
      'folder': 'dossiers',
    };
    final counts = <String, int>{};
    for (final item in items) {
      counts.update(names[item.kind] ?? item.kind, (n) => n + 1, ifAbsent: () => 1);
    }
    final kinds = counts.entries.map((e) => '${e.value} ${e.key}').join(', ');
    return r.copyWith(status: CheckStatus.ok, detail: '${items.length} éléments : $kinds');
  }

  Future<CheckResult> _playlist(CheckResult r) async {
    // A playlist of the library, else anything of it with a page, else a
    // playlist of the home page, else Liked Songs.
    final cards = _home?.blocks.expand((block) => block.cards) ?? const <WebCard>[];
    _listPath =
        _library.where((item) => item.kind == 'playlist').firstOrNull?.path ??
        _library.where((item) => item.path.isNotEmpty).firstOrNull?.path ??
        cards.where((card) => card.kind == 'playlist' || card.kind == 'album').firstOrNull?.path ??
        '/collection/tracks';
    final page = _list = await content.page(_listPath, fresh: true).result;
    final tracks = page.tracks.toList();
    final total = page.blocks.where((block) => block.isTracks).map((block) => block.total).nonNulls.firstOrNull;
    final withUri = tracks.where((track) => track.uri.isNotEmpty).length;
    final detail = [
      '« ${page.title.isEmpty ? _listPath : page.title} »',
      '${tracks.length} titres lus${total == null ? '' : ' sur $total'}',
      if (tracks.isNotEmpty && withUri < tracks.length) '${tracks.length - withUri} sans lien',
      page.canPlay ? 'bouton lecture trouvé' : 'pas de bouton lecture',
      page.hasMenu ? 'menu trouvé' : 'pas de menu',
    ].join(', ');
    final status = page.title.isEmpty && tracks.isEmpty
        ? CheckStatus.failed
        : tracks.isEmpty || withUri < tracks.length || !page.canPlay
        ? CheckStatus.partial
        : CheckStatus.ok;
    return r.copyWith(status: status, detail: detail);
  }

  Future<CheckResult> _more(CheckResult r) async {
    final page = _list;
    if (page == null || page.tracks.isEmpty) {
      return r.copyWith(status: CheckStatus.skipped, detail: 'Pas de liste à prolonger');
    }
    final before = page.tracks.length;
    if (page.complete) {
      return r.copyWith(status: CheckStatus.skipped, detail: 'Liste entière dès le début ($before titres)');
    }
    final after = _list = await content.more(_listPath).result;
    final count = after.tracks.length;
    return count > before
        ? r.copyWith(status: CheckStatus.ok, detail: '$before → $count titres en faisant défiler')
        : r.copyWith(status: CheckStatus.partial, detail: 'Toujours $before titres après avoir fait défiler');
  }

  Future<CheckResult> _artist(CheckResult r) async {
    final fromLibrary = _library.where((item) => item.kind == 'artist' && item.path.isNotEmpty).firstOrNull;
    final fromTrack = _list?.tracks.expand((track) => track.artists).firstOrNull;
    final path = fromLibrary?.path ?? fromTrack?.path ?? '';
    if (path.isEmpty) return r.copyWith(status: CheckStatus.skipped, detail: 'Aucun artiste trouvé à ouvrir');
    final page = await content.page(path).result;
    _artistName = page.title.isNotEmpty ? page.title : fromLibrary?.title ?? fromTrack?.name ?? '';
    final tracks = page.tracks.length;
    final sections = page.blocks.where((block) => block.cards.isNotEmpty).length;
    final detail = [
      '« $_artistName »',
      '$tracks titres populaires',
      '$sections sections',
      if (page.image.isEmpty) 'sans photo',
    ].join(', ');
    final status = page.title.isEmpty || tracks + sections == 0
        ? CheckStatus.failed
        : tracks == 0 || sections == 0
        ? CheckStatus.partial
        : CheckStatus.ok;
    return r.copyWith(status: status, detail: detail);
  }

  Future<CheckResult> _search(CheckResult r) async {
    final query = _artistName.isNotEmpty
        ? _artistName
        : _list?.tracks.where((track) => track.title.isNotEmpty).firstOrNull?.title ?? 'Daft Punk';
    final page = await content.page('/search/${query.replaceAll('/', ' ')}').result;
    final blocks = [
      for (final block in page.blocks)
        if (block.tracks.isNotEmpty || block.cards.isNotEmpty) block,
    ];
    if (blocks.isEmpty) return r.copyWith(status: CheckStatus.failed, detail: '« $query » : aucun résultat lu');
    final titles = _some(blocks.map((block) => block.title.isEmpty ? '(sans titre)' : block.title));
    // Songs: a track list, or tracks among the results.
    final songs = blocks.any((block) => block.tracks.isNotEmpty || block.cards.any((card) => card.kind == 'track'));
    return r.copyWith(
      status: songs ? CheckStatus.ok : CheckStatus.partial,
      detail: '« $query » : $titles${songs ? '' : ' (pas de titres)'}',
    );
  }

  Future<CheckResult> _menu(CheckResult r) async {
    final track = _list?.tracks.where((track) => !track.disabled).firstOrNull;
    if (track == null) return r.copyWith(status: CheckStatus.skipped, detail: 'Aucun titre où ouvrir un menu');
    try {
      final menu = await content.openMenu(TrackTarget(track), path: _listPath);
      if (menu.entries.isEmpty) return r.copyWith(status: CheckStatus.partial, detail: 'Menu ouvert, mais vide');
      return r.copyWith(
        status: CheckStatus.ok,
        detail: '${menu.entries.length} entrées : ${_some(menu.entries.map((entry) => entry.label))}',
      );
    } finally {
      await content.closeMenu();
    }
  }

  Future<CheckResult> _queue(CheckResult r) async {
    if (!_state.hasTrack) {
      return r.copyWith(
        status: CheckStatus.skipped,
        detail: 'Rien en lecture : lance un titre puis relance le diagnostic',
      );
    }
    final data = await _firstOf(content.queue(), const Duration(seconds: 15));
    final sections = [
      for (final section in data.sections)
        if (section.tracks.isNotEmpty) section,
    ];
    if (sections.isEmpty) return r.copyWith(status: CheckStatus.partial, detail: 'File vide, ou pas lue');
    final titles = _some(sections.map((s) => '${s.title.isEmpty ? '(sans titre)' : s.title} (${s.tracks.length})'));
    // The queue starts with what plays: without it, what was read is something else.
    final current = sections.first.tracks.any((track) => track.uri.isNotEmpty && track.uri == data.current);
    return r.copyWith(
      status: current ? CheckStatus.ok : CheckStatus.partial,
      detail: '$titles${current ? '' : ', titre en cours non repéré'}',
    );
  }

  Future<CheckResult> _lyrics(CheckResult r) async {
    if (!_state.hasTrack) {
      return r.copyWith(
        status: CheckStatus.skipped,
        detail: 'Rien en lecture : lance un titre puis relance le diagnostic',
      );
    }
    // Until the line being sung shows (if it plays), or no lyrics.
    final data = await _firstOf(
      content.lyrics(),
      const Duration(seconds: 12),
      until: (data) => data.lines.isEmpty || data.active >= 0 || !_state.playing,
    );
    if (data.lines.isEmpty) {
      final message = data.message.isEmpty ? '' : ' (« ${data.message.split('\n').first} »)';
      return r.copyWith(status: CheckStatus.partial, detail: 'Pas de paroles lues pour ce titre$message');
    }
    if (data.active >= 0) {
      return r.copyWith(
        status: CheckStatus.ok,
        detail: '${data.lines.length} lignes, ligne en cours suivie (« ${data.lines[data.active]} »)',
      );
    }
    return _state.playing
        ? r.copyWith(status: CheckStatus.partial, detail: '${data.lines.length} lignes, ligne en cours non repérée')
        : r.copyWith(status: CheckStatus.ok, detail: '${data.lines.length} lignes (en pause : suivi non vérifié)');
  }

  Future<CheckResult> _playback(CheckResult r) async {
    final track = _list?.tracks.where((track) => !track.disabled && track.uri.isNotEmpty).firstOrNull;
    if (track == null) {
      return r.copyWith(status: CheckStatus.skipped, detail: 'Aucun titre à lancer : relance le diagnostic');
    }
    await content.playTrack(_listPath, track);
    // The player bar then shows it, and the music plays.
    final started = await _until(() => _state.trackUri == track.uri && _state.playing, const Duration(seconds: 10));
    if (started) return r.copyWith(status: CheckStatus.ok, detail: '« ${track.title} » lancé, en lecture');
    final state = _state;
    final now = state.hasTrack ? '« ${state.title} »${state.playing ? ' en lecture' : ' en pause'}' : 'rien';
    return r.copyWith(status: CheckStatus.failed, detail: '« ${track.title} » demandé ; le lecteur montre : $now');
  }

  // ------------------------------------------------------------------- helpers
  /// The first update of a live stream that satisfies [until] (or the last one
  /// within [timeout]); the stream is then stopped.
  static Future<T> _firstOf<T extends Object>(Stream<T> stream, Duration timeout, {bool Function(T)? until}) async {
    final found = Completer<T>();
    T? last;
    final subscription = stream.listen(
      (value) {
        last = value;
        if ((until == null || until(value)) && !found.isCompleted) found.complete(value);
      },
      onError: (Object error) {
        if (!found.isCompleted) found.completeError(error);
      },
    );
    try {
      return await found.future.timeout(
        timeout,
        onTimeout: () => last ?? (throw const WebError('La page ne répond pas')),
      );
    } finally {
      // Not awaited: nothing to wait for (and, in tests, it never comes).
      unawaited(subscription.cancel());
    }
  }

  /// Waits for the player state to satisfy [test].
  Future<bool> _until(bool Function() test, Duration timeout) async {
    if (test()) return true;
    final done = Completer<bool>();
    void check() {
      if (test() && !done.isCompleted) done.complete(true);
    }

    _bridge.state.addListener(check);
    try {
      return await done.future.timeout(timeout, onTimeout: () => false);
    } finally {
      _bridge.state.removeListener(check);
    }
  }

  // -------------------------------------------------------------------- report
  /// What to send to find out what goes wrong: each check, and the page where
  /// something did.
  String report() {
    final started = _startedAt;
    String two(int n) => n.toString().padLeft(2, '0');
    final date = started == null
        ? ''
        : ' du ${two(started.day)}/${two(started.month)}/${started.year} à ${two(started.hour)}:${two(started.minute)}';
    final lines = <String>[
      'SpotiWeb — diagnostic$date',
      'Version $version, ${defaultTargetPlatform.name}',
      '',
      for (final result in results.value)
        '${_symbol(result.status)} ${result.title}${result.detail.isEmpty ? '' : ' — ${result.detail}'}',
    ];
    for (final result in results.value) {
      if (result.outline.isNotEmpty) lines.addAll(['', '## ${result.title}', result.outline]);
    }
    if (_pageReport.isNotEmpty) lines.addAll(['', '## Page à la fin', _pageReport]);
    return lines.join('\n');
  }

  static String _symbol(CheckStatus status) => switch (status) {
    CheckStatus.ok => '✓',
    CheckStatus.partial => '⚠',
    CheckStatus.failed => '✗',
    CheckStatus.skipped => '–',
    CheckStatus.waiting || CheckStatus.running => '…',
  };
}
