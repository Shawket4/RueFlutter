// ─────────────────────────────────────────────────────────────────────────────
// RESCUE BUILD — offline DB extraction only. NOT a working POS.
//
// Built from tag v3.5.1.2 (the build deployed to the field) so it installs in
// place over com.sufrixpos.sufrix_pos with the data partition untouched.
//
// The point of this entrypoint is what it does NOT do:
//   • never imports/opens AppDatabase  → openDatabase() is never called, so
//     _onUpgrade can't ALTER the outbox or rewrite in_flight → pending
//   • never starts OfflineQueue        → no replay, no retry_count churn, no
//     rows flipped to dead, no synced_at stamped, nothing sent to the API
//   • never starts ConnectivityService / NotificationService / the router
//
// It copies raw bytes of a file SQLite has not opened in this process, hashes
// both sides, and stops. A byte copy of an unopened file cannot corrupt it.
//
// Destination is the app's external files dir
// (/sdcard/Android/data/com.sufrixpos.sufrix_pos/files/), which `adb pull`
// reaches on a stock, non-rooted, non-debuggable device.
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// The sqflite DB sits next to getApplicationSupportDirectory() — NOT in the
/// conventional databases/ dir. Mirrors AppDatabase._dbPath().
const _dbName = 'sufrix_pos.db';

/// WAL sidecars. The -wal file can hold the most recent orders; copying the
/// .db alone would silently hand back a stale snapshot.
const _dbFiles = [_dbName, '$_dbName-wal', '$_dbName-shm'];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DumpReport report;
  try {
    report = await _dump();
  } catch (e, st) {
    report = DumpReport.failure('$e\n$st');
  }
  runApp(RescueApp(report));
}

class CopiedFile {
  final String name;
  final int bytes;
  final String sourceSha256;
  final String destSha256;
  const CopiedFile(this.name, this.bytes, this.sourceSha256, this.destSha256);

  bool get verified => sourceSha256 == destSha256;
}

class DumpReport {
  final bool ok;
  final String? error;
  final String? destDir;
  final List<CopiedFile> files;
  final List<String> missing;

  const DumpReport({
    required this.ok,
    this.error,
    this.destDir,
    this.files = const [],
    this.missing = const [],
  });

  factory DumpReport.failure(String e) => DumpReport(ok: false, error: e);

  bool get allVerified => files.isNotEmpty && files.every((f) => f.verified);
}

Future<DumpReport> _dump() async {
  final srcDir = await getApplicationSupportDirectory();

  // External files dir is adb-pullable without root. Null on iOS and on the
  // odd Android device with no external volume — fall back to the documents
  // dir, whose path the UI prints either way.
  Directory? extDir;
  if (Platform.isAndroid) {
    extDir = await getExternalStorageDirectory();
  }
  final destRoot = extDir ?? await getApplicationDocumentsDirectory();

  final stamp =
      DateTime.now().toIso8601String().replaceAll(':', '-').replaceAll('.', '-');
  final destDir = Directory(p.join(destRoot.path, 'rescue-dump-$stamp'));
  await destDir.create(recursive: true);

  final copied = <CopiedFile>[];
  final missing = <String>[];

  for (final name in _dbFiles) {
    final src = File(p.join(srcDir.path, name));
    if (!await src.exists()) {
      missing.add(name);
      continue;
    }
    final dest = File(p.join(destDir.path, name));

    // Plain byte copy. No sqflite, no openDatabase, no migration.
    await src.copy(dest.path);

    // Hash both sides so a truncated copy (full disk) is caught here, not
    // after the tablet has gone back to the branch.
    final srcHash = await _sha256(src);
    final destHash = await _sha256(dest);
    copied.add(CopiedFile(name, await dest.length(), srcHash, destHash));
  }

  // Drop a manifest in the dump so the pulled folder is self-describing.
  final manifest = StringBuffer()
    ..writeln('sufrix_pos rescue dump')
    ..writeln('taken_at: ${DateTime.now().toIso8601String()}')
    ..writeln('source_dir: ${srcDir.path}')
    ..writeln('os: ${Platform.operatingSystemVersion}')
    ..writeln('');
  for (final f in copied) {
    manifest.writeln('${f.name}  ${f.bytes} bytes  sha256=${f.sourceSha256}  '
        'verified=${f.verified}');
  }
  for (final m in missing) {
    manifest.writeln('$m  ABSENT');
  }
  await File(p.join(destDir.path, 'manifest.txt')).writeAsString('$manifest');

  return DumpReport(
    ok: copied.isNotEmpty,
    destDir: destDir.path,
    files: copied,
    missing: missing,
  );
}

Future<String> _sha256(File f) async {
  // Streamed so a large DB doesn't spike memory on a low-RAM tablet.
  final digest = await sha256.bind(f.openRead()).first;
  return digest.toString();
}

class RescueApp extends StatelessWidget {
  final DumpReport report;
  const RescueApp(this.report, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.deepOrange, useMaterial3: true),
      home: RescueScreen(report),
    );
  }
}

class RescueScreen extends StatelessWidget {
  final DumpReport report;
  const RescueScreen(this.report, {super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final good = report.ok && report.allVerified;

    return Scaffold(
      backgroundColor: good ? const Color(0xFF0E2A14) : const Color(0xFF2A0E0E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(good ? Icons.check_circle : Icons.error,
                        color: good ? Colors.greenAccent : Colors.redAccent,
                        size: 40),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        good ? 'DUMP READY' : 'DUMP FAILED',
                        style: t.headlineMedium?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Maintenance build — this is not the POS.\n'
                  'DO NOT UNINSTALL THIS APP. Hand the tablet to the admin.',
                  style: t.titleMedium?.copyWith(color: Colors.amberAccent),
                ),
                const Divider(height: 32, color: Colors.white24),
                if (report.error != null)
                  SelectableText(report.error!,
                      style: t.bodySmall?.copyWith(color: Colors.redAccent)),
                if (report.destDir != null) ...[
                  Text('Dump folder',
                      style: t.labelLarge?.copyWith(color: Colors.white70)),
                  SelectableText(report.destDir!,
                      style: t.bodyMedium?.copyWith(
                          color: Colors.white, fontFamily: 'monospace')),
                  const SizedBox(height: 16),
                ],
                for (final f in report.files)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${f.verified ? "✓" : "✗"}  ${f.name}  —  '
                          '${_human(f.bytes)}',
                          style: t.bodyLarge?.copyWith(
                              color: f.verified
                                  ? Colors.greenAccent
                                  : Colors.redAccent),
                        ),
                        SelectableText(
                          'sha256 ${f.sourceSha256}',
                          style: t.bodySmall?.copyWith(
                              color: Colors.white54, fontFamily: 'monospace'),
                        ),
                      ],
                    ),
                  ),
                for (final m in report.missing)
                  Text('–  $m  (not present)',
                      style: t.bodyMedium?.copyWith(color: Colors.white38)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _human(int b) => b < 1024
      ? '$b B'
      : b < 1024 * 1024
          ? '${(b / 1024).toStringAsFixed(1)} KB'
          : '${(b / 1024 / 1024).toStringAsFixed(2)} MB';
}
