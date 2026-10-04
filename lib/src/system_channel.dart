import 'package:flutter/services.dart';

/// Native helpers implemented in MainActivity.kt.
abstract final class SystemChannel {
  static const _channel = MethodChannel('spotiweb/system');

  /// [onBecomingNoisy] fires when headphones are unplugged or Bluetooth audio drops.
  static void listen({required VoidCallback onBecomingNoisy}) {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'becomingNoisy') onBecomingNoisy();
    });
  }

  /// Sends the app to the background like the home button: unlike finishing the
  /// activity, this keeps the WebView (and the music) alive.
  static Future<void> moveTaskToBack() => _channel.invokeMethod<void>('moveTaskToBack');
}
