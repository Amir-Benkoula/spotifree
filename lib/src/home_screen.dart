import 'package:flutter/material.dart';

import 'app_actions.dart';
import 'page_screen.dart';
import 'player_state.dart';
import 'tiles.dart';

/// The home page of the web player: shortcuts and shelves, read from it.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.app});

  final AppActions app;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with PageLoading {
  @override
  AppActions get app => widget.app;

  @override
  String get pagePath => '/';

  @override
  void initState() {
    super.initState();
    startLoading();
  }

  @override
  void dispose() {
    stopLoading();
    super.dispose();
  }

  static String _greeting(DateTime now) {
    if (now.hour >= 5 && now.hour < 12) return 'Bonjour';
    if (now.hour >= 12 && now.hour < 18) return 'Bon après-midi';
    return 'Bonsoir';
  }

  @override
  Widget build(BuildContext context) {
    final current = page;
    return Scaffold(
      backgroundColor: Colors.black,
      body: ValueListenableBuilder<PlayerState>(
        valueListenable: app.bridge.state,
        builder: (context, state, _) => NotificationListener<Notification>(
          onNotification: onScrollNotification,
          child: RefreshIndicator(
            onRefresh: () => load(fresh: true),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverAppBar(
                  floating: true,
                  backgroundColor: Colors.black,
                  surfaceTintColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  titleSpacing: 8,
                  title: Row(
                    children: [
                      AccountButton(app: app),
                      const SizedBox(width: 4),
                      Text(
                        _greeting(DateTime.now()),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                if (current == null && loadError != null)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: FailureView(
                      error: loadError!,
                      onRetry: () => load(fresh: true),
                      onWeb: () => app.openWeb(path: '/'),
                    ),
                  )
                else if (current == null)
                  const SliverFillRemaining(hasScrollBody: false, child: LoadingView())
                else ...[
                  ...blockSlivers(context, app: app, page: current, state: state),
                  if (!current.complete || loadingMore)
                    const SliverToBoxAdapter(
                      child: Padding(padding: EdgeInsets.all(24), child: LoadingView()),
                    ),
                ],
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
