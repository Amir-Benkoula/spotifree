// Runs at document start in the page's own world on https://open.spotify.com,
// before any page script (content script of the app's built-in extension, see
// manifest.json; mobile.css is injected alongside).
//
// 1. Takes over the MediaSession API, so metadata, playback state and actions
//    reach the native player, notification and lock screen instead. Spotify
//    doesn't keep the playback state and position up to date there: they are
//    worked out from the media it plays and from the (hidden) desktop player bar.
// 2. Answers commands from the native UI (window.__spotiweb.cmd(name, arg)).
//    Those whose argument carries an __id are requests: their result, maybe a
//    promise, goes back as a { type: 'reply', id, result } message. reader.js,
//    which runs next, adds the commands of the native screens.
// 3. Adapts touch interactions (a tap on a track plays it, like the mobile app).
// 4. Cuts ads short (Spotify Free), unless turned off.
//
// Messages go through relay.js (isolated world, which can reach the app):
// 'spotiweb:out' events to the app, 'spotiweb:in' events from it.
(() => {
  'use strict';
  if (window.__spotiweb || location.hostname !== 'open.spotify.com') return;

  const define = (target, prop, get) => {
    try {
      Object.defineProperty(target, prop, { get, configurable: true });
    } catch (_) {}
  };
  const byTestId = (id, root = document) => root.querySelector(`[data-testid="${id}"]`);

  // View transitions (cinema mode, panels) are expensive on phones.
  try {
    delete Document.prototype.startViewTransition;
  } catch (_) {}

  // ------------------------------------------------------------- MediaSession
  const handlers = Object.create(null);
  const media = { metadata: null, playbackState: 'none', position: null };
  const session = {
    get metadata() {
      return media.metadata;
    },
    set metadata(value) {
      media.metadata = value || null;
      scheduleState();
    },
    get playbackState() {
      return media.playbackState;
    },
    set playbackState(value) {
      media.playbackState = String(value);
      scheduleState();
    },
    setActionHandler(action, handler) {
      if (typeof handler === 'function') handlers[action] = handler;
      else delete handlers[action];
    },
    setPositionState(state) {
      media.position =
        state && state.duration > 0
          ? { position: state.position || 0, duration: state.duration, at: Date.now() }
          : null;
      scheduleState();
    },
    setCameraActive() {},
    setMicrophoneActive() {},
  };
  define(Navigator.prototype, 'mediaSession', () => session);
  if (typeof window.MediaMetadata !== 'function') {
    window.MediaMetadata = class MediaMetadata {
      constructor(init = {}) {
        Object.assign(this, { title: '', artist: '', album: '', artwork: [] }, init);
      }
    };
  }

  // ----------------------------------------------------------- media elements
  // Like the browser, guess the playback state from the media actually playing
  // (a declared "playing" still wins, see playingNow). Elements are caught as
  // they are created or played, as the player's may never be attached to the
  // page. Muted ones (cover videos) don't count.
  const players = new Set(); // WeakRefs: elements the page drops can go.
  const watched = new WeakSet();
  const loads = new WeakMap(); // Element -> number of sources it loaded.
  let heardAt = 0; // Last time an element was heard playing.
  let pausedAt = 0; // Last time one was paused on purpose (not by its end).

  // Between two tracks the element ends, or reloads, before it plays again:
  // that is no pause.
  const TRACK_GAP_MS = 2000;

  const audible = (el) => !el.paused && !el.muted;

  function onMediaEvent(event) {
    const el = event.target;
    if (event.type === 'timeupdate') {
      if (audible(el)) heardAt = Date.now();
      return;
    }
    if (event.type === 'pause' && !el.muted && !el.ended) pausedAt = Date.now();
    if (event.type === 'loadstart') loads.set(el, (loads.get(el) || 0) + 1);
    scheduleState();
  }

  const MEDIA_EVENTS = [
    'loadstart',
    'durationchange',
    'play',
    'playing',
    'pause',
    'ended',
    'emptied',
    'volumechange',
    'timeupdate',
  ];

  function watchMedia(el) {
    if (!(el instanceof HTMLMediaElement) || watched.has(el)) return;
    watched.add(el);
    players.add(new WeakRef(el));
    for (const type of MEDIA_EVENTS) el.addEventListener(type, onMediaEvent);
  }

  const nativeCreateElement = Document.prototype.createElement;
  Document.prototype.createElement = function (...args) {
    const el = nativeCreateElement.apply(this, args);
    watchMedia(el);
    return el;
  };
  const nativePlay = HTMLMediaElement.prototype.play;
  HTMLMediaElement.prototype.play = function (...args) {
    watchMedia(this);
    return nativePlay.apply(this, args);
  };
  // Elements in the page: media events don't bubble, but do go through capture.
  document.addEventListener('play', (event) => watchMedia(event.target), true);

  function mediaPlaying(now) {
    for (const ref of players) {
      const el = ref.deref();
      if (!el) {
        players.delete(ref);
      } else if (audible(el)) {
        heardAt = now;
        return true;
      }
    }
    if (pausedAt >= heardAt || now - heardAt >= TRACK_GAP_MS) return false;
    recheckIn(TRACK_GAP_MS - (now - heardAt));
    return true;
  }

  // ------------------------------------------------------------------ ad block
  // Spotify Free plays ads between tracks. Blocking their requests leaves the
  // player stuck ("your music will continue after the break"), so ads are let
  // in and cut short: muted at once, then taken to their end, after which the
  // player moves on as if they had played. Meanwhile the page sees the element
  // as it set it (not muted, normal speed), should it hold such an ad back.
  //
  // The bar may still show the ad as the next track starts: an element is only
  // taken to the end once the ad has lasted a moment on the same source, and
  // if it is short like an ad. A track mistaken for one loses that moment.
  const AD_CONFIRM_MS = 600;
  const AD_MAX_SECONDS = 70;
  const AD_RATE = 16; // As fast as browsers play: in case the page undoes the jump.
  const mutedProp = Object.getOwnPropertyDescriptor(HTMLMediaElement.prototype, 'muted');
  const rateProp = Object.getOwnPropertyDescriptor(HTMLMediaElement.prototype, 'playbackRate');
  const silenced = new Map(); // Element -> what the page set, and since when it is held.
  // Spotify's tab title during an ad, in a few languages ("Advertisement · …").
  const AD_TITLE =
    /^(?:Advertisement|Publicité|Werbung|Anuncio|Publicidad|Pubblicità|Anúncio|Publicidade|Advertentie)(?:\s|$)/;

  let adBlock = true;
  try {
    adBlock = localStorage.getItem('spotiweb:adblock') !== 'off';
  } catch (_) {}

  // The bar flags ads. The tab title tells too, but a track could be called so:
  // one that links to a track or an episode isn't an ad.
  function adShown(bar) {
    if (bar && bar.getAttribute('data-testadtype') === 'ad-type-ad') return true;
    if (!AD_TITLE.test(document.title)) return false;
    const title = bar && byTestId('context-item-info-title', bar);
    const link = title && (title.closest('a') || title.querySelector('a'));
    return !(link && /\/(?:track|episode)\//.test(link.getAttribute('href') || ''));
  }

  function hold(el) {
    let held = silenced.get(el);
    if (held) return held;
    const page = { muted: mutedProp.get.call(el), rate: rateProp.get.call(el) };
    held = { page, load: loads.get(el) || 0, since: Date.now() };
    silenced.set(el, held);
    Object.defineProperty(el, 'muted', {
      configurable: true,
      get: () => page.muted,
      set: (value) => {
        page.muted = !!value;
      },
    });
    Object.defineProperty(el, 'playbackRate', {
      configurable: true,
      get: () => page.rate,
      set: (value) => {
        if (+value > 0) page.rate = +value;
      },
    });
    mutedProp.set.call(el, true);
    setTimeout(scheduleState, AD_CONFIRM_MS + 50);
    return held;
  }

  const setRate = (el, rate) => {
    try {
      if (rateProp.get.call(el) !== rate) rateProp.set.call(el, rate);
    } catch (_) {}
  };

  function release(el) {
    const held = silenced.get(el);
    if (!held) return;
    silenced.delete(el);
    delete el.muted;
    delete el.playbackRate;
    mutedProp.set.call(el, held.page.muted);
    setRate(el, held.page.rate);
  }

  function cutShort(el, held) {
    const load = loads.get(el) || 0;
    if (held.load !== load) {
      // Another source since: maybe the next track already. Look again later.
      Object.assign(held, { load, since: Date.now() });
      setRate(el, held.page.rate);
      setTimeout(scheduleState, AD_CONFIRM_MS + 50);
      return;
    }
    const end = el.duration;
    if (Date.now() - held.since < AD_CONFIRM_MS || !(end <= AD_MAX_SECONDS)) return;
    setRate(el, AD_RATE);
    // Once: should the page take the jump back, the speed does the rest.
    if (held.jumped !== load && el.currentTime < end - 0.5) {
      held.jumped = load;
      el.currentTime = end - 0.1;
    }
  }

  function syncAds(bar) {
    const ad = adBlock && adShown(bar);
    for (const ref of players) {
      const el = ref.deref();
      if (!el) continue;
      if (ad && (silenced.has(el) || audible(el))) {
        const held = hold(el);
        if (!el.paused) cutShort(el, held);
      } else if (!ad) {
        release(el);
      }
    }
  }

  // ------------------------------------------------------------------- clock
  // Position as positionMs at positionAt (epoch ms). It only moves on
  // discontinuities (seek, new track, play/pause): the app extrapolates in
  // between, so its bar runs smoothly instead of jumping at every report.
  // Declared by setPositionState if the page calls it, otherwise read from the
  // elapsed time in the player bar (whole seconds) when it changes. The bar's
  // range input doesn't follow playback: only its max (the duration) is used.
  const clock = { positionMs: null, positionAt: null, playing: false };
  let clockTrack = null; // Track the clock is about.
  let clockDeclared = null; // Last media.position applied.
  let elapsedText = null; // Elapsed time last seen in the bar.
  let tickAt = 0; // Last time it moved on by itself.

  // Longest wait between two ticks of the elapsed time while playing.
  const TICK_MS = 2500;

  // "1:23" or "1:02:03" -> seconds, null otherwise (no track, remaining time…).
  function parseTime(text) {
    const match = /^(?:(\d+):)?(\d+):(\d\d)$/.exec(String(text || '').trim());
    return match ? (+match[1] || 0) * 3600 + +match[2] * 60 + +match[3] : null;
  }

  function setClock(positionMs, at) {
    clock.positionMs = Math.max(0, Math.round(positionMs));
    clock.positionAt = at;
  }
  const clockAt = (now) => clock.positionMs + (clock.playing ? now - clock.positionAt : 0);

  const elapsedLabel = (bar) => {
    const label = bar ? byTestId('playback-position', bar) : null;
    return label ? label.textContent : null;
  };

  function readElapsed(bar, now) {
    const text = elapsedLabel(bar);
    const seconds = parseTime(text);
    const changed = text !== elapsedText;
    if (changed) {
      const before = parseTime(elapsedText);
      if (seconds !== null && before !== null && seconds - before >= 1 && seconds - before <= 2) tickAt = now;
      elapsedText = text;
    }
    return { ms: seconds === null ? null : seconds * 1000, changed };
  }

  function playingNow(now) {
    if (media.playbackState === 'playing' || mediaPlaying(now)) return true;
    // Nothing ever heard here: playing on another device (Spotify Connect), or
    // through media out of reach. The elapsed time still tells.
    if (heardAt || media.playbackState !== 'none' || now - tickAt >= TICK_MS) return false;
    recheckIn(TICK_MS - (now - tickAt));
    return true;
  }

  function updateClock(meta, elapsed, playing, now) {
    // Play/pause: carry on, or stop, from where it is. With no media heard here,
    // the elapsed time is what tells, so it also has the position.
    if (playing !== clock.playing) {
      if (!heardAt && elapsed.ms !== null) setClock(elapsed.ms, now);
      else if (clock.positionMs !== null) setClock(clockAt(now), now);
      clock.playing = playing;
    }
    // New tracks start from the top (the bar may still show the previous one).
    // The first one can resume anywhere: the bar has it.
    const track = meta ? [meta.title, meta.artist, meta.album].join('\n') : null;
    const newTrack = track !== clockTrack;
    if (newTrack) {
      setClock(clockTrack === null && elapsed.ms !== null ? elapsed.ms : 0, now);
      clockTrack = track;
    }
    if (media.position !== clockDeclared) {
      clockDeclared = media.position;
      if (media.position) setClock(media.position.position * 1000, media.position.at);
    }
    if (newTrack || !elapsed.changed || elapsed.ms === null) return;
    // The elapsed time just turned (the bar is observed): playback is within
    // the second it shows. Further off than some jitter is a seek, a new track
    // that didn't start from the top, or a clock started early.
    const position = clock.positionMs === null ? null : clockAt(now);
    if (position === null || position < elapsed.ms - 250 || position > elapsed.ms + 1250) {
      setClock(elapsed.ms, now);
    }
  }

  function readDuration(bar) {
    if (media.position) return Math.round(media.position.duration * 1000);
    const label = bar ? byTestId('playback-duration', bar) : null;
    const total = parseTime(label && label.textContent);
    const range = bar && bar.querySelector('[data-testid="playback-progressbar"] input[type="range"]');
    // The range's max is in milliseconds (when it agrees with the label).
    const max = range ? +range.max : 0;
    if (max > 0 && (total === null || Math.abs(max - total * 1000) < 2000)) return max;
    return total ? total * 1000 : null;
  }

  // Reports again once a guess based on recent activity runs out.
  let recheckTimer = 0;
  function recheckIn(ms) {
    clearTimeout(recheckTimer);
    recheckTimer = setTimeout(scheduleState, ms + 50);
  }

  // -------------------------------------------------------------------- state
  // The app shows this page itself (web interface) rather than its own screens.
  let webUi = false;
  try {
    webUi = localStorage.getItem('spotiweb:ui') === 'web';
  } catch (_) {}

  const nowPlayingBar = () => byTestId('now-playing-bar');
  const barControl = (id) => {
    const bar = nowPlayingBar();
    return bar ? byTestId(id, bar) : null;
  };
  // aria-checked: "false" -> 0, "true" -> 1, "mixed" (repeat one) -> 2.
  const checkedState = (el) => {
    if (!el) return null;
    const value = el.getAttribute('aria-checked');
    return value === 'mixed' ? 2 : value === 'true' ? 1 : 0;
  };
  const isEnabled = (el) => !!el && !el.disabled && el.getAttribute('aria-disabled') !== 'true';

  const largestArtwork = (artwork) => {
    let best = '';
    let bestSize = -1;
    for (const image of artwork || []) {
      const size = parseInt(String(image.sizes || '0').split('x')[0], 10) || 0;
      if (image.src && size > bestSize) {
        best = image.src;
        bestSize = size;
      }
    }
    return best;
  };

  // The link of a text in the bar (the element itself, inside or around it).
  const linkOf = (el) => (el ? el.closest('a') || el.querySelector('a') : null);
  const hrefOf = (link) => {
    try {
      return decodeURIComponent((link && link.getAttribute('href')) || '');
    } catch (_) {
      return '';
    }
  };

  // The track playing, from its title's link in the bar: /track/<id>, or its
  // album with the track in the query (…?highlight=spotify:track:<id>).
  function trackUri(bar = nowPlayingBar()) {
    const href = hrefOf(linkOf(bar && byTestId('context-item-info-title', bar)));
    const match = /spotify:(track|episode):(\w+)/.exec(href) || /\/(track|episode)\/(\w+)/.exec(href);
    return match ? `spotify:${match[1]}:${match[2]}` : '';
  }

  // Pages of the track playing: its album, artists and what it plays from.
  function trackLinks(bar) {
    const path = (href) => {
      const match = /^(?:https:\/\/open\.spotify\.com)?(\/[a-z-]+\/\w+)/.exec(href);
      return match ? match[1] : '';
    };
    const album = path(hrefOf(linkOf(bar && byTestId('context-item-info-title', bar))));
    const artists = [];
    if (bar) {
      const links = bar.querySelectorAll('[data-testid="context-item-info-artist"], a[href*="/artist/"]');
      for (const el of links) {
        const link = linkOf(el) || el;
        const artist = { name: (link.textContent || '').trim(), path: path(hrefOf(link)) };
        if (artist.name && artist.path.startsWith('/artist/') && !artists.some((a) => a.path === artist.path)) {
          artists.push(artist);
        }
      }
    }
    const context = path(hrefOf(bar && byTestId('context-link', bar)));
    return {
      albumPath: album.startsWith('/album/') ? album : '',
      artists,
      contextPath: /^\/(?:playlist|album|artist|show|collection)\//.test(context) ? context : '',
    };
  }

  function readState() {
    const now = Date.now();
    const meta = media.metadata;
    const bar = nowPlayingBar();
    const control = (id) => (bar ? byTestId(id, bar) : null);
    const shuffle = control('control-button-shuffle');
    const repeat = control('control-button-repeat');
    const like = control('add-button');
    const avatar = document.querySelector('[data-testid="user-widget-link"] img');

    const elapsed = readElapsed(bar, now);
    const playing = playingNow(now);
    updateClock(meta, elapsed, playing, now);
    const links = trackLinks(bar);

    return {
      appReady: !!document.getElementById('main-view'),
      loggedIn: byTestId('login-button') ? false : byTestId('user-widget-link') ? true : null,
      avatar: avatar ? avatar.src : '',
      path: location.pathname,
      webUi,
      hasTrack: !!(meta && meta.title),
      title: meta ? meta.title || '' : '',
      artist: meta ? meta.artist || '' : '',
      album: meta ? meta.album || '' : '',
      artwork: meta ? largestArtwork(meta.artwork) : '',
      trackUri: trackUri(bar),
      albumPath: links.albumPath,
      artists: links.artists,
      contextPath: links.contextPath,
      isAd: adShown(bar),
      adBlock,
      playing,
      positionMs: clock.positionMs,
      positionAt: clock.positionAt,
      durationMs: readDuration(bar),
      shuffle: checkedState(shuffle),
      repeat: checkedState(repeat),
      liked: like ? checkedState(like) === 1 : null,
      canShuffle: isEnabled(shuffle),
      canRepeat: isEnabled(repeat),
      canLike: isEnabled(like),
      canNext: isEnabled(control('control-button-skip-forward')),
      canPrevious: isEnabled(control('control-button-skip-back')),
      canSeek: typeof handlers.seekto === 'function',
      panel: document.documentElement.classList.contains('sw-panel'),
      library: document.documentElement.classList.contains('sw-library'),
    };
  }

  // ------------------------------------------------------------- bridge out
  let lastSent = '';
  let scheduled = false;

  const post = (message) =>
    window.dispatchEvent(new CustomEvent('spotiweb:out', { detail: JSON.stringify(message) }));

  // Copies (links to share…) go to the phone's clipboard through the app: the
  // page's own attempt needs a user gesture, which commands from the app lack.
  try {
    const writeText = Clipboard.prototype.writeText;
    Clipboard.prototype.writeText = function (data) {
      post({ type: 'clipboard', text: String(data) });
      return writeText.call(this, data).catch(() => {});
    };
  } catch (_) {}
  const execCommand = Document.prototype.execCommand;
  Document.prototype.execCommand = function (name, ...args) {
    if (String(name).toLowerCase() === 'copy') {
      const field = document.activeElement;
      const data =
        field && typeof field.value === 'string' && field.selectionEnd > field.selectionStart
          ? field.value.slice(field.selectionStart, field.selectionEnd)
          : String(document.getSelection() || '');
      if (data) post({ type: 'clipboard', text: data });
    }
    return execCommand.call(this, name, ...args);
  };

  // Changes in the player bar (elapsed time, buttons) are read as they happen.
  const barObserver = new MutationObserver(scheduleState);
  let observedBar = null;
  function observeBar(bar) {
    if (bar === observedBar) return;
    barObserver.disconnect();
    observedBar = bar;
    if (bar) {
      barObserver.observe(bar, {
        subtree: true,
        childList: true,
        characterData: true,
        attributeFilter: ['aria-label', 'aria-checked', 'aria-disabled', 'disabled', 'data-testadtype'],
      });
    }
  }

  function pushState() {
    syncRouteClasses();
    const bar = nowPlayingBar();
    observeBar(bar);
    syncAds(bar);
    const state = readState();
    const json = JSON.stringify(state);
    if (json === lastSent) return;
    lastSent = json;
    post({ type: 'state', state });
  }

  function scheduleState() {
    if (scheduled) return;
    scheduled = true;
    Promise.resolve().then(() => {
      scheduled = false;
      pushState();
    });
  }

  setInterval(() => {
    if (document.visibilityState === 'visible') pushState();
  }, 1000);

  for (const name of ['pushState', 'replaceState']) {
    const original = history[name];
    history[name] = function (...args) {
      const result = original.apply(this, args);
      scheduleState();
      return result;
    };
  }
  window.addEventListener('popstate', scheduleState);

  // Classes on <html> drive the mobile stylesheet.
  let lastPath = location.pathname;
  // The app reads a panel (queue, lyrics) as it changes: it stays open.
  let panelHeld = false;
  function syncRouteClasses() {
    const root = document.documentElement;
    if (location.pathname !== lastPath) {
      lastPath = location.pathname;
      // Opening something from the library or a panel brings that page to the front.
      root.classList.remove('sw-library');
      if (root.classList.contains('sw-panel') && !panelHeld) closePanel();
    }
    // Logged-out visitors get a locale prefix (/intl-fr/search).
    root.classList.toggle('sw-search', /^\/(?:intl-[\w-]+\/)?search(?:\/|$)/.test(location.pathname));
    // The desktop player opens the "Now playing" side panel by itself when playback
    // starts; the native full screen player replaces it, so close it unless asked.
    if (!root.classList.contains('sw-panel') && byTestId('NPV_Panel_OpenDiv')) {
      const close = document.querySelector('[data-testid="PanelHeader_CloseButton"] button');
      if (close) close.click();
    }
  }

  // ----------------------------------------------------------------- commands
  const click = (el) => {
    if (!el || el.disabled) return false;
    el.click();
    return true;
  };
  const runAction = (action, details) => {
    const handler = handlers[action];
    if (typeof handler !== 'function') return false;
    try {
      handler(Object.assign({ action }, details));
      return true;
    } catch (_) {
      return false;
    }
  };

  // SPA navigation through the page's own router (falls back to a reload).
  function navigate(path) {
    try {
      const idx = ((history.state && history.state.idx) || 0) + 1;
      history.pushState({ usr: null, key: Math.random().toString(36).slice(2, 10), idx }, '', path);
      window.dispatchEvent(new PopStateEvent('popstate', { state: history.state }));
    } catch (_) {
      location.assign(path);
    }
    return true;
  }

  function setOverlay(name, on) {
    const root = document.documentElement;
    if (on) {
      root.classList.remove('sw-library', 'sw-panel');
      root.classList.add(`sw-${name}`);
    } else {
      root.classList.remove(`sw-${name}`);
    }
  }

  function openPanel(buttonId) {
    const button = barControl(buttonId);
    if (!button) return false;
    setOverlay('panel', true);
    // These buttons toggle: only click when the panel is not already showing.
    if (button.getAttribute('aria-pressed') !== 'true' && button.getAttribute('data-active') !== 'true') {
      button.click();
    }
    return true;
  }

  function closePanel() {
    setOverlay('panel', false);
    const close = document.querySelector('[data-testid="PanelHeader_CloseButton"] button');
    if (close) return click(close);
    for (const id of ['control-button-queue', 'lyrics-button']) {
      const button = barControl(id);
      if (button && button.getAttribute('aria-pressed') === 'true') return click(button);
    }
    return true;
  }

  function focusSearch() {
    const input = byTestId('search-input');
    if (!input) return false;
    input.focus();
    return true;
  }

  // Resolves once check() holds, or after timeout ms anyway.
  const until = (check, timeout) =>
    new Promise((resolve) => {
      const end = Date.now() + timeout;
      const poll = () => (check() || Date.now() >= end ? resolve() : setTimeout(poll, 50));
      poll();
    });

  const isPlaying = () => playingNow(Date.now());
  const commands = {
    toggle: () => click(barControl('control-button-playpause')) || runAction(isPlaying() ? 'pause' : 'play'),
    play: () => runAction('play') || (!isPlaying() && click(barControl('control-button-playpause'))),
    pause: () => runAction('pause') || (isPlaying() && click(barControl('control-button-playpause'))),
    next: () => click(barControl('control-button-skip-forward')) || runAction('nexttrack'),
    previous: () => click(barControl('control-button-skip-back')) || runAction('previoustrack'),
    // A swipe back always goes to the previous track, while the button only
    // restarts the current one once it has played a few seconds: go back to
    // the top first, wait for the bar to show it, then ask for the previous one.
    previousTrack: () => {
      const played = clock.positionMs === null ? 0 : clockAt(Date.now());
      if (played < 1500 || !commands.seek(0)) return commands.previous();
      until(() => {
        const seconds = parseTime(elapsedLabel(nowPlayingBar()));
        return seconds !== null && seconds < 2;
      }, 1000).then(commands.previous);
      return true;
    },
    seek: (ms) => {
      const target = Math.max(0, ms);
      if (!runAction('seekto', { seekTime: target / 1000, fastSeek: false })) return false;
      // Known to the millisecond, unlike the elapsed time the bar will show.
      setClock(target, Date.now());
      return true;
    },
    adBlock: (on) => {
      adBlock = on !== false;
      try {
        localStorage.setItem('spotiweb:adblock', adBlock ? 'on' : 'off');
      } catch (_) {}
      syncAds(nowPlayingBar());
      return true;
    },
    webUi: (on) => {
      webUi = on === true;
      try {
        localStorage.setItem('spotiweb:ui', webUi ? 'web' : 'native');
      } catch (_) {}
      return true;
    },
    shuffle: () => click(barControl('control-button-shuffle')),
    repeat: () => click(barControl('control-button-repeat')),
    like: () => click(barControl('add-button')),
    queue: () => openPanel('control-button-queue'),
    lyrics: () => openPanel('lyrics-button'),
    closePanel,
    library: (on) => {
      setOverlay('library', on !== false);
      return true;
    },
    home: () => {
      setOverlay('library', false);
      return click(byTestId('home-button')) || navigate('/');
    },
    search: () => {
      setOverlay('library', false);
      if (!document.documentElement.classList.contains('sw-search')) {
        click(byTestId('browse-button')) || navigate('/search');
      }
      setTimeout(focusSearch, 250);
      return true;
    },
    openArtist: () => {
      const link = barControl('context-item-info-artist');
      return click(link && (link.closest('a') || link.querySelector('a') || link));
    },
    openTrack: () => {
      const title = barControl('context-item-info-title');
      return click(title && (title.closest('a') || title.querySelector('a') || title));
    },
    navigate,
    login: () => click(byTestId('login-button')),
    // The app (re)connected: send a full report even if nothing changed.
    sync: () => {
      lastSent = '';
      return true;
    },
  };

  window.__spotiweb = {
    cmd(name, arg) {
      const command = commands[name];
      let result;
      try {
        result = command ? command(arg) : Promise.reject(new Error(`unknown command ${name}`));
      } catch (error) {
        result = Promise.reject(error);
      }
      // A request: its result goes back to the app once known.
      const id = arg && typeof arg === 'object' ? arg.__id : undefined;
      if (id !== undefined) {
        Promise.resolve(result).then(
          (value) => post({ type: 'reply', id, result: value === undefined ? null : value }),
          (error) => post({ type: 'reply', id, error: String((error && error.message) || error) }),
        );
      } else if (result instanceof Promise) {
        result.catch(() => {});
      }
      // Let the page react, then report the new state right away.
      setTimeout(pushState, 150);
      setTimeout(pushState, 700);
      return !!command && !!result;
    },
    state: readState,
    // For reader.js.
    internals: {
      commands,
      post,
      byTestId,
      navigate,
      nowPlayingBar,
      barControl,
      setOverlay,
      openPanel,
      closePanel,
      isPlaying,
      trackUri,
      until,
      scheduleState,
      holdPanel: (on) => {
        panelHeld = !!on;
      },
    },
  };
  window.addEventListener('spotiweb:in', (event) => {
    if (typeof event.detail !== 'string') return;
    const { name, arg } = JSON.parse(event.detail);
    window.__spotiweb.cmd(name, arg);
  });

  // ------------------------------------------------------------ touch tweaks
  // The desktop player selects a track on click and plays it on double click.
  // On a phone a single tap should play it; buttons inside the row (like, more)
  // keep working, and links (title, artist) play instead of navigating.
  document.addEventListener(
    'click',
    (event) => {
      if (!event.isTrusted || !(event.target instanceof Element)) return;
      const row = event.target.closest('[data-testid="tracklist-row"]');
      if (!row || event.target.closest('button, input, label, [role="switch"], [role="checkbox"]')) return;
      event.preventDefault();
      event.stopPropagation();
      row.dispatchEvent(new MouseEvent('dblclick', { bubbles: true, cancelable: true, view: window, detail: 2 }));
    },
    true,
  );
})();
