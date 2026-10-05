import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spotiweb/src/app_actions.dart';
import 'package:spotiweb/src/web_bridge.dart';
import 'package:spotiweb/src/web_content.dart';
import 'package:spotiweb/src/web_data.dart';

/// What assets/inject/reader.js answered on a Spotify-like page (see
/// test/fixtures/reader.json): the shapes the app reads.
final Map<String, dynamic> readerFixtures =
    jsonDecode(File('test/fixtures/reader.json').readAsStringSync()) as Map<String, dynamic>;

Map<String, dynamic> fixture(String name) => Map<String, dynamic>.from(readerFixtures[name] as Map);

/// The web page as the app sees it in tests: commands are recorded, requests
/// answered from [answers] (by command name; throwing makes an error reply),
/// and the page can send messages of its own.
///
/// Replies wait for [flush] or [settle]: messages from the page only reach the
/// app when sent from the test itself.
class FakePage {
  FakePage(this.tester) {
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(_channel, _onCall);
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('spotiweb/system'),
      (_) async => null,
    );
  }

  static const _channel = MethodChannel('spotiweb/player');

  final WidgetTester tester;
  final commands = <({String name, Object? arg})>[];
  final answers = <String, Object? Function(Map<String, Object?> arg)>{};
  final _replies = <Map<String, Object?>>[];

  Iterable<String> get names => commands.map((command) => command.name);

  /// The arguments of the commands of that name, in order.
  List<Map<String, Object?>> argsOf(String name) => [
    for (final command in commands)
      if (command.name == name && command.arg is Map) Map<String, Object?>.from(command.arg! as Map),
  ];

  Future<Object?> _onCall(MethodCall call) async {
    if (call.method != 'command') return null;
    final map = Map<String, Object?>.from(call.arguments as Map);
    final name = map['name']! as String;
    final arg = map['arg'];
    commands.add((name: name, arg: arg));
    final answer = answers[name];
    if (arg is Map && arg['__id'] != null && answer != null) {
      final id = arg['__id'];
      try {
        _replies.add({'type': 'reply', 'id': id, 'result': answer(Map<String, Object?>.from(arg))});
      } catch (error) {
        _replies.add({'type': 'reply', 'id': id, 'error': '$error'});
      }
    }
    return true;
  }

  /// Sends the replies due, then lets the app take them in.
  Future<void> flush() async {
    while (_replies.isNotEmpty) {
      await send(_replies.removeAt(0));
    }
    await tester.pump();
  }

  /// Rounds of requests and replies, until the app asks for nothing more.
  Future<void> settle() async {
    for (var round = 0; round < 10; round++) {
      await tester.pump();
      if (_replies.isEmpty) {
        await tester.pump(const Duration(milliseconds: 50));
        if (_replies.isEmpty) return;
      }
      await flush();
    }
  }

  /// A message from the page (state, reply, live update…).
  Future<void> send(Map<String, Object?> message) => tester.binding.defaultBinaryMessenger.handlePlatformMessage(
    _channel.name,
    _channel.codec.encodeMethodCall(MethodCall('message', jsonEncode(message))),
    (_) {},
  );

  Future<void> state(Map<String, Object?> state) => send({
    'type': 'state',
    'state': {'appReady': true, 'loggedIn': true, ...state},
  });

  Future<void> live(String topic, Object? data) => send({'type': 'live', 'topic': topic, 'data': data});
}

/// The shell's part, for screens tested alone: what they ask is recorded.
class TestApp implements AppActions {
  TestApp(this.bridge) : content = WebContent(bridge);

  @override
  final WebBridge bridge;

  @override
  final WebContent content;

  final opened = <String>[];
  final webs = <({String? path, String? view})>[];
  final menus = <(MenuTarget, String?)>[];
  final notices = <String>[];
  var queues = 0;
  var lyrics = 0;
  var settings = 0;

  @override
  void openPath(String path, {WebCard? preview}) => opened.add(path);

  @override
  void openWeb({String? path, String? view}) => webs.add((path: path, view: view));

  @override
  void openQueue() => queues++;

  @override
  void openLyrics() => lyrics++;

  @override
  void openSettings() => settings++;

  @override
  Future<void> showMenu(MenuTarget target, {String? path, MenuHeader? header}) async => menus.add((target, path));

  @override
  void notify(String message) => notices.add(message);
}

/// Pictures can't load in tests: pages without them.
Map<String, dynamic> withoutImages(Map<String, dynamic> json) => _strip(json) as Map<String, dynamic>;

Object? _strip(Object? json) => switch (json) {
  Map() => {
    for (final MapEntry(key: name, :value) in json.entries) name as String: name == 'image' ? '' : _strip(value),
  },
  List() => [for (final item in json) _strip(item)],
  _ => json,
};
