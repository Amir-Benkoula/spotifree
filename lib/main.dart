import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/audio_handler.dart';
import 'src/shell.dart';
import 'src/system_channel.dart';
import 'src/web_bridge.dart';
import 'src/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  final bridge = WebBridge();
  final session = await AudioSession.instance;
  await session.configure(const AudioSessionConfiguration.music());
  await AudioService.init(
    builder: () => WebPlayerAudioHandler(
      bridge,
      interruptions: session.interruptionEventStream,
      setAudioActive: session.setActive,
    ),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.amirbenkoula.spotiweb.playback',
      androidNotificationChannelName: 'Lecture',
      // White on transparent, with a color: some devices draw the notification's
      // seek bar only then (android/app/src/main/res/drawable/).
      androidNotificationIcon: 'drawable/ic_stat_music',
      notificationColor: spotifyGreen,
      // Stay in the foreground while paused: Android 12+ forbids restarting a
      // foreground service from the background (e.g. a Bluetooth play button).
      androidStopForegroundOnPause: false,
    ),
  );
  SystemChannel.listen(
    onBecomingNoisy: () {
      if (bridge.state.value.playing) bridge.pause();
    },
  );

  runApp(SpotiwebApp(bridge: bridge));
}

class SpotiwebApp extends StatelessWidget {
  const SpotiwebApp({super.key, required this.bridge});

  final WebBridge bridge;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpotiWeb',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: spotifyGreen,
          brightness: Brightness.dark,
          surface: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      home: Shell(bridge: bridge),
    );
  }
}
