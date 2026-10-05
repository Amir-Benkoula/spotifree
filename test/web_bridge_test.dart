import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:spotiweb/src/web_bridge.dart';

import 'support/fake_page.dart';

void main() {
  testWidgets('a request gets the reply with its id', (tester) async {
    final page = FakePage(tester)..answers['read'] = (arg) => {'title': 'Page ${arg['path']}'};
    final bridge = WebBridge();
    final request = bridge.request('read', {'path': '/a'});
    Object? result;
    request.result.then((value) => result = value);
    await page.flush();
    expect(result, {'title': 'Page /a'});
    expect(page.argsOf('read').single, {'path': '/a', '__id': request.id});
  });

  testWidgets('an error reply fails the request', (tester) async {
    final page = FakePage(tester)..answers['read'] = (_) => throw 'not found';
    final bridge = WebBridge();
    Object? error;
    bridge.request('read').result.catchError((Object e) => error = e);
    await page.flush();
    expect(error, isA<WebError>().having((e) => e.message, 'message', 'not found'));
  });

  testWidgets('a cancelled request tells the page and fails at once', (tester) async {
    final page = FakePage(tester);
    final bridge = WebBridge();
    final request = bridge.request('read');
    Object? error;
    request.result.catchError((Object e) => error = e);
    await tester.pump();
    request.cancel();
    await tester.pump();
    expect(error, isA<WebError>().having((e) => e.cancelled, 'cancelled', isTrue));
    expect(page.argsOf('cancel').single, {'id': request.id});
  });

  testWidgets('a request that never gets its reply times out', (tester) async {
    final page = FakePage(tester);
    final bridge = WebBridge();
    Object? error;
    bridge.request('read', const {}, const Duration(seconds: 5)).result.catchError((Object e) => error = e);
    await tester.pump(const Duration(seconds: 6));
    expect(error, isA<WebError>());
    expect(page.names, contains('cancel'));
  });

  testWidgets('a page reload fails what was pending', (tester) async {
    FakePage(tester);
    final bridge = WebBridge();
    Object? error;
    bridge.request('read').result.catchError((Object e) => error = e);
    await tester.pump();
    await tester.binding.defaultBinaryMessenger.handlePlatformMessage(
      'spotiweb/player',
      const StandardMethodCodec().encodeMethodCall(const MethodCall('pageStart', 'https://open.spotify.com/')),
      (_) {},
    );
    expect(error, isA<WebError>());
  });

  testWidgets('live updates and copies from the page', (tester) async {
    final page = FakePage(tester);
    final bridge = WebBridge();
    final live = <LiveEvent>[];
    final notices = <String>[];
    bridge.live.listen(live.add);
    bridge.notices.listen(notices.add);
    final clipboard = <Object?>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') clipboard.add((call.arguments as Map)['text']);
      return null;
    });
    await page.live('queue', {'sections': []});
    await page.send({'type': 'clipboard', 'text': 'https://open.spotify.com/track/a'});
    await tester.pump();
    expect(live.single.topic, 'queue');
    expect(clipboard, ['https://open.spotify.com/track/a']);
    expect(notices, ['Copié dans le presse-papiers']);
  });
}
