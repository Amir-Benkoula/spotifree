import 'dart:async';

import 'web_bridge.dart';
import 'web_data.dart';

/// What the native screens show and do, all through the web page (reader.js
/// reads it and clicks in it): pages, the library, the queue, lyrics, menus.
class WebContent {
  WebContent(this.bridge);

  final WebBridge bridge;
  final _pages = <String, WebPage>{};
  List<LibraryItem>? _library;

  /// The page as last read, to show at once while it is read again.
  WebPage? cached(String path) => _pages[path];

  List<LibraryItem>? get cachedLibrary => _library;

  /// Reads a page (the page is taken there first). [fresh] forgets what
  /// earlier reads found further down.
  Pending<WebPage> page(String path, {bool fresh = false}) =>
      _ask('read', {'path': path, 'fresh': fresh}, (json) => _keep(path, json));

  /// Reads further down the page: long lists only show what is around where
  /// the page is scrolled.
  Pending<WebPage> more(String path) =>
      _ask('more', {'path': path}, (json) => _keep(path, json), timeout: const Duration(seconds: 40));

  WebPage _keep(String path, Object? json) {
    // Known by the path it was asked for, which actions on it go back to.
    final page = WebPage.fromJson({if (json is Map) ...Map<String, dynamic>.from(json), 'path': path});
    _pages[path] = page;
    if (_pages.length > 60) _pages.remove(_pages.keys.first);
    return page;
  }

  Pending<List<LibraryItem>> library() => _ask('readLibrary', const {}, (json) {
    final items = LibraryItem.listFrom(json);
    _library = items;
    return items;
  }, timeout: const Duration(seconds: 70));

  /// Plays a track from its page's list (as a double click on it would).
  Future<void> playTrack(String path, WebTrack track) =>
      _ask('playTrack', {'path': path, 'uri': track.uri, 'index': track.index}, _ignore).result;

  /// Plays the page from the start (its big play button).
  Future<void> playPage(String path) => _ask('playPage', {'path': path}, _ignore).result;

  /// Plays what a card leads to, from the card's own play button.
  Future<void> playCard(String path, WebCard card) =>
      _ask('playCard', {'path': path, 'target': card.path}, _ignore).result;

  /// Saves the page to the library, or removes it (its like / follow button).
  Future<bool?> toggleSaved(String path) =>
      _ask('pageSave', {'path': path}, (json) => json is bool ? json : null).result;

  Future<void> playFromQueue(QueueTarget target) => _ask('queuePlay', target.toJson(), _ignore).result;

  /// Opens a context menu in the page, which stays open for [pickMenu].
  Future<WebMenu> openMenu(MenuTarget target, {String? path}) =>
      _ask('menu', {'path': ?path, 'target': target.toJson()}, WebMenu.fromJson).result;

  /// Picks an entry of the open menu: a submenu ([WebMenu]) or what the entry
  /// did ([MenuOutcome]).
  Future<Object> pickMenu(WebMenu menu, int index) => _ask('menuPick', {'level': menu.level, 'index': index}, (json) {
    final map = json is Map ? Map<String, dynamic>.from(json) : <String, dynamic>{};
    return map['items'] is List ? WebMenu.fromJson(map) : MenuOutcome.fromJson(map);
  }).result;

  Future<void> closeMenu() => bridge.command('menuClose');

  /// The queue, as it changes, while listened to.
  Stream<QueueData> queue() => _watch('watchQueue', 'queue', QueueData.fromJson);

  /// The lyrics of the track playing, and the line being sung, while listened to.
  Stream<LyricsData> lyrics() => _watch('watchLyrics', 'lyrics', LyricsData.fromJson);

  Future<void> seekToLyric(int index) => bridge.command('lyricsSeek', {'index': index});

  /// The page itself shown (for what the app has no screen for): [path] opened
  /// first, or the library ([view]: 'library').
  Future<void> showWeb({String? path, String? view}) =>
      _ask('showWeb', {'path': ?path, 'view': ?view}, _ignore).result.catchError((_) {});

  /// An outline of the page, to find out what changed when it can't be read.
  Future<String> report() => _ask('report', const {}, (json) => '$json').result;

  static void _ignore(Object? _) {}

  Pending<T> _ask<T>(String name, Map<String, Object?> arguments, T Function(Object? json) parse, {Duration? timeout}) {
    late final Pending<T> pending;
    Future<T> run() async {
      await _ready();
      if (pending._cancelled) throw const WebError('Annulé', cancelled: true);
      final request = bridge.request(name, arguments, timeout);
      pending._request = request;
      return parse(await request.result);
    }

    pending = Pending._(run());
    return pending;
  }

  /// Requests wait for the page to be there.
  Future<void> _ready() async {
    if (bridge.state.value.appReady) return;
    final ready = Completer<void>();
    void check() {
      if (bridge.state.value.appReady && !ready.isCompleted) ready.complete();
    }

    bridge.state.addListener(check);
    try {
      await ready.future.timeout(const Duration(seconds: 30));
    } on TimeoutException {
      throw const WebError("La page Spotify ne s'est pas chargée");
    } finally {
      bridge.state.removeListener(check);
    }
  }

  /// What the page pushes on [topic] once [command] subscribed to it.
  Stream<T> _watch<T>(String command, String topic, T Function(Object? json) parse) {
    late final StreamController<T> controller;
    StreamSubscription<LiveEvent>? updates;
    Pending<T>? start;
    controller = StreamController<T>(
      onListen: () {
        updates = bridge.live
            .where((event) => event.topic == topic)
            .listen((event) => controller.add(parse(event.data)));
        start = _ask(command, {'live': true}, parse);
        start!.result.then(controller.add, onError: controller.addError);
      },
      onCancel: () {
        updates?.cancel();
        start?.cancel();
        bridge.command(command, {'live': false});
      },
    );
    return controller.stream;
  }
}

/// A request to the page, to cancel when its answer is no longer needed.
class Pending<T> {
  Pending._(this.result) {
    // Not an unhandled error when nobody waits for it any more.
    result.ignore();
  }

  final Future<T> result;
  WebRequest? _request;
  bool _cancelled = false;

  void cancel() {
    _cancelled = true;
    _request?.cancel();
  }
}
