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

  Future<void> _onCall(MethodCall call) async {
    switch (call.method) {
      case 'message':
        final message = jsonDecode(call.arguments as String);
        if (message is Map && message['type'] == 'state' && message['state'] is Map) {
          state.value = PlayerState.fromJson(Map<String, dynamic>.from(message['state'] as Map));
        }
      case 'location':
        location.value = Uri.tryParse(call.arguments as String);
      case 'pageStart':
        loadError.value = null;
      case 'loadError':
        loadError.value = call.arguments as String;
    }
  }

  /// False when the page isn't listening (loading, or on the login pages).
  Future<bool> command(String name, [Object? argument]) async {
    try {
      return await _channel.invokeMethod<bool>('command', {'name': name, 'arg': argument}) ?? false;
    } on PlatformException {
      return false;
    }
  }

  Future<bool> toggle() => command('toggle');
  Future<bool> play() => command('play');
  Future<bool> pause() => command('pause');
  Future<bool> next() => command('next');
  Future<bool> previous() => command('previous');
  Future<bool> seek(Duration position) => command('seek', position.inMilliseconds);
  Future<bool> toggleShuffle() => command('shuffle');
  Future<bool> cycleRepeat() => command('repeat');
  Future<bool> toggleLike() => command('like');

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
