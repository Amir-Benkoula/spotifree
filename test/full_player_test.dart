import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spotiweb/src/full_player.dart';
import 'package:spotiweb/src/player_state.dart';
import 'package:spotiweb/src/web_bridge.dart';
import 'package:spotiweb/src/widgets.dart';

void main() {
  late WebBridge bridge;
  late List<String> commands;
  late int verticalDrags;

  // Covers are left empty: network images can't load in tests.
  PlayerState track(String title, {bool canNext = true, bool canPrevious = true}) =>
      PlayerState(hasTrack: true, title: title, artist: 'Artiste', canNext: canNext, canPrevious: canPrevious);

  Future<void> showPlayer(WidgetTester tester, PlayerState state) async {
    commands = [];
    verticalDrags = 0;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(const MethodChannel('spotiweb/player'), (
      call,
    ) async {
      if (call.method == 'command') commands.add((call.arguments as Map)['name'] as String);
      return true;
    });
    bridge = WebBridge()..state.value = state;
    await tester.pumpWidget(
      MaterialApp(
        // Inside the shell's Scaffold, like in the app.
        home: Scaffold(
          body: FullPlayer(bridge: bridge, onClose: () {}, onDragUpdate: (_) => verticalDrags++, onDragEnd: (_) {}),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  final cover = find.byType(Artwork);
  double coverX(WidgetTester tester) => tester.getCenter(cover).dx;

  testWidgets('a swipe to the left skips to the next track, which comes in from the right', (tester) async {
    await showPlayer(tester, track('A'));
    final home = coverX(tester);

    await tester.fling(cover, const Offset(-200, 0), 1500);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(commands, ['next']);
    expect(coverX(tester), lessThan(0), reason: 'off screen to the left');

    bridge.state.value = track('B');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    expect(coverX(tester), greaterThan(home), reason: 'coming in from the right');
    await tester.pumpAndSettle();
    expect(coverX(tester), moreOrLessEquals(home));
    expect(commands, ['next']);
  });

  testWidgets('the old cover leaves, the new one comes in', (tester) async {
    // Covers can't load in tests: those errors don't matter here.
    final onError = FlutterError.onError;
    FlutterError.onError = (details) {
      if (details.library != 'image resource service') onError!(details);
    };
    Finder coverOf(String url) => find.byWidgetPredicate((widget) => widget is Artwork && widget.url == url);
    const a = PlayerState(hasTrack: true, title: 'A', artwork: 'https://i.scdn.co/image/a', canNext: true);
    const b = PlayerState(hasTrack: true, title: 'B', artwork: 'https://i.scdn.co/image/b', canNext: true);

    await showPlayer(tester, a);
    await tester.fling(cover, const Offset(-200, 0), 1500);
    await tester.pump();
    bridge.state.value = b;
    await tester.pump(const Duration(milliseconds: 100));
    expect(coverOf(a.artwork), findsOneWidget, reason: 'still leaving');
    await tester.pump(const Duration(milliseconds: 900));
    expect(coverOf(b.artwork), findsOneWidget);
    await tester.pumpAndSettle();
    expect(coverOf(b.artwork), findsOneWidget);
    // Lets the cover colour lookups time out.
    await tester.pump(const Duration(seconds: 6));
    FlutterError.onError = onError;
  });

  testWidgets('a swipe to the right goes back to the previous track', (tester) async {
    await showPlayer(tester, track('B'));
    await tester.fling(cover, const Offset(200, 0), 1500);
    await tester.pump();
    expect(commands, ['previousTrack']);
    bridge.state.value = track('A');
    await tester.pumpAndSettle();
  });

  testWidgets('the cover comes back as it was if the track never changes', (tester) async {
    await showPlayer(tester, track('A'));
    final home = coverX(tester);
    await tester.fling(cover, const Offset(-200, 0), 1500);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1000));
    expect(coverX(tester), lessThan(0));
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();
    expect(coverX(tester), moreOrLessEquals(home));
    expect(commands, ['next']);
  });

  testWidgets('a short, slow drag only moves the cover, which settles back', (tester) async {
    await showPlayer(tester, track('A'));
    final home = coverX(tester);
    final gesture = await tester.startGesture(tester.getCenter(cover));
    for (var i = 0; i < 3; i++) {
      await gesture.moveBy(const Offset(-40, 0));
      await tester.pump();
    }
    expect(coverX(tester), lessThan(home - 40), reason: 'follows the finger');
    await tester.pump(const Duration(milliseconds: 500));
    await gesture.up();
    await tester.pumpAndSettle();
    expect(coverX(tester), moreOrLessEquals(home));
    expect(commands, isEmpty);
  });

  testWidgets('no skip where there is nowhere to go', (tester) async {
    await showPlayer(tester, track('A', canNext: false));
    final home = coverX(tester);
    await tester.fling(cover, const Offset(-200, 0), 1500);
    await tester.pumpAndSettle();
    expect(commands, isEmpty);
    expect(coverX(tester), moreOrLessEquals(home));
  });

  testWidgets('dragging the cover down still closes the player', (tester) async {
    await showPlayer(tester, track('A'));
    await tester.drag(cover, const Offset(0, 200));
    await tester.pumpAndSettle();
    expect(verticalDrags, greaterThan(0));
    expect(commands, isEmpty);
  });
}
