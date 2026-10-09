import 'package:flutter/services.dart';

/// Native helpers implemented in MainActivity.kt (Android) and SystemBridge.swift (iOS).
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

  /// Android: where updates are downloaded (the app's cache).
  static Future<String> updatesDir() async => await _channel.invokeMethod<String>('updatesDir') ?? '';

  /// Android: hands a downloaded APK to the system installer, which asks to confirm
  /// (and, the first time, to allow the app to install updates).
  static Future<void> installApk(String path) => _channel.invokeMethod<void>('installApk', path);

  /// Opens a link outside the app (browser).
  static Future<void> openUrl(String url) => _channel.invokeMethod<void>('openUrl', url);
}
