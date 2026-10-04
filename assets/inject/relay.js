// Isolated-world half of the bridge. bootstrap.js runs in the page's own world
// (it must patch the page's objects) where extension APIs don't exist; this
// script forwards between it and the app (GeckoView native messaging).
//   page -> app: 'spotiweb:out' events, JSON string detail
//   app -> page: 'spotiweb:in' events, JSON string detail ({ name, arg })
(() => {
  'use strict';
  const port = browser.runtime.connectNative('spotiweb');
  const toPage = (message) =>
    window.dispatchEvent(new CustomEvent('spotiweb:in', { detail: JSON.stringify(message) }));

  window.addEventListener('spotiweb:out', (event) => {
    if (typeof event.detail === 'string') port.postMessage(JSON.parse(event.detail));
  });
  port.onMessage.addListener(toPage);

  // The page may have reported before this listener existed: ask again.
  toPage({ name: 'sync' });
})();
