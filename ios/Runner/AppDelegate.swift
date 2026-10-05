import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private var player: WebPlayer?
  private var system: SystemBridge?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    // The web player (WebPlayer.swift) and the system helpers (SystemBridge.swift).
    guard let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "SpotiWeb") else { return }
    let player = WebPlayer(registrar: registrar)
    registrar.register(player, withId: WebPlayer.viewType)
    self.player = player
    system = SystemBridge(messenger: registrar.messenger())
  }
}
