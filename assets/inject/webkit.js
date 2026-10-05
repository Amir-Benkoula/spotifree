// iOS only (WebPlayer.swift): runs first, at the start of the document, for
// what the web player expects from a desktop browser and WebKit on iPhone does
// differently.
(() => {
  'use strict';
  if (location.hostname !== 'open.spotify.com') return;

  // Media plays in the page, never full screen: video elements need playsinline
  // for that on iPhone (the player may play through one, never shown).
  // iPhones have no MediaSource, which the player streams with, but have its
  // managed version (iOS 17.1+), which only works without AirPlay offered.
  const managed = !window.MediaSource && typeof window.ManagedMediaSource === 'function';
  if (managed) window.MediaSource = window.ManagedMediaSource;

  const prepare = (el) => {
    if (el instanceof HTMLVideoElement) {
      el.playsInline = true;
      el.setAttribute('playsinline', '');
    }
    if (managed && el instanceof HTMLMediaElement) el.disableRemotePlayback = true;
    return el;
  };

  const createElement = Document.prototype.createElement;
  Document.prototype.createElement = function (...args) {
    return prepare(createElement.apply(this, args));
  };
  const NativeAudio = window.Audio;
  if (typeof NativeAudio === 'function') {
    const Audio = function Audio(src) {
      return prepare(src === undefined ? new NativeAudio() : new NativeAudio(src));
    };
    Audio.prototype = NativeAudio.prototype;
    window.Audio = Audio;
  }
  // Elements in the page's markup.
  document.addEventListener('loadstart', (event) => prepare(event.target), true);
})();
