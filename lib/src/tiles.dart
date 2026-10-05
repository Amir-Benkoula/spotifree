import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'app_actions.dart';
import 'player_state.dart';
import 'web_bridge.dart';
import 'web_data.dart';
import 'widgets.dart';

/// Pieces the native screens are made of: covers, rows, cards, sections.

const surfaceColor = Color(0xFF121212);
const tileColor = Color(0xFF2A2A2A);

IconData kindIcon(String kind) => switch (kind) {
  'artist' || 'user' => Icons.person_rounded,
  'album' => Icons.album_rounded,
  'show' || 'episode' || 'audiobook' || 'chapter' => Icons.podcasts_rounded,
  'collection' => Icons.favorite_rounded,
  'folder' => Icons.folder_rounded,
  'genre' || 'section' => Icons.grid_view_rounded,
  'playlist' => Icons.queue_music_rounded,
  _ => Icons.music_note_rounded,
};

/// A page's picture: square, or round for artists. Liked Songs and pages
/// without a picture get their kind's icon.
class Cover extends StatelessWidget {
  const Cover({super.key, required this.url, required this.size, this.kind = '', this.round = false, this.radius = 4});

  final String url;
  final double size;
  final String kind;
  final bool round;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final placeholder = kind == 'collection'
        ? DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF450AF5), Color(0xFFC4EFD9)],
              ),
            ),
            child: Center(
              child: Icon(Icons.favorite_rounded, color: Colors.white, size: size * 0.4),
            ),
          )
        : ColoredBox(
            color: tileColor,
            child: Center(
              child: Icon(kindIcon(kind), color: Colors.white38, size: size * 0.4),
            ),
          );
    final image = url.isEmpty
        ? placeholder
        : Image.network(
            url,
            fit: BoxFit.cover,
            cacheWidth: (size * MediaQuery.devicePixelRatioOf(context)).round(),
            gaplessPlayback: true,
            errorBuilder: (_, _, _) => placeholder,
          );
    return SizedBox.square(
      dimension: size,
      child: round ? ClipOval(child: image) : ClipRRect(borderRadius: BorderRadius.circular(radius), child: image),
    );
  }
}

/// A track in a list: its cover (or number), title and artists.
class TrackTile extends StatelessWidget {
  const TrackTile({super.key, required this.track, this.number, this.current = false, this.onTap, this.onMore});

  final WebTrack track;

  /// Shown instead of the cover (albums).
  final int? number;

  /// Playing now: in green.
  final bool current;
  final VoidCallback? onTap;
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = current ? spotifyGreen : Colors.white;
    return Opacity(
      opacity: track.disabled ? 0.4 : 1,
      child: InkWell(
        onTap: track.disabled ? null : onTap,
        onLongPress: onMore,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 6, 4, 6),
          child: Row(
            children: [
              if (track.image.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Cover(url: track.image, size: 48, kind: 'track', radius: 2),
                )
              else if (number != null)
                SizedBox(
                  width: 36,
                  child: Text(
                    '$number',
                    style: textTheme.bodyMedium?.copyWith(color: current ? color : Colors.white60),
                  ),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      track.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyLarge?.copyWith(color: color, fontWeight: FontWeight.w500),
                    ),
                    if (track.artistNames.isNotEmpty || track.saved == true)
                      Row(
                        children: [
                          if (track.saved == true)
                            const Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Icon(Icons.check_circle_rounded, size: 14, color: spotifyGreen),
                            ),
                          Expanded(
                            child: Text(
                              track.artistNames,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodySmall?.copyWith(color: Colors.white60),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              if (onMore != null)
                IconButton(
                  tooltip: "Plus d'options",
                  icon: const Icon(Icons.more_vert_rounded, color: Colors.white60),
                  onPressed: onMore,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A card of a shelf: picture, title and subtitle under it.
class CardTile extends StatelessWidget {
  const CardTile({super.key, required this.card, this.size = 140, this.onTap, this.onLongPress});

  final WebCard card;
  final double size;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(6),
      child: SizedBox(
        width: size,
        child: Column(
          crossAxisAlignment: card.round ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Cover(url: card.image, size: size, kind: card.kind, round: card.round),
            const SizedBox(height: 8),
            Text(
              card.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: card.round ? TextAlign.center : TextAlign.start,
              style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            if (card.subtitle.isNotEmpty)
              Text(
                card.subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: card.round ? TextAlign.center : TextAlign.start,
                style: textTheme.bodySmall?.copyWith(color: Colors.white60),
              ),
          ],
        ),
      ),
    );
  }
}

/// A row of a list of pages: picture, title, subtitle (library, episodes…).
class EntityTile extends StatelessWidget {
  const EntityTile({
    super.key,
    required this.title,
    this.subtitle = '',
    this.image = '',
    this.kind = '',
    this.round = false,
    this.size = 56,
    this.onTap,
    this.onLongPress,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final String image;
  final String kind;
  final bool round;
  final double size;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Row(
          children: [
            Cover(url: image, size: size, kind: kind, round: round),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                  ),
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
            ?trailing,
          ],
        ),
      ),
    );
  }
}

/// The home page's shortcuts: small picture and title side by side.
class ShortcutTile extends StatelessWidget {
  const ShortcutTile({super.key, required this.card, this.onTap, this.onLongPress});

  final WebCard card;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: tileColor,
      borderRadius: BorderRadius.circular(4),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Row(
          children: [
            Cover(url: card.image, size: 56, kind: card.kind, radius: 0),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                card.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

/// A category to browse: a colored tile with its title and picture.
class GenreTile extends StatelessWidget {
  const GenreTile({super.key, required this.card, this.onTap});

  final WebCard card;
  final VoidCallback? onTap;

  static const _colors = [
    Color(0xFFDC148C),
    Color(0xFF006450),
    Color(0xFF8400E7),
    Color(0xFF1E3264),
    Color(0xFFE8115B),
    Color(0xFF477D95),
    Color(0xFFBA5D07),
    Color(0xFF503750),
    Color(0xFF148A08),
    Color(0xFFAF2896),
  ];

  @override
  Widget build(BuildContext context) {
    final color = _colors[card.title.codeUnits.fold(0, (a, b) => a + b) % _colors.length];
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            if (card.image.isNotEmpty)
              Positioned(
                right: -14,
                bottom: -4,
                child: Transform.rotate(
                  angle: math.pi / 8,
                  child: Cover(url: card.image, size: 64, kind: card.kind),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                card.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A section's title, with its "show all" link.
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.onMore});

  final String title;
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 24, onMore == null ? 16 : 4, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
          if (onMore != null)
            TextButton(
              onPressed: onMore,
              style: TextButton.styleFrom(foregroundColor: Colors.white70),
              child: const Text('Tout afficher'),
            ),
        ],
      ),
    );
  }
}

/// The big green play / pause button.
class PlayButton extends StatelessWidget {
  const PlayButton({super.key, required this.playing, required this.onPressed, this.size = 56});

  final bool playing;
  final VoidCallback? onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: IconButton.filled(
        tooltip: playing ? 'Pause' : 'Lecture',
        style: IconButton.styleFrom(
          backgroundColor: spotifyGreen,
          foregroundColor: Colors.black,
          disabledBackgroundColor: Colors.white24,
        ),
        iconSize: size * 0.55,
        onPressed: onPressed,
        icon: Icon(playing ? Icons.pause_rounded : Icons.play_arrow_rounded),
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) => const Center(
    child: SizedBox.square(dimension: 28, child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white54)),
  );
}

/// When the page couldn't be read: try again, or look at the page itself.
class FailureView extends StatelessWidget {
  const FailureView({super.key, required this.error, this.onRetry, this.onWeb});

  final Object error;
  final VoidCallback? onRetry;
  final VoidCallback? onWeb;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_rounded, size: 40, color: Colors.white54),
            const SizedBox(height: 12),
            Text("Impossible d'afficher cette page", style: textTheme.titleMedium, textAlign: TextAlign.center),
            const SizedBox(height: 6),
            Text(
              error is WebError ? (error as WebError).message : '$error',
              textAlign: TextAlign.center,
              style: textTheme.bodySmall?.copyWith(color: Colors.white54),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                if (onRetry != null) FilledButton(onPressed: onRetry, child: const Text('Réessayer')),
                if (onWeb != null) OutlinedButton(onPressed: onWeb, child: const Text('Voir la page web')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Plays a track of a page's list, saying so when it can't.
Future<void> playTrackOf(AppActions app, String path, WebTrack track) async {
  try {
    await app.content.playTrack(path, track);
  } on WebError catch (error) {
    if (!error.cancelled) app.notify('Lecture impossible : ${error.message}');
  }
}

/// Plays a page from the start (pause when it is what plays).
Future<void> playPageOf(AppActions app, WebPage page, PlayerState state) async {
  if (isPlayingFrom(page, state)) {
    state.playing ? app.bridge.pause() : app.bridge.play();
    return;
  }
  try {
    await app.content.playPage(page.path);
  } on WebError catch (error) {
    if (!error.cancelled) app.notify('Lecture impossible : ${error.message}');
  }
}

/// What plays comes from this page: its context, or one of its tracks.
bool isPlayingFrom(WebPage page, PlayerState state) {
  if (!state.hasTrack) return false;
  if (state.contextPath.isNotEmpty && state.contextPath == page.path) return true;
  return state.trackUri.isNotEmpty && page.tracks.any((track) => track.uri == state.trackUri);
}

enum _CardLayout { shortcuts, shelf, grid, genres, list, top }

_CardLayout _layoutOf(WebPage page, WebBlock block, int position) {
  final cards = block.cards;
  if (cards.every((card) => card.kind == 'genre')) return _CardLayout.genres;
  if (page.kind == 'home' && block.title.isEmpty && position == 0) return _CardLayout.shortcuts;
  if (page.kind == 'search' && cards.length == 1 && position == 0) return _CardLayout.top;
  if (cards.where((card) => card.kind == 'episode').length * 2 > cards.length) return _CardLayout.list;
  final cardBlocks = page.blocks.where((b) => b.cards.isNotEmpty).length;
  if (cardBlocks == 1 && page.blocks.length <= 2 && cards.length > 4) return _CardLayout.grid;
  return _CardLayout.shelf;
}

/// Height of a [CardTile] under its picture: two lines of title, one of subtitle.
double cardTextHeight(BuildContext context) => 12 + 56 * MediaQuery.textScalerOf(context).scale(1);

/// A page's blocks, laid out like the official app does: track lists, shelves
/// of cards, grids.
List<Widget> blockSlivers(
  BuildContext context, {
  required AppActions app,
  required WebPage page,
  required PlayerState state,
}) {
  final slivers = <Widget>[];
  void openCard(WebCard card) => app.openPath(card.path, preview: card);
  void cardMenu(WebCard card) => app.showMenu(CardTarget(card), path: page.path, header: MenuHeader.card(card));

  for (final (position, block) in page.blocks.indexed) {
    final more = block.path.isEmpty || block.path == page.path ? null : () => app.openPath(block.path);
    if (block.title.isNotEmpty && (block.tracks.isNotEmpty || block.cards.isNotEmpty)) {
      slivers.add(
        SliverToBoxAdapter(
          child: SectionHeader(title: block.title, onMore: more),
        ),
      );
    }
    if (block.isTracks) {
      final numbered = block.tracks.every((track) => track.image.isEmpty);
      slivers.add(
        SliverList.builder(
          itemCount: block.tracks.length,
          itemBuilder: (context, i) {
            final track = block.tracks[i];
            return TrackTile(
              track: track,
              number: numbered ? (track.index == null ? i + 1 : track.index! - 1) : null,
              current: track.uri.isNotEmpty && track.uri == state.trackUri,
              onTap: () => playTrackOf(app, page.path, track),
              onMore: () => app.showMenu(TrackTarget(track), path: page.path, header: MenuHeader.track(track)),
            );
          },
        ),
      );
      continue;
    }
    if (block.cards.isEmpty) continue;
    switch (_layoutOf(page, block, position)) {
      case _CardLayout.shortcuts:
        slivers.add(
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 56,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: block.cards.length,
              itemBuilder: (context, i) => ShortcutTile(
                card: block.cards[i],
                onTap: () => openCard(block.cards[i]),
                onLongPress: () => cardMenu(block.cards[i]),
              ),
            ),
          ),
        );
      case _CardLayout.genres:
        slivers.add(
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 96,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: block.cards.length,
              itemBuilder: (context, i) => GenreTile(card: block.cards[i], onTap: () => openCard(block.cards[i])),
            ),
          ),
        );
      case _CardLayout.top:
        final card = block.cards.first;
        slivers.add(
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Material(
                color: tileColor,
                borderRadius: BorderRadius.circular(8),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => openCard(card),
                  onLongPress: () => cardMenu(card),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Cover(url: card.image, size: 92, kind: card.kind, round: card.round),
                        const SizedBox(height: 16),
                        Text(
                          card.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        if (card.subtitle.isNotEmpty)
                          Text(
                            card.subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white60),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      case _CardLayout.list:
        slivers.add(
          SliverList.builder(
            itemCount: block.cards.length,
            itemBuilder: (context, i) {
              final card = block.cards[i];
              return EntityTile(
                title: card.title,
                subtitle: card.subtitle,
                image: card.image,
                kind: card.kind,
                round: card.round,
                size: 64,
                onTap: () => openCard(card),
                onLongPress: () => cardMenu(card),
              );
            },
          ),
        );
      case _CardLayout.grid:
        slivers.add(
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            sliver: SliverLayoutBuilder(
              builder: (context, constraints) {
                final size = (constraints.crossAxisExtent - 16) / 2;
                return SliverGrid.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: size + cardTextHeight(context),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 16,
                  ),
                  itemCount: block.cards.length,
                  itemBuilder: (context, i) => CardTile(
                    card: block.cards[i],
                    size: size,
                    onTap: () => openCard(block.cards[i]),
                    onLongPress: () => cardMenu(block.cards[i]),
                  ),
                );
              },
            ),
          ),
        );
      case _CardLayout.shelf:
        slivers.add(
          SliverToBoxAdapter(
            child: SizedBox(
              height: 140 + cardTextHeight(context),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: block.cards.length,
                separatorBuilder: (_, _) => const SizedBox(width: 16),
                itemBuilder: (context, i) => CardTile(
                  card: block.cards[i],
                  onTap: () => openCard(block.cards[i]),
                  onLongPress: () => cardMenu(block.cards[i]),
                ),
              ),
            ),
          ),
        );
    }
  }
  return slivers;
}

/// The account's picture, which opens the settings.
class AccountButton extends StatelessWidget {
  const AccountButton({super.key, required this.app});

  final AppActions app;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PlayerState>(
      valueListenable: app.bridge.state,
      builder: (context, state, _) => IconButton(
        tooltip: 'Réglages',
        onPressed: app.openSettings,
        icon: CircleAvatar(
          radius: 16,
          backgroundColor: const Color(0xFFF573A0),
          foregroundImage: state.avatar.isEmpty ? null : NetworkImage(state.avatar),
          child: const Icon(Icons.person_rounded, size: 20, color: Colors.black),
        ),
      ),
    );
  }
}
