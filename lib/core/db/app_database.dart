import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

/// Singleton database gateway.
///
/// Call [init] once from [main] before [runApp], then use [db] anywhere.
/// Platform factory selection:
///   - Web   → databaseFactoryFfiWeb
///   - macOS/Windows/Linux → sqfliteFfiInit() + databaseFactoryFfi
///   - iOS/Android → default sqflite factory (no setup needed)
class AppDatabase {
  AppDatabase._();
  static final AppDatabase instance = AppDatabase._();

  Database? _db;

  /// Lazily-opened [Database].
  Future<Database> get db async {
    _db ??= await _open();
    return _db!;
  }

  /// Must be called from [main] before [runApp].
  Future<void> init() async {
    _db = await _open();
  }

  // ── Factory selection ──────────────────────────────────────────────────────

  void _initFactory() {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
      return;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        sqfliteFfiInit();
        databaseFactory = databaseFactoryFfi;
        break;
      default:
        // iOS / Android — default sqflite factory is already correct.
        break;
    }
  }

  Future<String> _dbPath() async {
    if (kIsWeb) return 'sufrix_pos.db';
    final dir = await getApplicationSupportDirectory();
    return p.join(dir.path, 'sufrix_pos.db');
  }

  // ── Open ───────────────────────────────────────────────────────────────────

  Future<Database> _open() async {
    _initFactory();
    final path = await _dbPath();
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // ── Schema ─────────────────────────────────────────────────────────────────

  Future<void> _onCreate(Database db, int version) async {
    // Key-value cache store: replaces SharedPreferences.
    await db.execute('''
      CREATE TABLE kv (
        k     TEXT PRIMARY KEY,
        v     TEXT NOT NULL,
        ts    INTEGER NOT NULL
      )
    ''');

    // Durable outbox for offline-write mutations.
    await db.execute('''
      CREATE TABLE outbox (
        local_id        TEXT PRIMARY KEY,
        type            TEXT NOT NULL,
        payload         TEXT NOT NULL,
        status          TEXT NOT NULL,
        depends_on      TEXT,
        retry_count     INTEGER NOT NULL DEFAULT 0,
        last_error      TEXT,
        created_at      INTEGER NOT NULL,
        next_attempt_at INTEGER NOT NULL
      )
    ''');
    await db.execute(
      'CREATE INDEX idx_outbox_status ON outbox(status, next_attempt_at)',
    );

    // Per-entity sync timestamps for freshness / TTL logic.
    await db.execute('''
      CREATE TABLE sync_meta (
        entity        TEXT PRIMARY KEY,
        last_synced_at INTEGER
      )
    ''');
  }
}
