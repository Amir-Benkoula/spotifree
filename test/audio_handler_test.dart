import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spotiweb/src/audio_handler.dart';
import 'package:spotiweb/src/player_state.dart';
import 'package:spotiweb/src/web_bridge.dart';

void main() {
  late WebBridge bridge;
  late WebPlayerAudioHandler handler;
  late StreamController<AudioInterruptionEvent> interruptions;
  late List<String> commands;
  late List<bool> focus;
  late bool focusGranted;

  const playing = PlayerState(hasTrack: true, title: 'A', playing: true);
  const paused = PlayerState(hasTrack: true, title: 'A');

  // Runs in testWidgets for its fake clock (the idle delay).
  Future<void> setUpHandler(WidgetTester tester) async {
    commands = [];
    focus = [];
    focusGranted = true;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(const MethodChannel('spotiweb/player'), (
      call,
    ) async {
      if (call.method == 'command') commands.add((call.arguments as Map)['name'] as String);
      return true;
    });
    bridge = WebBridge();
    interruptions = StreamController<AudioInterruptionEvent>();
    handler = WebPlayerAudioHandler(
      bridge,
      interruptions: interruptions.stream,
      setAudioActive: (active) async {
        focus.add(active);
        return !active || focusGranted;
      },
    );
  }

  Future<void> interrupt(WidgetTester tester, bool begin, AudioInterruptionType type) async {
    interruptions.add(AudioInterruptionEvent(begin, type));
    await tester.pump();
  }

  testWidgets('asks for the audio focus when playback starts', (tester) async {
    await setUpHandler(tester);
    bridge.state.value = paused;
    await tester.pump();
    expect(focus, isEmpty);
    bridge.state.value = playing;
    await tester.pump();
    expect(focus, [true]);
    expect(handler.playbackState.value.playing, isTrue);
  });

  testWidgets('a refused focus request is dropped, so the next one asks again', (tester) async {
    await setUpHandler(tester);
    focusGranted = false;
    bridge.state.value = playing;
    await tester.pump();
    expect(focus, [true, false]);
    expect(commands, isEmpty, reason: 'playback is left alone');
  });

  testWidgets('a call pauses the music, which comes back after it', (tester) async {
    await setUpHandler(tester);
    bridge.state.value = playing;
    await tester.pump();
    await interrupt(tester, true, AudioInterruptionType.pause);
    expect(commands, ['pause']);
    bridge.state.value = paused;
    await interrupt(tester, false, AudioInterruptionType.pause);
    expect(commands, ['pause', 'play']);
  });

  testWidgets('another player taking over pauses the music for good', (tester) async {
    await setUpHandler(tester);
    bridge.state.value = playing;
    await tester.pump();
    await interrupt(tester, true, AudioInterruptionType.unknown);
    bridge.state.value = paused;
    await interrupt(tester, false, AudioInterruptionType.pause);
    expect(commands, ['pause']);
  });

  testWidgets('another player taking over during a call cancels the comeback', (tester) async {
    await setUpHandler(tester);
    bridge.state.value = playing;
    await tester.pump();
    await interrupt(tester, true, AudioInterruptionType.pause);
    bridge.state.value = paused;
    await interrupt(tester, true, AudioInterruptionType.unknown);
    await interrupt(tester, false, AudioInterruptionType.pause);
    expect(commands, ['pause']);
  });

  testWidgets('ducking, and interruptions while paused, leave playback alone', (tester) async {
    await setUpHandler(tester);
    bridge.state.value = playing;
    await tester.pump();
    await interrupt(tester, true, AudioInterruptionType.duck);
    await interrupt(tester, false, AudioInterruptionType.duck);
    bridge.state.value = paused;
    await interrupt(tester, true, AudioInterruptionType.pause);
    await interrupt(tester, false, AudioInterruptionType.pause);
    expect(commands, isEmpty);
  });

  testWidgets('playing again by hand during an interruption cancels the comeback', (tester) async {
    await setUpHandler(tester);
    bridge.state.value = playing;
    await tester.pump();
    await interrupt(tester, true, AudioInterruptionType.pause);
    bridge.state.value = paused;
    await tester.pump();
    bridge.state.value = playing;
    await tester.pump();
    bridge.state.value = paused;
    await interrupt(tester, false, AudioInterruptionType.pause);
    expect(commands, ['pause']);
  });

  testWidgets('the media session outlives a short gap without a track', (tester) async {
    await setUpHandler(tester);
    bridge.state.value = playing;
    await tester.pump();
    expect(handler.playbackState.value.processingState, AudioProcessingState.ready);

    bridge.state.value = const PlayerState(playing: true);
    await tester.pump(const Duration(seconds: 5));
    expect(handler.playbackState.value.processingState, AudioProcessingState.ready);
    bridge.state.value = const PlayerState(hasTrack: true, title: 'B', playing: true);
    await tester.pump(WebPlayerAudioHandler.idleDelay);
    expect(handler.playbackState.value.processingState, AudioProcessingState.ready);
    expect(handler.mediaItem.value?.title, 'B');

    bridge.state.value = const PlayerState();
    await tester.pump(WebPlayerAudioHandler.idleDelay);
    expect(handler.playbackState.value.processingState, AudioProcessingState.idle);
    expect(focus.last, isFalse, reason: 'the audio focus goes with it');
  });
}
