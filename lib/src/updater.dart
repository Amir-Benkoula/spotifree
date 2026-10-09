import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'system_channel.dart';

/// This build, as GitHub made it (--dart-define in .github/workflows/): its
/// number grows with each build. 0 for a build made elsewhere, which looks for
/// no updates.
const appBuild = int.fromEnvironment('SPOTIWEB_BUILD');
const appCommit = String.fromEnvironment('SPOTIWEB_COMMIT');

/// Where the builds are published.
const appRepository = String.fromEnvironment('SPOTIWEB_REPO', defaultValue: 'Amir-Benkoula/spotifree');

String versionName(int build) => '1.0.$build';

/// "1.0.12 (abc1234)", or a development build.
String get appVersionLabel =>
    appBuild > 0 ? '${versionName(appBuild)}${appCommit.isEmpty ? '' : ' ($appCommit)'}' : 'de développement';

/// A published build, as its version.json describes it.
@immutable
class Release {
  const Release({required this.build, this.commit = '', this.notes = ''});

  factory Release.fromJson(Map<String, dynamic> json) => Release(
    build: (json['build'] as num).toInt(),
    commit: json['commit'] as String? ?? '',
    notes: json['notes'] as String? ?? '',
  );

  final int build;
  final String commit;

  /// What changed (the build's commit title).
  final String notes;

  String get name => versionName(build);
}

sealed class UpdateState {
  const UpdateState();
}

/// Not checked yet, or nothing to say.
final class UpdateIdle extends UpdateState {
  const UpdateIdle();
}

final class UpdateChecking extends UpdateState {
  const UpdateChecking();
}

/// Checked: this is the latest build.
final class UpToDate extends UpdateState {
  const UpToDate();
}

final class UpdateAvailable extends UpdateState {
  const UpdateAvailable(this.release);

  final Release release;
}

final class UpdateDownloading extends UpdateState {
  const UpdateDownloading(this.release, this.progress);

  final Release release;

  /// From 0 to 1, null while unknown.
  final double? progress;
}

final class UpdateFailed extends UpdateState {
  const UpdateFailed(this.message, [this.release]);

  final String message;

  /// The build it was about, to try again.
  final Release? release;
}

/// Keeps the app up to date with the builds published on GitHub: checks the
/// latest one's version.json now and then; on Android, downloads its APK and
/// hands it to the system installer (the user confirms). An iPhone can only be
/// updated from a Mac: the release page opens.
class Updater {
  Updater({
    this.build = appBuild,
    this.repository = appRepository,
    bool? ios,
    Future<Object?> Function(Uri url)? fetchJson,
    Future<String> Function(Uri url, Release release, void Function(double? progress) onProgress)? download,
    Future<void> Function(String path)? installApk,
    Future<void> Function(String url)? openUrl,
  }) : ios = ios ?? defaultTargetPlatform == TargetPlatform.iOS,
       _fetchJson = fetchJson ?? _getJson,
       _download = download ?? _downloadApk,
       _installApk = installApk ?? SystemChannel.installApk,
       _openUrl = openUrl ?? SystemChannel.openUrl;

  /// This build's number; 0: no updates.
  final int build;
  final String repository;
  final bool ios;
  final Future<Object?> Function(Uri url) _fetchJson;
  final Future<String> Function(Uri url, Release release, void Function(double? progress) onProgress) _download;
  final Future<void> Function(String path) _installApk;
  final Future<void> Function(String url) _openUrl;

  final state = ValueNotifier<UpdateState>(const UpdateIdle());

  /// The build the user put off: not offered again.
  final dismissed = ValueNotifier<int>(0);

  DateTime? _checkedAt;
  Timer? _timer;
  AppLifecycleListener? _lifecycle;

  bool get enabled => build > 0;

  Uri get _releases => Uri.parse('https://github.com/$repository/releases/');
  Uri get versionUrl => _releases.resolve(ios ? 'download/ios/version.json' : 'download/apk/version.json');
  Uri get apkUrl => _releases.resolve('download/apk/spotiweb.apk');
  Uri get iosPage => _releases.resolve('tag/ios');

  /// Checks a little after the start, then when the app comes back after a while.
  void schedule() {
    if (!enabled) return;
    _timer = Timer(const Duration(seconds: 20), check);
    _lifecycle = AppLifecycleListener(
      onResume: () {
        final checkedAt = _checkedAt;
        if (checkedAt == null || DateTime.now().difference(checkedAt) > const Duration(hours: 6)) check();
      },
    );
  }

  void dispose() {
    _timer?.cancel();
    _lifecycle?.dispose();
    state.dispose();
    dismissed.dispose();
  }

  /// Looks for a newer build. Asked for by the user ([manual]), it says when it
  /// can't tell; otherwise it fails quietly.
  Future<void> check({bool manual = false}) async {
    if (!enabled) return;
    final previous = state.value;
    if (previous is UpdateChecking || previous is UpdateDownloading) return;
    _checkedAt = DateTime.now();
    if (manual) state.value = const UpdateChecking();
    try {
      final json = await _fetchJson(versionUrl);
      final release = Release.fromJson(Map<String, dynamic>.from(json! as Map));
      state.value = release.build > build ? UpdateAvailable(release) : const UpToDate();
    } catch (error) {
      state.value = manual ? UpdateFailed('Impossible de vérifier les mises à jour ($error)') : previous;
    }
  }

  /// Installs the build on offer (or the one that failed).
  Future<void> install() async {
    final release = switch (state.value) {
      UpdateAvailable(:final release) => release,
      UpdateFailed(:final release?) => release,
      _ => null,
    };
    if (release == null) return;
    if (ios) {
      await _openUrl(iosPage.toString());
      return;
    }
    state.value = UpdateDownloading(release, null);
    try {
      final path = await _download(apkUrl, release, (progress) => state.value = UpdateDownloading(release, progress));
      // The system asks to confirm; the app stays as is until then.
      state.value = UpdateAvailable(release);
      await _installApk(path);
    } catch (error) {
      state.value = UpdateFailed("La mise à jour n'a pas pu se faire ($error)", release);
    }
  }

  void dismiss(Release release) => dismissed.value = release.build;

  static Future<Object?> _getJson(Uri url) async {
    final client = HttpClient()..connectionTimeout = const Duration(seconds: 15);
    try {
      final request = await client.getUrl(url);
      final response = await request.close().timeout(const Duration(seconds: 20));
      if (response.statusCode != HttpStatus.ok) throw HttpException('HTTP ${response.statusCode}', uri: url);
      return jsonDecode(await response.transform(utf8.decoder).join());
    } finally {
      client.close();
    }
  }

  /// Downloads the APK in the app's cache (kept for another try at the same build).
  static Future<String> _downloadApk(Uri url, Release release, void Function(double? progress) onProgress) async {
    final directory = Directory(await SystemChannel.updatesDir());
    final file = File('${directory.path}/spotiweb-${release.build}.apk');
    if (await file.exists()) return file.path;
    // Older downloads go.
    await for (final old in directory.list()) {
      if (old is File) await old.delete();
    }
    final partial = File('${file.path}.part');
    final client = HttpClient()..connectionTimeout = const Duration(seconds: 15);
    try {
      final request = await client.getUrl(url);
      final response = await request.close();
      if (response.statusCode != HttpStatus.ok) throw HttpException('HTTP ${response.statusCode}', uri: url);
      final total = response.contentLength;
      final sink = partial.openWrite();
      var received = 0;
      try {
        await for (final chunk in response.timeout(const Duration(seconds: 30))) {
          sink.add(chunk);
          received += chunk.length;
          onProgress(total > 0 ? received / total : null);
        }
      } finally {
        await sink.close();
      }
      await partial.rename(file.path);
      return file.path;
    } finally {
      client.close();
    }
  }
}
