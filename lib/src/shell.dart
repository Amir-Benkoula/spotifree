import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_actions.dart';
import 'diagnostic_screen.dart';
import 'full_player.dart';
import 'home_screen.dart';
import 'library_screen.dart';
import 'lyrics_screen.dart';
import 'menu_sheet.dart';
import 'mini_player.dart';
import 'page_screen.dart';
import 'player_state.dart';
import 'queue_screen.dart';
import 'search_screen.dart';
import 'settings_sheet.dart';
import 'spotify_web_view.dart';
import 'system_channel.dart';
import 'updater.dart';
import 'web_bridge.dart';
import 'web_content.dart';
import 'web_data.dart';
import 'widgets.dart';

enum _Tab { home, search, library }

/// The app: its own screens (home, search, library and the pages they lead
/// to) over the web player, which keeps running out of sight behind them and
/// is where everything they show comes from; the mini player, and the full
/// screen player that slides over everything.
///
/// The web player itself shows for logging in, for what the app has no screen
/// for, and as the whole interface when chosen in the settings (with the
/// bottom navigation and players around it, as the app first was).
class Shell extends StatefulWidget {
  const Shell({super.key, required this.bridge, @visibleForTesting this.webView, @visibleForTesting this.updater});

  final WebBridge bridge;

  /// In place of the web view (tests, which have none).
  final Widget? webView;

  /// In place of the app's own (tests).
  final Updater? updater;

  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> with SingleTickerProviderStateMixin implements AppActions {
  late final AnimationController _player = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  @override
  WebBridge get bridge => widget.bridge;

  @override
  late final WebContent content = WebContent(widget.bridge);

  @override
  late final Updater updater = widget.updater ?? (Updater()..schedule());

  /// False on the login pages (accounts.spotify.com…), which get the whole screen.
  bool _onPlayer = true;
  bool _splashTimedOut = false;
  late final Timer _splashTimer;
  StreamSubscription<String>? _notices;

  /// The web player keeps its place in the tree whatever shows over it.
  final _webView = GlobalKey();

  // The app's own screens: a navigator per tab, each built once first shown.
  _Tab _tab = _Tab.home;
  final _visited = <_Tab>{_Tab.home};
  final _navigators = {for (final tab in _Tab.values) tab: GlobalKey<NavigatorState>()};
  final _libraryShown = ValueNotifier<int>(0);

  /// The web page shown in place of the app's screens.
  bool _webShown = false;

  /// Web interface: tab to highlight on pages that belong to none (a playlist…).
  _Tab _lastTab = _Tab.home;

  @override
  void initState() {
    super.initState();
    _splashTimer = Timer(const Duration(seconds: 10), () => setState(() => _splashTimedOut = true));
    bridge.state.addListener(_onState);
    bridge.location.addListener(_onLocationChanged);
    _notices = bridge.notices.listen(notify);
  }

  @override
  void dispose() {
    bridge.state.removeListener(_onState);
    bridge.location.removeListener(_onLocationChanged);
    _notices?.cancel();
    _splashTimer.cancel();
    if (widget.updater == null) updater.dispose();
    _libraryShown.dispose();
    _player.dispose();
    super.dispose();
  }

  void _onState() {
    if (!bridge.state.value.hasTrack && _player.value > 0) _player.value = 0;
  }

  void _onLocationChanged() {
    final url = bridge.location.value;
    if (url == null) return;
    final onPlayer = url.host == 'open.spotify.com';
    if (onPlayer != _onPlayer) setState(() => _onPlayer = onPlayer);
  }

  /// The app's own screens, unless the web interface is chosen or a login is due.
  bool _native(PlayerState state) => _onPlayer && !state.webUi && state.loggedIn != false;

  // ------------------------------------------------------------ full player
  void _openPlayer() => _player.animateTo(1, curve: Curves.easeOutCubic);

  void _closePlayer() => _player.animateBack(0, curve: Curves.easeOutCubic);

  void _dragPlayer(DragUpdateDetails details) {
    final height = MediaQuery.sizeOf(context).height;
    _player.value -= (details.primaryDelta ?? 0) / height;
  }

  void _endDragPlayer(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (velocity > 700 || (velocity > -700 && _player.value < 0.5)) {
      _closePlayer();
    } else {
      _openPlayer();
    }
  }

  // ---------------------------------------------------------- app actions
  /// Back to the tabs: what shows over them closes.
  void _closeOverlays() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    if (_player.value > 0) _closePlayer();
  }

  @override
  void openPath(String path, {WebCard? preview}) {
    if (path.isEmpty) return;
    if (!appPageKinds.contains(kindOfPath(path))) {
      openWeb(path: path);
      return;
    }
    _closeOverlays();
    if (_webShown) setState(() => _webShown = false);
    _navigators[_tab]!.currentState?.push(
      MaterialPageRoute<void>(
        builder: (_) => PageScreen(app: this, path: path, preview: preview),
      ),
    );
  }

  @override
  void openWeb({String? path, String? view}) {
    _closeOverlays();
    content.showWeb(path: path, view: view);
    setState(() => _webShown = true);
  }

  void _closeWeb() => setState(() => _webShown = false);

  @override
  void openQueue() => Navigator.of(context).push(_slideUp((_) => QueueScreen(app: this)));

  @override
  void openLyrics() => Navigator.of(context).push(_slideUp((_) => LyricsScreen(app: this)));

  // Not opaque: the web player under it must keep being drawn.
  Route<void> _slideUp(WidgetBuilder builder) => PageRouteBuilder<void>(
    opaque: false,
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (context, _, _) => builder(context),
    transitionsBuilder: (context, animation, _, child) => SlideTransition(
      position: Tween(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
      child: child,
    ),
  );

  @override
  void openSettings() => showSettings(context, this);

  @override
  void openDiagnostic() => Navigator.of(context).push(_slideUp((_) => DiagnosticScreen(app: this)));

  @override
  Future<void> showMenu(MenuTarget target, {String? path, MenuHeader? header}) =>
      showWebMenu(context, this, target, path: path, header: header);

  @override
  void notify(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 132),
          duration: const Duration(seconds: 3),
        ),
      );
  }

  // ------------------------------------------------------------- navigation
  void _selectNativeTab(_Tab tab) {
    if (_webShown) _closeWeb();
    if (tab == _tab) {
      // Again on the tab: back to its first screen.
      _navigators[tab]!.currentState?.popUntil((route) => route.isFirst);
    }
    if (tab == _Tab.library) _libraryShown.value++;
    setState(() {
      _tab = tab;
      _visited.add(tab);
    });
  }

  Widget _rootScreen(_Tab tab) => switch (tab) {
    _Tab.home => HomeScreen(app: this),
    _Tab.search => SearchScreen(app: this),
    _Tab.library => LibraryScreen(app: this, shown: _libraryShown),
  };

  Widget _nativeTabs() {
    return ColoredBox(
      color: Colors.black,
      child: IndexedStack(
        index: _tab.index,
        children: [
          for (final tab in _Tab.values)
            if (_visited.contains(tab))
              Navigator(
                key: _navigators[tab],
                onGenerateRoute: (settings) =>
                    MaterialPageRoute<void>(settings: settings, builder: (_) => _rootScreen(tab)),
              )
            else
              const SizedBox.shrink(),
        ],
      ),
    );
  }

  _Tab _selectedWebTab(PlayerState state) {
    if (state.library) return _Tab.library;
    if (state.isSearchRoute) return _Tab.search;
    if (state.isHomeRoute) return _Tab.home;
    return _lastTab;
  }

  void _selectWebTab(_Tab tab) {
    setState(() => _lastTab = tab);
    switch (tab) {
      case _Tab.home:
        bridge.goHome();
      case _Tab.search:
        bridge.openSearch();
      case _Tab.library:
        bridge.showLibrary(true);
    }
  }

  /// Back closes what is on top first, then goes back through the screens
  /// (or the page history), and finally sends the app to the background
  /// (finishing it would stop the music).
  Future<void> _handleBack() async {
    final state = bridge.state.value;
    if (_player.value > 0) {
      _closePlayer();
      return;
    }
    if (_native(state)) {
      final navigator = _navigators[_tab]!.currentState;
      if (_webShown) {
        _closeWeb();
      } else if (navigator != null && navigator.canPop()) {
        navigator.pop();
      } else if (_tab != _Tab.home) {
        _selectNativeTab(_Tab.home);
      } else {
        await SystemChannel.moveTaskToBack();
      }
    } else if (state.panel) {
      await bridge.closePanel();
    } else if (state.library) {
      await bridge.showLibrary(false);
    } else if (!await bridge.goBack()) {
      await SystemChannel.moveTaskToBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _handleBack();
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          // iOS: light text on the dark app.
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          backgroundColor: Colors.black,
          body: ValueListenableBuilder<PlayerState>(
            valueListenable: bridge.state,
            // The web view is built once and passed through, never rebuilt by state changes.
            child: KeyedSubtree(
              key: _webView,
              child: widget.webView ?? SpotifyWebView(bridge: bridge),
            ),
            builder: (context, state, webView) {
              final native = _native(state);
              final chrome = _onPlayer && !keyboardOpen;
              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: SafeArea(bottom: !chrome, child: webView!),
                            ),
                            if (native)
                              Positioned.fill(
                                child: Offstage(
                                  offstage: _webShown,
                                  child: MediaQuery.removePadding(
                                    context: context,
                                    removeBottom: chrome,
                                    child: _nativeTabs(),
                                  ),
                                ),
                              ),
                            if (native && _webShown)
                              Positioned(
                                right: 12,
                                bottom: 12,
                                child: FloatingActionButton.extended(
                                  heroTag: null,
                                  onPressed: _closeWeb,
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  icon: const Icon(Icons.arrow_back_rounded),
                                  label: const Text("Retour à l'app"),
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (chrome && state.hasTrack)
                        MiniPlayer(
                          bridge: bridge,
                          state: state,
                          onOpen: _openPlayer,
                          onDragUpdate: _dragPlayer,
                          onDragEnd: _endDragPlayer,
                        ),
                      if (chrome && state.loggedIn == false) _LoginBanner(onLogin: bridge.login),
                      if (chrome) _UpdateBanner(updater: updater),
                      if (chrome)
                        _BottomNav(
                          selected: native ? _tab : _selectedWebTab(state),
                          onSelected: native ? _selectNativeTab : _selectWebTab,
                          onSettings: native ? null : openSettings,
                        ),
                    ],
                  ),
                  if (_onPlayer && !state.appReady && !_splashTimedOut) const Positioned.fill(child: _Splash()),
                  if (state.hasTrack)
                    AnimatedBuilder(
                      animation: _player,
                      child: FullPlayer(
                        bridge: bridge,
                        onClose: _closePlayer,
                        onDragUpdate: _dragPlayer,
                        onDragEnd: _endDragPlayer,
                        onQueue: native ? openQueue : null,
                        onLyrics: native ? openLyrics : null,
                        onOpenPath: native ? openPath : null,
                        onMenu: native
                            ? () => showMenu(
                                const NowPlayingTarget(),
                                header: MenuHeader(title: state.title, subtitle: state.artist, image: state.artwork),
                              )
                            : null,
                      ),
                      builder: (context, child) {
                        if (_player.value == 0) return const SizedBox.shrink();
                        return Positioned.fill(
                          child: FractionalTranslation(translation: Offset(0, 1 - _player.value), child: child),
                        );
                      },
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.selected, required this.onSelected, this.onSettings});

  final _Tab selected;
  final ValueChanged<_Tab> onSelected;

  /// Web interface: the settings have no other way in.
  final VoidCallback? onSettings;

  static const _items = [
    (_Tab.home, Icons.home_filled, Icons.home_outlined, 'Accueil'),
    (_Tab.search, Icons.search_rounded, Icons.search_rounded, 'Rechercher'),
    (_Tab.library, Icons.library_music, Icons.library_music_outlined, 'Bibliothèque'),
  ];

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelSmall;
    Widget item({
      required bool isSelected,
      required IconData icon,
      required String label,
      required VoidCallback onTap,
    }) {
      final color = isSelected ? Colors.white : Colors.white60;
      return Expanded(
        child: InkResponse(
          onTap: onTap,
          radius: 36,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 26),
              const SizedBox(height: 3),
              Text(label, style: labelStyle?.copyWith(color: color)),
            ],
          ),
        ),
      );
    }

    return ColoredBox(
      color: Colors.black,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              for (final (tab, activeIcon, icon, label) in _items)
                item(
                  isSelected: tab == selected,
                  icon: tab == selected ? activeIcon : icon,
                  label: label,
                  onTap: () => onSelected(tab),
                ),
              if (onSettings != null)
                item(isSelected: false, icon: Icons.settings_outlined, label: 'Réglages', onTap: onSettings!),
            ],
          ),
        ),
      ),
    );
  }
}

/// A newer build to install: download progress, then the system installer.
class _UpdateBanner extends StatelessWidget {
  const _UpdateBanner({required this.updater});

  final Updater updater;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([updater.state, updater.dismissed]),
      builder: (context, _) {
        final state = updater.state.value;
        final release = switch (state) {
          UpdateAvailable(:final release) => release,
          UpdateDownloading(:final release) => release,
          UpdateFailed(:final release?) => release,
          _ => null,
        };
        if (release == null || (updater.dismissed.value == release.build && state is! UpdateDownloading)) {
          return const SizedBox.shrink();
        }
        final textTheme = Theme.of(context).textTheme;
        final (title, subtitle) = switch (state) {
          UpdateDownloading() => ('Téléchargement de la version ${release.name}…', ''),
          UpdateFailed(:final message) => ('Mise à jour ${release.name}', message),
          _ when updater.ios => ('Version ${release.name} disponible', 'À installer depuis ton Mac'),
          _ => ('Nouvelle version ${release.name}', release.notes),
        };
        return Container(
          margin: const EdgeInsets.fromLTRB(8, 0, 8, 6),
          padding: const EdgeInsets.fromLTRB(16, 8, 4, 8),
          decoration: BoxDecoration(color: const Color(0xFF2A2A2A), borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.system_update_rounded, color: spotifyGreen),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                        if (subtitle.isNotEmpty)
                          Text(
                            subtitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodySmall?.copyWith(color: Colors.white60),
                          ),
                      ],
                    ),
                  ),
                  if (state is! UpdateDownloading) ...[
                    TextButton(
                      onPressed: updater.install,
                      child: Text(
                        state is UpdateFailed
                            ? 'Réessayer'
                            : updater.ios
                            ? 'Voir'
                            : 'Installer',
                      ),
                    ),
                    IconButton(
                      tooltip: 'Plus tard',
                      icon: const Icon(Icons.close_rounded, size: 20),
                      onPressed: () => updater.dismiss(release),
                    ),
                  ],
                ],
              ),
              if (state is UpdateDownloading)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 12, 4),
                  child: LinearProgressIndicator(value: state.progress, minHeight: 3),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _LoginBanner extends StatelessWidget {
  const _LoginBanner({required this.onLogin});

  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 6),
      padding: const EdgeInsets.fromLTRB(16, 10, 10, 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFAF2896), Color(0xFF509BF5)]),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Connecte-toi pour écouter ta musique',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
            onPressed: onLogin,
            child: const Text('Se connecter'),
          ),
        ],
      ),
    );
  }
}

class _Splash extends StatelessWidget {
  const _Splash();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.graphic_eq_rounded, size: 64, color: spotifyGreen),
            SizedBox(height: 24),
            SizedBox.square(dimension: 24, child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white54)),
          ],
        ),
      ),
    );
  }
}
