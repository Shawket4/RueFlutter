import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sufrix_pos/core/db/app_database.dart';
import 'package:sufrix_pos/core/db/outbox_dao.dart';

void main() {
  sqfliteFfiInit();

  late Database db;
  late OutboxDao dao;

  OutboxEntry entry({
    required String id,
    String type = 'order',
    String status = 'pending',
    String? dependsOn,
    int retryCount = 0,
    int createdAt = 1000,
    int nextAttemptAt = 0,
    String? userId,
    Map<String, dynamic>? payload,
  }) =>
      OutboxEntry(
        localId: id,
        type: type,
        payload: jsonEncode(payload ?? {'local_id': id, 'type': type}),
        status: status,
        dependsOn: dependsOn,
        retryCount: retryCount,
        createdAt: createdAt,
        nextAttemptAt: nextAttemptAt,
        userId: userId,
      );

  setUp(() async {
    db = await databaseFactoryFfi.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(singleInstance: false),
    );
    await AppDatabase.createSchema(db);
    dao = OutboxDao(AppDatabase.forTesting(db));
  });

  tearDown(() async => db.close());

  group('retry accounting', () {
    test('markRetry increments retry_count, markRetryNoCount does not',
        () async {
      await dao.insert(entry(id: 'a'));

      await dao.markRetryNoCount('a', 5000);
      var rows = await db.query('outbox');
      expect(rows.first['retry_count'], 0,
          reason: 'network blips must not consume the retry budget');
      expect(rows.first['next_attempt_at'], 5000);
      expect(rows.first['status'], 'pending');

      await dao.markRetry('a', 'boom', 9000);
      rows = await db.query('outbox');
      expect(rows.first['retry_count'], 1);
      expect(rows.first['last_error'], 'boom');
    });
  });

  group('synced recovery log', () {
    test('markSynced keeps the row; loadAll and dueForSync exclude it',
        () async {
      await dao.insert(entry(id: 'a'));
      await dao.markSynced('a', 123456);

      final raw = await db.query('outbox');
      expect(raw, hasLength(1), reason: 'synced rows are kept as a log');
      expect(raw.first['status'], 'synced');
      expect(raw.first['synced_at'], 123456);

      expect(await dao.loadAll(), isEmpty);
      expect(await dao.dueForSync(999999999), isEmpty);
    });

    test('purgeSyncedOlderThan removes only old synced rows', () async {
      await dao.insert(entry(id: 'old'));
      await dao.insert(entry(id: 'new'));
      await dao.insert(entry(id: 'live'));
      await dao.markSynced('old', 1000);
      await dao.markSynced('new', 9000);

      await dao.purgeSyncedOlderThan(5000);

      final ids = (await db.query('outbox')).map((r) => r['local_id']).toSet();
      expect(ids, {'new', 'live'});
    });
  });

  group('crash recovery', () {
    test('recoverInFlight resets in_flight rows to pending', () async {
      await dao.insert(entry(id: 'a'));
      await dao.markInFlight('a');
      expect(await dao.dueForSync(999999), isEmpty,
          reason: 'in_flight rows are invisible to the drain');

      await dao.recoverInFlight();

      final due = await dao.dueForSync(999999);
      expect(due, hasLength(1));
      expect(due.first.localId, 'a');
    });
  });

  group('dueForSync', () {
    test('orders oldest-first, respects next_attempt_at', () async {
      await dao.insert(entry(id: 'late', createdAt: 1, nextAttemptAt: 99999));
      await dao.insert(entry(id: 'b', createdAt: 300));
      await dao.insert(entry(id: 'a', createdAt: 100));
      await dao.insert(entry(id: 'dead', createdAt: 50, status: 'dead'));

      final due = await dao.dueForSync(1000);
      expect(due.map((e) => e.localId).toList(), ['a', 'b']);
    });

    test('filters by user but always includes legacy NULL rows', () async {
      await dao.insert(entry(id: 'mine', userId: 'u1'));
      await dao.insert(entry(id: 'theirs', userId: 'u2'));
      await dao.insert(entry(id: 'legacy'));

      final due = await dao.dueForSync(1000, userId: 'u1');
      expect(due.map((e) => e.localId).toSet(), {'mine', 'legacy'});
    });
  });

  group('dependency helpers', () {
    test('statusOf returns status or null when discarded', () async {
      await dao.insert(entry(id: 'a'));
      expect(await dao.statusOf('a'), 'pending');
      await dao.markDead('a', 'err');
      expect(await dao.statusOf('a'), 'dead');
      await dao.discard('a');
      expect(await dao.statusOf('a'), isNull);
    });

    test('hasLiveOrdersOrVoids ignores dead/synced and other types',
        () async {
      await dao.insert(entry(id: 's1', type: 'shiftOpen'));
      expect(await dao.hasLiveOrdersOrVoids(), isFalse);

      await dao.insert(entry(id: 'o1', type: 'order'));
      expect(await dao.hasLiveOrdersOrVoids(), isTrue);

      await dao.markDead('o1', 'err');
      expect(await dao.hasLiveOrdersOrVoids(), isFalse);

      await dao.insert(entry(id: 'v1', type: 'voidOrder'));
      expect(await dao.hasLiveOrdersOrVoids(), isTrue);
      await dao.markSynced('v1', 100);
      expect(await dao.hasLiveOrdersOrVoids(), isFalse);
    });
  });

  group('schema v2 migration', () {
    test('v1 outbox table upgrades in place (user_id, synced_at, in_flight)',
        () async {
      // Build a stand-alone v1 database, then re-open it at v2 with the same
      // upgrade SQL AppDatabase uses.
      final mig = await databaseFactoryFfi.openDatabase(
        inMemoryDatabasePath,
        options: OpenDatabaseOptions(
          singleInstance: false,
          version: 1,
          onCreate: (d, v) async {
            await d.execute('''
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
          },
        ),
      );
      await mig.insert('outbox', {
        'local_id': 'stuck',
        'type': 'order',
        'payload': '{}',
        'status': 'in_flight',
        'retry_count': 0,
        'created_at': 1,
        'next_attempt_at': 0,
      });

      // Same statements as AppDatabase._onUpgrade for v2.
      await mig.execute('ALTER TABLE outbox ADD COLUMN user_id TEXT');
      await mig.execute('ALTER TABLE outbox ADD COLUMN synced_at INTEGER');
      await mig.execute(
          "UPDATE outbox SET status = 'pending' WHERE status = 'in_flight'");

      final migratedDao = OutboxDao(AppDatabase.forTesting(mig));
      final due = await migratedDao.dueForSync(1000);
      expect(due, hasLength(1));
      expect(due.first.localId, 'stuck');
      expect(due.first.status, 'pending');
      expect(due.first.userId, isNull);
      await mig.close();
    });
  });
}
