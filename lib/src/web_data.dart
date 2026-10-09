// What assets/inject/reader.js reads from the web player's pages, for the
// native screens. Everything comes from the page: nothing is fetched otherwise.

/// A JSON object, as the page sends it.
typedef JsonMap = Map<String, dynamic>;

String _text(JsonMap json, String key) => json[key] is String ? json[key] as String : '';
bool _flag(JsonMap json, String key) => json[key] == true;
int? _int(JsonMap json, String key) => (json[key] as num?)?.round();
List<JsonMap> _list(Object? value) => value is List
    ? [
        for (final item in value)
          if (item is Map) Map<String, dynamic>.from(item),
      ]
    : const [];
List<String> _strings(Object? value) => value is List
    ? [
        for (final item in value)
          if (item is String) item,
      ]
    : const [];

/// The kind of page a path leads to: /playlist/…, /artist/…
String kindOfPath(String path) {
  final parts = path.split('/');
  return parts.length > 1 ? parts[1] : '';
}

/// A link to a page, with what it shows: an artist, an owner…
class WebLink {
  const WebLink({required this.name, required this.path});

  factory WebLink.fromJson(JsonMap json) => WebLink(name: _text(json, 'name'), path: _text(json, 'path'));

  static List<WebLink> listFrom(Object? value) => [for (final json in _list(value)) WebLink.fromJson(json)];

  final String name;
  final String path;
}

/// A row of a track list (or of the queue).
class WebTrack {
  const WebTrack({
    this.uri = '',
    this.path = '',
    required this.title,
    this.artists = const [],
    this.album,
    this.duration = '',
    this.image = '',
    this.index,
    this.disabled = false,
    this.saved,
    this.subtitle = '',
  });

  factory WebTrack.fromJson(JsonMap json) => WebTrack(
    uri: _text(json, 'uri'),
    path: _text(json, 'path'),
    title: _text(json, 'title'),
    artists: WebLink.listFrom(json['artists']),
    album: json['album'] is Map ? WebLink.fromJson(Map<String, dynamic>.from(json['album'] as Map)) : null,
    duration: _text(json, 'duration'),
    image: _text(json, 'image'),
    index: _int(json, 'index'),
    disabled: _flag(json, 'disabled'),
    saved: json['saved'] as bool?,
    subtitle: _text(json, 'subtitle'),
  );

  final String uri;
  final String path;
  final String title;
  final List<WebLink> artists;
  final WebLink? album;

  /// As the page shows it: "3:25".
  final String duration;
  final String image;

  /// Position in its list (the page counts the list's header row as 1).
  final int? index;
  final bool disabled;

  /// In Liked Songs, when the page tells.
  final bool? saved;

  /// What to show under the title when there are no artist links.
  final String subtitle;

  String get artistNames => artists.isEmpty ? subtitle : artists.map((artist) => artist.name).join(', ');
}

/// A card (or any link to a page): a playlist, an album, an artist…
class WebCard {
  const WebCard({
    required this.path,
    this.uri = '',
    this.kind = '',
    required this.title,
    this.subtitle = '',
    this.image = '',
    this.links = const [],
  });

  factory WebCard.fromJson(JsonMap json) => WebCard(
    path: _text(json, 'path'),
    uri: _text(json, 'uri'),
    kind: _text(json, 'kind'),
    title: _text(json, 'title'),
    subtitle: _text(json, 'subtitle'),
    image: _text(json, 'image'),
    links: WebLink.listFrom(json['links']),
  );

  final String path;
  final String uri;

  /// playlist, album, artist, show, episode, track, genre, section, collection…
  final String kind;
  final String title;
  final String subtitle;
  final String image;

  /// Other pages it mentions (its artists…).
  final List<WebLink> links;

  bool get round => kind == 'artist' || kind == 'user';
}

/// A part of a page: a track list, or a section of cards.
class WebBlock {
  const WebBlock({
    required this.key,
    this.title = '',
    this.path = '',
    this.total,
    this.tracks = const [],
    this.cards = const [],
    this.rows = false,
  });

  factory WebBlock.fromJson(JsonMap json) {
    final tracks = json['type'] == 'track';
    final items = _list(json['items']);
    return WebBlock(
      key: _text(json, 'key'),
      title: _text(json, 'title'),
      path: _text(json, 'path'),
      total: _int(json, 'total'),
      tracks: tracks ? [for (final item in items) WebTrack.fromJson(item)] : const [],
      cards: tracks ? const [] : [for (final item in items) WebCard.fromJson(item)],
      rows: json['rows'] == true,
    );
  }

  final String key;
  final String title;

  /// Where its title (or "Show all") leads.
  final String path;

  /// How many tracks the list has, when it tells (more than read so far, maybe).
  final int? total;
  final List<WebTrack> tracks;
  final List<WebCard> cards;

  /// The page lists its cards one per row (search results), rather than side by side.
  final bool rows;

  bool get isTracks => tracks.isNotEmpty;
}

/// A page of the web player as reader.js saw it.
class WebPage {
  const WebPage({
    required this.path,
    this.kind = '',
    this.title = '',
    this.label = '',
    this.lines = const [],
    this.links = const [],
    this.image = '',
    this.canPlay = false,
    this.hasMenu = false,
    this.saved,
    this.blocks = const [],
    this.complete = true,
  });

  factory WebPage.fromJson(JsonMap json) => WebPage(
    path: _text(json, 'path'),
    kind: _text(json, 'kind'),
    title: _text(json, 'title'),
    label: _text(json, 'label'),
    lines: _strings(json['lines']),
    links: WebLink.listFrom(json['links']),
    image: _text(json, 'image'),
    canPlay: _flag(json, 'canPlay'),
    hasMenu: _flag(json, 'hasMenu'),
    saved: json['saved'] as bool?,
    blocks: [for (final block in _list(json['blocks'])) WebBlock.fromJson(block)],
    complete: json['complete'] != false,
  );

  final String path;

  /// home, search, playlist, album, artist, show, genre, section, collection…
  final String kind;
  final String title;

  /// The kind of page as it says it: "Playlist", "Album", "Verified artist"…
  final String label;

  /// Description, owner, year, length…
  final List<String> lines;
  final List<WebLink> links;
  final String image;
  final bool canPlay;
  final bool hasMenu;

  /// In the library (liked, followed), when the page has that button.
  final bool? saved;
  final List<WebBlock> blocks;

  /// False while the page has more to show further down.
  final bool complete;

  Iterable<WebTrack> get tracks => blocks.expand((block) => block.tracks);

  bool get isEmpty => title.isEmpty && blocks.every((block) => block.tracks.isEmpty && block.cards.isEmpty);
}

/// An entry of "Your Library".
class LibraryItem {
  const LibraryItem({
    required this.uri,
    this.path = '',
    this.kind = '',
    required this.title,
    this.subtitle = '',
    this.image = '',
  });

  factory LibraryItem.fromJson(JsonMap json) => LibraryItem(
    uri: _text(json, 'uri'),
    path: _text(json, 'path'),
    kind: _text(json, 'kind'),
    title: _text(json, 'title'),
    subtitle: _text(json, 'subtitle'),
    image: _text(json, 'image'),
  );

  static List<LibraryItem> listFrom(Object? json) =>
      json is Map ? [for (final item in _list(json['items'])) LibraryItem.fromJson(item)] : const [];

  final String uri;

  /// Empty for folders, which have no page.
  final String path;

  /// playlist, album, artist, show, collection (Liked Songs…), folder.
  final String kind;
  final String title;
  final String subtitle;
  final String image;
}

class QueueSection {
  const QueueSection({required this.title, required this.tracks});

  factory QueueSection.fromJson(JsonMap json) => QueueSection(
    title: _text(json, 'title'),
    tracks: [for (final track in _list(json['tracks'])) WebTrack.fromJson(track)],
  );

  final String title;
  final List<WebTrack> tracks;
}

/// The queue panel: now playing, next in queue, next from the context.
class QueueData {
  const QueueData({this.sections = const [], this.current = ''});

  factory QueueData.fromJson(Object? json) {
    if (json is! Map) return const QueueData();
    final map = Map<String, dynamic>.from(json);
    return QueueData(
      sections: [for (final section in _list(map['sections'])) QueueSection.fromJson(section)],
      current: _text(map, 'current'),
    );
  }

  final List<QueueSection> sections;

  /// The track playing.
  final String current;
}

class LyricsData {
  const LyricsData({this.lines = const [], this.active = -1, this.uri = '', this.message = ''});

  factory LyricsData.fromJson(Object? json) {
    if (json is! Map) return const LyricsData();
    final map = Map<String, dynamic>.from(json);
    return LyricsData(
      lines: _strings(map['lines']),
      active: _int(map, 'active') ?? -1,
      uri: _text(map, 'uri'),
      message: _text(map, 'message'),
    );
  }

  final List<String> lines;

  /// The line being sung, -1 when none (not synced, or not started).
  final int active;

  /// The track they are the lyrics of.
  final String uri;

  /// What the page says instead, when it has none.
  final String message;
}

/// An entry of one of the page's context menus.
class MenuEntry {
  const MenuEntry({
    required this.label,
    this.submenu = false,
    this.disabled = false,
    this.checked,
    this.separated = false,
  });

  factory MenuEntry.fromJson(JsonMap json) => MenuEntry(
    label: _text(json, 'label'),
    submenu: _flag(json, 'submenu'),
    disabled: _flag(json, 'disabled'),
    checked: json['checked'] as bool?,
    separated: _flag(json, 'separated'),
  );

  final String label;

  /// Opens another menu (Add to playlist, Share…).
  final bool submenu;
  final bool disabled;
  final bool? checked;

  /// A separator comes before it.
  final bool separated;
}

/// A menu open in the page, at some depth (0: the menu, 1: a submenu…).
class WebMenu {
  const WebMenu({required this.level, required this.entries});

  factory WebMenu.fromJson(Object? json) {
    final map = json is Map ? Map<String, dynamic>.from(json) : <String, dynamic>{};
    return WebMenu(
      level: _int(map, 'level') ?? 0,
      entries: [for (final entry in _list(map['items'])) MenuEntry.fromJson(entry)],
    );
  }

  final int level;
  final List<MenuEntry> entries;
}

/// What picking a menu entry did in the page.
class MenuOutcome {
  const MenuOutcome({this.navigated = '', this.dialog = '', this.message = ''});

  factory MenuOutcome.fromJson(JsonMap json) =>
      MenuOutcome(navigated: _text(json, 'navigated'), dialog: _text(json, 'dialog'), message: _text(json, 'message'));

  /// The page it opened.
  final String navigated;

  /// A dialog it opened in the page, to fill in there.
  final String dialog;

  /// The message the page showed.
  final String message;
}

/// What a context menu is about.
sealed class MenuTarget {
  const MenuTarget();

  Map<String, Object?> toJson();
}

/// A track of a page's list.
class TrackTarget extends MenuTarget {
  const TrackTarget(this.track);

  final WebTrack track;

  @override
  Map<String, Object?> toJson() => {'type': 'track', 'uri': track.uri, 'index': track.index};
}

/// A card of a page.
class CardTarget extends MenuTarget {
  const CardTarget(this.card);

  final WebCard card;

  @override
  Map<String, Object?> toJson() => {'type': 'card', 'path': card.path};
}

/// The page itself (its "…" button).
class PageTarget extends MenuTarget {
  const PageTarget();

  @override
  Map<String, Object?> toJson() => {'type': 'page'};
}

/// A track of the queue, by section and position.
class QueueTarget extends MenuTarget {
  const QueueTarget(this.track, {required this.section, required this.position});

  final WebTrack track;
  final int section;

  /// From 1.
  final int position;

  @override
  Map<String, Object?> toJson() => {'type': 'queue', 'uri': track.uri, 'section': section, 'index': position};
}

/// The track playing.
class NowPlayingTarget extends MenuTarget {
  const NowPlayingTarget();

  @override
  Map<String, Object?> toJson() => {'type': 'nowPlaying'};
}

/// An entry of the library.
class LibraryTarget extends MenuTarget {
  const LibraryTarget(this.item);

  final LibraryItem item;

  @override
  Map<String, Object?> toJson() => {'type': 'library', 'uri': item.uri};
}
