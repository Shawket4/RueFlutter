import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/order_api.dart';
import '../api/shift_api.dart';
import '../api/client.dart';
import '../db/outbox_dao.dart';
import '../models/order.dart';
import '../models/pending_action.dart';
import '../models/shift.dart';
import 'connectivity_service.dart';

// ── Constants ───────────────────────────────────────────────────────────────

const _kMaxRetries = 8;
const _kBaseBackoffMs = 2000; // 2s
const _kMaxBackoffMs  = 300000; // 5min

// ── State ────────────────────────────────────────────────────────────────────

class OfflineQueueState {
  final List<OutboxEntry> _entries;
  final bool isSyncing;

  const OfflineQueueState({
    List<OutboxEntry> entries = const [],
    this.isSyncing = false,
  }) : _entries = entries;

  OfflineQueueState copyWith({
    List<OutboxEntry>? entries,
    bool? isSyncing,
  }) =>
      OfflineQueueState(
        entries: entries ?? _entries,
        isSyncing: isSyncing ?? this.isSyncing,
      );

  // Expose entries for UI (read-only view).
  List<OutboxEntry> get entries => List.unmodifiable(_entries);

  // ── Computed counts (preserved from original public surface) ───────────────

  int get orderCount =>
      _entries.where((e) => e.type == PendingActionType.order.name && e.status != 'dead').length;

  int get shiftOpenCount =>
      _entries.where((e) => e.type == PendingActionType.shiftOpen.name && e.status != 'dead').length;

  int get shiftCloseCount =>
      _entries.where((e) => e.type == PendingActionType.shiftClose.name && e.status != 'dead').length;

  int get voidCount =>
      _entries.where((e) => e.type == PendingActionType.voidOrder.name && e.status != 'dead').length;

  int get cashCount =>
      _entries.where((e) => e.type == PendingActionType.cashMovement.name && e.status != 'dead').length;

  int get totalCount => orderCount + shiftOpenCount + shiftCloseCount + voidCount + cashCount;

  bool get isEmpty => totalCount == 0;

  /// Number of permanently dead (exhausted-retry) entries.
  int get stuckCount => _entries.where((e) => e.status == 'dead').length;

  bool get hasStuck => stuckCount > 0;
}

// ── Notifier ─────────────────────────────────────────────────────────────────

class OfflineQueueNotifier extends Notifier<OfflineQueueState> {
  // ── Lifecycle callbacks (set from main.dart) ──────────────────────────────

  /// Called when a queued order has been confirmed by the server.
  void Function(Order order, String localId)? onOrderSynced;

  /// Called when a queued shift-open has been confirmed.
  void Function(Shift shift)? onShiftOpenSynced;

  /// Called when a queued shift-close has been confirmed.
  void Function(Shift shift)? onShiftCloseSynced;

  /// Called when a queued void has been confirmed.
  void Function(Order order)? onVoidSynced;

  // ── Internal ──────────────────────────────────────────────────────────────

  StreamSubscription<bool>? _connectivitySub;
  Timer? _drainTimer;
  bool _drainRunning = false;

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  OfflineQueueState build() {
    ref.onDispose(() {
      _connectivitySub?.cancel();
      _drainTimer?.cancel();
    });
    return const OfflineQueueState();
  }

  // ── Init ──────────────────────────────────────────────────────────────────

  /// Must be called once from main.dart after ProviderScope is up.
  Future<void> init() async {
    // Hydrate in-memory state from the durable outbox table.
    final entries = await ref.read(outboxDaoProvider).loadAll();
    state = state.copyWith(entries: entries);

    // Subscribe to connectivity stream → drain when we come online.
    _connectivitySub = ConnectivityService.instance.stream.listen((online) {
      if (online) _drain();
    });

    // Always-on 15-second drain tick so in-flight failures get retried promptly.
    _drainTimer = Timer.periodic(const Duration(seconds: 15), (_) => _drain());

    // Drain immediately if we're already online.
    if (ConnectivityService.instance.isOnline) _drain();
  }

  // ── Public enqueue methods ─────────────────────────────────────────────────

  Future<void> enqueueShiftOpen(PendingShiftOpen action) async {
    final entry = OutboxEntry.fromActionJson(action.toJson());
    await ref.read(outboxDaoProvider).insert(entry);
    state = state.copyWith(entries: [...state._entries, entry]);
    _drain();
  }

  Future<void> enqueueOrder(PendingOrder action) async {
    // Attach dependency on any live PendingShiftOpen for the same shift.
    final dependsOn = _findLiveShiftOpen(action.shiftId);
    final entry = OutboxEntry.fromActionJson(action.toJson(), dependsOn: dependsOn);
    await ref.read(outboxDaoProvider).insert(entry);
    state = state.copyWith(entries: [...state._entries, entry]);
    _drain();
  }

  Future<void> enqueueShiftClose(PendingShiftClose action) async {
    final dependsOn = _findLiveShiftOpen(action.shiftId);
    final entry = OutboxEntry.fromActionJson(action.toJson(), dependsOn: dependsOn);
    await ref.read(outboxDaoProvider).insert(entry);
    state = state.copyWith(entries: [...state._entries, entry]);
    _drain();
  }

  Future<void> enqueueVoid(PendingVoidOrder action) async {
    final entry = OutboxEntry.fromActionJson(action.toJson());
    await ref.read(outboxDaoProvider).insert(entry);
    state = state.copyWith(entries: [...state._entries, entry]);
    _drain();
  }

  /// Cash movements are ONLINE-ONLY.
  ///
  /// This method signature is preserved so call sites don't break; however
  /// calling it while offline throws [OfflineCashMovementError].
  /// [CashMovementSheet] must guard against this before calling.
  Future<void> enqueueCashMovement(PendingCashMovement action) async {
    if (!ConnectivityService.instance.isOnline) {
      throw const OfflineCashMovementError();
    }
    // If somehow called while online, fire immediately — never queue.
    final shiftApi = ref.read(shiftApiProvider);
    await shiftApi.addCashMovement(action.shiftId, action.amount, action.note);
  }

  // ── Public management methods ──────────────────────────────────────────────

  Future<void> discard(String localId) async {
    await ref.read(outboxDaoProvider).discard(localId);
    state = state.copyWith(
      entries: state._entries.where((e) => e.localId != localId).toList(),
    );
  }

  Future<void> resetRetry(String localId) async {
    await ref.read(outboxDaoProvider).resetRetry(localId);
    final updated = state._entries.map((e) =>
        e.localId == localId
            ? e.copyWith(status: 'pending', retryCount: 0, nextAttemptAt: 0)
            : e).toList();
    state = state.copyWith(entries: updated);
    _drain();
  }

  // ── Drain ─────────────────────────────────────────────────────────────────

  /// Public alias so existing callers (e.g. PendingOrdersScreen sync button) continue to work.
  Future<void> syncAll() => _drain();

  Future<void> _drain() async {
    if (_drainRunning) return;
    if (!ConnectivityService.instance.isOnline) return;

    _drainRunning = true;
    state = state.copyWith(isSyncing: true);

    try {
      final dao = ref.read(outboxDaoProvider);
      final nowMs = DateTime.now().millisecondsSinceEpoch;
      final due = await dao.dueForSync(nowMs);

      for (final entry in due) {
        if (!ConnectivityService.instance.isOnline) break;

        // Skip if prerequisite is still live.
        if (entry.dependsOn != null) {
          final prereqLive = await dao.existsLive(entry.dependsOn!);
          if (prereqLive) continue;
        }

        await dao.markInFlight(entry.localId);
        _updateEntryInState(entry.copyWith(status: 'in_flight'));

        try {
          await _processEntry(entry);
          await dao.markSynced(entry.localId);
          state = state.copyWith(
            entries: state._entries
                .where((e) => e.localId != entry.localId)
                .toList(),
          );
        } on DioException catch (e) {
          final status = e.response?.statusCode;
          if (status == 409 || status == 404) {
            // Already applied — treat as success.
            await dao.markSynced(entry.localId);
            state = state.copyWith(
              entries: state._entries
                  .where((e) => e.localId != entry.localId)
                  .toList(),
            );
          } else if (isNetworkError(e)) {
            // Quietly fail for network errors; do not increment retry count.
            await dao.markRetry(entry.localId, '', nowMs + 15000);
            _updateEntryInState(entry.copyWith(status: 'pending'));
          } else {
            await _handleFailure(dao, entry, nowMs, e);
          }
        } catch (e) {
          if (isNetworkError(e)) {
            await dao.markRetry(entry.localId, '', nowMs + 15000);
            _updateEntryInState(entry.copyWith(status: 'pending'));
          } else {
            await _handleFailure(dao, entry, nowMs, e);
          }
        }
      }
    } finally {
      _drainRunning = false;
      state = state.copyWith(isSyncing: false);
    }
  }

  Future<void> _handleFailure(OutboxDao dao, OutboxEntry entry, int nowMs, Object e) async {
    final newRetryCount = entry.retryCount + 1;
    if (newRetryCount >= _kMaxRetries) {
      final errStr = e.toString();
      await dao.markDead(entry.localId, errStr);
      _updateEntryInState(entry.copyWith(status: 'dead', lastError: errStr));
    } else {
      final backoffMs = _computeBackoff(newRetryCount);
      final nextAttempt = nowMs + backoffMs;
      final errStr = e.toString();
      await dao.markRetry(entry.localId, errStr, nextAttempt);
      _updateEntryInState(entry.copyWith(
        status: 'pending',
        retryCount: newRetryCount,
        lastError: errStr,
        nextAttemptAt: nextAttempt,
      ));
    }
  }

  // ── Entry processing ───────────────────────────────────────────────────────

  Future<void> _processEntry(OutboxEntry entry) async {
    final payload = entry.payloadMap;
    final action = PendingAction.fromJson(payload);

    switch (action) {
      case PendingShiftOpen():
        final result = await ref.read(shiftApiProvider).openWithId(
              branchId: action.branchId,
              shiftId: action.shiftId,
              openingCash: action.openingCash,
              openedAt: action.openedAt,
            );
        onShiftOpenSynced?.call(result);

      case PendingOrder():
        var order = await ref.read(orderApiProvider).create(
              branchId: action.branchId,
              shiftId: action.shiftId,
              items: action.items,
              paymentMethod: action.paymentMethod,
              customerName: action.customerName,
              notes: action.notes,
              discountType: action.discountType,
              discountValue: action.discountValue,
              discountId: action.discountId,
              amountTendered: action.amountTendered,
              tipAmount: action.tipAmount,
              tipPaymentMethod: action.tipPaymentMethod,
              paymentSplits: action.paymentSplits,
              idempotencyKey: action.localId,
              createdAt: action.orderedAt,
        );
        
        // Task 1.6: Fix backend syncing bugs where create order endpoint might return 'mixed'
        // or an unrecognized casing for payment methods, but OrderApi.list returns the correct one.
        if (order.paymentMethod.isEmpty || order.paymentMethod.toLowerCase() == 'mixed') {
          if (action.paymentMethod.toLowerCase() != 'mixed') {
            order = order.copyWith(paymentMethod: action.paymentMethod);
          }
        }

        onOrderSynced?.call(order, action.localId);

      case PendingVoidOrder():
        final result = await ref.read(orderApiProvider).voidOrder(
              action.orderId,
              reason: action.reason,
              restoreInventory: action.restoreInventory,
            );
        onVoidSynced?.call(result);

      case PendingShiftClose():
        final result = await ref.read(shiftApiProvider).close(
              action.shiftId,
              closingCash: action.closingCash,
              note: action.cashNote,
              inventoryCounts: action.inventoryCounts,
            );
        onShiftCloseSynced?.call(result);

      case PendingCashMovement():
        await ref.read(shiftApiProvider).addCashMovement(
              action.shiftId,
              action.amount,
              action.note,
            );
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  /// Returns the [localId] of a live PendingShiftOpen for [shiftId], or null.
  String? _findLiveShiftOpen(String shiftId) {
    for (final e in state._entries) {
      if (e.type != 'PendingShiftOpen') continue;
      if (e.status == 'dead') continue;
      final payload = e.payloadMap;
      if (payload['shift_id'] == shiftId) return e.localId;
    }
    return null;
  }

  void _updateEntryInState(OutboxEntry updated) {
    state = state.copyWith(
      entries: state._entries
          .map((e) => e.localId == updated.localId ? updated : e)
          .toList(),
    );
  }

  /// Exponential backoff with jitter: BASE * 2^(retry-1) + rand(0..1000ms), capped at MAX.
  int _computeBackoff(int retryCount) {
    final exp = _kBaseBackoffMs * (1 << (retryCount - 1));
    final capped = exp.clamp(0, _kMaxBackoffMs);
    final jitter = Random().nextInt(1000);
    return (capped + jitter).clamp(0, _kMaxBackoffMs);
  }
}

// ── Errors ─────────────────────────────────────────────────────────────────

class OfflineCashMovementError implements Exception {
  const OfflineCashMovementError();
  @override
  String toString() =>
      'Cash movements require an internet connection. Please try again when online.';
}

// ── Provider ───────────────────────────────────────────────────────────────

final offlineQueueProvider =
    NotifierProvider<OfflineQueueNotifier, OfflineQueueState>(
        OfflineQueueNotifier.new);
