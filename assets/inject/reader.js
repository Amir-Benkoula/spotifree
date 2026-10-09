// Reads the web player's pages for the app's own screens, and acts on them for
// it: the page is the only source. A request takes the page (kept running out
// of sight) where the app's screen is, waits for it to show, then reads what it
// shows or clicks what the user would have clicked: play buttons, tracks,
// context menus. Runs after bootstrap.js, in the page's world (manifest.json),
// and adds its commands to window.__spotiweb: requests are answered with a
// { type: 'reply', id, result } message, subscriptions (queue, lyrics) push
// { type: 'live', topic, data } messages as the page changes.
//
// Spotify's class names change with every build: only ids, data-testid, ARIA
// roles and attributes, links and the page's structure are relied on, loosely.
(() => {
  'use strict';
  const api = window.__spotiweb;
  if (!api || !api.internals || api.reader) return;
  api.reader = true;
  const { commands, post, byTestId, navigate, nowPlayingBar, barControl, setOverlay, openPanel, closePanel } =
    api.internals;
  const { holdPanel } = api.internals;
  const { isPlaying, trackUri } = api.internals;
  // <html>: there is none yet when this runs, at the start of the document.
  const root = () => document.documentElement;

  const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
  const clean = (value) =>
    String(value || '')
      .replace(/\s+/g, ' ')
      .trim();
  const textOf = (el) => (el ? clean(el.textContent) : '');
  // Rendered text, a line per block: what the user would read.
  const linesOf = (el) =>
    String((el && el.innerText) || '')
      .split('\n')
      .map(clean)
      .filter(Boolean);
  // Laid out: not hidden away with display: none.
  const laidOut = (el) => !!el && el.getClientRects().length > 0;
  const precedes = (a, b) => !!(a.compareDocumentPosition(b) & Node.DOCUMENT_POSITION_FOLLOWING);
  const byPosition = (a, b) => (a === b ? 0 : precedes(a, b) ? -1 : 1);

  // -------------------------------------------------------------------- jobs
  // Requests that use the page (navigate it, scroll it, open its menus) run
  // one at a time, in order. The app cancels those it no longer needs.
  const JOB_TIMEOUT_MS = 20000;
  const jobs = new Map(); // Request id -> job.
  let line = Promise.resolve();

  function exclusive(arg, task, timeoutMs = JOB_TIMEOUT_MS) {
    const job = { id: arg && arg.__id, cancelled: false };
    if (job.id !== undefined) jobs.set(job.id, job);
    const run = line.then(() => {
      if (job.cancelled) throw new Error('cancelled');
      let timer = 0;
      const timeout = new Promise((_, reject) => {
        timer = setTimeout(() => {
          job.cancelled = true;
          reject(new Error('timeout'));
        }, timeoutMs);
      });
      return Promise.race([task(job), timeout]).finally(() => clearTimeout(timer));
    });
    line = run.catch(() => {});
    return run.finally(() => jobs.delete(job.id));
  }

  const check = (job) => {
    if (job && job.cancelled) throw new Error('cancelled');
  };

  // Resolves with check()'s first truthy value, or null after timeout ms.
  function waitFor(test, timeout, job) {
    return new Promise((resolve, reject) => {
      const end = Date.now() + timeout;
      const poll = () => {
        if (job && job.cancelled) return reject(new Error('cancelled'));
        let value = null;
        try {
          value = test();
        } catch (_) {}
        if (value) resolve(value);
        else if (Date.now() >= end) resolve(null);
        else setTimeout(poll, 50);
      };
      poll();
    });
  }

  // Resolves once el has gone ms without changing (after max ms anyway).
  function settled(el, ms, max) {
    return new Promise((resolve) => {
      let timer = 0;
      let cap = 0;
      const observer = new MutationObserver(() => {
        clearTimeout(timer);
        timer = setTimeout(done, ms);
      });
      function done() {
        observer.disconnect();
        clearTimeout(timer);
        clearTimeout(cap);
        resolve();
      }
      observer.observe(el, {
        subtree: true,
        childList: true,
        characterData: true,
        attributeFilter: ['src', 'href', 'aria-rowcount', 'aria-rowindex'],
      });
      timer = setTimeout(done, ms);
      cap = setTimeout(done, max);
    });
  }

  // ------------------------------------------------------------------- paths
  // App paths: Spotify's own, without the query or the locale prefix that
  // logged-out visitors get (/intl-fr/album/…), and decoded (search queries).
  const ENTITY =
    /^\/(?:intl-[\w-]+\/)?((?:playlist|album|artist|show|episode|track|genre|section|user|collection|audiobook|chapter|concert)(?:\/[^?#]*)?)$/;

  // The path a link leads to, if it is a Spotify page; null otherwise.
  function entityPath(href) {
    if (!href) return null;
    let url;
    try {
      url = new URL(href, location.href);
    } catch (_) {
      return null;
    }
    if (url.origin !== location.origin) return null;
    const match = ENTITY.exec(url.pathname.replace(/\/+$/, ''));
    return match ? `/${match[1]}` : null;
  }
  const kindOf = (path) => String(path || '').split('/')[1] || '';
  const uriOf = (path) => {
    const match = /^\/(track|episode|album|playlist|artist|show|audiobook|chapter)\/(\w+)$/.exec(path || '');
    return match ? `spotify:${match[1]}:${match[2]}` : '';
  };
  function uriPath(uri) {
    const parts = String(uri || '').split(':');
    if (parts[0] !== 'spotify' || parts.includes('folder')) return '';
    if (parts.includes('collection')) {
      return parts[parts.length - 1] === 'your-episodes' ? '/collection/your-episodes' : '/collection/tracks';
    }
    return parts.length === 3 ? `/${parts[1]}/${parts[2]}` : '';
  }
  const decoded = (path) => {
    try {
      return decodeURIComponent(path);
    } catch (_) {
      return path;
    }
  };
  const normalize = (path) =>
    decoded(
      String(path || '/')
        .split(/[?#]/)[0]
        .replace(/^\/intl-[\w-]+(?=\/|$)/, '')
        .replace(/\/+$/, ''),
    ) || '/';
  const encodePath = (path) => path.split('/').map(encodeURIComponent).join('/') || '/';
  const here = () => normalize(location.pathname);

  // ------------------------------------------------------------------ images
  // From a srcset, the smallest at least width pixels wide (else the largest).
  function srcOf(img, width) {
    let best = '';
    let bestWidth = 0;
    for (const part of (img.getAttribute('srcset') || '').split(',')) {
      const [url, size] = part.trim().split(/\s+/);
      const w = parseInt(size, 10) || 0;
      if (!url) continue;
      if (!best || (bestWidth < width ? w > bestWidth : w >= width && w < bestWidth)) {
        best = url;
        bestWidth = w;
      }
    }
    const src = best || img.currentSrc || img.getAttribute('src') || '';
    return /^https?:/.test(src) ? src : '';
  }

  const BACKGROUND = /url\(["']?(https?:[^"')]+)/;
  const backgroundOf = (el) => {
    const match = el && el.style ? BACKGROUND.exec(el.style.backgroundImage || '') : null;
    return match ? match[1] : '';
  };

  function imageIn(el, width) {
    if (!el) return '';
    for (const img of el.tagName === 'IMG' ? [el] : el.querySelectorAll('img')) {
      const src = srcOf(img, width);
      if (src) return src;
    }
    for (const node of [el, ...el.querySelectorAll('[style*="background"]')]) {
      const src = backgroundOf(node);
      if (src) return src;
    }
    return '';
  }

  // The largest image shown in el (a page's cover rather than a small badge).
  function largestImage(el, width) {
    let best = '';
    let bestArea = 0;
    for (const img of el.querySelectorAll('img')) {
      const box = img.getBoundingClientRect();
      const src = srcOf(img, width);
      if (src && box.width * box.height > bestArea) {
        best = src;
        bestArea = box.width * box.height;
      }
    }
    return best;
  }

  // ------------------------------------------------------------------- parts
  const mainView = () => document.getElementById('main-view') || document.querySelector('main') || document.body;
  const sidebar = () => document.getElementById('Desktop_LeftSidebar_Id');
  const panel = () => document.getElementById('Desktop_PanelContainer_Id');

  const ROW = '[data-testid="tracklist-row"]';
  const GRID = '[role="grid"], [role="treegrid"], [aria-rowcount]';
  const TITLE_IDS = '[id^="card-title-spotify:"], [id^="listrow-title-spotify:"]';
  const ITEM_ROOTS = '[role="row"], [role="listitem"], [role="treeitem"], [role="group"], [data-encore-id="card"], li';
  const HEADINGS = 'h1, h2, h3, h4, [role="heading"]';
  const TIME = /^(?:\d+:)?\d+:\d\d$/;
  // Play buttons' labels, in a few languages: the page's play button may have no test id.
  const PLAY_LABEL =
    /^(?:play|pause|lire|lecture|écouter|reproducir|pausar|pausa|wiedergabe|abspielen|riproduci|tocar|afspelen|spela)\b/i;
  // Parts of the page that are not part of what they hold (menus over a page…).
  const AWAY =
    '[role="dialog"], [role="alertdialog"], [role="menu"], [data-testid="now-playing-bar"], #Desktop_LeftSidebar_Id, #Desktop_PanelContainer_Id, [data-testid="topbar-content-wrapper"], [data-testid="user-widget-link"]';

  // el sits in a part of scope that is not scope's own content.
  const away = (el, scope) => {
    const part = el.closest(AWAY);
    return !!part && part !== scope && scope.contains(part);
  };

  // ------------------------------------------------------------------- items
  // What a list shows, one item per track row, card or library row: elements
  // with their kind ('track': a row of a track list, 'entity': anything that
  // leads to a page), in the order of the page.
  function collectItems(scope, skip, loose) {
    const items = [];
    const taken = new WeakSet();
    const inItem = (el) => {
      for (let node = el; node && node !== scope; node = node.parentElement) if (taken.has(node)) return true;
      return false;
    };
    const add = (el, type, title) => {
      if (!el || !laidOut(el) || inItem(el) || away(el, scope) || (skip && skip.contains(el))) return;
      taken.add(el);
      items.push({ el, type, title });
    };

    for (const row of scope.querySelectorAll(ROW)) add(row, 'track');
    for (const title of scope.querySelectorAll(TITLE_IDS)) {
      const holder = title.closest(ITEM_ROOTS);
      const own = holder && scope.contains(holder) && holder.querySelectorAll(TITLE_IDS).length === 1;
      add(own ? holder : climb(title, scope, uriPath(title.id.replace(/^\w+-title-/, ''))), 'entity', title);
    }
    for (const link of scope.querySelectorAll('a[href]')) {
      const path = entityPath(link.getAttribute('href'));
      if (!path || inItem(link)) continue;
      const holder = climb(link, scope, path);
      // A section's title or its "show all" link: not an item.
      if (!holder.querySelector('img') && nearHeading(link)) continue;
      add(holder, 'entity');
    }
    if (loose) {
      // Rows without a link (some lists only have buttons): rows with a picture.
      for (const row of scope.querySelectorAll('[role="row"], [role="listitem"], li')) {
        if (row.querySelector('[role="row"], [role="listitem"], li') || !row.querySelector('img')) continue;
        add(row, 'entity');
      }
    }
    return items.sort((a, b) => byPosition(a.el, b.el));
  }

  // The element holding a link and what goes with it (picture, subtitle):
  // its largest ancestor that holds no other item.
  function climb(start, scope, path) {
    const kind = kindOf(path);
    let el = start;
    for (let depth = 0; depth < 8; depth++) {
      const parent = el.parentElement;
      if (!parent || parent === scope || parent.contains(scope)) break;
      if (parent.querySelectorAll('img').length > 1 || parent.querySelector(`h1, h2, ${ROW}`)) break;
      if (parent.querySelectorAll(TITLE_IDS).length > 1 || otherOfKind(parent, path, kind)) break;
      el = parent;
    }
    return el;
  }

  function otherOfKind(el, path, kind) {
    for (const link of el.querySelectorAll('a[href]')) {
      const other = entityPath(link.getAttribute('href'));
      if (other && other !== path && kindOf(other) === kind) return true;
    }
    return false;
  }

  function nearHeading(link) {
    if (link.closest(HEADINGS)) return true;
    for (let node = link.parentElement, depth = 0; node && depth < 2; node = node.parentElement, depth++) {
      if (node.querySelector(HEADINGS)) return true;
    }
    return false;
  }

  function linksIn(el, kinds) {
    const found = [];
    for (const link of el.querySelectorAll('a[href]')) {
      const path = entityPath(link.getAttribute('href'));
      const name = textOf(link);
      if (!path || !name || !kinds.includes(kindOf(path)) || found.some((l) => l.path === path)) continue;
      found.push({ name, path });
    }
    return found;
  }

  const rowIndex = (row) => {
    const holder = row.closest('[aria-rowindex]');
    return holder ? parseInt(holder.getAttribute('aria-rowindex'), 10) || null : null;
  };
  const rowLink = (row) =>
    row.querySelector('[data-testid="internal-track-link"], a[href*="/track/"], a[href*="/episode/"]');
  const rowUri = (row) => {
    const link = rowLink(row);
    return link ? uriOf(entityPath(link.getAttribute('href'))) : '';
  };

  function readRow(row) {
    const holder = row.closest('[aria-rowindex]') || row;
    const link = rowLink(row);
    const path = (link && entityPath(link.getAttribute('href'))) || '';
    const title = textOf(link) || linesOf(row.querySelector('[aria-colindex="2"]') || row)[0] || '';
    const album = row.querySelector('a[href*="/album/"]');
    const times = [];
    for (const el of row.querySelectorAll('div, span')) {
      if (!el.children.length && TIME.test(textOf(el))) times.push(textOf(el));
    }
    const save = row.querySelector('[data-testid="add-button"], button[aria-checked]');
    return {
      uri: uriOf(path),
      path,
      title,
      artists: linksIn(row, ['artist']),
      album: album ? { name: textOf(album), path: entityPath(album.getAttribute('href')) || '' } : null,
      duration: times.length ? times[times.length - 1] : '',
      image: imageIn(row, 64),
      index: rowIndex(row),
      disabled: holder.getAttribute('aria-disabled') === 'true' || row.getAttribute('aria-disabled') === 'true',
      saved: save ? save.getAttribute('aria-checked') === 'true' : null,
    };
  }

  function readEntity(el, titleEl) {
    titleEl = titleEl || el.querySelector(TITLE_IDS);
    const ownUri = titleEl ? titleEl.id.replace(/^\w+-title-/, '') : '';
    const links = [...(el.matches('a[href]') ? [el] : []), ...el.querySelectorAll('a[href]')]
      .map((link) => ({ link, path: entityPath(link.getAttribute('href')) }))
      .filter((l) => l.path);
    let path = uriPath(ownUri);
    if (!path && links.length) {
      // Cards link to their page twice (picture and title): the most linked.
      const counts = new Map();
      for (const l of links) counts.set(l.path, (counts.get(l.path) || 0) + 1);
      path = links.reduce((a, b) => (counts.get(b.path) > counts.get(a.path) ? b : a)).path;
    }
    let title = textOf(titleEl);
    for (const l of links) {
      const name = textOf(l.link) || clean(l.link.getAttribute('title'));
      if (!title && l.path === path && name) title = name;
    }
    // What it reads, without its buttons' words.
    const buttons = new Set([...el.querySelectorAll('button')].map(textOf).filter(Boolean));
    const lines = linesOf(el).filter((l) => !buttons.has(l));
    if (!title) title = lines[0] || clean(el.getAttribute('aria-label'));
    const subtitleEl = el.querySelector('[id^="card-subtitle-"], [id^="listrow-subtitle-"]');
    const subtitle = subtitleEl
      ? textOf(subtitleEl)
      : lines
          .filter((l) => l !== title)
          .slice(0, 2)
          .join(' • ');
    const kind = kindOf(path) || (ownUri.includes(':folder:') ? 'folder' : ownUri.split(':')[1] || '');
    return {
      path: path || '',
      uri: ownUri || uriOf(path),
      kind,
      title,
      subtitle: subtitle.slice(0, 200),
      image: imageIn(el, 300),
      links: linksIn(el, ['artist', 'user', 'show', 'album']).filter((l) => l.path !== path),
    };
  }

  const itemData = (item) => (item.type === 'track' ? readRow(item.el) : readEntity(item.el, item.title));

  // An entity read as a track (queue rows that are not track list rows).
  function asTrack(item, position) {
    if (item.type === 'track') return readRow(item.el);
    const entity = readEntity(item.el, item.title);
    return {
      uri: kindOf(entity.path) === 'track' || kindOf(entity.path) === 'episode' ? entity.uri : '',
      path: entity.path,
      title: entity.title,
      artists: entity.links.filter((l) => kindOf(l.path) === 'artist'),
      album: null,
      duration: '',
      image: entity.image,
      index: position,
      disabled: false,
      saved: null,
      subtitle: entity.subtitle,
    };
  }

  // -------------------------------------------------------------- headings
  // The heading of what el is part of: the last one before it in the smallest
  // part of the page that has one (not one inside an item).
  function headingFor(el, scope, inItem) {
    for (let node = el.parentElement; node; node = node.parentElement) {
      let found = null;
      for (const heading of node.querySelectorAll(HEADINGS)) {
        if (heading.tagName === 'H1' || el.contains(heading) || inItem(heading) || !precedes(heading, el)) continue;
        if (laidOut(heading) && textOf(heading)) found = heading;
      }
      if (found || node === scope) return found;
    }
    return null;
  }

  // A heading's link (its title's, or a "show all" next to it): a page, or
  // more results of a search.
  function headingLink(heading, inItem) {
    const places = [heading, heading.parentElement, heading.parentElement && heading.parentElement.parentElement];
    for (const place of places) {
      if (!place || place.querySelector(ROW)) continue;
      for (const link of place.querySelectorAll('a[href]')) {
        const href = link.getAttribute('href');
        const path = entityPath(href) || (/^\/(?:intl-[\w-]+\/)?search\/./.test(href) ? normalize(href) : null);
        if (path && !inItem(link)) return path;
      }
    }
    return '';
  }

  // Items grouped as the page shows them: a section per heading, a list per grid.
  function groupItems(items, scope) {
    const inItemSet = new WeakSet(items.map((item) => item.el));
    const inItem = (el) => {
      for (let node = el; node && node !== scope; node = node.parentElement) if (inItemSet.has(node)) return true;
      return false;
    };
    const groups = [];
    const byKey = new Map();
    const unnamed = new Map(); // Holder element -> key of its group.
    for (const item of items) {
      const holder = item.type === 'track' ? item.el.closest(GRID) || item.el.parentElement : item.el;
      const heading = headingFor(holder, scope, inItem);
      let key;
      if (heading) {
        key = `${item.type}|${textOf(heading)}`;
      } else {
        const parent = item.type === 'track' ? holder : item.el.parentElement;
        if (!unnamed.has(parent)) unnamed.set(parent, `${item.type}|#${unnamed.size}`);
        key = unnamed.get(parent);
      }
      let group = byKey.get(key);
      if (!group) {
        const grid = item.type === 'track' ? item.el.closest(GRID) : null;
        const count = grid ? parseInt(grid.getAttribute('aria-rowcount'), 10) : NaN;
        group = {
          key,
          type: item.type,
          title: heading ? textOf(heading) : '',
          path: heading ? headingLink(heading, inItem) : '',
          // Track lists count their header row.
          total: count > 0 ? count - 1 : null,
          items: [],
        };
        byKey.set(key, group);
        groups.push(group);
      }
      group.items.push(item);
    }
    return groups;
  }

  // ------------------------------------------------------------------ header
  function readHeader(scope) {
    const h1 = [...scope.querySelectorAll('h1')].find((el) => laidOut(el) && !away(el, scope) && !el.closest(ROW));
    if (!h1) return null;
    // The largest part around the title without any list in it.
    let region = h1;
    for (let depth = 0; depth < 12; depth++) {
      const parent = region.parentElement;
      if (!parent || parent === scope || parent.contains(scope)) break;
      if (parent.querySelector(`${ROW}, ${TITLE_IDS}, h2, [role="grid"], [role="list"], section`)) break;
      region = parent;
    }
    const title = textOf(h1);
    const buttons = new Set([...region.querySelectorAll('button')].map(textOf).filter(Boolean));
    const lines = linesOf(region).filter((l) => !buttons.has(l));
    const at = lines.indexOf(title);
    // An artist's banner is a background around or before the title.
    let image = largestImage(region, 640);
    if (!image) {
      for (const el of scope.querySelectorAll('[style*="background"]')) {
        if ((precedes(el, h1) || el.contains(h1)) && backgroundOf(el)) {
          image = backgroundOf(el);
          break;
        }
      }
    }
    return {
      region,
      title,
      label: at > 0 ? lines[at - 1] : '',
      lines: (at >= 0 ? lines.slice(at + 1) : lines.filter((l) => l !== title)).slice(0, 4),
      image,
      links: linksIn(region, ['artist', 'user', 'album', 'show', 'playlist']).filter((l) => l.path !== here()),
    };
  }

  // The page's own buttons: play, save (like, follow), more options.
  function pageControls(scope, items) {
    const free = (el) => !items.some((item) => item.el.contains(el)) && !away(el, scope);
    let play = [...scope.querySelectorAll('[data-testid="play-button"]')].find(free);
    if (play && play.tagName !== 'BUTTON') play = play.querySelector('button') || play;
    if (!play) {
      play = [...scope.querySelectorAll('button[aria-label]')].find(
        (button) => free(button) && PLAY_LABEL.test(button.getAttribute('aria-label')),
      );
    }
    const bar =
      (play && play.closest('[data-testid="action-bar-row"], [data-testid="action-bar"]')) ||
      scope.querySelector('[data-testid="action-bar-row"], [data-testid="action-bar"]') ||
      (play && play.parentElement && play.parentElement.parentElement);
    const pick = (selector) => (bar ? [...bar.querySelectorAll(selector)].find(free) || null : null);
    return {
      play: play || null,
      save: pick('[data-testid="add-button"], button[aria-checked]'),
      more: pick('[data-testid="more-button"], button[aria-haspopup="menu"], button[aria-haspopup="true"]'),
    };
  }

  // -------------------------------------------------------------- snapshot
  // What the app shows of a page, with what an earlier look saw further down
  // (lists only render what is around their scroll position).
  const memos = new Map(); // Path -> { blocks: Map(key -> block) }

  function memoOf(path) {
    let memo = memos.get(path);
    if (!memo) {
      memo = { blocks: new Map() };
      memos.set(path, memo);
      if (memos.size > 40) memos.delete(memos.keys().next().value);
    }
    return memo;
  }

  function snapshot(path) {
    const scope = mainView();
    const header = readHeader(scope);
    const items = collectItems(scope, header && header.region, false);
    const controls = pageControls(scope, items);
    const memo = memoOf(path);
    for (const group of groupItems(items, scope)) {
      let block = memo.blocks.get(group.key);
      if (!block) {
        block = { key: group.key, type: group.type, entries: new Map() };
        memo.blocks.set(group.key, block);
      }
      Object.assign(block, { title: group.title, path: group.path, total: group.total });
      for (const item of group.items) {
        const data = itemData(item);
        const id =
          item.type === 'track' ? (data.index !== null ? `#${data.index}` : data.uri || data.title) : data.path;
        if (id) block.entries.set(id, data);
      }
    }
    const blocks = [...memo.blocks.values()].map((block) => {
      const entries = [...block.entries.values()];
      if (block.type === 'track') {
        entries.sort((a, b) => (a.index || 0) - (b.index || 0));
        if (block.total !== null) entries.length = Math.min(entries.length, block.total);
      }
      return {
        key: block.key,
        type: block.type,
        title: block.title,
        path: block.path,
        total: block.total,
        items: entries,
      };
    });
    const first = items.length ? items[0].el : scope.querySelector('h1');
    const scroller = scrollerOf(first || scope);
    const listsDone = blocks.every((b) => b.type !== 'track' || b.total === null || b.items.length >= b.total);
    return {
      path,
      kind: path === '/' ? 'home' : kindOf(path),
      title: header ? header.title : '',
      label: header ? header.label : '',
      lines: header ? header.lines : [],
      links: header ? header.links : [],
      image: header ? header.image : '',
      canPlay: !!controls.play,
      hasMenu: !!controls.more,
      saved: controls.save ? controls.save.getAttribute('aria-checked') === 'true' : null,
      blocks,
      complete: listsDone && atBottom(scroller),
    };
  }

  // ------------------------------------------------------------- navigating
  // What the main view shows, to tell when the next page replaced it.
  function signature() {
    const scope = mainView();
    const h1 = scope.querySelector('h1');
    const parts = [textOf(h1)];
    for (const link of scope.querySelectorAll('a[href]')) {
      if (parts.length > 8) break;
      const path = entityPath(link.getAttribute('href'));
      if (path && !away(link, scope)) parts.push(path);
    }
    return { key: parts.join('|'), ready: !!(parts[0] || parts.length > 1 || scope.querySelector(ROW)) };
  }

  // Takes the page to path (through its own router) and waits for it to show.
  async function open(path, job) {
    closeMenus();
    if (here() !== path) {
      const from = here();
      const before = signature().key;
      navigate(path === '/' ? '/' : encodePath(path));
      // Some pages redirect: anywhere new will do.
      const moved = await waitFor(() => here() === path || here() !== from, 3000, job);
      if (!moved) throw new Error(`could not open ${path}`);
      const landed = here();
      // The new page's content, not the previous one still on screen (search
      // results may stay the same).
      const waitMs = kindOf(path) === 'search' ? 3000 : 8000;
      await waitFor(
        () => {
          const now = signature();
          return here() !== landed || (now.ready && now.key !== before);
        },
        waitMs,
        job,
      );
      if (here() !== landed) throw new Error(`left ${path} for ${here()}`);
    } else {
      // Maybe still loading (the app just started).
      await waitFor(() => signature().ready, 10000, job);
    }
    const start = here();
    await settled(mainView(), 250, 2000);
    check(job);
    // Gone elsewhere meanwhile (a link followed in the page itself).
    if (here() !== start) throw new Error(`left ${path} for ${here()}`);
  }

  // ---------------------------------------------------------------- scrolling
  function scrollerOf(el) {
    for (let node = el && el.parentElement; node; node = node.parentElement) {
      if (node.scrollHeight > node.clientHeight + 8) {
        const overflow = getComputedStyle(node).overflowY;
        if (overflow === 'auto' || overflow === 'scroll' || overflow === 'overlay') return node;
      }
    }
    return document.scrollingElement || root();
  }
  const atBottom = (scroller) => scroller.scrollTop + scroller.clientHeight >= scroller.scrollHeight - 8;

  const shownRows = (scope) => [...scope.querySelectorAll(ROW)].filter((row) => laidOut(row) && rowIndex(row));

  // Scrolls a list's rows so that the one at index shows.
  function scrollTowards(scope, index) {
    const rows = shownRows(scope);
    if (!rows.length) return false;
    const first = rowIndex(rows[0]);
    const last = rowIndex(rows[rows.length - 1]);
    const height = rows[0].getBoundingClientRect().height || 56;
    const scroller = scrollerOf(rows[0]);
    if (index < first) scroller.scrollTop -= (first - index + 3) * height;
    else if (index > last) scroller.scrollTop += (index - last + 3) * height;
    else return false;
    return true;
  }

  // A track's row, by its position in the list (and its uri, to be sure).
  function rowFor(scope, uri, index) {
    const rows = [...scope.querySelectorAll(ROW)].filter(laidOut);
    return (
      rows.find((row) => rowIndex(row) === index && (!uri || rowUri(row) === uri)) ||
      (uri ? rows.find((row) => rowUri(row) === uri) : null) ||
      null
    );
  }

  async function findRow(scope, target, job) {
    let row = rowFor(scope, target.uri, target.index);
    for (let attempt = 0; !row && target.index && attempt < 10; attempt++) {
      if (!scrollTowards(scope, target.index)) break;
      await settled(scope, 120, 700);
      check(job);
      row = rowFor(scope, target.uri, target.index);
    }
    return row;
  }

  async function more(path, job) {
    await open(path, job);
    const scope = mainView();
    const count = () => [...memoOf(path).blocks.values()].reduce((n, b) => n + b.entries.size, 0);
    let page = snapshot(path);
    const start = count();
    const scroller = scrollerOf(scope.querySelector(ROW) || scope.querySelector('a[href]') || scope.firstElementChild);
    // Back where an earlier look stopped (the page may have opened again at the top).
    const main = page.blocks.find((b) => b.type === 'track');
    const known = main && main.items.length ? main.items[main.items.length - 1].index : null;
    const rows = shownRows(scope);
    if (known && rows.length && known > rowIndex(rows[rows.length - 1]) + 10) {
      const height = rows[0].getBoundingClientRect().height || 56;
      scroller.scrollTop += (known - rowIndex(rows[0]) - 5) * height;
      await settled(scope, 150, 800);
    }
    for (let step = 0; step < 14 && count() - start < 40; step++) {
      if (atBottom(scroller)) {
        // Endless pages load more once at the bottom.
        await settled(scope, 400, 1500);
        page = snapshot(path);
        break;
      }
      scroller.scrollTop += Math.max(200, scroller.clientHeight * 0.75);
      await settled(scope, 150, 800);
      check(job);
      page = snapshot(path);
    }
    return page;
  }

  // ------------------------------------------------------------------ playing
  const dblclick = (el) =>
    el.dispatchEvent(new MouseEvent('dblclick', { bubbles: true, cancelable: true, view: window, detail: 2 }));
  const playButtonIn = (el) =>
    el.querySelector('[aria-colindex="1"] button') ||
    [...el.querySelectorAll('button[aria-label]')].find((b) => PLAY_LABEL.test(b.getAttribute('aria-label')));

  // Plays a row like a double click does on a computer; its play button if
  // nothing happened.
  async function startRow(row, uri, job) {
    const was = trackUri();
    dblclick(row);
    const started = await waitFor(() => (uri ? trackUri() === uri : trackUri() !== was) && isPlaying(), 4000, job);
    if (started || trackUri() !== was || (uri && uri === was)) return;
    const button = playButtonIn(row);
    if (button) button.click();
  }

  async function playTrack(arg, job) {
    const path = normalize(arg.path);
    await open(path, job);
    const row = await findRow(mainView(), arg, job);
    if (!row) throw new Error('track not found');
    await startRow(row, arg.uri, job);
    return true;
  }

  async function playPage(arg, job) {
    const path = normalize(arg.path);
    await open(path, job);
    const scope = mainView();
    const header = readHeader(scope);
    const { play } = pageControls(scope, collectItems(scope, header && header.region, false));
    if (!play) throw new Error('nothing to play here');
    play.click();
    return true;
  }

  // The page's save button (like, follow): pressed; its new state.
  async function pageSave(arg, job) {
    const path = normalize(arg.path);
    await open(path, job);
    const scope = mainView();
    const controls = () => {
      const header = readHeader(scope);
      return pageControls(scope, collectItems(scope, header && header.region, false));
    };
    const save = controls().save;
    if (!save) throw new Error('nothing to save here');
    const before = save.getAttribute('aria-checked');
    save.click();
    const changed = () => {
      const now = controls().save;
      return now && now.getAttribute('aria-checked') !== before ? now : null;
    };
    const after = (await waitFor(changed, 2000, job)) || controls().save;
    return after ? after.getAttribute('aria-checked') === 'true' : null;
  }

  function findEntity(scope, path) {
    const item = collectItems(scope, null, false).find(
      (i) => i.type === 'entity' && readEntity(i.el, i.title).path === path,
    );
    return item ? item.el : null;
  }

  async function playCard(arg, job) {
    const path = normalize(arg.path);
    await open(path, job);
    const card = findEntity(mainView(), arg.target);
    const button =
      card &&
      (card.querySelector('button[data-testid="play-button"], [data-testid="play-button"] button') ||
        card.querySelector('[data-testid="play-button"]') ||
        playButtonIn(card));
    if (button) {
      button.click();
      return true;
    }
    // From its own page.
    return playPage({ path: arg.target }, job);
  }

  // -------------------------------------------------------------------- menus
  // Context menus open for the app, which shows their items itself and picks
  // one for the user: the menu stays open on the page meanwhile.
  const MENU = '[role="menu"]';
  const MENU_ITEM = '[role="menuitem"], [role="menuitemcheckbox"], [role="menuitemradio"]';
  let menus = []; // The open menu, then its open submenus.
  let menuDone = null; // Undoes what opening the menu needed.

  const openMenus = () => [...document.querySelectorAll(MENU)].filter(laidOut);
  const menuItems = (menu) => [...menu.querySelectorAll(MENU_ITEM)].filter((el) => el.closest(MENU) === menu);
  const hasSubmenu = (el) => {
    const popup = el.getAttribute('aria-haspopup');
    return (!!popup && popup !== 'false') || el.hasAttribute('aria-expanded');
  };

  function describeMenu(menu) {
    const entries = [];
    let separated = false;
    for (const el of menu.querySelectorAll(`${MENU_ITEM}, [role="separator"], hr`)) {
      if (el.closest(MENU) !== menu) continue;
      if (!el.matches(MENU_ITEM)) {
        separated = entries.length > 0;
        continue;
      }
      entries.push({
        label: textOf(el) || clean(el.getAttribute('aria-label')),
        submenu: hasSubmenu(el),
        disabled: el.getAttribute('aria-disabled') === 'true' || el.disabled === true,
        checked: el.hasAttribute('aria-checked') ? el.getAttribute('aria-checked') === 'true' : null,
        separated,
      });
      separated = false;
    }
    return entries;
  }

  const waitMenu = (known, job) =>
    waitFor(() => openMenus().find((menu) => !known.includes(menu) && menuItems(menu).length), 2000, job);

  function rightClick(el) {
    const box = el.getBoundingClientRect();
    el.dispatchEvent(
      new MouseEvent('contextmenu', {
        bubbles: true,
        cancelable: true,
        view: window,
        button: 2,
        buttons: 2,
        clientX: box.left + Math.min(box.width / 2, 40),
        clientY: box.top + box.height / 2,
      }),
    );
  }

  function finishMenus() {
    menus = [];
    const done = menuDone;
    menuDone = null;
    if (done) done();
  }

  function closeMenus() {
    const open = openMenus();
    if (open.length) {
      const escape = { key: 'Escape', code: 'Escape', keyCode: 27, which: 27, bubbles: true, cancelable: true };
      for (const target of [open[open.length - 1], document.activeElement, document]) {
        if (target) target.dispatchEvent(new KeyboardEvent('keydown', escape));
      }
      // Popups also close on a press outside.
      document.body.dispatchEvent(new MouseEvent('mousedown', { bubbles: true, cancelable: true, view: window }));
    }
    finishMenus();
  }

  async function openMenu(arg, job) {
    const target = arg.target || {};
    let el = null;
    let button = null;
    if (target.type === 'nowPlaying') {
      closeMenus();
      const bar = nowPlayingBar();
      const title = bar && byTestId('context-item-info-title', bar);
      el = bar && (byTestId('now-playing-widget', bar) || (title && title.parentElement));
    } else if (target.type === 'queue') {
      closeMenus();
      await showQueue(job);
      el = queueItem(target);
    } else if (target.type === 'library') {
      closeMenus();
      root().classList.add('sw-read-library');
      menuDone = () => root().classList.remove('sw-read-library');
      const side = sidebar();
      const title =
        side &&
        (await waitFor(
          () => [...side.querySelectorAll(TITLE_IDS)].find((t) => t.id === `listrow-title-${target.uri}`),
          3000,
          job,
        ));
      el = title && (title.closest(ITEM_ROOTS) || title.parentElement);
    } else {
      const path = normalize(arg.path);
      await open(path, job);
      const scope = mainView();
      if (target.type === 'track') {
        el = await findRow(scope, target, job);
      } else if (target.type === 'card') {
        el = findEntity(scope, target.path);
      } else {
        const header = readHeader(scope);
        button = pageControls(scope, collectItems(scope, header && header.region, false)).more;
      }
    }
    if (el && !button) {
      button = el.querySelector(
        '[data-testid="more-button"], button[aria-haspopup="menu"], button[aria-haspopup="true"]',
      );
    }
    if (!el && !button) {
      finishMenus();
      throw new Error('nothing to open a menu on');
    }
    const known = openMenus();
    if (button) button.click();
    else rightClick(el);
    let menu = await waitMenu(known, job);
    if (!menu && button && el) {
      rightClick(el);
      menu = await waitMenu(known, job);
    }
    if (!menu) {
      finishMenus();
      throw new Error('no menu');
    }
    menus = [menu];
    return { level: 0, items: describeMenu(menu) };
  }

  // Messages the page shows for a moment ("Added to Liked Songs"…).
  function watchNotices() {
    const seen = { text: '' };
    const LIVE = '[aria-live], [role="status"], [role="alert"]';
    const note = (region) => {
      if (!region || region.closest('#main-view, [data-testid="now-playing-bar"], #Desktop_LeftSidebar_Id')) return;
      const text = textOf(region);
      if (text) seen.text = text;
    };
    // Changes inside a message region, or a region coming in.
    const observer = new MutationObserver((records) => {
      for (const record of records) {
        const node = record.target.nodeType === 1 ? record.target : record.target.parentElement;
        note(node && node.closest(LIVE));
        for (const added of record.addedNodes) {
          if (added.nodeType === 1) note(added.closest(LIVE) || added.querySelector(LIVE));
        }
      }
    });
    observer.observe(document.body, { subtree: true, childList: true, characterData: true });
    seen.stop = () => observer.disconnect();
    return seen;
  }

  async function pickMenu(arg, job) {
    const menu = menus[arg.level || 0];
    if (!menu || !menu.isConnected) {
      finishMenus();
      throw new Error('menu closed');
    }
    const item = menuItems(menu)[arg.index];
    if (!item) throw new Error('no such menu item');
    if (hasSubmenu(item)) {
      const known = openMenus();
      for (const type of ['pointerover', 'pointerenter', 'mouseover', 'mouseenter']) {
        item.dispatchEvent(new MouseEvent(type, { bubbles: type.endsWith('over'), view: window }));
      }
      let submenu = await waitMenu(known, job);
      if (!submenu) {
        item.click();
        submenu = await waitMenu(known, job);
      }
      if (!submenu) {
        item.focus();
        item.dispatchEvent(new KeyboardEvent('keydown', { key: 'ArrowRight', code: 'ArrowRight', bubbles: true }));
        submenu = await waitMenu(known, job);
      }
      if (!submenu) throw new Error('no submenu');
      menus = [...menus.slice(0, (arg.level || 0) + 1), submenu];
      return { level: menus.length - 1, items: describeMenu(submenu) };
    }
    // An action: report what it did.
    const from = location.pathname;
    const dialogs = [...document.querySelectorAll('[role="dialog"], [role="alertdialog"]')];
    const newDialog = () =>
      [...document.querySelectorAll('[role="dialog"], [role="alertdialog"]')].find(
        (d) => !dialogs.includes(d) && laidOut(d),
      );
    const notices = watchNotices();
    item.click();
    await waitFor(() => location.pathname !== from || newDialog() || notices.text, 1500, job);
    await sleep(150);
    notices.stop();
    const result = { done: true };
    if (location.pathname !== from) result.navigated = entityPath(location.pathname) || normalize(location.pathname);
    const dialog = newDialog();
    if (dialog) result.dialog = textOf(dialog.querySelector('h1, h2, h3')) || textOf(dialog).slice(0, 80);
    if (notices.text) result.message = notices.text;
    if (!openMenus().length) finishMenus();
    else closeMenus();
    return result;
  }

  // ------------------------------------------------------------------ library
  async function library(job) {
    const side = sidebar();
    if (!side) throw new Error('no library');
    root().classList.add('sw-read-library');
    try {
      const first = await waitFor(() => side.querySelector('[id^="listrow-title-spotify:"]'), 8000, job);
      if (!first) return { items: [] };
      const found = new Map();
      const collect = () => {
        for (const title of side.querySelectorAll('[id^="listrow-title-spotify:"]')) {
          const item = libraryItem(title);
          found.set(item.uri, item);
        }
      };
      const scroller = scrollerOf(first);
      scroller.scrollTop = 0;
      await settled(side, 120, 600);
      collect();
      for (let step = 0; step < 100 && !atBottom(scroller); step++) {
        scroller.scrollTop += Math.max(100, scroller.clientHeight * 0.8);
        await settled(side, 100, 500);
        check(job);
        collect();
      }
      scroller.scrollTop = 0;
      return { items: [...found.values()] };
    } finally {
      if (!menuDone) root().classList.remove('sw-read-library');
    }
  }

  function libraryItem(title) {
    const uri = title.id.slice('listrow-title-'.length);
    const row = title.closest(ITEM_ROOTS) || title.parentElement;
    const name = textOf(title);
    const subtitle = row.querySelector('[id^="listrow-subtitle-"]');
    const kind = uri.includes(':folder:') ? 'folder' : uri.includes(':collection') ? 'collection' : uri.split(':')[1];
    return {
      uri,
      path: uriPath(uri),
      kind,
      title: name,
      subtitle: subtitle
        ? textOf(subtitle)
        : linesOf(row)
            .filter((l) => l !== name)
            .slice(0, 2)
            .join(' • '),
      image: imageIn(row, 120),
    };
  }

  // -------------------------------------------------------------------- queue
  let queueWatch = null;

  // Whether a toggle button of the player bar (queue, lyrics) is on; null when
  // it doesn't tell. Such a button is never pressed blindly: that could close.
  const toggled = (button) => {
    if (!button) return false;
    if (!button.hasAttribute('aria-pressed') && !button.hasAttribute('data-active')) return null;
    return button.getAttribute('aria-pressed') === 'true' || button.getAttribute('data-active') === 'true';
  };
  const pressed = (button) => toggled(button) === true;

  // The panel shows the queue: its button says so (or, when it doesn't tell,
  // the panel has tracks).
  const queueShown = () => {
    const scope = panel();
    if (!scope || !laidOut(scope)) return false;
    const on = toggled(barControl('control-button-queue'));
    return on === null ? collectItems(scope, null, true).length > 0 : on;
  };

  async function showQueue(job) {
    if (!barControl('control-button-queue')) throw new Error('no queue');
    if (!queueShown()) openPanel('control-button-queue');
    if (!(await waitFor(queueShown, 3000, job))) throw new Error('no queue');
    await waitFor(() => collectItems(panel(), null, true).length, 3000, job);
    await settled(panel(), 200, 1500);
  }

  function readQueue() {
    const scope = panel();
    if (!scope || !queueShown()) return { sections: [], current: trackUri() };
    const items = collectItems(scope, null, true);
    const sections = groupItems(items, scope).map((group) => ({
      title: group.title,
      tracks: group.items.map((item, i) => asTrack(item, i + 1)),
    }));
    return { sections, current: trackUri() };
  }

  function queueItem(target) {
    const scope = panel();
    if (!scope) return null;
    const groups = groupItems(collectItems(scope, null, true), scope);
    const all = groups.flatMap((group, section) => group.items.map((item, i) => ({ item, section, position: i })));
    const match =
      (target.uri &&
        (all.find((e) => e.section === target.section && asTrack(e.item, 0).uri === target.uri) ||
          all.find((e) => asTrack(e.item, 0).uri === target.uri))) ||
      all.find((e) => e.section === target.section && e.position === target.index - 1);
    return match ? match.item.el : null;
  }

  function watchQueue() {
    stopQueue();
    let timer = 0;
    let last = '';
    let reopenedAt = 0;
    const report = () => {
      timer = 0;
      if (!queueWatch) return;
      const scope = panel();
      if (scope && !laidOut(scope)) setOverlay('panel', true);
      if (toggled(barControl('control-button-queue')) === false) {
        // Closed by the page (another panel): open it again, not too often.
        if (Date.now() - reopenedAt > 3000) {
          reopenedAt = Date.now();
          openPanel('control-button-queue');
        }
        return;
      }
      const data = readQueue();
      const json = JSON.stringify(data);
      if (json === last) return;
      last = json;
      post({ type: 'live', topic: 'queue', data });
    };
    const schedule = () => {
      if (!timer) timer = setTimeout(report, 250);
    };
    const observer = new MutationObserver(schedule);
    observer.observe(document.body, {
      subtree: true,
      childList: true,
      characterData: true,
      attributeFilter: ['aria-pressed', 'data-active', 'src', 'href'],
    });
    // The track changing changes "now playing" even when the panel doesn't.
    const interval = setInterval(schedule, 2000);
    holdPanel(true);
    queueWatch = {
      stop() {
        holdPanel(false);
        observer.disconnect();
        clearInterval(interval);
        clearTimeout(timer);
      },
    };
  }

  function stopQueue() {
    if (!queueWatch) return false;
    queueWatch.stop();
    queueWatch = null;
    return true;
  }

  async function queuePlay(arg, job) {
    await showQueue(job);
    const el = queueItem(arg);
    if (!el) throw new Error('not in the queue');
    await startRow(el, arg.uri, job);
    return true;
  }

  // ------------------------------------------------------------------- lyrics
  const LYRIC = '[data-testid="fullscreen-lyric"]';
  let lyricsWatch = null;
  let lyricsOpened = false;

  const lyricLines = () => [...document.querySelectorAll(LYRIC)].filter(laidOut);

  // The line being sung. Lines already sung, the one being sung and those to
  // come look different (classes, style): runs of alike lines tell them apart.
  function activeLine(lines) {
    const current = lines.findIndex(
      (l) => l.getAttribute('aria-current') === 'true' || l.matches('[aria-current="true"] *'),
    );
    if (current >= 0) return current;
    const looks = lines.map((l) => `${l.className}|${l.getAttribute('style') || ''}`);
    const runs = [];
    looks.forEach((look, i) => {
      const run = runs[runs.length - 1];
      if (run && run.look === look) run.end = i;
      else runs.push({ look, start: i, end: i });
    });
    if (runs.length < 2) return -1;
    const single = (run) => run.start === run.end;
    if (runs.length >= 3) {
      // Sung, singing, to come: the middle one (a single line, if several).
      const inner = runs.slice(1, -1);
      return (inner.find(single) || inner[0]).start;
    }
    // Only two kinds: the first line is being sung, or the last, or the last one sung.
    if (single(runs[0]) && !single(runs[1])) return 0;
    if (single(runs[1])) return runs[1].start;
    return runs[0].end;
  }

  function readLyrics() {
    const lines = lyricLines();
    return { lines: lines.map(textOf), active: activeLine(lines), uri: trackUri() };
  }

  async function showLyrics(job) {
    if (lyricLines().length) return true;
    const button = barControl('lyrics-button');
    if (!button || button.disabled || button.getAttribute('aria-disabled') === 'true') return false;
    if (!pressed(button)) lyricsOpened = true;
    openPanel('lyrics-button');
    return !!(await waitFor(() => lyricLines().length, 5000, job));
  }

  function watchLyrics() {
    stopLyrics(false);
    let timer = 0;
    let last = '';
    const report = () => {
      timer = 0;
      if (!lyricsWatch) return;
      const data = readLyrics();
      const json = JSON.stringify(data);
      if (json === last) return;
      last = json;
      post({ type: 'live', topic: 'lyrics', data });
    };
    const observer = new MutationObserver(() => {
      if (!timer) timer = setTimeout(report, 80);
    });
    observer.observe(document.body, {
      subtree: true,
      childList: true,
      characterData: true,
      attributeFilter: ['class', 'style', 'aria-current'],
    });
    // A new track: its lyrics, or none. Closed by the page: open again.
    const interval = setInterval(() => {
      if (toggled(barControl('lyrics-button')) === false) openPanel('lyrics-button');
      if (!timer) timer = setTimeout(report, 80);
    }, 1500);
    holdPanel(true);
    lyricsWatch = {
      stop() {
        holdPanel(false);
        observer.disconnect();
        clearInterval(interval);
        clearTimeout(timer);
      },
    };
  }

  function stopLyrics(close = true) {
    if (lyricsWatch) lyricsWatch.stop();
    lyricsWatch = null;
    if (close && lyricsOpened) {
      lyricsOpened = false;
      if (pressed(barControl('lyrics-button'))) closePanel();
      else setOverlay('panel', false);
    }
    return true;
  }

  async function lyrics(job) {
    const shown = await showLyrics(job);
    check(job);
    watchLyrics();
    const data = readLyrics();
    if (!shown || !data.lines.length) {
      const view = panel();
      data.message = view && laidOut(view) ? linesOf(view).slice(0, 3).join('\n') : '';
    }
    return data;
  }

  function lyricsSeek(arg) {
    const line = lyricLines()[arg.index];
    if (!line) return false;
    (line.querySelector('div, span') || line).click();
    line.click();
    return true;
  }

  // ---------------------------------------------------------------- web view
  // The app shows the page itself (a dialog to fill in, a page it can't show).
  async function showWeb(arg, job) {
    closeMenus();
    root().classList.remove('sw-read-library');
    if (arg.path) await open(normalize(arg.path), job);
    setOverlay('library', arg.view === 'library');
    if (arg.view !== 'panel') setOverlay('panel', false);
    return true;
  }

  // ---------------------------------------------------------------- reporting
  // An outline of the page, to find out what changed when the app can't read it.
  function outline(el, depth, out, budget) {
    if (!el || out.length >= budget) return;
    const tag = el.tagName.toLowerCase();
    if (tag === 'svg' || tag === 'path' || tag === 'script' || tag === 'style') return;
    // Chains of wrappers with a single child show as one line.
    let node = el;
    const chain = [];
    for (;;) {
      chain.push(describe(node));
      const only = node.children.length === 1 ? node.children[0] : null;
      if (!only || only.tagName === 'svg' || ownText(node)) break;
      node = only;
    }
    const text = ownText(node);
    out.push(`${'  '.repeat(depth)}${chain.join(' > ')}${text ? ` "${text.slice(0, 40)}"` : ''}`);
    for (const child of node.children) outline(child, depth + 1, out, budget);
  }

  function describe(el) {
    let label = el.tagName.toLowerCase();
    if (el.id) label += `#${el.id.length > 40 ? `${el.id.slice(0, 40)}…` : el.id}`;
    for (const name of ['role', 'data-testid', 'aria-rowindex', 'aria-rowcount', 'aria-haspopup', 'aria-checked']) {
      if (el.hasAttribute(name)) label += `[${name}=${el.getAttribute(name)}]`;
    }
    const href = el.getAttribute('href');
    if (href) label += `[href=${href.slice(0, 60)}]`;
    return label;
  }

  const ownText = (el) =>
    clean(
      [...el.childNodes]
        .filter((n) => n.nodeType === 3)
        .map((n) => n.textContent)
        .join(' '),
    );

  // [lines]: about how many lines of outline (a shorter report, for the diagnostic).
  function report(lines = 1200) {
    const scale = Math.max(0.05, lines / 1200);
    const out = [
      `URL : ${location.pathname}`,
      `Titre : ${document.title}`,
      `Écran : ${window.innerWidth}x${window.innerHeight}`,
      `Navigateur : ${navigator.userAgent}`,
      // What the player streams with: missing on some phones (iPhone).
      `Lecture : MediaSource ${typeof window.MediaSource}, ManagedMediaSource ${typeof window.ManagedMediaSource}, ` +
        `EME ${typeof navigator.requestMediaKeySystemAccess}`,
    ];
    const ids = new Map();
    for (const el of document.querySelectorAll('[data-testid]')) {
      const id = el.getAttribute('data-testid');
      ids.set(id, (ids.get(id) || 0) + 1);
    }
    out.push(
      `data-testid : ${[...ids]
        .sort((a, b) => b[1] - a[1])
        .map(([id, n]) => `${id}×${n}`)
        .join(', ')}`,
    );
    for (const [name, el, budget] of [
      ['page', mainView(), 700],
      ['panneau', panel(), 250],
      ['bibliothèque', sidebar(), 150],
      ['menus', openMenus()[0], 80],
    ]) {
      out.push('', `# ${name}`);
      const part = [];
      outline(el, 0, part, Math.round(budget * scale));
      out.push(...part);
    }
    out.push('', '# lecture', JSON.stringify(snapshot(here())).slice(0, 8000));
    return out.join('\n');
  }

  // ------------------------------------------------------------------ commands
  const request = (task, timeoutMs) => (arg) => exclusive(arg || {}, (job) => task(arg || {}, job), timeoutMs);
  Object.assign(commands, {
    read: request(async (arg, job) => {
      const path = normalize(arg.path);
      if (arg.fresh) memos.delete(path);
      await open(path, job);
      return snapshot(path);
    }),
    more: request((arg, job) => more(normalize(arg.path), job)),
    playTrack: request(playTrack),
    playPage: request(playPage),
    playCard: request(playCard),
    pageSave: request(pageSave),
    menu: request(openMenu),
    menuPick: request(pickMenu),
    menuClose: () => {
      closeMenus();
      return true;
    },
    // Long libraries take a while to scroll through.
    readLibrary: request((arg, job) => library(job), 60000),
    watchQueue: (arg) =>
      arg && arg.live === false
        ? stopQueue()
        : exclusive(arg || {}, async (job) => {
            await showQueue(job);
            // Dropped meanwhile: nothing to keep up to date.
            check(job);
            watchQueue();
            return readQueue();
          }),
    queuePlay: request(queuePlay),
    watchLyrics: (arg) => (arg && arg.live === false ? stopLyrics() : exclusive(arg || {}, lyrics)),
    lyricsSeek,
    showWeb: request(showWeb),
    report: (arg) => report(arg && arg.lines),
    cancel: (arg) => {
      const job = jobs.get(arg && arg.id);
      if (job) job.cancelled = true;
      return true;
    },
  });
})();
