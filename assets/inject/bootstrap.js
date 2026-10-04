// Runs at document start in the page's own world on https://open.spotify.com,
// before any page script (content script of the app's built-in extension, see
// manifest.json; mobile.css is injected alongside).
//
// 1. Takes over the MediaSession API, so metadata, playback state and actions
//    reach the native player, notification and lock screen instead.
// 2. Answers commands from the native UI (window.__spotiweb.cmd(name, arg)).
// 3. Adapts touch interactions (a tap on a track plays it, like the mobile app).
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

  // -------------------------------------------------------------------- state
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

  function readState() {
    const meta = media.metadata;
    const bar = nowPlayingBar();
    const control = (id) => (bar ? byTestId(id, bar) : null);
    const shuffle = control('control-button-shuffle');
    const repeat = control('control-button-repeat');
    const like = control('add-button');
    const avatar = document.querySelector('[data-testid="user-widget-link"] img');

    let positionMs = null;
    let positionAt = null;
    let durationMs = null;
    if (media.position) {
      positionMs = Math.round(media.position.position * 1000);
      durationMs = Math.round(media.position.duration * 1000);
      positionAt = media.position.at;
    } else {
      const range = bar && bar.querySelector('[data-testid="playback-progressbar"] input[type="range"]');
      if (range && +range.max > 0) {
        positionMs = +range.value;
        durationMs = +range.max;
        positionAt = Date.now();
      }
    }

    return {
      appReady: !!document.getElementById('main-view'),
      loggedIn: byTestId('login-button') ? false : byTestId('user-widget-link') ? true : null,
      avatar: avatar ? avatar.src : '',
      path: location.pathname,
      hasTrack: !!(meta && meta.title),
      title: meta ? meta.title || '' : '',
      artist: meta ? meta.artist || '' : '',
      album: meta ? meta.album || '' : '',
      artwork: meta ? largestArtwork(meta.artwork) : '',
      isAd: !!bar && bar.getAttribute('data-testadtype') === 'ad-type-ad',
      playing: media.playbackState === 'playing',
      positionMs,
      positionAt,
      durationMs,
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

  function pushState() {
    syncRouteClasses();
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
  function syncRouteClasses() {
    const root = document.documentElement;
    if (location.pathname !== lastPath) {
      lastPath = location.pathname;
      // Opening something from the library or a panel brings that page to the front.
      root.classList.remove('sw-library');
      if (root.classList.contains('sw-panel')) closePanel();
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

  const isPlaying = () => media.playbackState === 'playing';
  const commands = {
    toggle: () => click(barControl('control-button-playpause')) || runAction(isPlaying() ? 'pause' : 'play'),
    play: () => runAction('play') || (!isPlaying() && click(barControl('control-button-playpause'))),
    pause: () => runAction('pause') || (isPlaying() && click(barControl('control-button-playpause'))),
    next: () => click(barControl('control-button-skip-forward')) || runAction('nexttrack'),
    previous: () => click(barControl('control-button-skip-back')) || runAction('previoustrack'),
    seek: (ms) => runAction('seekto', { seekTime: Math.max(0, ms) / 1000, fastSeek: false }),
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
      const done = command ? !!command(arg) : false;
      // Let the page react, then report the new state right away.
      setTimeout(pushState, 150);
      setTimeout(pushState, 700);
      return done;
    },
    state: readState,
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
