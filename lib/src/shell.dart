import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'full_player.dart';
import 'mini_player.dart';
import 'player_state.dart';
import 'spotify_web_view.dart';
import 'system_channel.dart';
import 'web_bridge.dart';
import 'widgets.dart';

enum _Tab { home, search, library }

/// The web player plus the native chrome around it: bottom navigation,
/// mini player and the full screen player that slides over everything.
class Shell extends StatefulWidget {
  const Shell({super.key, required this.bridge});

  final WebBridge bridge;

  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> with SingleTickerProviderStateMixin {
  late final AnimationController _player = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  WebBridge get _bridge => widget.bridge;

  /// False on the login pages (accounts.spotify.com…), which get the whole screen.
  bool _onPlayer = true;
  bool _splashTimedOut = false;
  late final Timer _splashTimer;

  /// Tab to highlight on pages that belong to none (a playlist, an artist…).
  _Tab _lastTab = _Tab.home;

  @override
  void initState() {
    super.initState();
    _splashTimer = Timer(const Duration(seconds: 10), () => setState(() => _splashTimedOut = true));
    _bridge.state.addListener(_onState);
    _bridge.location.addListener(_onLocationChanged);
  }

  @override
  void dispose() {
    _bridge.state.removeListener(_onState);
    _bridge.location.removeListener(_onLocationChanged);
    _splashTimer.cancel();
    _player.dispose();
    super.dispose();
  }

  void _onState() {
    if (!_bridge.state.value.hasTrack && _player.value > 0) _player.value = 0;
  }

  void _onLocationChanged() {
    final url = _bridge.location.value;
    if (url == null) return;
    final onPlayer = url.host == 'open.spotify.com';
    if (onPlayer != _onPlayer) setState(() => _onPlayer = onPlayer);
  }

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

  // ------------------------------------------------------------- navigation
  _Tab _selectedTab(PlayerState state) {
    if (state.library) return _Tab.library;
    if (state.isSearchRoute) return _Tab.search;
    if (state.isHomeRoute) return _Tab.home;
    return _lastTab;
  }

  void _selectTab(_Tab tab) {
    setState(() => _lastTab = tab);
    switch (tab) {
      case _Tab.home:
        _bridge.goHome();
      case _Tab.search:
        _bridge.openSearch();
      case _Tab.library:
        _bridge.showLibrary(true);
    }
  }

  /// Back closes what is on top first, then walks the page history, and finally
  /// sends the app to the background (finishing it would stop the music).
  Future<void> _handleBack() async {
    final state = _bridge.state.value;
    if (_player.value > 0) {
      _closePlayer();
    } else if (state.panel) {
      await _bridge.closePanel();
    } else if (state.library) {
      await _bridge.showLibrary(false);
    } else if (!await _bridge.goBack()) {
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
          systemNavigationBarColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          backgroundColor: Colors.black,
          body: ValueListenableBuilder<PlayerState>(
            valueListenable: _bridge.state,
            // The WebView is built once and passed through, never rebuilt by state changes.
            child: SpotifyWebView(bridge: _bridge),
            builder: (context, state, webView) {
              final chrome = _onPlayer && !keyboardOpen;
              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: SafeArea(bottom: !chrome, child: webView!),
                      ),
                      if (chrome && state.hasTrack)
                        MiniPlayer(
                          bridge: _bridge,
                          state: state,
                          onOpen: _openPlayer,
                          onDragUpdate: _dragPlayer,
                          onDragEnd: _endDragPlayer,
                        ),
                      if (chrome && state.loggedIn == false) _LoginBanner(onLogin: _bridge.login),
                      if (chrome) _BottomNav(selected: _selectedTab(state), onSelected: _selectTab),
                    ],
                  ),
                  if (_onPlayer && !state.appReady && !_splashTimedOut) const Positioned.fill(child: _Splash()),
                  if (state.hasTrack)
                    AnimatedBuilder(
                      animation: _player,
                      child: FullPlayer(
                        bridge: _bridge,
                        onClose: _closePlayer,
                        onDragUpdate: _dragPlayer,
                        onDragEnd: _endDragPlayer,
                      ),
                      builder: (context, child) {
                        if (_player.value == 0) return const SizedBox.shrink();
                        return Positioned.fill(
                          child: FractionalTranslation(
                            translation: Offset(0, 1 - _player.value),
                            child: child,
                          ),
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
  const _BottomNav({required this.selected, required this.onSelected});

  final _Tab selected;
  final ValueChanged<_Tab> onSelected;

  static const _items = [
    (_Tab.home, Icons.home_filled, Icons.home_outlined, 'Accueil'),
    (_Tab.search, Icons.search_rounded, Icons.search_rounded, 'Rechercher'),
    (_Tab.library, Icons.library_music, Icons.library_music_outlined, 'Bibliothèque'),
  ];

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelSmall;
    return ColoredBox(
      color: Colors.black,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              for (final (tab, activeIcon, icon, label) in _items)
                Expanded(
                  child: InkResponse(
                    onTap: () => onSelected(tab),
                    radius: 36,
                    child: Builder(
                      builder: (context) {
                        final isSelected = tab == selected;
                        final color = isSelected ? Colors.white : Colors.white60;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(isSelected ? activeIcon : icon, color: color, size: 26),
                            const SizedBox(height: 3),
                            Text(label, style: labelStyle?.copyWith(color: color)),
                          ],
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
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
            SizedBox.square(
              dimension: 24,
              child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}
