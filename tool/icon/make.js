// Renders SpotiWeb's icon (design.js) into the app: Android's adaptive icon
// (foreground, themed monochrome layer, older launchers' icon), the status bar
// icon, the Android 12 splash screen, the iPhone icon (and its dark and tinted
// looks), the iPhone launch screen, and the picture of the app's own splash.
//   node tool/icon/make.js
// Needs Playwright with a Chromium (PLAYWRIGHT: its module, CHROMIUM: the
// browser) and ImageMagick (iPhone icons can't have transparency).
const fs = require('fs');
const path = require('path');
const { execFileSync } = require('child_process');
const { chromium } = require(process.env.PLAYWRIGHT || 'playwright');
const { shapes, mark, background, icon, P } = require('./design.js');

const ROOT = path.resolve(__dirname, '../..');
const RES = path.join(ROOT, 'android/app/src/main/res');
const IOS = path.join(ROOT, 'ios/Runner/Assets.xcassets');
const DENSITIES = { mdpi: 1, hdpi: 1.5, xhdpi: 2, xxhdpi: 3, xxxhdpi: 4 };

const svg = (content, view = '0 0 108 108') => `<svg xmlns="http://www.w3.org/2000/svg" viewBox="${view}">${content}</svg>`;
// The mark alone, white, its globe lines cut out (themed icons, no relief).
const plainMark = (id) => mark(id, 'green', { relief: false, solid: '#FFFFFF', opacity: 1 });
// The whole icon in a shape: a circle (Android) or Apple's rounded square.
const shaped = (id, theme, radius) =>
  `<div style="width:100%;height:100%;border-radius:${radius};overflow:hidden">${icon(id, theme)}</div>`;

(async () => {
  const browser = await chromium.launch(process.env.CHROMIUM ? { executablePath: process.env.CHROMIUM } : {});
  const page = await browser.newPage();
  let n = 0;
  // html (an <svg> or anything) rendered size × size into file, transparent around.
  async function render(html, size, file, { box = size, opaque = false } = {}) {
    fs.mkdirSync(path.dirname(file), { recursive: true });
    await page.setViewportSize({ width: size, height: size });
    const inner = `<div style="width:${box}px;height:${box}px">${html.replace('<svg ', '<svg width="100%" height="100%" ')}</div>`;
    await page.setContent(
      `<body style="margin:0;width:${size}px;height:${size}px;display:flex;align-items:center;justify-content:center;background:transparent">${inner}</body>`,
    );
    await page.screenshot({ path: file, omitBackground: !opaque, clip: { x: 0, y: 0, width: size, height: size } });
    if (opaque) execFileSync('convert', [file, '-background', 'black', '-alpha', 'remove', '-alpha', 'off', `PNG24:${file}`]);
  }

  // ------------------------------------------------------------- Android
  for (const [density, scale] of Object.entries(DENSITIES)) {
    const dir = path.join(RES, `mipmap-${density}`);
    // Adaptive icon layers: 108 dp.
    await render(svg(mark(`f${n++}`, 'green')), 108 * scale, path.join(dir, 'ic_launcher_foreground.png'));
    await render(svg(plainMark(`m${n++}`)), 108 * scale, path.join(dir, 'ic_launcher_monochrome.png'));
    // Launchers without adaptive icons: 48 dp, round.
    await render(shaped(`l${n++}`, 'green', '50%'), 48 * scale, path.join(dir, 'ic_launcher.png'));
  }
  // Android 12's splash screen: an icon in a 288 dp square (shown within its
  // 192 dp circle), here a 112 dp disc like the app's own splash.
  await render(shaped(`s${n++}`, 'green', '50%'), 1152, path.join(RES, 'drawable-nodpi/splash_icon.png'), { box: 448 });

  // The background layer, and the status bar icon: vector drawables.
  const b = shapes().bounds;
  fs.writeFileSync(
    path.join(RES, 'drawable/ic_launcher_background.xml'),
    `<?xml version="1.0" encoding="utf-8"?>
<!-- The icon's background layer (tool/icon/make.js). -->
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:aapt="http://schemas.android.com/aapt"
    android:width="108dp"
    android:height="108dp"
    android:viewportWidth="108"
    android:viewportHeight="108">
    <path android:pathData="M0,0h108v108h-108z">
        <aapt:attr name="android:fillColor">
            <gradient
                android:type="linear"
                android:startX="54"
                android:startY="18"
                android:endX="54"
                android:endY="90"
                android:startColor="#FF3DDC84"
                android:endColor="#FF0E9F7E" />
        </aapt:attr>
    </path>
</vector>
`,
  );
  const s = shapes();
  const scale = 21 / (b.bottom - b.top);
  const centerX = (b.left + b.right) / 2;
  const centerY = (b.top + b.bottom) / 2;
  fs.writeFileSync(
    path.join(RES, 'drawable/ic_stat_music.xml'),
    `<?xml version="1.0" encoding="utf-8"?>
<!-- Status bar and media notification icon: the icon's note, white on
     transparent, the system tints it (tool/icon/make.js). -->
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24">
    <group
        android:scaleX="${scale.toFixed(4)}"
        android:scaleY="${scale.toFixed(4)}"
        android:translateX="${(12 - centerX * scale).toFixed(3)}"
        android:translateY="${(12 - centerY * scale).toFixed(3)}">
        <path android:fillColor="#FFFFFFFF" android:pathData="${s.head}" />
        <path android:fillColor="#FFFFFFFF" android:pathData="${s.stem}" />
        <path android:fillColor="#FFFFFFFF" android:pathData="${s.flag}" />
    </group>
</vector>
`,
  );

  // ----------------------------------------------------------------- iOS
  // One 1024 picture per look; Xcode makes the other sizes.
  const icons = path.join(IOS, 'AppIcon.appiconset');
  for (const file of fs.readdirSync(icons)) if (file.endsWith('.png')) fs.unlinkSync(path.join(icons, file));
  await render(icon(`i${n++}`, 'green'), 1024, path.join(icons, 'Icon-App-1024x1024@1x.png'), { opaque: true });
  await render(icon(`i${n++}`, 'dark'), 1024, path.join(icons, 'Icon-App-Dark-1024x1024@1x.png'), { opaque: true });
  await render(icon(`i${n++}`, 'tinted'), 1024, path.join(icons, 'Icon-App-Tinted-1024x1024@1x.png'), { opaque: true });
  const look = (value, file) => ({
    appearances: [{ appearance: 'luminosity', value }],
    filename: file,
    idiom: 'universal',
    platform: 'ios',
    size: '1024x1024',
  });
  fs.writeFileSync(
    path.join(icons, 'Contents.json'),
    `${JSON.stringify(
      {
        images: [
          { filename: 'Icon-App-1024x1024@1x.png', idiom: 'universal', platform: 'ios', size: '1024x1024' },
          look('dark', 'Icon-App-Dark-1024x1024@1x.png'),
          look('tinted', 'Icon-App-Tinted-1024x1024@1x.png'),
        ],
        info: { author: 'xcode', version: 1 },
      },
      null,
      2,
    )}\n`,
  );
  // The launch screen's picture: the icon, 112 points, Apple's corners.
  const launch = path.join(IOS, 'LaunchImage.imageset');
  for (const [suffix, k] of [['', 1], ['@2x', 2], ['@3x', 3]]) {
    await render(shaped(`k${n++}`, 'green', '22.5%'), 112 * k, path.join(launch, `LaunchImage${suffix}.png`));
  }

  // ------------------------------------------------------- the app's splash
  await render(icon(`a${n++}`, 'green'), 336, path.join(ROOT, 'assets/icon/icon.png'));

  await browser.close();
  console.log(`made the icons (mark ${JSON.stringify(P)})`);
})().catch((error) => {
  console.error(error);
  process.exit(1);
});
