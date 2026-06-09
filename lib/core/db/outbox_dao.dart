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
  final String status; // pending|in_flight|failed|dead
  final String? dependsOn; // localId of prerequisite action
  final int retryCount;
  final String? lastError;
  final int createdAt; // epoch ms
  final int nextAttemptAt; // epoch ms; 0 = ready now

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
      );

  /// Convenience: build an [OutboxEntry] directly from [PendingAction.toJson()].
  factory OutboxEntry.fromActionJson(
    Map<String, dynamic> actionJson, {
    String? dependsOn,
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

  /// Deletes the row — the action has been applied successfully.
  Future<void> markSynced(String localId) async {
    final db = await _db;
    await db.delete('outbox', where: 'local_id = ?', whereArgs: [localId]);
  }

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

  // ── Read ─────────────────────────────────────────────────────────────────

  /// All rows — used to hydrate notifier state on startup.
  Future<List<OutboxEntry>> loadAll() async {
    final db = await _db;
    final rows = await db.query('outbox', orderBy: 'created_at ASC');
    return rows.map(OutboxEntry.fromMap).toList();
  }

  /// Rows that are [pending] and ready to be attempted (next_attempt_at ≤ now),
  /// ordered oldest-first to preserve causal ordering.
  Future<List<OutboxEntry>> dueForSync(int nowMs) async {
    final db = await _db;
    final rows = await db.query(
      'outbox',
      where: 'status = ? AND next_attempt_at <= ?',
      whereArgs: ['pending', nowMs],
      orderBy: 'created_at ASC',
    );
    return rows.map(OutboxEntry.fromMap).toList();
  }

  /// True if a non-synced row with [localId] still exists in the table.
  Future<bool> existsLive(String localId) async {
    final db = await _db;
    final rows = await db.query(
      'outbox',
      columns: ['local_id'],
      where: 'local_id = ?',
      whereArgs: [localId],
      limit: 1,
    );
    return rows.isNotEmpty;
  }
}

// ── Provider ───────────────────────────────────────────────────────────────

final outboxDaoProvider = Provider<OutboxDao>(
  (_) => throw UnimplementedError('outboxDaoProvider must be overridden'),
);
