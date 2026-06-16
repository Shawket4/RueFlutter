import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sufrix_pos/core/api/order_api.dart';
import 'package:sufrix_pos/core/api/shift_api.dart';
import 'package:sufrix_pos/core/db/app_database.dart';
import 'package:sufrix_pos/core/db/outbox_dao.dart';
import 'package:sufrix_pos/core/models/order.dart';
import 'package:sufrix_pos/core/models/pending_action.dart';
import 'package:sufrix_pos/core/models/shift.dart';
import 'package:sufrix_pos/core/models/user.dart';
import 'package:sufrix_pos/core/providers/auth_notifier.dart';
import 'package:sufrix_pos/core/services/offline_queue.dart';

class MockOrderApi extends Mock implements OrderApi {}

class MockShiftApi extends Mock implements ShiftApi {}

class _FakeAuth extends AuthNotifier {
  @override
  AuthState build() => AuthState(
        isLoading: false,
        user:
            User(id: 'u1', name: 'Teller', role: UserRole.teller, isActive: true),
      );
}

DioException dioStatus(int code) => DioException(
      requestOptions: RequestOptions(path: '/x'),
      response:
          Response(requestOptions: RequestOptions(path: '/x'), statusCode: code),
      type: DioExceptionType.badResponse,
    );

DioException dioNetwork() => DioException(
      requestOptions: RequestOptions(path: '/x'),
      type: DioExceptionType.connectionError,
    );

Order order(String id) => Order(
      id: id,
      branchId: 'b1',
      shiftId: 's1',
      tellerId: 'u1',
      tellerName: 'Teller',
      orderType: 'dine_in',
      deliveryFee: 0,
      orderNumber: 1,
      status: 'completed',
      paymentMethod: 'cash',
      subtotal: 100,
      discountValue: 0,
      discountAmount: 0,
      taxAmount: 0,
      totalAmount: 100,
      createdAt: DateTime.utc(2026, 1, 1),
      items: const [],
    );

Shift shift(String id) => Shift(
      id: id,
      branchId: 'b1',
      tellerId: 'u1',
      tellerName: 'Teller',
      status: 'open',
      openingCash: 0,
      openingCashWasEdited: false,
      openedAt: DateTime.utc(2026, 1, 1),
    );

PendingOrder pendingOrder(String id, {String shiftId = 's1'}) => PendingOrder(
      localId: id,
      createdAt: DateTime.utc(2026, 1, 1),
      branchId: 'b1',
      shiftId: shiftId,
      paymentMethod: 'cash',
      items: const [],
      orderedAt: DateTime.utc(2026, 1, 1),
    );

PendingShiftOpen pendingShiftOpen(String id, {String shiftId = 's1'}) =>
    PendingShiftOpen(
      localId: id,
      createdAt: DateTime.utc(2026, 1, 1),
      branchId: 'b1',
      shiftId: shiftId,
      openingCash: 0,
      openedAt: DateTime.utc(2026, 1, 1),
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();

  late Database db;
  late OutboxDao dao;
  late MockOrderApi orderApi;
  late MockShiftApi shiftApi;
  late ProviderContainer container;

  OfflineQueueNotifier queue() => container.read(offlineQueueProvider.notifier);
  OfflineQueueState state() => container.read(offlineQueueProvider);

  setUp(() async {
    db = await databaseFactoryFfi.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(singleInstance: false),
    );
    await AppDatabase.createSchema(db);
    dao = OutboxDao(AppDatabase.forTesting(db));
    orderApi = MockOrderApi();
    shiftApi = MockShiftApi();
    container = ProviderContainer(overrides: [
      outboxDaoProvider.overrideWithValue(dao),
      orderApiProvider.overrideWithValue(orderApi),
      shiftApiProvider.overrideWithValue(shiftApi),
      authProvider.overrideWith(_FakeAuth.new),
    ]);
    // ConnectivityService.instance.isOnline defaults to true (init() never
    // called in tests), so drains run.
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  void mockOrderCreateSuccess() {
    when(() => orderApi.create(
          branchId: any(named: 'branchId'),
          shiftId: any(named: 'shiftId'),
          items: any(named: 'items'),
          paymentMethod: any(named: 'paymentMethod'),
          customerName: any(named: 'customerName'),
          notes: any(named: 'notes'),
          discountType: any(named: 'discountType'),
          discountValue: any(named: 'discountValue'),
          discountId: any(named: 'discountId'),
          amountTendered: any(named: 'amountTendered'),
          tipAmount: any(named: 'tipAmount'),
          tipPaymentMethod: any(named: 'tipPaymentMethod'),
          paymentSplits: any(named: 'paymentSplits'),
          idempotencyKey: any(named: 'idempotencyKey'),
          createdAt: any(named: 'createdAt'),
        )).thenAnswer((_) async => order('server-1'));
  }

  void mockOrderCreateError(Object e) {
    when(() => orderApi.create(
          branchId: any(named: 'branchId'),
          shiftId: any(named: 'shiftId'),
          items: any(named: 'items'),
          paymentMethod: any(named: 'paymentMethod'),
          customerName: any(named: 'customerName'),
          notes: any(named: 'notes'),
          discountType: any(named: 'discountType'),
          discountValue: any(named: 'discountValue'),
          discountId: any(named: 'discountId'),
          amountTendered: any(named: 'amountTendered'),
          tipAmount: any(named: 'tipAmount'),
          tipPaymentMethod: any(named: 'tipPaymentMethod'),
          paymentSplits: any(named: 'paymentSplits'),
          idempotencyKey: any(named: 'idempotencyKey'),
          createdAt: any(named: 'createdAt'),
        )).thenThrow(e);
  }

  void verifyOrderCreateNever() {
    verifyNever(() => orderApi.create(
          branchId: any(named: 'branchId'),
          shiftId: any(named: 'shiftId'),
          items: any(named: 'items'),
          paymentMethod: any(named: 'paymentMethod'),
          customerName: any(named: 'customerName'),
          notes: any(named: 'notes'),
          discountType: any(named: 'discountType'),
          discountValue: any(named: 'discountValue'),
          discountId: any(named: 'discountId'),
          amountTendered: any(named: 'amountTendered'),
          tipAmount: any(named: 'tipAmount'),
          tipPaymentMethod: any(named: 'tipPaymentMethod'),
          paymentSplits: any(named: 'paymentSplits'),
          idempotencyKey: any(named: 'idempotencyKey'),
          createdAt: any(named: 'createdAt'),
        ));
  }

  Future<Map<Object?, Object?>> statuses() async => {
        for (final r in await db.query('outbox')) r['local_id']: r['status']
      };

  test('successful drain marks entry synced and keeps recovery-log row',
      () async {
    mockOrderCreateSuccess();
    Order? syncedOrder;
    queue().onOrderSynced = (o, localId) => syncedOrder = o;

    await queue().enqueueOrder(pendingOrder('o1'));
    await queue().syncAll();

    expect(syncedOrder?.id, 'server-1');
    expect(state().totalCount, 0);
    final rows = await db.query('outbox');
    expect(rows.single['status'], 'synced');
  });

  test('401 pauses the queue without consuming retries; resumeAfterAuth drains',
      () async {
    mockOrderCreateError(dioStatus(401));

    await queue().enqueueOrder(pendingOrder('o1'));
    await queue().syncAll();

    expect(state().authPaused, isTrue);
    final row = (await db.query('outbox')).single;
    expect(row['status'], 'pending');
    expect(row['retry_count'], 0, reason: '401 must not burn retry budget');

    // Drains are no-ops while paused.
    await queue().syncAll();
    expect((await db.query('outbox')).single['status'], 'pending');

    // Fresh token → resume.
    mockOrderCreateSuccess();
    queue().resumeAfterAuth();
    await Future<void>.delayed(const Duration(milliseconds: 100));
    expect(state().authPaused, isFalse);
    expect((await db.query('outbox')).single['status'], 'synced');
  });

  test('permanent 4xx dead-letters immediately (no 8-retry poison)', () async {
    mockOrderCreateError(dioStatus(422));

    await queue().enqueueOrder(pendingOrder('o1'));
    await queue().syncAll();

    final row = (await db.query('outbox')).single;
    expect(row['status'], 'dead');
    expect(state().stuckCount, 1);
  });

  test('network error reschedules without retry-count increment', () async {
    mockOrderCreateError(dioNetwork());

    await queue().enqueueOrder(pendingOrder('o1'));
    await queue().syncAll();

    final row = (await db.query('outbox')).single;
    expect(row['status'], 'pending');
    expect(row['retry_count'], 0);
    expect(row['next_attempt_at'], greaterThan(0));
  });

  test('404 on a void is NOT treated as success — dead-letters instead',
      () async {
    when(() => orderApi.voidOrder(any(),
            reason: any(named: 'reason'),
            restoreInventory: any(named: 'restoreInventory'),
            voidedAt: any(named: 'voidedAt')))
        .thenThrow(dioStatus(404));

    await queue().enqueueVoid(PendingVoidOrder(
      localId: 'v1',
      createdAt: DateTime.utc(2026, 1, 1),
      orderId: 'no-such-order',
      reason: 'wrong order',
      restoreInventory: false,
      voidedAt: DateTime.utc(2026, 1, 1),
    ));
    await queue().syncAll();

    expect((await db.query('outbox')).single['status'], 'dead');
  });

  test('order-create 409 (shift closed) dead-letters — never silently dropped',
      () async {
    // The backend returns 409 ONLY when the order was genuinely not recorded
    // (an idempotency replay of a saved order returns 200). Treating it as
    // success would lose the sale silently while the cash sits in the drawer.
    mockOrderCreateError(dioStatus(409));
    var reportedSynced = false;
    queue().onOrderSynced = (_, __) => reportedSynced = true;

    await queue().enqueueOrder(pendingOrder('o1'));
    await queue().syncAll();

    final row = (await db.query('outbox')).single;
    expect(row['status'], 'dead',
        reason: 'a 409 order must surface as stuck, not be dropped as success');
    expect(state().stuckCount, 1);
    expect(reportedSynced, isFalse,
        reason: 'an unrecorded order must never be reported as synced');
  });

  test('shift-open 409 dead-letters and fires the reject callback', () async {
    when(() => shiftApi.openWithId(
          branchId: any(named: 'branchId'),
          shiftId: any(named: 'shiftId'),
          openingCash: any(named: 'openingCash'),
          openedAt: any(named: 'openedAt'),
        )).thenThrow(dioStatus(409));
    String? rejectedShift;
    String? rejectedBranch;
    queue().onShiftOpenRejected = (s, b) {
      rejectedShift = s;
      rejectedBranch = b;
    };

    await queue().enqueueShiftOpen(pendingShiftOpen('so1', shiftId: 's9'));
    await queue().syncAll();

    expect((await db.query('outbox')).single['status'], 'dead',
        reason: 'a rejected open must surface, not silently succeed');
    expect(rejectedShift, 's9',
        reason: 'the app is told which phantom shift to clear');
    expect(rejectedBranch, 'b1');
  });

  test('order waits for its shift-open prerequisite; syncs after it', () async {
    when(() => shiftApi.openWithId(
          branchId: any(named: 'branchId'),
          shiftId: any(named: 'shiftId'),
          openingCash: any(named: 'openingCash'),
          openedAt: any(named: 'openedAt'),
        )).thenThrow(dioNetwork());
    mockOrderCreateSuccess();

    await queue().enqueueShiftOpen(pendingShiftOpen('so1'));
    await queue().enqueueOrder(pendingOrder('o1'));
    await queue().syncAll();

    verifyOrderCreateNever();

    when(() => shiftApi.openWithId(
          branchId: any(named: 'branchId'),
          shiftId: any(named: 'shiftId'),
          openingCash: any(named: 'openingCash'),
          openedAt: any(named: 'openedAt'),
        )).thenAnswer((_) async => shift('s1'));
    await dao.markRetryNoCount('so1', 0);
    await queue().syncAll();

    final s = await statuses();
    expect(s['so1'], 'synced');
    expect(s['o1'], 'synced');
  });

  test('dead prerequisite dead-letters dependents instead of blocking forever',
      () async {
    when(() => shiftApi.openWithId(
          branchId: any(named: 'branchId'),
          shiftId: any(named: 'shiftId'),
          openingCash: any(named: 'openingCash'),
          openedAt: any(named: 'openedAt'),
        )).thenThrow(dioNetwork());

    await queue().enqueueShiftOpen(pendingShiftOpen('so1'));
    await queue().enqueueOrder(pendingOrder('o1'));
    // Settle the enqueue-triggered drains before mutating rows directly,
    // or their markRetry can overwrite the markDead below.
    await queue().syncAll();
    await dao.markDead('so1', 'validation failed');

    await queue().syncAll();

    expect((await statuses())['o1'], 'dead',
        reason: 'order can never succeed once its shift-open died');
  });

  test('shift close waits until orders/voids are gone', () async {
    mockOrderCreateError(dioNetwork()); // order stays live
    when(() => shiftApi.close(any(),
            closingCash: any(named: 'closingCash'),
            note: any(named: 'note'),
            inventoryCounts: any(named: 'inventoryCounts'),
            closedAt: any(named: 'closedAt')))
        .thenAnswer((_) async => shift('s1'));

    await queue().enqueueOrder(pendingOrder('o1'));
    await queue().enqueueShiftClose(PendingShiftClose(
      localId: 'sc1',
      createdAt: DateTime.utc(2026, 1, 2),
      branchId: 'b1',
      shiftId: 's1',
      closingCash: 0,
      inventoryCounts: const [],
      closedAt: DateTime.utc(2026, 1, 2),
    ));
    await queue().syncAll();

    verifyNever(() => shiftApi.close(any(),
        closingCash: any(named: 'closingCash'),
        note: any(named: 'note'),
        inventoryCounts: any(named: 'inventoryCounts'),
        closedAt: any(named: 'closedAt')));

    mockOrderCreateSuccess();
    await dao.markRetryNoCount('o1', 0);
    await queue().syncAll();

    final s = await statuses();
    expect(s['o1'], 'synced');
    expect(s['sc1'], 'synced');
  });

  test('void of a still-queued order depends on it and follows it', () async {
    mockOrderCreateSuccess();
    when(() => orderApi.voidOrder(any(),
            reason: any(named: 'reason'),
            restoreInventory: any(named: 'restoreInventory'),
            voidedAt: any(named: 'voidedAt')))
        .thenAnswer((_) async => order('server-1'));

    // Offline-created order uses its localId as the optimistic order id.
    await queue().enqueueOrder(pendingOrder('o1'));
    await queue().enqueueVoid(PendingVoidOrder(
      localId: 'v1',
      createdAt: DateTime.utc(2026, 1, 1, 1),
      orderId: 'o1',
      reason: 'wrong order',
      restoreInventory: false,
      voidedAt: DateTime.utc(2026, 1, 1, 1),
    ));

    final voidRow = (await db.query('outbox',
            where: "local_id = 'v1'"))
        .single;
    expect(voidRow['depends_on'], 'o1',
        reason: 'void must wait for the order it targets');

    await queue().syncAll();
    final s = await statuses();
    expect(s['o1'], 'synced');
    expect(s['v1'], 'synced');
  });

  test('enqueueVoid refuses to void an order whose sync already died',
      () async {
    mockOrderCreateError(dioNetwork());
    await queue().enqueueOrder(pendingOrder('o1'));
    // Settle the enqueue-triggered drain before mutating the row directly.
    await queue().syncAll();
    await dao.markDead('o1', 'rejected');

    // The in-memory entry is still 'pending', so this attaches a dependency;
    // the drain's dead-prerequisite rule must then dead-letter the void.
    await queue().enqueueVoid(PendingVoidOrder(
      localId: 'v1',
      createdAt: DateTime.utc(2026, 1, 1),
      orderId: 'o1',
      reason: 'wrong order',
      restoreInventory: false,
      voidedAt: DateTime.utc(2026, 1, 1),
    ));
    await queue().syncAll();

    expect((await statuses())['v1'], 'dead');
  });
}
