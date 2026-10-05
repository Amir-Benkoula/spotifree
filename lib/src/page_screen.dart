import 'package:flutter/material.dart';

import 'app_actions.dart';
import 'player_state.dart';
import 'tiles.dart';
import 'web_bridge.dart';
import 'web_content.dart';
import 'web_data.dart';
import 'widgets.dart';

/// Loads a page of the web player for a screen: what was read before at once,
/// then the page read again, and further down as the user scrolls.
mixin PageLoading<T extends StatefulWidget> on State<T> {
  AppActions get app;
  String get pagePath;

  WebPage? page;
  Object? loadError;
  bool loading = false;
  Pending<WebPage>? _load;
  Pending<WebPage>? _more;
  bool _moreFailed = false;

  bool get loadingMore => _more != null;

  /// From initState, or when [pagePath] changes.
  void startLoading() {
    page = app.content.cached(pagePath);
    loadError = null;
    _moreFailed = false;
    _more?.cancel();
    _more = null;
    load();
  }

  Future<void> load({bool fresh = false}) async {
    _load?.cancel();
    final pending = _load = app.content.page(pagePath, fresh: fresh);
    loading = true;
    loadError = null;
    if (fresh) _moreFailed = false;
    if (mounted) setState(() {});
    try {
      final result = await pending.result;
      if (!mounted || _load != pending) return;
      setState(() {
        page = result;
        loading = false;
      });
    } catch (error) {
      if (!mounted || _load != pending || (error is WebError && error.cancelled)) return;
      setState(() {
        loadError = error;
        loading = false;
      });
    }
  }

  Future<void> loadMore() async {
    final current = page;
    if (current == null || current.complete || loading || _more != null || _moreFailed) return;
    final pending = _more = app.content.more(pagePath);
    setState(() {});
    try {
      final result = await pending.result;
      if (mounted && _more == pending) setState(() => page = result);
    } catch (error) {
      // Not again until the page is read anew.
      if (!(error is WebError && error.cancelled)) _moreFailed = true;
    } finally {
      if (_more == pending) {
        _more = null;
        if (mounted) setState(() {});
      }
    }
  }

  /// Reads further down when the list nears its end (or is too short to scroll).
  bool onScrollNotification(Notification notification) {
    final metrics = switch (notification) {
      ScrollNotification(:final metrics) => metrics,
      ScrollMetricsNotification(:final metrics) => metrics,
      _ => null,
    };
    if (metrics != null && metrics.axis == Axis.vertical && metrics.extentAfter < 800) loadMore();
    return false;
  }

  void stopLoading() {
    _load?.cancel();
    _more?.cancel();
  }
}

/// A page of the web player (playlist, album, artist, podcast, genre…), on its
/// own screen: what the page shows, read from it.
class PageScreen extends StatefulWidget {
  const PageScreen({super.key, required this.app, required this.path, this.preview});

  final AppActions app;
  final String path;

  /// What the link to it showed, while it loads.
  final WebCard? preview;

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> with PageLoading {
  /// How far the header has scrolled away, for the title in the bar.
  final _scrolled = ValueNotifier<double>(0);

  @override
  AppActions get app => widget.app;

  @override
  String get pagePath => widget.path;

  @override
  void initState() {
    super.initState();
    startLoading();
  }

  @override
  void dispose() {
    stopLoading();
    _scrolled.dispose();
    super.dispose();
  }

  bool _onScroll(Notification notification) {
    if (notification is ScrollUpdateNotification && notification.metrics.axis == Axis.vertical) {
      _scrolled.value = (notification.metrics.pixels / 260).clamp(0.0, 1.0);
    }
    return onScrollNotification(notification);
  }

  Future<void> _toggleSaved() async {
    try {
      await app.content.toggleSaved(widget.path);
      await load();
    } on WebError catch (error) {
      if (!error.cancelled) app.notify(error.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = page;
    final title = current?.title.isNotEmpty == true ? current!.title : widget.preview?.title ?? '';
    return Scaffold(
      backgroundColor: Colors.black,
      body: ValueListenableBuilder<PlayerState>(
        valueListenable: app.bridge.state,
        builder: (context, state, _) => NotificationListener<Notification>(
          onNotification: _onScroll,
          child: RefreshIndicator(
            onRefresh: () => load(fresh: true),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  backgroundColor: surfaceColor,
                  surfaceTintColor: Colors.transparent,
                  title: ValueListenableBuilder<double>(
                    valueListenable: _scrolled,
                    builder: (context, scrolled, _) => Opacity(
                      opacity: scrolled,
                      child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  actions: [
                    PopupMenuButton<void>(
                      tooltip: 'Options',
                      icon: const Icon(Icons.more_vert_rounded),
                      itemBuilder: (context) => [
                        PopupMenuItem(onTap: () => load(fresh: true), child: const Text('Actualiser')),
                        PopupMenuItem(
                          onTap: () => app.openWeb(path: widget.path),
                          child: const Text('Voir la page web'),
                        ),
                      ],
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: _PageHeader(
                    page: current,
                    preview: widget.preview,
                    path: widget.path,
                    state: state,
                    onPlay: current == null ? null : () => playPageOf(app, current, state),
                    onMenu: current == null || !current.hasMenu
                        ? null
                        : () => app.showMenu(const PageTarget(), path: widget.path, header: MenuHeader.page(current)),
                    onSave: current?.saved == null ? null : _toggleSaved,
                    onLink: app.openPath,
                  ),
                ),
                if (loading && current == null)
                  const SliverFillRemaining(hasScrollBody: false, child: LoadingView())
                else if (loadError != null && current == null)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: FailureView(
                      error: loadError!,
                      onRetry: () => load(fresh: true),
                      onWeb: () => app.openWeb(path: widget.path),
                    ),
                  )
                else if (current != null) ...[
                  if (current.isEmpty && !loading)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: Text('Rien à afficher ici', textAlign: TextAlign.center),
                      ),
                    ),
                  ...blockSlivers(context, app: app, page: current, state: state),
                  if (!current.complete || loadingMore)
                    const SliverToBoxAdapter(
                      child: Padding(padding: EdgeInsets.all(24), child: LoadingView()),
                    ),
                ],
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader({
    required this.page,
    required this.preview,
    required this.path,
    required this.state,
    required this.onPlay,
    required this.onMenu,
    required this.onSave,
    required this.onLink,
  });

  final WebPage? page;
  final WebCard? preview;
  final String path;
  final PlayerState state;
  final VoidCallback? onPlay;
  final VoidCallback? onMenu;
  final VoidCallback? onSave;
  final void Function(String path) onLink;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final page = this.page;
    final kind = page?.kind.isNotEmpty == true ? page!.kind : kindOfPath(path);
    final image = page?.image.isNotEmpty == true ? page!.image : preview?.image ?? '';
    final title = page?.title.isNotEmpty == true ? page!.title : preview?.title ?? '';
    final playing = page != null && isPlayingFrom(page, state) && state.playing;
    final width = MediaQuery.sizeOf(context).width;
    return ArtworkColorBuilder(
      url: image,
      builder: (context, color) => DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.lerp(color, surfaceColor, 0.2)!, Colors.black],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (image.isNotEmpty || kind == 'collection')
                Center(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: kind == 'artist' ? BoxShape.circle : BoxShape.rectangle,
                      boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 24, offset: Offset(0, 8))],
                    ),
                    child: Cover(
                      url: image,
                      size: (width * 0.6).clamp(120.0, 260.0),
                      kind: kind,
                      round: kind == 'artist',
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              if (page?.label.isNotEmpty == true)
                Text(page!.label, style: textTheme.labelMedium?.copyWith(color: Colors.white70)),
              Text(title, style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
              for (final line in page?.lines.take(3) ?? const <String>[])
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    line,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall?.copyWith(color: Colors.white70),
                  ),
                ),
              if (page != null && page.links.isNotEmpty)
                Wrap(
                  spacing: 4,
                  children: [
                    for (final link in page.links)
                      ActionChip(
                        label: Text(link.name),
                        visualDensity: VisualDensity.compact,
                        onPressed: () => onLink(link.path),
                      ),
                  ],
                ),
              const SizedBox(height: 8),
              Row(
                children: [
                  if (onSave != null)
                    IconButton(
                      tooltip: page?.saved == true ? 'Retirer de la bibliothèque' : 'Ajouter à la bibliothèque',
                      iconSize: 28,
                      onPressed: onSave,
                      icon: page?.saved == true
                          ? const Icon(Icons.check_circle_rounded, color: spotifyGreen)
                          : const Icon(Icons.add_circle_outline_rounded),
                    ),
                  if (onMenu != null)
                    IconButton(
                      tooltip: "Plus d'options",
                      onPressed: onMenu,
                      icon: const Icon(Icons.more_horiz_rounded),
                    ),
                  const Spacer(),
                  if (page == null || page.canPlay) PlayButton(playing: playing, onPressed: onPlay),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
