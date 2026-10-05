import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'player_state.dart';

/// Link with the page running in GeckoView (GeckoPlayer.kt): page reports arrive
/// as `message` calls, commands leave as `command` calls and reach
/// `window.__spotiweb.cmd` in the page (bootstrap.js, through relay.js).
class WebBridge {
  WebBridge() {
    _channel.setMethodCallHandler(_onCall);
  }

  static const _channel = MethodChannel('spotiweb/player');

  final ValueNotifier<PlayerState> state = ValueNotifier(PlayerState.empty);

  /// Top-level URL shown by the player view.
  final ValueNotifier<Uri?> location = ValueNotifier(null);

  /// Why the last page load failed; cleared when a new load starts.
  final ValueNotifier<String?> loadError = ValueNotifier(null);

  final _live = StreamController<LiveEvent>.broadcast();
  final _notices = StreamController<String>.broadcast();
  final _pending = <int, Completer<Object?>>{};
  int _lastId = 0;

  /// What subscriptions in the page push (queue, lyrics), see [request].
  Stream<LiveEvent> get live => _live.stream;

  /// Short messages for the user (a link copied…).
  Stream<String> get notices => _notices.stream;

  Future<void> _onCall(MethodCall call) async {
    switch (call.method) {
      case 'message':
        final message = jsonDecode(call.arguments as String);
        if (message is Map) _onMessage(message);
      case 'location':
        location.value = Uri.tryParse(call.arguments as String);
      case 'pageStart':
        loadError.value = null;
        // A new document: what the previous one was doing is gone.
        _failPending('La page a été rechargée');
      case 'loadError':
        loadError.value = call.arguments as String;
    }
  }

  void _onMessage(Map<dynamic, dynamic> message) {
    switch (message['type']) {
      case 'state' when message['state'] is Map:
        state.value = PlayerState.fromJson(Map<String, dynamic>.from(message['state'] as Map));
      case 'reply':
        final completer = _pending.remove((message['id'] as num?)?.toInt());
        if (completer == null) return;
        final error = message['error'];
        if (error != null) {
          completer.completeError(WebError('$error'));
        } else {
          completer.complete(message['result']);
        }
      case 'live':
        _live.add(LiveEvent('${message['topic']}', message['data']));
      case 'clipboard':
        // What the page copies goes to the phone's clipboard.
        final text = '${message['text'] ?? ''}';
        if (text.isEmpty) return;
        Clipboard.setData(ClipboardData(text: text));
        _notices.add('Copié dans le presse-papiers');
    }
  }

  void _failPending(String reason) {
    final pending = _pending.values.toList();
    _pending.clear();
    for (final completer in pending) {
      completer.completeError(WebError(reason));
    }
  }

  void notify(String message) => _notices.add(message);

  /// False when the page isn't listening (loading, or on the login pages).
  Future<bool> command(String name, [Object? argument]) async {
    try {
      return await _channel.invokeMethod<bool>('command', {'name': name, 'arg': argument}) ?? false;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  /// A command whose result the page sends back (reader.js): it may take a
  /// while, as the page is taken somewhere and read.
  WebRequest request(String name, [Map<String, Object?> arguments = const {}, Duration? timeout]) {
    final id = ++_lastId;
    final completer = Completer<Object?>();
    _pending[id] = completer;
    command(name, {...arguments, '__id': id}).then((sent) {
      if (!sent && _pending.remove(id) != null) completer.completeError(const WebError('La page ne répond pas'));
    });
    final result = completer.future.timeout(
      timeout ?? const Duration(seconds: 30),
      onTimeout: () {
        _pending.remove(id);
        command('cancel', {'id': id});
        throw const WebError('La page met trop de temps à répondre');
      },
    );
    return WebRequest._(this, id, result);
  }

  Future<bool> toggle() => command('toggle');
  Future<bool> play() => command('play');
  Future<bool> pause() => command('pause');
  Future<bool> next() => command('next');
  Future<bool> previous() => command('previous');

  /// The previous track even when the current one has played for a while,
  /// where [previous] restarts it, like the player's button.
  Future<bool> previousTrack() => command('previousTrack');

  Future<bool> seek(Duration position) => command('seek', position.inMilliseconds);
  Future<bool> toggleShuffle() => command('shuffle');
  Future<bool> cycleRepeat() => command('repeat');
  Future<bool> toggleLike() => command('like');
  Future<bool> setAdBlock(bool on) => command('adBlock', on);

  /// The app shows the web page itself, as before its own screens existed.
  Future<bool> setWebUi(bool on) => command('webUi', on);

  Future<bool> goHome() => command('home');
  Future<bool> openSearch() => command('search');
  Future<bool> showLibrary(bool visible) => command('library', visible);
  Future<bool> openQueue() => command('queue');
  Future<bool> openLyrics() => command('lyrics');
  Future<bool> closePanel() => command('closePanel');
  Future<bool> openArtist() => command('openArtist');
  Future<bool> login() => command('login');

  /// Steps back in the page history; false when there is nothing to go back to.
  Future<bool> goBack() async => await _channel.invokeMethod<bool>('goBack') ?? false;

  Future<void> reload() => _channel.invokeMethod<void>('reload');
}

/// A request to the page, which the app can drop when it no longer needs it.
class WebRequest {
  WebRequest._(this._bridge, this.id, this.result) {
    // Not an unhandled error when nobody waits for it any more.
    result.ignore();
  }

  final WebBridge _bridge;
  final int id;
  final Future<Object?> result;

  /// Spares the page what is left to do; [result] fails.
  void cancel() {
    final completer = _bridge._pending.remove(id);
    if (completer == null) return;
    _bridge.command('cancel', {'id': id});
    completer.completeError(const WebError('Annulé', cancelled: true));
  }
}

/// What a page subscription pushed.
class LiveEvent {
  const LiveEvent(this.topic, this.data);

  final String topic;
  final Object? data;
}

class WebError implements Exception {
  const WebError(this.message, {this.cancelled = false});

  final String message;
  final bool cancelled;

  @override
  String toString() => message;
}
