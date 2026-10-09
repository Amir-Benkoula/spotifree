import 'package:flutter_test/flutter_test.dart';
import 'package:spotiweb/src/updater.dart';

void main() {
  late List<Uri> fetched;
  late List<String> installed;
  late List<String> opened;
  late Object? Function() published;

  Updater updater({int build = 5, String signer = '', bool ios = false, bool downloadFails = false}) {
    fetched = [];
    installed = [];
    opened = [];
    return Updater(
      build: build,
      repository: 'owner/repo',
      signer: signer,
      ios: ios,
      fetchJson: (url) async {
        fetched.add(url);
        return published();
      },
      download: (url, release, onProgress) async {
        onProgress(null);
        onProgress(0.5);
        if (downloadFails) throw Exception('réseau');
        onProgress(1);
        return '/cache/updates/spotiweb-${release.build}.apk';
      },
      installApk: (path) async => installed.add(path),
      openUrl: (url) async => opened.add(url),
    );
  }

  test('a newer build is offered, the same one is not', () async {
    published = () => {'build': 7, 'commit': 'abc1234', 'notes': 'Écrans natifs'};
    final newer = updater();
    await newer.check();
    expect(fetched.single.toString(), 'https://github.com/owner/repo/releases/download/apk/version.json');
    final state = newer.state.value;
    expect(state, isA<UpdateAvailable>());
    expect((state as UpdateAvailable).release.name, '1.0.7');
    expect(state.release.notes, 'Écrans natifs');

    final same = updater(build: 7);
    await same.check();
    expect(same.state.value, isA<UpToDate>());
  });

  test('a failed check says so only when asked for', () async {
    published = () => throw Exception('hors ligne');
    final quiet = updater();
    await quiet.check();
    expect(quiet.state.value, isA<UpdateIdle>());
    await quiet.check(manual: true);
    expect(quiet.state.value, isA<UpdateFailed>());
  });

  test('builds made elsewhere look for nothing', () async {
    published = () => {'build': 7};
    final local = updater(build: 0);
    await local.check(manual: true);
    expect(fetched, isEmpty);
    expect(local.state.value, isA<UpdateIdle>());
  });

  test('installing downloads the APK, then hands it to the system', () async {
    published = () => {'build': 7};
    final android = updater();
    await android.check();
    final states = <UpdateState>[];
    android.state.addListener(() => states.add(android.state.value));
    await android.install();
    expect(states.whereType<UpdateDownloading>().map((s) => s.progress), [null, null, 0.5, 1]);
    expect(installed, ['/cache/updates/spotiweb-7.apk']);
    // Still on offer, should the installer be cancelled.
    expect(android.state.value, isA<UpdateAvailable>());
  });

  test('a failed download can be tried again', () async {
    published = () => {'build': 7};
    final android = updater(downloadFails: true);
    await android.check();
    await android.install();
    final failed = android.state.value;
    expect(failed, isA<UpdateFailed>());
    expect((failed as UpdateFailed).release?.build, 7);
    expect(installed, isEmpty);
  });

  test('on iPhone, the release page opens (installed from a Mac)', () async {
    published = () => {'build': 9};
    final ios = updater(ios: true);
    await ios.check();
    expect(fetched.single.path, endsWith('/download/ios/version.json'));
    await ios.install();
    expect(opened, ['https://github.com/owner/repo/releases/tag/ios']);
  });

  test('a build signed with another key is to install anew', () async {
    const key = '27:AB:58:6D';
    published = () => {'build': 7, 'signer': '27:AB:58:6D'};
    final same = updater(signer: key);
    await same.check();
    final release = (same.state.value as UpdateAvailable).release;
    expect(release.signer, key);
    expect(same.installsOver(release), isTrue);
    expect(same.installsOver(const Release(build: 7, signer: '27ab586d')), isTrue);
    // Unknown on either side: as before.
    expect(updater().installsOver(release), isTrue);
    expect(same.installsOver(const Release(build: 7)), isTrue);

    final other = updater(signer: 'C4:01:9E:12');
    await other.check();
    expect(other.installsOver(release), isFalse);
    expect(updater(signer: 'C4:01:9E:12', ios: true).installsOver(release), isTrue);
    // The system installer would refuse it: the browser downloads it instead.
    await other.install();
    expect(installed, isEmpty);
    expect(opened, ['https://github.com/owner/repo/releases/download/apk/spotiweb.apk']);
    expect(other.state.value, isA<UpdateAvailable>());
  });

  test('a build put off is remembered', () async {
    published = () => {'build': 7};
    final android = updater();
    await android.check();
    android.dismiss((android.state.value as UpdateAvailable).release);
    expect(android.dismissed.value, 7);
  });
}
