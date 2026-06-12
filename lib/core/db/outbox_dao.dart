import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'app_database.dart';

// ── Model ──────────────────────────────────────────────────────────────────

/// Mirrors one row in the [outbox] table.
class OutboxEntry {
  final String localId;
  final String type;
  final String payload; // JSON of PendingAction.toJson()
  final String status; // pending|in_flight|dead|synced
  final String? dependsOn; // localId of prerequisite action
  final int retryCount;
  final String? lastError;
  final int createdAt; // epoch ms
  final int nextAttemptAt; // epoch ms; 0 = ready now
  final String? userId; // user who enqueued the action
  final int? syncedAt; // epoch ms; set when status becomes 'synced'

  const OutboxEntry({
    required this.localId,
    required this.type,
    required this.payload,
    required this.status,
    this.dependsOn,
    required this.retryCount,
    this.lastError,
    required this.createdAt,
    required this.nextAttemptAt,
    this.userId,
    this.syncedAt,
  });

  Map<String, dynamic> toMap() => {
        'local_id': localId,
        'type': type,
        'payload': payload,
        'status': status,
        'depends_on': dependsOn,
        'retry_count': retryCount,
        'last_error': lastError,
        'created_at': createdAt,
        'next_attempt_at': nextAttemptAt,
        'user_id': userId,
        'synced_at': syncedAt,
      };

  factory OutboxEntry.fromMap(Map<String, dynamic> m) => OutboxEntry(
        localId: m['local_id'] as String,
        type: m['type'] as String,
        payload: m['payload'] as String,
        status: m['status'] as String,
        dependsOn: m['depends_on'] as String?,
        retryCount: (m['retry_count'] as int?) ?? 0,
        lastError: m['last_error'] as String?,
        createdAt: m['created_at'] as int,
        nextAttemptAt: m['next_attempt_at'] as int,
        userId: m['user_id'] as String?,
        syncedAt: m['synced_at'] as int?,
      );

  /// Convenience: build an [OutboxEntry] directly from [PendingAction.toJson()].
  factory OutboxEntry.fromActionJson(
    Map<String, dynamic> actionJson, {
    String? dependsOn,
    String? userId,
  }) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final createdAtMs = () {
      final raw = actionJson['created_at'];
      if (raw is String) {
        return DateTime.tryParse(raw)?.millisecondsSinceEpoch ?? now;
      }
      return now;
    }();
    return OutboxEntry(
      localId: actionJson['local_id'] as String,
      type: actionJson['type'] as String,
      payload: jsonEncode(actionJson),
      status: 'pending',
      dependsOn: dependsOn,
      retryCount: 0,
      lastError: null,
      createdAt: createdAtMs,
      nextAttemptAt: 0,
      userId: userId,
    );
  }

  /// Decoded payload back to a [Map].
  Map<String, dynamic> get payloadMap =>
      jsonDecode(payload) as Map<String, dynamic>;

  OutboxEntry copyWith({
    String? status,
    int? retryCount,
    String? lastError,
    int? nextAttemptAt,
    int? syncedAt,
  }) =>
      OutboxEntry(
        localId: localId,
        type: type,
        payload: payload,
        status: status ?? this.status,
        dependsOn: dependsOn,
        retryCount: retryCount ?? this.retryCount,
        lastError: lastError ?? this.lastError,
        createdAt: createdAt,
        nextAttemptAt: nextAttemptAt ?? this.nextAttemptAt,
        userId: userId,
        syncedAt: syncedAt ?? this.syncedAt,
      );
}

// ── DAO ────────────────────────────────────────────────────────────────────

/// Typed CRUD over the [outbox] table.
class OutboxDao {
  OutboxDao(this._appDb);
  final AppDatabase _appDb;

  Future<Database> get _db => _appDb.db;

  // ── Write ────────────────────────────────────────────────────────────────

  Future<void> insert(OutboxEntry e) async {
    final db = await _db;
    await db.insert(
      'outbox',
      e.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> markInFlight(String localId) async {
    final db = await _db;
    await db.update(
      'outbox',
      {'status': 'in_flight'},
      where: 'local_id = ?',
      whereArgs: [localId],
    );
  }

  /// The action has been applied successfully. The row is kept as a
  /// short-lived recovery log (purged by [purgeSyncedOlderThan]) so a crash
  /// between server ack and local cache writes never loses the record.
  Future<void> markSynced(String localId, int syncedAtMs) async {
    final db = await _db;
    await db.update(
      'outbox',
      {'status': 'synced', 'synced_at': syncedAtMs},
      where: 'local_id = ?',
      whereArgs: [localId],
    );
  }

  /// Counted failure: increments retry_count.
  Future<void> markRetry(
      String localId, String error, int nextAttemptAtMs) async {
    final db = await _db;
    await db.rawUpdate(
      '''
      UPDATE outbox
      SET status = 'pending',
          retry_count = retry_count + 1,
          last_error = ?,
          next_attempt_at = ?
      WHERE local_id = ?
      ''',
      [error, nextAttemptAtMs, localId],
    );
  }

  /// Transient network failure: reschedules WITHOUT consuming the retry
  /// budget — connectivity blips must never push an entry toward 'dead'.
  Future<void> markRetryNoCount(String localId, int nextAttemptAtMs) async {
    final db = await _db;
    await db.update(
      'outbox',
      {'status': 'pending', 'next_attempt_at': nextAttemptAtMs},
      where: 'local_id = ?',
      whereArgs: [localId],
    );
  }

  Future<void> markDead(String localId, String error) async {
    final db = await _db;
    await db.update(
      'outbox',
      {'status': 'dead', 'last_error': error},
      where: 'local_id = ?',
      whereArgs: [localId],
    );
  }

  Future<void> resetRetry(String localId) async {
    final db = await _db;
    await db.update(
      'outbox',
      {'status': 'pending', 'retry_count': 0, 'next_attempt_at': 0},
      where: 'local_id = ?',
      whereArgs: [localId],
    );
  }

  /// Permanently deletes the row (user-initiated discard).
  Future<void> discard(String localId) async {
    final db = await _db;
    await db.delete('outbox', where: 'local_id = ?', whereArgs: [localId]);
  }

  /// Crash recovery: rows left 'in_flight' by a kill mid-drain would
  /// otherwise be invisible to [dueForSync] forever.
  Future<void> recoverInFlight() async {
    final db = await _db;
    await db.update(
      'outbox',
      {'status': 'pending'},
      where: 'status = ?',
      whereArgs: ['in_flight'],
    );
  }

  /// Drops synced recovery-log rows older than [cutoffMs].
  Future<void> purgeSyncedOlderThan(int cutoffMs) async {
    final db = await _db;
    await db.delete(
      'outbox',
      where: "status = 'synced' AND synced_at IS NOT NULL AND synced_at < ?",
      whereArgs: [cutoffMs],
    );
  }

  // ── Read ─────────────────────────────────────────────────────────────────

  /// All non-synced rows — used to hydrate notifier state on startup.
  Future<List<OutboxEntry>> loadAll() async {
    final db = await _db;
    final rows = await db.query(
      'outbox',
      where: "status != 'synced'",
      orderBy: 'created_at ASC',
    );
    return rows.map(OutboxEntry.fromMap).toList();
  }

  /// Rows that are pending and ready to be attempted (next_attempt_at ≤ now),
  /// ordered oldest-first to preserve causal ordering.
  ///
  /// When [userId] is given, entries enqueued by a different user are
  /// excluded — the backend attributes actions to the JWT holder, so syncing
  /// another teller's queue would mis-attribute their orders. Legacy rows
  /// with NULL user_id are always included.
  Future<List<OutboxEntry>> dueForSync(int nowMs, {String? userId}) async {
    final db = await _db;
    final where = StringBuffer('status = ? AND next_attempt_at <= ?');
    final args = <Object?>['pending', nowMs];
    if (userId != null) {
      where.write(' AND (user_id IS NULL OR user_id = ?)');
      args.add(userId);
    }
    final rows = await db.query(
      'outbox',
      where: where.toString(),
      whereArgs: args,
      orderBy: 'created_at ASC',
    );
    return rows.map(OutboxEntry.fromMap).toList();
  }

  /// Current status of a row, or null if it no longer exists (discarded).
  Future<String?> statusOf(String localId) async {
    final db = await _db;
    final rows = await db.query(
      'outbox',
      columns: ['status'],
      where: 'local_id = ?',
      whereArgs: [localId],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return rows.first['status'] as String?;
  }

  /// True while any order/void is still pending or in flight. A shift close
  /// must not reach the server before the shift's sales have.
  Future<bool> hasLiveOrdersOrVoids() async {
    final db = await _db;
    final rows = await db.rawQuery(
      '''
      SELECT 1 FROM outbox
      WHERE status IN ('pending', 'in_flight')
        AND type IN (?, ?)
      LIMIT 1
      ''',
      ['order', 'voidOrder'],
    );
    return rows.isNotEmpty;
  }
}

// ── Provider ───────────────────────────────────────────────────────────────

final outboxDaoProvider = Provider<OutboxDao>(
  (_) => throw UnimplementedError('outboxDaoProvider must be overridden'),
);
