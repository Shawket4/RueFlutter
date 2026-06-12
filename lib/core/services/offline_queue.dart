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
import '../providers/auth_notifier.dart';
import 'connectivity_service.dart';

// ── Constants ───────────────────────────────────────────────────────────────

const _kMaxRetries = 8;
const _kBaseBackoffMs = 2000; // 2s
const _kMaxBackoffMs = 300000; // 5min
const _kNetworkRetryMs = 15000; // fixed reschedule for connectivity blips
const _kSyncedRetentionMs = 48 * 60 * 60 * 1000; // keep synced rows 48h

// ── State ────────────────────────────────────────────────────────────────────

class OfflineQueueState {
  final List<OutboxEntry> _entries;
  final bool isSyncing;

  /// True when a drain hit a 401: the queue is parked, consuming no retry
  /// budget, until the user signs in again ([OfflineQueueNotifier.resumeAfterAuth]).
  final bool authPaused;

  const OfflineQueueState({
    List<OutboxEntry> entries = const [],
    this.isSyncing = false,
    this.authPaused = false,
  }) : _entries = entries;

  OfflineQueueState copyWith({
    List<OutboxEntry>? entries,
    bool? isSyncing,
    bool? authPaused,
  }) =>
      OfflineQueueState(
        entries: entries ?? _entries,
        isSyncing: isSyncing ?? this.isSyncing,
        authPaused: authPaused ?? this.authPaused,
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

  /// Number of permanently dead (exhausted-retry / rejected) entries.
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
  Future<void>? _drainFuture;

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
    final dao = ref.read(outboxDaoProvider);

    // Crash recovery: rows stranded in_flight are otherwise never retried.
    await dao.recoverInFlight();

    // Trim the synced recovery log.
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    await dao.purgeSyncedOlderThan(nowMs - _kSyncedRetentionMs);

    // Hydrate in-memory state from the durable outbox table.
    final entries = await dao.loadAll();
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

  String? get _currentUserId => ref.read(authProvider).user?.id;

  Future<void> enqueueShiftOpen(PendingShiftOpen action) async {
    final entry = OutboxEntry.fromActionJson(
      action.toJson(),
      userId: _currentUserId,
    );
    await ref.read(outboxDaoProvider).insert(entry);
    state = state.copyWith(entries: [...state._entries, entry]);
    _drain();
  }

  Future<void> enqueueOrder(PendingOrder action) async {
    // Attach dependency on any live PendingShiftOpen for the same shift.
    final dependsOn = _findLiveShiftOpen(action.shiftId);
    final entry = OutboxEntry.fromActionJson(
      action.toJson(),
      dependsOn: dependsOn,
      userId: _currentUserId,
    );
    await ref.read(outboxDaoProvider).insert(entry);
    state = state.copyWith(entries: [...state._entries, entry]);
    _drain();
  }

  Future<void> enqueueShiftClose(PendingShiftClose action) async {
    final dependsOn = _findLiveShiftOpen(action.shiftId);
    final entry = OutboxEntry.fromActionJson(
      action.toJson(),
      dependsOn: dependsOn,
      userId: _currentUserId,
    );
    await ref.read(outboxDaoProvider).insert(entry);
    state = state.copyWith(entries: [...state._entries, entry]);
    _drain();
  }

  /// Queues a void. If the order being voided was itself created offline and
  /// is still queued, the void depends on it (a void must never reach the
  /// server before its order). If that order has permanently failed, the void
  /// is rejected up front with [OfflineVoidBlockedError].
  Future<void> enqueueVoid(PendingVoidOrder action) async {
    String? dependsOn;
    for (final e in state._entries) {
      if (e.type != PendingActionType.order.name) continue;
      if (e.payloadMap['local_id'] != action.orderId) continue;
      if (e.status == 'dead') throw const OfflineVoidBlockedError();
      dependsOn = e.localId;
      break;
    }
    final entry = OutboxEntry.fromActionJson(
      action.toJson(),
      dependsOn: dependsOn,
      userId: _currentUserId,
    );
    await ref.read(outboxDaoProvider).insert(entry);
    state = state.copyWith(entries: [...state._entries, entry]);
    _drain();
  }

  /// Cash movements are ONLINE-ONLY.
  ///
  /// The backend has no idempotency key for cash movements, so a queued
  /// retry after an ambiguous timeout could double-apply cash. Calling this
  /// while offline throws [OfflineCashMovementError]; UI must disable the
  /// entry points when offline.
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

  /// Called by AuthNotifier after a successful online login: a 401-parked
  /// queue can sync again under the fresh token.
  void resumeAfterAuth() {
    if (state.authPaused) {
      state = state.copyWith(authPaused: false);
    }
    // syncAll, not _drain: _drain would only join a drain that may already be
    // mid-flight (started before the unpause, about to exit). syncAll joins
    // it AND runs one guaranteed fresh pass under the new token, instead of
    // leaving the queue parked until the next 15-second tick.
    unawaited(syncAll());
  }

  /// Parks the queue before an offline session is exposed — there is no
  /// valid token, so draining would only burn 401s.
  void pauseForAuth() {
    if (!state.authPaused) state = state.copyWith(authPaused: true);
  }

  // ── Drain ─────────────────────────────────────────────────────────────────

  /// Manual "Sync Now": joins any in-flight drain, then runs one guaranteed
  /// fresh pass so changes made while a drain was mid-loop are picked up.
  Future<void> syncAll() async {
    await _drain();
    await _drain();
  }

  /// Single-flight: concurrent triggers (connectivity event + timer + manual
  /// button) share the in-flight drain instead of returning early, so
  /// awaiting syncAll() genuinely means "the drain you saw started is done".
  Future<void> _drain() {
    final existing = _drainFuture;
    if (existing != null) return existing;
    if (state.authPaused) return Future.value();
    if (!ConnectivityService.instance.isOnline) return Future.value();

    final future = _runDrain().whenComplete(() => _drainFuture = null);
    _drainFuture = future;
    return future;
  }

  Future<void> _runDrain() async {
    // Don't toggle isSyncing for the always-on 15s tick when the queue is
    // idle — flipping it rebuilds every watcher (sync chips, badges, action
    // bar) twice per tick for nothing.
    final hasWork =
        state._entries.any((e) => e.status == 'pending' || e.status == 'in_flight');
    if (hasWork) state = state.copyWith(isSyncing: true);

    final dao = ref.read(outboxDaoProvider);
    try {
      final nowMs = DateTime.now().millisecondsSinceEpoch;
      final due = await dao.dueForSync(nowMs, userId: _currentUserId);

      for (final entry in due) {
        if (!ConnectivityService.instance.isOnline) break;
        if (state.authPaused) break;

        // A shift close must be the last thing that syncs for the shift:
        // wait until every order/void has either synced or died.
        if (entry.type == PendingActionType.shiftClose.name &&
            await dao.hasLiveOrdersOrVoids()) {
          continue;
        }

        // Prerequisite gating.
        if (entry.dependsOn != null) {
          final prereqStatus = await dao.statusOf(entry.dependsOn!);
          if (prereqStatus == 'pending' || prereqStatus == 'in_flight') {
            continue; // still waiting for the prerequisite
          }
          if (prereqStatus == 'dead') {
            // The prerequisite permanently failed — this entry can never
            // succeed on its own. Surface it instead of skipping forever.
            const err = 'A required earlier action failed to sync';
            await dao.markDead(entry.localId, err);
            _updateEntryInState(entry.copyWith(status: 'dead', lastError: err));
            continue;
          }
          // null (discarded) or 'synced' → safe to proceed.
        }

        await dao.markInFlight(entry.localId);
        _updateEntryInState(entry.copyWith(status: 'in_flight'));

        try {
          await _processEntry(entry);
          await _completeEntry(dao, entry);
        } on DioException catch (e) {
          final status = e.response?.statusCode;
          final isVoid = entry.type == PendingActionType.voidOrder.name;
          if (status == 401) {
            // Token expired mid-drain. Park the whole queue without
            // consuming retry budget; resume after the next login.
            await dao.markRetryNoCount(entry.localId, nowMs);
            _updateEntryInState(entry.copyWith(status: 'pending'));
            state = state.copyWith(authPaused: true);
            break;
          } else if (status == 404 && isVoid) {
            // The order this void targets does not exist server-side
            // (its creation never synced). Treating 404 as "already
            // applied" here would silently discard the void.
            final err = friendlyError(e);
            await dao.markDead(entry.localId,
                'Order not found on server — $err');
            _updateEntryInState(entry.copyWith(
                status: 'dead', lastError: 'Order not found on server'));
          } else if (status == 409 || status == 404) {
            // Already applied — treat as success.
            await _completeEntry(dao, entry);
          } else if (status == 400 || status == 403 || status == 422) {
            // Permanent validation/permission errors: retrying cannot
            // succeed, so fail fast instead of poisoning the queue.
            final err = friendlyError(e);
            await dao.markDead(entry.localId, err);
            _updateEntryInState(
                entry.copyWith(status: 'dead', lastError: err));
          } else if (isNetworkError(e)) {
            // Quietly reschedule network blips; never consume retry budget.
            await dao.markRetryNoCount(entry.localId, nowMs + _kNetworkRetryMs);
            _updateEntryInState(entry.copyWith(status: 'pending'));
          } else {
            await _handleFailure(dao, entry, nowMs, e);
          }
        } catch (e) {
          if (isNetworkError(e)) {
            await dao.markRetryNoCount(entry.localId, nowMs + _kNetworkRetryMs);
            _updateEntryInState(entry.copyWith(status: 'pending'));
          } else {
            await _handleFailure(dao, entry, nowMs, e);
          }
        }
      }
    } finally {
      // Safety net: anything still marked in_flight at this point (e.g. an
      // exception thrown between markInFlight and its handler) would be
      // invisible to dueForSync forever. Put it back in the pending pool.
      try {
        await dao.recoverInFlight();
      } catch (_) {/* DB unavailable — init() recovery will catch it */}
      // Only emit when isSyncing actually flips — a fresh state object alone
      // is enough to rebuild every watcher.
      if (state.isSyncing) state = state.copyWith(isSyncing: false);
    }
  }

  /// Marks the entry synced (kept as a recovery-log row) and drops it from
  /// the in-memory queue view.
  Future<void> _completeEntry(OutboxDao dao, OutboxEntry entry) async {
    await dao.markSynced(
        entry.localId, DateTime.now().millisecondsSinceEpoch);
    state = state.copyWith(
      entries:
          state._entries.where((e) => e.localId != entry.localId).toList(),
    );
  }

  Future<void> _handleFailure(OutboxDao dao, OutboxEntry entry, int nowMs, Object e) async {
    final newRetryCount = entry.retryCount + 1;
    final errStr = friendlyError(e);
    if (newRetryCount >= _kMaxRetries) {
      await dao.markDead(entry.localId, errStr);
      _updateEntryInState(entry.copyWith(status: 'dead', lastError: errStr));
    } else {
      final backoffMs = _computeBackoff(newRetryCount);
      final nextAttempt = nowMs + backoffMs;
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
              closedAt: action.closedAt,
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
      if (e.type != PendingActionType.shiftOpen.name) continue;
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

class OfflineVoidBlockedError implements Exception {
  const OfflineVoidBlockedError();
  @override
  String toString() =>
      'This order never reached the server. Retry or discard it from the sync screen instead of voiding.';
}

// ── Provider ───────────────────────────────────────────────────────────────

final offlineQueueProvider =
    NotifierProvider<OfflineQueueNotifier, OfflineQueueState>(
        OfflineQueueNotifier.new);
