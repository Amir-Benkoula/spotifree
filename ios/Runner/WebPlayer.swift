import Flutter
import UIKit
import WebKit

/// open.spotify.com in a WKWebView: on iOS what GeckoPlayer.kt is on Android,
/// the platform view showing the page and the "spotiweb/player" channel
/// between the page and Dart.
///
/// iOS apps can only show web pages through WebKit. The page scripts and the
/// stylesheet (Flutter assets in assets/inject/) are added as user scripts,
/// which run in the page's own world like the Android extension's content
/// scripts; relay-webkit.js stands in for relay.js and posts the page's
/// messages to a script message handler.
final class WebPlayer: NSObject, FlutterPlatformViewFactory {
  /// Must match the view type in lib/src/spotify_web_view.dart.
  static let viewType = "spotiweb/webkit"

  private static let playerURL = URL(string: "https://open.spotify.com/")!

  /// Must match relay-webkit.js.
  private static let handlerName = "spotiweb"

  /// In this order, at the start of the document, before the page's own scripts.
  private static let scripts = ["webkit.js", "bootstrap.js", "reader.js", "relay-webkit.js"]

  private let registrar: FlutterPluginRegistrar
  private let channel: FlutterMethodChannel
  private var webView: WKWebView?
  private var urlObservation: NSKeyValueObservation?

  /// The page's relay listens (it says so first thing).
  private var pageReady = false

  init(registrar: FlutterPluginRegistrar) {
    self.registrar = registrar
    channel = FlutterMethodChannel(name: "spotiweb/player", binaryMessenger: registrar.messenger())
    super.init()
    channel.setMethodCallHandler { [weak self] call, result in
      guard let self else {
        result(FlutterMethodNotImplemented)
        return
      }
      self.handle(call, result: result)
    }
  }

  // MARK: - Platform view

  func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
    FlutterStandardMessageCodec.sharedInstance()
  }

  func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
    // One page for the app's whole life: should the Flutter widget be built
    // again, the new view takes the page already there (and its music).
    if let webView {
      return PlayerView(webView)
    }
    let noInject = (args as? [String: Any])?["noInject"] as? Bool ?? false
    return PlayerView(makeWebView(inject: !noInject))
  }

  private func makeWebView(inject: Bool) -> WKWebView {
    let configuration = WKWebViewConfiguration()
    // Played in the page, and from the app's controls without a tap in it.
    configuration.allowsInlineMediaPlayback = true
    configuration.mediaTypesRequiringUserActionForPlayback = []
    if inject {
      let content = configuration.userContentController
      if let css = asset("mobile.css") {
        content.addUserScript(
          WKUserScript(source: Self.styleScript(css), injectionTime: .atDocumentStart, forMainFrameOnly: true))
      }
      for name in Self.scripts {
        guard let source = asset(name) else {
          NSLog("SpotiWeb: missing page script %@", name)
          continue
        }
        content.addUserScript(WKUserScript(source: source, injectionTime: .atDocumentStart, forMainFrameOnly: true))
      }
      content.add(MessageRelay(self), name: Self.handlerName)
    }

    let webView = WKWebView(frame: .zero, configuration: configuration)
    webView.customUserAgent = Self.desktopUserAgent()
    webView.navigationDelegate = self
    webView.uiDelegate = self
    webView.isOpaque = false
    webView.backgroundColor = .black
    webView.scrollView.backgroundColor = .black
    // The app keeps the page within the safe area itself.
    webView.scrollView.contentInsetAdjustmentBehavior = .never
    if #available(iOS 16.4, *) {
      // Safari on a Mac can inspect the page (Develop menu), to see what goes wrong.
      webView.isInspectable = true
    }
    urlObservation = webView.observe(\.url, options: [.new]) { [weak self] view, _ in
      guard let url = view.url else { return }
      self?.channel.invokeMethod("location", arguments: url.absoluteString)
    }
    webView.load(URLRequest(url: Self.playerURL))
    self.webView = webView
    return webView
  }

  /// A Flutter asset of the page scripts (assets/inject/), from the app bundle.
  private func asset(_ name: String) -> String? {
    let key = registrar.lookupKey(forAsset: "assets/inject/\(name)")
    guard let path = Bundle.main.path(forResource: key, ofType: nil) else { return nil }
    return try? String(contentsOfFile: path, encoding: .utf8)
  }

  /// mobile.css, added by a script: apps can only add scripts to pages. (There
  /// is a document element at document start, but should there not be yet…)
  private static func styleScript(_ css: String) -> String {
    """
    (() => {
      if (location.hostname !== 'open.spotify.com') return;
      const style = document.createElement('style');
      style.textContent = \(jsString(css));
      const add = () => (document.head || document.documentElement).appendChild(style);
      if (document.documentElement) return add();
      new MutationObserver((_, observer) => {
        if (!document.documentElement) return;
        observer.disconnect();
        add();
      }).observe(document, { childList: true });
    })();
    """
  }

  /// A JavaScript string literal of text.
  private static func jsString(_ text: String) -> String {
    guard let data = try? JSONEncoder().encode(text), let literal = String(data: data, encoding: .utf8) else {
      return "''"
    }
    return literal
  }

  /// Safari on a Mac, the same version as this iOS's WebKit: Spotify then serves
  /// its full web player rather than its mobile site.
  private static func desktopUserAgent() -> String {
    let major = UIDevice.current.systemVersion.split(separator: ".").first.map(String.init) ?? "18"
    return "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) "
      + "Version/\(major).0 Safari/605.1.15"
  }

  /// Hosts allowed to load inside the app: the player and the login flows.
  private static func staysInApp(_ url: URL) -> Bool {
    guard let host = url.host?.lowercased() else { return false }
    let domains = ["spotify.com", "spotifycdn.com", "scdn.co", "accounts.google.com", "facebook.com", "appleid.apple.com"]
    return domains.contains { host == $0 || host.hasSuffix(".\($0)") }
  }

  // MARK: - Dart calls

  private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "command":
      // False when the page isn't listening (loading, or on the login pages).
      guard let webView, pageReady,
        let arguments = call.arguments as? [String: Any],
        let name = arguments["name"] as? String
      else {
        result(false)
        return
      }
      var message: [String: Any] = ["name": name]
      if let arg = arguments["arg"], !(arg is NSNull) {
        message["arg"] = arg
      }
      guard JSONSerialization.isValidJSONObject(message),
        let data = try? JSONSerialization.data(withJSONObject: message),
        let json = String(data: data, encoding: .utf8)
      else {
        result(false)
        return
      }
      webView.evaluateJavaScript(
        "window.dispatchEvent(new CustomEvent('spotiweb:in', { detail: \(Self.jsString(json)) })); true",
        completionHandler: nil)
      result(true)
    case "goBack":
      if let webView, webView.canGoBack {
        webView.goBack()
        result(true)
      } else {
        result(false)
      }
    case "reload":
      webView?.reload()
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  /// A message of the page (relay-webkit.js): state, replies, live updates…
  fileprivate func receive(_ message: WKScriptMessage) {
    guard message.frameInfo.isMainFrame, message.frameInfo.securityOrigin.host == "open.spotify.com",
      let text = message.body as? String
    else { return }
    pageReady = true
    channel.invokeMethod("message", arguments: text)
  }

  private func reportLoadError(_ error: Error) {
    let error = error as NSError
    // Loads stopped on purpose: a newer one, or a link opened outside the app.
    if error.domain == NSURLErrorDomain && error.code == NSURLErrorCancelled { return }
    // Frame load interrupted by a policy change.
    if error.domain == "WebKitErrorDomain" && error.code == 102 { return }
    let reason = error.domain == NSURLErrorDomain ? "réseau" : "\(error.code)"
    channel.invokeMethod("loadError", arguments: "Erreur de chargement (\(reason))")
  }
}

// MARK: - Navigation

extension WebPlayer: WKNavigationDelegate {
  func webView(
    _ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
    decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
  ) {
    guard let url = navigationAction.request.url, let scheme = url.scheme?.lowercased() else {
      decisionHandler(.cancel)
      return
    }
    switch scheme {
    case "about", "data", "blob":
      decisionHandler(.allow)
    case "http", "https":
      // Frames load as they are; the page itself stays on Spotify and its login
      // providers, anything else opens outside the app.
      if navigationAction.targetFrame?.isMainFrame == false || Self.staysInApp(url) {
        decisionHandler(.allow)
      } else {
        UIApplication.shared.open(url)
        decisionHandler(.cancel)
      }
    default:
      // spotify:, itms-apps:… would leave for the official app or the App Store.
      decisionHandler(.cancel)
    }
  }

  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    pageReady = false
    channel.invokeMethod("pageStart", arguments: webView.url?.absoluteString ?? "")
  }

  func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    reportLoadError(error)
  }

  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    reportLoadError(error)
  }

  // The page's process can be ended (memory pressure in the background): start over.
  func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
    pageReady = false
    webView.load(URLRequest(url: Self.playerURL))
  }
}

extension WebPlayer: WKUIDelegate {
  // Popups (window.open, target=_blank) open in place or outside the app.
  func webView(
    _ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration,
    for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures
  ) -> WKWebView? {
    if let url = navigationAction.request.url {
      if Self.staysInApp(url) {
        webView.load(navigationAction.request)
      } else {
        UIApplication.shared.open(url)
      }
    }
    return nil
  }
}

/// The page, as a Flutter platform view.
private final class PlayerView: NSObject, FlutterPlatformView {
  private let webView: WKWebView

  init(_ webView: WKWebView) {
    self.webView = webView
  }

  func view() -> UIView { webView }
}

/// Script message handler that doesn't keep the player alive (WebKit keeps its handlers).
private final class MessageRelay: NSObject, WKScriptMessageHandler {
  private weak var player: WebPlayer?

  init(_ player: WebPlayer) {
    self.player = player
  }

  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    player?.receive(message)
  }
}
