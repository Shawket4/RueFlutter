import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/delivery_order.dart';
import '../models/delivery_settings.dart';
import 'client.dart';

/// Staff delivery API (JWT, branch-scoped). Reuses the shared [DioClient]:
/// the auth Bearer header is injected by its request interceptor and a 401
/// triggers the existing logout path (`onUnauthorizedCallback`). Errors are
/// surfaced verbatim and mapped by [friendlyError] at the call sites — exactly
/// like [OrderApi].
class DeliveryApi {
  final DioClient _c;
  DeliveryApi(this._c);

  /// `GET /delivery-orders` — the branch queue (newest first). [status] is a
  /// comma-separated filter; omit for all statuses.
  Future<List<DeliveryOrder>> listDeliveryOrders({
    required String branchId,
    String? status,
    int limit = 200,
  }) async {
    final res = await _c.dio.get('/delivery-orders', queryParameters: {
      'branch_id': branchId,
      if (status != null && status.isNotEmpty) 'status': status,
      'limit': limit,
    });
    final body = res.data;
    final List<dynamic> items = switch (body) {
      List() => body,
      Map() when body['data'] is List => body['data'] as List,
      _ => const [],
    };
    return items
        .map((o) => DeliveryOrder.fromJson(o as Map<String, dynamic>))
        .toList();
  }

  /// `GET /delivery/settings` — the branch's delivery configuration, including
  /// the POS-owned accepting overrides (`*_override`).
  Future<DeliverySettings> getSettings(String branchId) async {
    final res = await _c.dio.get('/delivery/settings',
        queryParameters: {'branch_id': branchId});
    return DeliverySettings.fromJson(res.data as Map<String, dynamic>);
  }

  /// `POST /delivery/accepting` — set a channel's accepting override.
  /// [channel] is `in_mall`/`outside`, [mode] is `auto`/`open`/`closed`.
  /// The backend rejects (409) an attempt to open a dashboard-disabled channel.
  /// Returns the updated [DeliverySettings].
  Future<DeliverySettings> setAccepting(
    String branchId, {
    required String channel,
    required String mode,
  }) async {
    final res = await _c.dio.post('/delivery/accepting', data: {
      'branch_id': branchId,
      'channel': channel,
      'mode': mode,
    });
    return DeliverySettings.fromJson(res.data as Map<String, dynamic>);
  }

  /// `GET /delivery-orders/{id}`.
  Future<DeliveryOrder> getDeliveryOrder(String id) async {
    final res = await _c.dio.get('/delivery-orders/$id');
    return DeliveryOrder.fromJson(res.data as Map<String, dynamic>);
  }

  /// `POST /delivery-orders/{id}/status` — single forward step
  /// (confirmed → preparing → ready → out_for_delivery).
  Future<DeliveryOrder> setStatus(String id, String status) async {
    final res = await _c.dio.post(
      '/delivery-orders/$id/status',
      data: {'status': status},
    );
    return DeliveryOrder.fromJson(res.data as Map<String, dynamic>);
  }

  /// `POST /delivery-orders/{id}/prep-time` — set the per-order extra prep time.
  /// [extraPrepMinutes] must be a non-negative multiple of 5.
  Future<DeliveryOrder> setPrepTime(String id, int extraPrepMinutes) async {
    final res = await _c.dio.post(
      '/delivery-orders/$id/prep-time',
      data: {'extra_prep_minutes': extraPrepMinutes},
    );
    return DeliveryOrder.fromJson(res.data as Map<String, dynamic>);
  }

  /// `POST /delivery-orders/{id}/cancel`. [restoreInventory] false means the
  /// food was made and is wasted (the frozen plan is deducted + logged as
  /// `waste`); true (default) leaves stock untouched.
  Future<DeliveryOrder> cancel(
    String id, {
    String? reason,
    bool restoreInventory = true,
  }) async {
    final res = await _c.dio.post('/delivery-orders/$id/cancel', data: {
      if (reason != null && reason.isNotEmpty) 'reason': reason,
      'restore_inventory': restoreInventory,
    });
    return DeliveryOrder.fromJson(res.data as Map<String, dynamic>);
  }

  /// `POST /delivery-orders/{id}/finalize` — replay the frozen snapshot into a
  /// real completed sale on the given (open) shift. Returns the updated delivery
  /// order, the new order id/ref, and any oversold warnings.
  Future<DeliveryFinalizeResult> finalize(
    String id, {
    required String shiftId,
    required String paymentMethod,
  }) async {
    final res = await _c.dio.post('/delivery-orders/$id/finalize', data: {
      'shift_id': shiftId,
      'payment_method': paymentMethod,
    });
    return DeliveryFinalizeResult.fromJson(res.data as Map<String, dynamic>);
  }

  /// `GET /delivery-orders/stream` — opens the Server-Sent Events byte stream
  /// of live order changes for a branch. Returns the raw [ResponseBody] whose
  /// `.stream` the caller parses (`event: created|updated` + `data: <DeliveryOrder>`).
  ///
  /// `receiveTimeout: Duration.zero` is essential — the default 20s receive
  /// timeout would kill an idle keep-alive stream. The Bearer header is injected
  /// by the shared [DioClient] interceptor, so auth is automatic; a 401 is
  /// surfaced as a [DioException] for the realtime service to handle (logout).
  Future<ResponseBody> openStream({
    required String branchId,
    String? status,
    CancelToken? cancelToken,
  }) async {
    final res = await _c.dio.get<ResponseBody>(
      '/delivery-orders/stream',
      queryParameters: {
        'branch_id': branchId,
        if (status != null && status.isNotEmpty) 'status': status,
      },
      options: Options(
        responseType: ResponseType.stream,
        receiveTimeout: Duration.zero,
        headers: {'Accept': 'text/event-stream'},
      ),
      cancelToken: cancelToken,
    );
    return res.data!;
  }
}

/// Decoded `POST /finalize` response.
class DeliveryFinalizeResult {
  final DeliveryOrder deliveryOrder;
  final String? orderId;
  final String? orderRef;
  final List<String> warnings;

  const DeliveryFinalizeResult({
    required this.deliveryOrder,
    this.orderId,
    this.orderRef,
    this.warnings = const [],
  });

  factory DeliveryFinalizeResult.fromJson(Map<String, dynamic> j) =>
      DeliveryFinalizeResult(
        deliveryOrder:
            DeliveryOrder.fromJson(j['delivery_order'] as Map<String, dynamic>),
        orderId: j['order_id'] as String?,
        orderRef: j['order_ref'] as String?,
        warnings:
            (j['warnings'] as List?)?.map((w) => w.toString()).toList() ??
                const [],
      );
}

final deliveryApiProvider =
    Provider<DeliveryApi>((ref) => DeliveryApi(ref.watch(dioClientProvider)));
