import 'dart:async';

import 'package:flutter/material.dart';

import 'app_actions.dart';
import 'page_screen.dart';
import 'player_state.dart';
import 'tiles.dart';

/// Search: categories to browse, then the results of what is typed, all read
/// from the web player's search pages.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.app});

  final AppActions app;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with PageLoading {
  final _field = TextEditingController();
  Timer? _debounce;
  String _query = '';

  // The page's results, filtered: songs, artists… (the web player's own paths).
  static const _filters = [
    ('Titres', 'tracks'),
    ('Artistes', 'artists'),
    ('Albums', 'albums'),
    ('Playlists', 'playlists'),
    ('Podcasts et émissions', 'podcastAndEpisodes'),
    ('Profils', 'users'),
  ];

  @override
  AppActions get app => widget.app;

  // A slash would split the query.
  @override
  String get pagePath => _query.isEmpty ? '/search' : '/search/${_query.replaceAll('/', ' ')}';

  @override
  void initState() {
    super.initState();
    startLoading();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _field.dispose();
    stopLoading();
    super.dispose();
  }

  void _onChanged(String text) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () => _search(text));
    setState(() {});
  }

  void _search(String text) {
    _debounce?.cancel();
    final query = text.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (query == _query) return;
    setState(() => _query = query);
    startLoading();
  }

  @override
  Widget build(BuildContext context) {
    final current = page;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TextField(
                controller: _field,
                onChanged: _onChanged,
                onSubmitted: _search,
                textInputAction: TextInputAction.search,
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Que souhaitez-vous écouter ?',
                  hintStyle: const TextStyle(color: Colors.black54),
                  prefixIcon: const Icon(Icons.search_rounded, color: Colors.black87),
                  suffixIcon: _field.text.isEmpty
                      ? null
                      : IconButton(
                          tooltip: 'Effacer',
                          icon: const Icon(Icons.close_rounded, color: Colors.black87),
                          onPressed: () {
                            _field.clear();
                            _search('');
                          },
                        ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            if (_query.isNotEmpty)
              SizedBox(
                height: 44,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _filters.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, i) => ActionChip(
                    label: Text(_filters[i].$1),
                    onPressed: () => app.openPath('$pagePath/${_filters[i].$2}'),
                  ),
                ),
              ),
            Expanded(
              child: ValueListenableBuilder<PlayerState>(
                valueListenable: app.bridge.state,
                builder: (context, state, _) => NotificationListener<Notification>(
                  onNotification: onScrollNotification,
                  child: CustomScrollView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    slivers: [
                      if (current == null && loadError != null)
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: FailureView(
                            error: loadError!,
                            onRetry: () => load(fresh: true),
                            onWeb: () => app.openWeb(path: pagePath),
                          ),
                        )
                      else if (current == null)
                        const SliverFillRemaining(hasScrollBody: false, child: LoadingView())
                      else ...[
                        if (loading) const SliverToBoxAdapter(child: LinearProgressIndicator(minHeight: 2)),
                        if (current.isEmpty && !loading)
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.all(32),
                              child: Text(
                                _query.isEmpty ? 'Rien à parcourir pour le moment' : 'Aucun résultat pour « $_query »',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
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
          ],
        ),
      ),
    );
  }
}
