/// Repeat button state, from its aria-checked attribute.
enum RepeatState { off, all, one }

/// Snapshot of the web player, as reported by assets/inject/bootstrap.js.
class PlayerState {
  const PlayerState({
    this.appReady = false,
    this.loggedIn,
    this.avatar = '',
    this.path = '/',
    this.hasTrack = false,
    this.title = '',
    this.artist = '',
    this.album = '',
    this.artwork = '',
    this.isAd = false,
    this.playing = false,
    this.positionMs,
    this.positionAt,
    this.durationMs,
    this.shuffle = false,
    this.repeat = RepeatState.off,
    this.liked,
    this.canShuffle = false,
    this.canRepeat = false,
    this.canLike = false,
    this.canNext = false,
    this.canPrevious = false,
    this.canSeek = false,
    this.panel = false,
    this.library = false,
  });

  factory PlayerState.fromJson(Map<String, dynamic> json) {
    int? integer(String key) => (json[key] as num?)?.round();
    bool flag(String key) => json[key] == true;
    String text(String key) => json[key] as String? ?? '';
    final repeat = integer('repeat') ?? 0;
    return PlayerState(
      appReady: flag('appReady'),
      loggedIn: json['loggedIn'] as bool?,
      avatar: text('avatar'),
      path: json['path'] as String? ?? '/',
      hasTrack: flag('hasTrack'),
      title: text('title'),
      artist: text('artist'),
      album: text('album'),
      artwork: text('artwork'),
      isAd: flag('isAd'),
      playing: flag('playing'),
      positionMs: integer('positionMs'),
      positionAt: integer('positionAt'),
      durationMs: integer('durationMs'),
      shuffle: integer('shuffle') == 1,
      repeat: RepeatState.values[repeat.clamp(0, RepeatState.values.length - 1)],
      liked: json['liked'] as bool?,
      canShuffle: flag('canShuffle'),
      canRepeat: flag('canRepeat'),
      canLike: flag('canLike'),
      canNext: flag('canNext'),
      canPrevious: flag('canPrevious'),
      canSeek: flag('canSeek'),
      panel: flag('panel'),
      library: flag('library'),
    );
  }

  static const empty = PlayerState();

  /// True once the web player has rendered its main view.
  final bool appReady;

  /// Null until the page shows either the login or the account button.
  final bool? loggedIn;
  final String avatar;
  final String path;

  final bool hasTrack;
  final String title;
  final String artist;
  final String album;
  final String artwork;
  final bool isAd;

  final bool playing;

  /// Position at [positionAt] (epoch ms); the page only reports discontinuities.
  final int? positionMs;
  final int? positionAt;
  final int? durationMs;

  final bool shuffle;
  final RepeatState repeat;
  final bool? liked;
  final bool canShuffle;
  final bool canRepeat;
  final bool canLike;
  final bool canNext;
  final bool canPrevious;
  final bool canSeek;

  /// A side panel (queue, lyrics) is shown full screen.
  final bool panel;

  /// The library sidebar is shown full screen.
  final bool library;

  Duration get duration => Duration(milliseconds: durationMs ?? 0);

  /// Current position, extrapolated from the last report while playing.
  Duration positionNow([DateTime? now]) {
    final base = positionMs;
    if (base == null) return Duration.zero;
    var ms = base;
    final at = positionAt;
    if (playing && at != null) {
      ms += (now ?? DateTime.now()).millisecondsSinceEpoch - at;
    }
    final max = durationMs;
    if (max != null && ms > max) ms = max;
    return Duration(milliseconds: ms < 0 ? 0 : ms);
  }

  // Logged-out visitors get a locale prefix: /intl-fr/search.
  static final _searchRoute = RegExp(r'^/(?:intl-[\w-]+/)?search(?:/|$)');
  static final _homeRoute = RegExp(r'^/(?:intl-[\w-]+/?)?$');

  bool get isSearchRoute => _searchRoute.hasMatch(path);
  bool get isHomeRoute => _homeRoute.hasMatch(path);
}
