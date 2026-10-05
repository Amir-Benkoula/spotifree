import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'web_bridge.dart';

/// Must match GeckoPlayer.VIEW_TYPE (Android) and WebPlayer.viewType (iOS).
const _viewType = 'spotiweb/gecko';
const _iosViewType = 'spotiweb/webkit';

/// Diagnostic switch: `--dart-define=SPOTIWEB_NO_INJECT=true` loads the bare
/// desktop site, to tell our injected script/CSS apart from Spotify changes.
const _injectionDisabled = bool.fromEnvironment('SPOTIWEB_NO_INJECT');

/// open.spotify.com in GeckoView (Firefox's engine), see GeckoPlayer.kt. Android
/// WebView isn't used: Spotify refuses to play in it. On iOS, where apps can
/// only use WebKit, in a WKWebView (ios/Runner/WebPlayer.swift).
class SpotifyWebView extends StatelessWidget {
  const SpotifyWebView({super.key, required this.bridge});

  final WebBridge bridge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (defaultTargetPlatform == TargetPlatform.iOS) _webKitView() else _geckoView(),
        ValueListenableBuilder<String?>(
          valueListenable: bridge.loadError,
          builder: (context, error, _) => error == null
              ? const SizedBox.shrink()
              : Positioned.fill(
                  child: _ErrorView(message: error, onRetry: bridge.reload),
                ),
        ),
      ],
    );
  }

  Widget _geckoView() {
    return PlatformViewLink(
      viewType: _viewType,
      // Hybrid composition: the native view scrolls and takes text input as is.
      surfaceFactory: (context, controller) => AndroidViewSurface(
        controller: controller as AndroidViewController,
        hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        gestureRecognizers: {Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer())},
      ),
      onCreatePlatformView: (params) =>
          PlatformViewsService.initExpensiveAndroidView(
              id: params.id,
              viewType: _viewType,
              layoutDirection: TextDirection.ltr,
              creationParams: const {'noInject': _injectionDisabled},
              creationParamsCodec: const StandardMessageCodec(),
              onFocus: () => params.onFocusChanged(true),
            )
            ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
            ..create(),
    );
  }

  Widget _webKitView() {
    return UiKitView(
      viewType: _iosViewType,
      layoutDirection: TextDirection.ltr,
      creationParams: const {'noInject': _injectionDisabled},
      creationParamsCodec: const StandardMessageCodec(),
      gestureRecognizers: {Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer())},
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off_rounded, size: 48, color: Colors.white54),
              const SizedBox(height: 16),
              Text('Impossible de charger Spotify', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.white54),
              ),
              const SizedBox(height: 24),
              FilledButton(onPressed: onRetry, child: const Text('Réessayer')),
            ],
          ),
        ),
      ),
    );
  }
}
