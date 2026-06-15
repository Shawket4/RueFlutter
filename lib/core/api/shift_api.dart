import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cash_movement.dart';
import '../models/shift.dart';
import '../models/shift_report.dart';
import 'client.dart';

/// One page of the shifts list (newest first). Mirrors the backend
/// `PaginatedShifts` envelope.
class ShiftPage {
  final List<Shift> shifts;
  final int total;
  final int page;
  final int perPage;
  final int totalPages;
  const ShiftPage({
    required this.shifts,
    required this.total,
    required this.page,
    required this.perPage,
    required this.totalPages,
  });

  bool get hasMore => page < totalPages;
}

class ShiftApi {
  final DioClient _c;
  ShiftApi(this._c);

  Future<ShiftPreFill> current(String branchId) async {
    final res = await _c.dio.get('/shifts/branches/$branchId/current');
    return ShiftPreFill.fromJson(res.data as Map<String, dynamic>);
  }

  /// Paginated shifts list. The backend returns a `PaginatedShifts` envelope;
  /// supplying `page`/`perPage` requests one bounded page (the list grows
  /// without bound over time, so the history screen pages through it).
  Future<ShiftPage> list(String branchId, {int? page, int? perPage}) async {
    final res = await _c.dio.get(
      '/shifts/branches/$branchId',
      queryParameters: {
        if (page != null) 'page': page,
        if (perPage != null) 'per_page': perPage,
      },
    );
    final body = res.data as Map<String, dynamic>;
    final shifts = (body['data'] as List)
        .map((s) => Shift.fromJson(s as Map<String, dynamic>))
        .toList();
    return ShiftPage(
      shifts: shifts,
      total: (body['total'] as num).toInt(),
      page: (body['page'] as num).toInt(),
      perPage: (body['per_page'] as num).toInt(),
      totalPages: (body['total_pages'] as num).toInt(),
    );
  }

  /// Standard online open — server generates the UUID. `editReason` is sent when
  /// the opening cash deviates from the carried-over closing (the server requires
  /// it and derives `opening_cash_was_edited` itself).
  Future<Shift> open(String branchId, int openingCash, {String? editReason}) async {
    final res = await _c.dio.post(
      '/shifts/branches/$branchId/open',
      data: {
        'opening_cash': openingCash,
        if (editReason != null) 'edit_reason': editReason,
      },
    );
    return Shift.fromJson(res.data as Map<String, dynamic>);
  }

  /// Offline-aware open — client supplies its own UUID and timestamp.
  /// Idempotent: safe to call multiple times with the same shiftId.
  Future<Shift> openWithId({
    required String branchId,
    required String shiftId,
    required int openingCash,
    required DateTime openedAt,
    String? editReason,
  }) async {
    final res = await _c.dio.post(
      '/shifts/branches/$branchId/open',
      data: {
        'id': shiftId,
        'opening_cash': openingCash,
        'opened_at': openedAt.toUtc().toIso8601String(),
        if (editReason != null) 'edit_reason': editReason,
      },
    );
    return Shift.fromJson(res.data as Map<String, dynamic>);
  }

  /// Close shift. Accepts optional closedAt for offline scenarios.
  /// Idempotent: returns existing close data if already closed.
  Future<Shift> close(
    String shiftId, {
    required int closingCash,
    String? note,
    required List<Map<String, dynamic>> inventoryCounts,
    DateTime? closedAt,
  }) async {
    final res = await _c.dio.post('/shifts/$shiftId/close', data: {
      'closing_cash_declared': closingCash,
      'cash_note': note,
      'inventory_counts': inventoryCounts,
      if (closedAt != null) 'closed_at': closedAt.toUtc().toIso8601String(),
    });
    final body = res.data as Map<String, dynamic>;
    return Shift.fromJson(body['shift'] as Map<String, dynamic>);
  }

  Future<int> cashMovementsTotal(String shiftId) async {
    int movements = 0;
    try {
      final movRes = await _c.dio.get('/shifts/$shiftId/cash-movements');
      movements = (movRes.data as List)
          .fold<int>(0, (s, m) => s + (m['amount'] as int));
    } catch (_) {}
    return movements;
  }

  /// Full cash-movement list for a shift (newest-first is left to the caller).
  Future<List<CashMovement>> listCashMovements(String shiftId) async {
    final res = await _c.dio.get('/shifts/$shiftId/cash-movements');
    return (res.data as List)
        .map((m) => CashMovement.fromJson(m as Map<String, dynamic>))
        .toList();
  }

  Future<ShiftReport> getReport(String shiftId) async {
    final res = await _c.dio.get('/shifts/$shiftId/report');
    return ShiftReport.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> addCashMovement(String shiftId, int amount, String note) async {
    await _c.dio.post('/shifts/$shiftId/cash-movements',
        data: {'amount': amount, 'note': note});
  }
}

final shiftApiProvider =
    Provider<ShiftApi>((ref) => ShiftApi(ref.watch(dioClientProvider)));
