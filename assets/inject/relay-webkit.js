// iOS half of the bridge, in place of relay.js (Android's extension): in
// WebKit the page's own world can reach the app, through the script message
// handler that WebPlayer.swift adds. Runs after bootstrap.js and reader.js.
//   page -> app: 'spotiweb:out' events, posted to window.webkit.messageHandlers.spotiweb
//   app -> page: WebPlayer.swift dispatches 'spotiweb:in' events ({ name, arg })
(() => {
  'use strict';
  const handlers = window.webkit && window.webkit.messageHandlers;
  const app = handlers && handlers.spotiweb;
  if (!app || location.hostname !== 'open.spotify.com') return;

  window.addEventListener('spotiweb:out', (event) => {
    if (typeof event.detail === 'string') app.postMessage(event.detail);
  });

  // Tells the app the page listens, then asks for a full report: the page may
  // have reported before this listener existed.
  app.postMessage(JSON.stringify({ type: 'hello' }));
  window.dispatchEvent(new CustomEvent('spotiweb:in', { detail: JSON.stringify({ name: 'sync' }) }));
})();
