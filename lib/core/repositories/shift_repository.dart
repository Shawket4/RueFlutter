import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import '../api/order_api.dart';
import '../api/shift_api.dart';
import '../api/inventory_api.dart';
import '../db/app_database.dart';
import '../models/shift.dart';
import '../models/inventory.dart';
import '../models/shift_report.dart';
import '../models/payment_method.dart';
import '../storage/storage_service.dart';

/// TTL for inventory freshness: 5 minutes in ms.
const _kInventoryTtlMs = 5 * 60 * 1000;

class ShiftRepository {
  final ShiftApi       _shiftApi;
  final OrderApi       _orderApi;
  final InventoryApi   _inventoryApi;
  final StorageService _storage;
  final AppDatabase    _db;

  ShiftRepository(this._shiftApi, this._orderApi, this._inventoryApi,
      this._storage, this._db);

  // ── Freshness / sync_meta ────────────────────────────────────────────────

  Future<bool> isStale(String entity, {int ttlMs = _kInventoryTtlMs}) async {
    final db = await _db.db;
    final rows = await db.query(
      'sync_meta',
      columns: ['last_synced_at'],
      where: 'entity = ?',
      whereArgs: [entity],
      limit: 1,
    );
    if (rows.isEmpty) return true;
    final ts = rows.first['last_synced_at'] as int?;
    if (ts == null) return true;
    return DateTime.now().millisecondsSinceEpoch - ts > ttlMs;
  }

  Future<void> _bumpSyncMeta(String entity) async {
    final db = await _db.db;
    await db.insert(
      'sync_meta',
      {'entity': entity, 'last_synced_at': DateTime.now().millisecondsSinceEpoch},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ── Current shift ────────────────────────────────────────────────────────

  /// Returns local cached shift immediately (may be null).
  ShiftPreFill? loadShiftLocal(String branchId) {
    final cached = _storage.loadShift(branchId);
    if (cached == null) return null;
    try {
      final shift = Shift.fromJson(cached);
      return ShiftPreFill(
        hasOpenShift: shift.isOpen,
        openShift: shift,
        suggestedOpeningCash: 0,
      );
    } catch (_) {
      return null;
    }
  }

  /// Fetches fresh shift state from the network. Persists and bumps sync_meta.
  Future<ShiftPreFill> fetchShiftFresh(String branchId) async {
    final preFill = await _shiftApi.current(branchId);
    if (preFill.openShift != null) {
      await _storage.saveShift(branchId, preFill.openShift!.toJson());
    } else {
      await _storage.removeShift(branchId);
    }
    await _bumpSyncMeta('shift:$branchId');
    return preFill;
  }

  // ── Shifts list ──────────────────────────────────────────────────────────

  List<Shift>? loadShiftsLocal(String branchId) {
    final cached = _storage.loadShifts(branchId);
    if (cached == null) return null;
    try {
      return cached.map(Shift.fromJson).toList();
    } catch (_) {
      return null;
    }
  }

  Future<List<Shift>> fetchShiftsFresh(String branchId) async {
    final shifts = await _shiftApi.list(branchId);
    await _storage.saveShifts(branchId, shifts.map((s) => s.toJson()).toList());
    await _bumpSyncMeta('shifts:$branchId');
    return shifts;
  }

  // ── Shift open / close ───────────────────────────────────────────────────

  Future<Shift> openShift(String branchId, int openingCash) async {
    final shift = await _shiftApi.open(branchId, openingCash);
    await _storage.saveShift(branchId, shift.toJson());
    return shift;
  }

  Future<Shift> closeShift(String shiftId, {
    required String branchId,
    required int closingCash,
    String? note,
    required List<Map<String, dynamic>> inventoryCounts,
  }) async {
    final shift = await _shiftApi.close(shiftId,
        closingCash: closingCash,
        note: note,
        inventoryCounts: inventoryCounts);
    await _storage.removeShift(branchId);
    return shift;
  }

  // ── System cash ──────────────────────────────────────────────────────────

  Future<int> getSystemCash(String shiftId, int openingCash, List<PaymentMethod> methods) async {
    final orders = await _orderApi.list(shiftId: shiftId);
    final cashFromOrders = orders
        .where((o) {
          final isCash = methods.where((m) => m.wireFormat == o.paymentMethod).firstOrNull?.isCash ?? (o.paymentMethod == 'cash');
          return isCash && o.status != 'voided' && o.status != 'refunded';
        })
        .fold<int>(0, (s, o) => s + o.totalAmount);
    final movements = await _shiftApi.cashMovementsTotal(shiftId);
    return openingCash + cashFromOrders + movements;
  }

  // ── Inventory ────────────────────────────────────────────────────────────

  List<InventoryItem>? loadInventoryLocal(String branchId) {
    final cached = _storage.loadInventory(branchId);
    if (cached == null) return null;
    try {
      return cached.map(InventoryItem.fromJson).toList();
    } catch (_) {
      return null;
    }
  }

  Future<List<InventoryItem>> fetchInventoryFresh(String branchId) async {
    final items = await _inventoryApi.items(branchId);
    await _storage.saveInventory(
        branchId, items.map((i) => i.toJson()).toList().cast<Map<String, dynamic>>());
    await _bumpSyncMeta('inventory:$branchId');
    return items;
  }

  // ── Shift report ─────────────────────────────────────────────────────────

  Future<ShiftReport> getReport(String shiftId) async {
    try {
      final report = await _shiftApi.getReport(shiftId);
      await _storage.saveShiftReport(shiftId, report.toJson());
      return report;
    } catch (_) {
      final cached = _storage.loadShiftReport(shiftId);
      if (cached != null) return ShiftReport.fromJson(cached);
      rethrow;
    }
  }
}

final shiftRepositoryProvider = Provider<ShiftRepository>((ref) => ShiftRepository(
      ref.watch(shiftApiProvider),
      ref.watch(orderApiProvider),
      ref.watch(inventoryApiProvider),
      ref.watch(storageServiceProvider),
      AppDatabase.instance,
    ));
