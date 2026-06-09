import 'package:sqflite/sqflite.dart';
import 'app_database.dart';

/// SharedPreferences-shaped in-memory façade backed by the sqflite [kv] table.
///
/// Reads are synchronous (served from in-memory [_cache]).
/// Writes are asynchronous (persisted to [kv] via [AppDatabase]).
///
/// Call [init] once after [AppDatabase.init] before the first [getString].
class KvStore {
  KvStore(this._appDb);
  final AppDatabase _appDb;

  final Map<String, String> _cache = {};
  final Map<String, int> _ts = {};

  // ── Init ───────────────────────────────────────────────────────────────────

  /// Loads the entire kv table into memory.  Must be awaited before use.
  Future<void> init() async {
    final db = await _appDb.db;
    final rows = await db.query('kv');
    for (final row in rows) {
      final k = row['k'] as String;
      final v = row['v'] as String;
      final ts = row['ts'] as int;
      _cache[k] = v;
      _ts[k] = ts;
    }
  }

  // ── Sync reads ─────────────────────────────────────────────────────────────

  /// Returns the cached string for [key], or null.
  String? getString(String key) => _cache[key];

  /// Returns the last-write epoch-ms timestamp for [key], or null.
  int? tsOf(String key) => _ts[key];

  /// All currently cached keys.
  Iterable<String> keys() => _cache.keys;

  // ── Async writes ───────────────────────────────────────────────────────────

  /// Upserts [key] → [value] in both the cache and the [kv] table.
  Future<void> setString(String key, String value) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    _cache[key] = value;
    _ts[key] = now;
    final db = await _appDb.db;
    await db.insert(
      'kv',
      {'k': key, 'v': value, 'ts': now},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Removes [key] from cache and from the [kv] table.
  Future<void> remove(String key) async {
    _cache.remove(key);
    _ts.remove(key);
    final db = await _appDb.db;
    await db.delete('kv', where: 'k = ?', whereArgs: [key]);
  }

  /// Removes all keys matching [test] atomically in a single transaction.
  Future<void> removeWhere(bool Function(String key) test) async {
    final toRemove = _cache.keys.where(test).toList();
    if (toRemove.isEmpty) return;
    for (final k in toRemove) {
      _cache.remove(k);
      _ts.remove(k);
    }
    final db = await _appDb.db;
    await db.transaction((txn) async {
      for (final k in toRemove) {
        await txn.delete('kv', where: 'k = ?', whereArgs: [k]);
      }
    });
  }
}
