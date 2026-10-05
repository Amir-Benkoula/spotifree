import 'package:flutter/material.dart';

import 'app_actions.dart';
import 'tiles.dart';
import 'web_bridge.dart';
import 'web_content.dart';
import 'web_data.dart';

/// "Your Library", read from the web player's sidebar.
class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key, required this.app, this.shown});

  final AppActions app;

  /// Ticks each time the library tab is shown: read again if it is old.
  final Listenable? shown;

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  List<LibraryItem>? _items;
  Object? _error;
  Pending<List<LibraryItem>>? _loading;
  DateTime? _loadedAt;
  String? _filter;

  static const _filters = [
    ('playlist', 'Playlists'),
    ('album', 'Albums'),
    ('artist', 'Artistes'),
    ('show', 'Podcasts'),
  ];

  // Liked Songs and folders go with the playlists.
  static String _group(LibraryItem item) => switch (item.kind) {
    'collection' || 'folder' => 'playlist',
    final kind => kind,
  };

  @override
  void initState() {
    super.initState();
    _items = widget.app.content.cachedLibrary;
    widget.shown?.addListener(_onShown);
    _load();
  }

  @override
  void dispose() {
    widget.shown?.removeListener(_onShown);
    _loading?.cancel();
    super.dispose();
  }

  void _onShown() {
    final loadedAt = _loadedAt;
    if (_loading == null && (loadedAt == null || DateTime.now().difference(loadedAt) > const Duration(seconds: 30))) {
      _load();
    }
  }

  Future<void> _load() async {
    _loading?.cancel();
    final pending = _loading = widget.app.content.library();
    if (mounted) setState(() => _error = null);
    try {
      final items = await pending.result;
      if (!mounted || _loading != pending) return;
      setState(() {
        _items = items;
        _loadedAt = DateTime.now();
      });
    } catch (error) {
      if (!mounted || _loading != pending || (error is WebError && error.cancelled)) return;
      setState(() => _error = error);
    } finally {
      if (_loading == pending) _loading = null;
      if (mounted) setState(() {});
    }
  }

  void _open(LibraryItem item) {
    if (item.path.isNotEmpty) {
      widget.app.openPath(
        item.path,
        preview: WebCard(
          path: item.path,
          kind: item.kind,
          title: item.title,
          subtitle: item.subtitle,
          image: item.image,
        ),
      );
    } else {
      // Folders open in the page's own library.
      widget.app.openWeb(view: 'library');
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = _items;
    final kinds = {for (final item in items ?? const <LibraryItem>[]) _group(item)};
    final shown = items == null
        ? const <LibraryItem>[]
        : [
            for (final item in items)
              if (_filter == null || _group(item) == _filter) item,
          ];
    return Scaffold(
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        onRefresh: _load,
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
                  AccountButton(app: widget.app),
                  const SizedBox(width: 4),
                  Text(
                    'Bibliothèque',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              bottom: kinds.length < 2
                  ? null
                  : PreferredSize(
                      preferredSize: const Size.fromHeight(48),
                      child: SizedBox(
                        height: 48,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          children: [
                            for (final (kind, label) in _filters)
                              if (kinds.contains(kind))
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: FilterChip(
                                    label: Text(label),
                                    selected: _filter == kind,
                                    showCheckmark: false,
                                    onSelected: (on) => setState(() => _filter = on ? kind : null),
                                  ),
                                ),
                          ],
                        ),
                      ),
                    ),
            ),
            if (_loading != null && items != null)
              const SliverToBoxAdapter(child: LinearProgressIndicator(minHeight: 2)),
            if (items == null && _error != null)
              SliverFillRemaining(
                hasScrollBody: false,
                child: FailureView(
                  error: _error!,
                  onRetry: _load,
                  onWeb: () => widget.app.openWeb(view: 'library'),
                ),
              )
            else if (items == null)
              const SliverFillRemaining(hasScrollBody: false, child: LoadingView())
            else if (items.isEmpty)
              const SliverFillRemaining(hasScrollBody: false, child: Center(child: Text('Ta bibliothèque est vide')))
            else
              SliverList.builder(
                itemCount: shown.length,
                itemBuilder: (context, i) {
                  final item = shown[i];
                  return EntityTile(
                    title: item.title,
                    subtitle: item.subtitle,
                    image: item.image,
                    kind: item.kind,
                    round: item.kind == 'artist',
                    size: 64,
                    onTap: () => _open(item),
                    onLongPress: () => widget.app.showMenu(LibraryTarget(item), header: MenuHeader.library(item)),
                  );
                },
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}
