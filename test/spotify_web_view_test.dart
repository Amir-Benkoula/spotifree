import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spotiweb/src/spotify_web_view.dart';
import 'package:spotiweb/src/web_bridge.dart';

void main() {
  testWidgets('the page is shown by the platform\'s own web view', (tester) async {
    final created = <Map<Object?, Object?>>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform_views, (call) async {
      if (call.method == 'create') created.add(call.arguments as Map<Object?, Object?>);
      return null;
    });
    await tester.pumpWidget(MaterialApp(home: SpotifyWebView(bridge: WebBridge())));
    await tester.pump();
    final ios = defaultTargetPlatform == TargetPlatform.iOS;
    expect(find.byType(UiKitView), ios ? findsOneWidget : findsNothing);
    expect(find.byType(PlatformViewLink), ios ? findsNothing : findsOneWidget);
    if (ios) expect(created.single['viewType'], 'spotiweb/webkit');
  }, variant: const TargetPlatformVariant({TargetPlatform.android, TargetPlatform.iOS}));
}
