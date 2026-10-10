// SpotiWeb's icon: a music note whose head is a globe (a meridian, the
// equator), in frosted glass with a soft (gaussian) relief, on a plain
// gradient. Drawn on Android's adaptive icon canvas: 108 × 108, shown 18..90,
// the mark within the safe circle (r 33 around 54,54). make.js renders it.
const P = { cx: 46.7, cy: 65.5, r: 14.2, stemW: 6.4, top: 25.5, line: 2.3 };
const f = (n) => +n.toFixed(2);

function shapes(p = P) {
  const { cx, cy, r, stemW, top } = p;
  const stemR = cx + r;
  const stemL = stemR - stemW;
  // Down to the equator (its cut ends under the stem), no further: the head curves in below.
  const bottom = cy + p.line / 2 + 0.25;
  const stem = `M${f(stemL + stemW / 2)},${f(top)} a${f(stemW / 2)},${f(stemW / 2)} 0 0 1 ${f(stemW / 2)},${f(stemW / 2)} V${f(bottom)} H${f(stemL)} V${f(top + stemW / 2)} a${f(stemW / 2)},${f(stemW / 2)} 0 0 1 ${f(stemW / 2)},${f(-stemW / 2)} Z`;
  const x = stemR, y = top;
  const flag = `M${f(x - 0.6)},${f(y + 1.2)} C${f(x + 5.5)},${f(y + 3.2)} ${f(x + 14.5)},${f(y + 9)} ${f(x + 14)},${f(y + 19.5)} C${f(x + 13.8)},${f(y + 23.5)} ${f(x + 12.2)},${f(y + 27)} ${f(x + 10)},${f(y + 29.5)} C${f(x + 11)},${f(y + 23)} ${f(x + 8.5)},${f(y + 16.5)} ${f(x - 0.6)},${f(y + 14)} Z`;
  const head = `M${f(cx - r)},${f(cy)} a${f(r)},${f(r)} 0 1 0 ${f(2 * r)},0 a${f(r)},${f(r)} 0 1 0 ${f(-2 * r)},0 Z`;
  // Globe lines, cut out of the head: a meridian, the equator (to the stem).
  const m = r * 0.47;
  const lines = [
    `M${f(cx)},${f(cy - r - 1)} a${f(m)},${f(r + 1)} 0 1 0 0.01,0 Z`,
    `M${f(cx - r - 1)},${f(cy)} H${f(stemL)}`,
  ];
  return { stem, flag, head, lines, bounds: { left: cx - r, right: x + 14.6, top, bottom: cy + r } };
}

const THEMES = {
  // The icon: white glass on green.
  green: { bgTop: '#3DDC84', bgBottom: '#0E9F7E', glassTop: '#FFFFFF', glassBottom: '#E3FBEF', shadow: '#03483A', opacity: 0.94 },
  // iPhone in dark mode: green glass on black.
  dark: { bgTop: '#2A2D2C', bgBottom: '#0C0D0D', glassTop: '#45E896', glassBottom: '#11B087', shadow: '#000000', opacity: 1 },
  // iPhone tinted: grey levels, the system colors them.
  tinted: { bgTop: '#1C1C1C', bgBottom: '#000000', glassTop: '#FFFFFF', glassBottom: '#CFCFCF', shadow: '#000000', opacity: 1 },
};

// The mark with its relief: soft shadow under it, light along its top edges,
// shade along its bottom ones (blurred: gaussian).
function mark(id, theme, { relief = true, solid = null, opacity = null } = {}) {
  const t = THEMES[theme];
  const s = shapes();
  const fill = solid || `url(#glass${id})`;
  const cut = `<mask id="cut${id}" maskUnits="userSpaceOnUse" x="0" y="0" width="108" height="108"><rect width="108" height="108" fill="#fff"/>
      <g fill="none" stroke="#000" stroke-width="${P.line}" stroke-linecap="round">${s.lines.map((d) => `<path d="${d}"/>`).join('')}</g>
      <path d="${s.stem}" fill="#fff"/></mask>`;
  const defs = `<defs>
    <linearGradient id="glass${id}" x1="0" y1="${s.bounds.top}" x2="0" y2="${s.bounds.bottom}" gradientUnits="userSpaceOnUse">
      <stop offset="0" stop-color="${t.glassTop}"/><stop offset="1" stop-color="${t.glassBottom}"/></linearGradient>
    ${cut}
    <filter id="relief${id}" x="-30%" y="-30%" width="160%" height="170%" color-interpolation-filters="sRGB">
      <feGaussianBlur in="SourceAlpha" stdDeviation="2.6" result="soft"/>
      <feOffset in="soft" dy="2.4" result="drop"/>
      <feFlood flood-color="${t.shadow}" flood-opacity="0.32"/><feComposite in2="drop" operator="in" result="shadow"/>
      <feGaussianBlur in="SourceAlpha" stdDeviation="0.9" result="edge"/>
      <feOffset in="edge" dy="1.3" result="down"/>
      <feComposite in="SourceAlpha" in2="down" operator="arithmetic" k2="1" k3="-1" result="topRim"/>
      <feFlood flood-color="#FFFFFF" flood-opacity="0.85"/><feComposite in2="topRim" operator="in" result="light"/>
      <feOffset in="edge" dy="-1.3" result="up"/>
      <feComposite in="SourceAlpha" in2="up" operator="arithmetic" k2="1" k3="-1" result="bottomRim"/>
      <feFlood flood-color="${t.shadow}" flood-opacity="0.28"/><feComposite in2="bottomRim" operator="in" result="shade"/>
      <feMerge><feMergeNode in="shadow"/><feMergeNode in="SourceGraphic"/><feMergeNode in="light"/><feMergeNode in="shade"/></feMerge>
    </filter></defs>`;
  const body = `<g mask="url(#cut${id})"><path d="${s.head}" fill="${fill}"/></g><path d="${s.stem}" fill="${fill}"/><path d="${s.flag}" fill="${fill}"/>`;
  return `${defs}<g ${relief ? `filter="url(#relief${id})"` : ''} opacity="${opacity === null ? t.opacity : opacity}">${body}</g>`;
}

const background = (id, theme) => {
  const t = THEMES[theme];
  return `<defs><linearGradient id="bg${id}" x1="0" y1="18" x2="0" y2="90" gradientUnits="userSpaceOnUse">
    <stop offset="0" stop-color="${t.bgTop}"/><stop offset="1" stop-color="${t.bgBottom}"/></linearGradient></defs>
    <rect width="108" height="108" fill="url(#bg${id})"/>`;
};

const icon = (id, theme = 'green', view = '18 18 72 72') =>
  `<svg xmlns="http://www.w3.org/2000/svg" viewBox="${view}">${background(id, theme)}${mark(id, theme)}</svg>`;

module.exports = { P, shapes, mark, background, icon, THEMES };
