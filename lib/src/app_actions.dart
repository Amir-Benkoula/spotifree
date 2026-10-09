import 'updater.dart';
import 'web_bridge.dart';
import 'web_content.dart';
import 'web_data.dart';

/// What the screens ask of the app around them (the shell).
abstract interface class AppActions {
  WebBridge get bridge;
  WebContent get content;
  Updater get updater;

  /// Shows a page of the web player on its own screen, over the current tab.
  /// [preview] is what the link showed, to show while the page loads.
  void openPath(String path, {WebCard? preview});

  /// Shows the web page itself, for what the app has no screen for: [path]
  /// opened first, or a part of it ([view]: 'library', 'panel').
  void openWeb({String? path, String? view});

  void openQueue();
  void openLyrics();
  void openSettings();

  /// Tries each function of the app on the real page (diagnostic_screen.dart).
  void openDiagnostic();

  /// The page's context menu for [target] (on the page at [path]), as a sheet.
  Future<void> showMenu(MenuTarget target, {String? path, MenuHeader? header});

  /// A short message at the bottom of the screen.
  void notify(String message);
}

/// What a menu is about, shown at the top of its sheet.
class MenuHeader {
  const MenuHeader({required this.title, this.subtitle = '', this.image = '', this.round = false});

  factory MenuHeader.track(WebTrack track) =>
      MenuHeader(title: track.title, subtitle: track.artistNames, image: track.image);

  factory MenuHeader.card(WebCard card) =>
      MenuHeader(title: card.title, subtitle: card.subtitle, image: card.image, round: card.round);

  factory MenuHeader.page(WebPage page) => MenuHeader(
    title: page.title,
    subtitle: page.label.isNotEmpty ? page.label : (page.lines.isEmpty ? '' : page.lines.first),
    image: page.image,
    round: page.kind == 'artist',
  );

  factory MenuHeader.library(LibraryItem item) =>
      MenuHeader(title: item.title, subtitle: item.subtitle, image: item.image, round: item.kind == 'artist');

  final String title;
  final String subtitle;
  final String image;
  final bool round;
}
