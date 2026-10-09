import AVFoundation
import Flutter
import UIKit

/// The "spotiweb/system" channel (SystemChannel in Dart), as MainActivity.kt
/// answers it on Android.
final class SystemBridge: NSObject {
  private let channel: FlutterMethodChannel

  init(messenger: FlutterBinaryMessenger) {
    channel = FlutterMethodChannel(name: "spotiweb/system", binaryMessenger: messenger)
    super.init()
    channel.setMethodCallHandler { call, result in
      switch call.method {
      case "moveTaskToBack":
        // An iOS app can't send itself to the background.
        result(false)
      case "openUrl":
        if let link = call.arguments as? String, let url = URL(string: link) {
          UIApplication.shared.open(url)
        }
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
    // Headphones unplugged, Bluetooth audio gone: the page doesn't pause by itself.
    NotificationCenter.default.addObserver(
      self, selector: #selector(audioRouteChanged(_:)), name: AVAudioSession.routeChangeNotification, object: nil)
  }

  @objc private func audioRouteChanged(_ notification: Notification) {
    guard let value = notification.userInfo?[AVAudioSessionRouteChangeReasonKey] as? UInt,
      AVAudioSession.RouteChangeReason(rawValue: value) == .oldDeviceUnavailable
    else { return }
    DispatchQueue.main.async {
      self.channel.invokeMethod("becomingNoisy", arguments: nil)
    }
  }
}
