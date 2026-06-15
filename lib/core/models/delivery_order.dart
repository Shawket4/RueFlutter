// Hand-written wire model for the delivery-orders stack, built 1:1 against the
// backend contract:
//   * the read model  → SufrixRust/src/delivery/staff.rs  (DeliveryOrder)
//   * the cart jsonb   → SufrixRust/src/delivery/snapshot.rs
//        (CartSnapshot / SnapshotLine / SnapshotAddon / SnapshotOptional)
//
// The cart lives in `delivery_orders.cart` as a frozen, server-priced JSON blob
// (NOT the generated order shape), so it is parsed by hand here rather than
// going through Orval — the same manual-fromJson convention as the order stack's
// `InventoryDeduction`. Money is integer piastres throughout (use `egp()` from
// utils/formatting.dart to display).

import 'dart:convert';

/// Delivery channel. Mirrors the backend `delivery_channel` enum.
enum DeliveryChannel {
  inMall,
  outside,
  unknown;

  String get wire => switch (this) {
        DeliveryChannel.inMall => 'in_mall',
        DeliveryChannel.outside => 'outside',
        DeliveryChannel.unknown => 'unknown',
      };

  static DeliveryChannel fromWire(String? raw) => switch (raw) {
        'in_mall' => DeliveryChannel.inMall,
        'outside' => DeliveryChannel.outside,
        _ => DeliveryChannel.unknown,
      };

  bool get isInMall => this == DeliveryChannel.inMall;
}

/// Lifecycle of a delivery order. Mirrors the backend `delivery_order_status`
/// enum. `delivered` is reached only via finalize; `cancelled`/`rejected` via
/// the cancel endpoint.
enum DeliveryStatus {
  received,
  confirmed,
  preparing,
  ready,
  outForDelivery,
  delivered,
  cancelled,
  rejected,
  unknown,
}

extension DeliveryStatusX on DeliveryStatus {
  /// Wire identifier used in the API (`status` field / `POST /status` body).
  String get wire => switch (this) {
        DeliveryStatus.received => 'received',
        DeliveryStatus.confirmed => 'confirmed',
        DeliveryStatus.preparing => 'preparing',
        DeliveryStatus.ready => 'ready',
        DeliveryStatus.outForDelivery => 'out_for_delivery',
        DeliveryStatus.delivered => 'delivered',
        DeliveryStatus.cancelled => 'cancelled',
        DeliveryStatus.rejected => 'rejected',
        DeliveryStatus.unknown => 'unknown',
      };

  static DeliveryStatus fromWire(String? raw) => switch (raw) {
        'received' => DeliveryStatus.received,
        'confirmed' => DeliveryStatus.confirmed,
        'preparing' => DeliveryStatus.preparing,
        'ready' => DeliveryStatus.ready,
        'out_for_delivery' => DeliveryStatus.outForDelivery,
        'delivered' => DeliveryStatus.delivered,
        'cancelled' => DeliveryStatus.cancelled,
        'rejected' => DeliveryStatus.rejected,
        _ => DeliveryStatus.unknown,
      };

  /// Terminal states can no longer be advanced, finalized, or cancelled.
  bool get isTerminal =>
      this == DeliveryStatus.delivered ||
      this == DeliveryStatus.cancelled ||
      this == DeliveryStatus.rejected;

  /// True while the order is still in the active kitchen/delivery queue.
  bool get isActive => !isTerminal;

  /// The single forward step from this state, or null if there is no plain
  /// forward transition (finalize / cancel are separate endpoints).
  DeliveryStatus? get nextForward => switch (this) {
        DeliveryStatus.received => DeliveryStatus.confirmed,
        DeliveryStatus.confirmed => DeliveryStatus.preparing,
        DeliveryStatus.preparing => DeliveryStatus.ready,
        DeliveryStatus.ready => DeliveryStatus.outForDelivery,
        _ => null,
      };
}

/// One addon on a frozen cart line. Mirrors `snapshot.rs::SnapshotAddon`.
class DeliveryCartAddon {
  final String addonItemId;
  final String addonName;
  final Map<String, dynamic>? nameTranslations;
  final int unitPrice;
  final int quantity;
  final int? lineCost;

  const DeliveryCartAddon({
    this.addonItemId = '',
    required this.addonName,
    this.nameTranslations,
    required this.unitPrice,
    required this.quantity,
    this.lineCost,
  });

  factory DeliveryCartAddon.fromJson(Map<String, dynamic> j) =>
      DeliveryCartAddon(
        addonItemId: j['addon_item_id'] as String? ?? '',
        addonName: j['addon_name'] as String? ?? '',
        nameTranslations: _asMap(j['name_translations']),
        unitPrice: _asInt(j['unit_price']),
        quantity: _asInt(j['quantity'], fallback: 1),
        lineCost: _asIntOrNull(j['line_cost']),
      );

  Map<String, dynamic> toJson() => {
        if (addonItemId.isNotEmpty) 'addon_item_id': addonItemId,
        'addon_name': addonName,
        if (nameTranslations != null) 'name_translations': nameTranslations,
        'unit_price': unitPrice,
        'quantity': quantity,
        if (lineCost != null) 'line_cost': lineCost,
      };
}

/// One optional field on a frozen cart line. Mirrors
/// `snapshot.rs::SnapshotOptional` (the ingredient_* / cost fields are
/// server-internal and intentionally not modelled on the client).
class DeliveryCartOptional {
  final String optionalFieldId;
  final String fieldName;
  final Map<String, dynamic>? nameTranslations;
  final int price;

  const DeliveryCartOptional({
    this.optionalFieldId = '',
    required this.fieldName,
    this.nameTranslations,
    required this.price,
  });

  factory DeliveryCartOptional.fromJson(Map<String, dynamic> j) =>
      DeliveryCartOptional(
        optionalFieldId: j['optional_field_id'] as String? ?? '',
        fieldName: j['field_name'] as String? ?? '',
        nameTranslations: _asMap(j['name_translations']),
        price: _asInt(j['price']),
      );

  Map<String, dynamic> toJson() => {
        if (optionalFieldId.isNotEmpty) 'optional_field_id': optionalFieldId,
        'field_name': fieldName,
        if (nameTranslations != null) 'name_translations': nameTranslations,
        'price': price,
      };
}

/// One frozen, server-priced cart line. Mirrors `snapshot.rs::SnapshotLine`.
class DeliveryCartLine {
  final String menuItemId;
  final String itemName;
  final Map<String, dynamic>? nameTranslations;
  final String? sizeLabel;
  final int unitPrice;
  final int quantity;
  final int lineTotal;
  final String? notes;
  final List<DeliveryCartAddon> addons;
  final List<DeliveryCartOptional> optionals;
  final int? lineCost;
  final int? unitCost;
  final bool costMissing;

  const DeliveryCartLine({
    this.menuItemId = '',
    required this.itemName,
    this.nameTranslations,
    this.sizeLabel,
    required this.unitPrice,
    required this.quantity,
    required this.lineTotal,
    this.notes,
    this.addons = const [],
    this.optionals = const [],
    this.lineCost,
    this.unitCost,
    this.costMissing = false,
  });

  factory DeliveryCartLine.fromJson(Map<String, dynamic> j) => DeliveryCartLine(
        menuItemId: j['menu_item_id'] as String? ?? '',
        itemName: j['item_name'] as String? ?? '',
        nameTranslations: _asMap(j['name_translations']),
        sizeLabel: j['size_label'] as String?,
        unitPrice: _asInt(j['unit_price']),
        quantity: _asInt(j['quantity'], fallback: 1),
        lineTotal: _asInt(j['line_total']),
        notes: j['notes'] as String?,
        addons:
            _list(j['addons']).map(DeliveryCartAddon.fromJson).toList(),
        optionals:
            _list(j['optionals']).map(DeliveryCartOptional.fromJson).toList(),
        lineCost: _asIntOrNull(j['line_cost']),
        unitCost: _asIntOrNull(j['unit_cost']),
        costMissing: j['cost_missing'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        if (menuItemId.isNotEmpty) 'menu_item_id': menuItemId,
        'item_name': itemName,
        if (nameTranslations != null) 'name_translations': nameTranslations,
        if (sizeLabel != null) 'size_label': sizeLabel,
        'unit_price': unitPrice,
        'quantity': quantity,
        'line_total': lineTotal,
        if (notes != null) 'notes': notes,
        'addons': addons.map((a) => a.toJson()).toList(),
        'optionals': optionals.map((o) => o.toJson()).toList(),
        if (lineCost != null) 'line_cost': lineCost,
        if (unitCost != null) 'unit_cost': unitCost,
        'cost_missing': costMissing,
      };
}

/// The frozen priced cart snapshot stored on `delivery_orders.cart`. Mirrors
/// `snapshot.rs::CartSnapshot`.
class DeliveryCart {
  final List<DeliveryCartLine> lines;

  const DeliveryCart({this.lines = const []});

  factory DeliveryCart.fromJson(Map<String, dynamic> j) => DeliveryCart(
        lines: _list(j['lines']).map(DeliveryCartLine.fromJson).toList(),
      );

  Map<String, dynamic> toJson() =>
      {'lines': lines.map((l) => l.toJson()).toList()};
}

/// A delivery order: queue entry → finalized sale. Mirrors the backend
/// `staff.rs::DeliveryOrder` read model field-for-field. Money is piastres.
class DeliveryOrder {
  final String id;
  final String? orgId;
  final String branchId;

  final DeliveryChannel channel;
  final DeliveryStatus status;
  final String? deliveryRef;

  final String customerName;
  final String customerPhone;

  // Address parts (any subset may be present).
  final String? placeName;
  final String? floor;
  final String? unitNumber;
  final String? landmark;
  final String? addressLine;
  final String? deliveryNotes;
  final double? customerLat;
  final double? customerLng;
  final String? deliveryZoneId;
  final int? roadDistanceMeters;

  final int subtotal;
  final int deliveryFee;
  final int total;

  /// Frozen channel discount on the item subtotal (piastres); 0 when none.
  /// `total == subtotal - discountAmount + deliveryFee`.
  final int discountAmount;

  /// Per-order extra prep time in minutes (non-negative multiple of 5). Added
  /// on top of the branch BASE prep time (branch config; not on the order).
  final int extraPrepMinutes;

  final DeliveryCart cart;
  final String? paymentMethodHint;
  final bool otpVerified;

  /// Set once the order has been finalized into a real `orders` row.
  final String? orderId;

  final DateTime? receiptPrintedAt;
  final DateTime? confirmedAt;
  final DateTime? preparingAt;
  final DateTime? readyAt;
  final DateTime? outForDeliveryAt;
  final DateTime? deliveredAt;
  final DateTime? cancelledAt;
  final DateTime? rejectedAt;
  final String? cancelReason;
  final bool? cancelRestocked;

  final DateTime createdAt;
  final DateTime updatedAt;

  const DeliveryOrder({
    required this.id,
    this.orgId,
    required this.branchId,
    required this.channel,
    required this.status,
    this.deliveryRef,
    required this.customerName,
    required this.customerPhone,
    this.placeName,
    this.floor,
    this.unitNumber,
    this.landmark,
    this.addressLine,
    this.deliveryNotes,
    this.customerLat,
    this.customerLng,
    this.deliveryZoneId,
    this.roadDistanceMeters,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    this.discountAmount = 0,
    this.extraPrepMinutes = 0,
    required this.cart,
    this.paymentMethodHint,
    this.otpVerified = false,
    this.orderId,
    this.receiptPrintedAt,
    this.confirmedAt,
    this.preparingAt,
    this.readyAt,
    this.outForDeliveryAt,
    this.deliveredAt,
    this.cancelledAt,
    this.rejectedAt,
    this.cancelReason,
    this.cancelRestocked,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Whether the customer receipt has already been printed (print-once guard).
  bool get receiptPrinted => receiptPrintedAt != null;

  bool get isInMall => channel == DeliveryChannel.inMall;

  factory DeliveryOrder.fromJson(Map<String, dynamic> j) => DeliveryOrder(
        id: j['id'] as String,
        orgId: j['org_id'] as String?,
        branchId: j['branch_id'] as String,
        channel: DeliveryChannel.fromWire(j['channel'] as String?),
        status: DeliveryStatusX.fromWire(j['status'] as String?),
        deliveryRef: j['delivery_ref'] as String?,
        customerName: j['customer_name'] as String? ?? '',
        customerPhone: j['customer_phone'] as String? ?? '',
        placeName: j['place_name'] as String?,
        floor: j['floor'] as String?,
        unitNumber: j['unit_number'] as String?,
        landmark: j['landmark'] as String?,
        addressLine: j['address_line'] as String?,
        deliveryNotes: j['delivery_notes'] as String?,
        customerLat: _asDouble(j['customer_lat']),
        customerLng: _asDouble(j['customer_lng']),
        deliveryZoneId: j['delivery_zone_id'] as String?,
        roadDistanceMeters: _asIntOrNull(j['road_distance_meters']),
        subtotal: _asInt(j['subtotal']),
        deliveryFee: _asInt(j['delivery_fee']),
        total: _asInt(j['total']),
        discountAmount: _asInt(j['discount_amount']),
        extraPrepMinutes: _asInt(j['extra_prep_minutes']),
        cart: DeliveryCart.fromJson(_asMap(j['cart']) ?? const {}),
        paymentMethodHint: j['payment_method_hint'] as String?,
        otpVerified: j['otp_verified'] as bool? ?? false,
        orderId: j['order_id'] as String?,
        receiptPrintedAt: _asDate(j['receipt_printed_at']),
        confirmedAt: _asDate(j['confirmed_at']),
        preparingAt: _asDate(j['preparing_at']),
        readyAt: _asDate(j['ready_at']),
        outForDeliveryAt: _asDate(j['out_for_delivery_at']),
        deliveredAt: _asDate(j['delivered_at']),
        cancelledAt: _asDate(j['cancelled_at']),
        rejectedAt: _asDate(j['rejected_at']),
        cancelReason: j['cancel_reason'] as String?,
        cancelRestocked: j['cancel_restocked'] as bool?,
        createdAt: _asDate(j['created_at']) ?? DateTime.now(),
        updatedAt: _asDate(j['updated_at']) ?? DateTime.now(),
      );

  /// Round-trip JSON used for the local cache (mirrors `Order.toJson`). Must
  /// serialize every field so a cached order survives a cold start intact.
  Map<String, dynamic> toJson() => {
        'id': id,
        if (orgId != null) 'org_id': orgId,
        'branch_id': branchId,
        'channel': channel.wire,
        'status': status.wire,
        if (deliveryRef != null) 'delivery_ref': deliveryRef,
        'customer_name': customerName,
        'customer_phone': customerPhone,
        if (placeName != null) 'place_name': placeName,
        if (floor != null) 'floor': floor,
        if (unitNumber != null) 'unit_number': unitNumber,
        if (landmark != null) 'landmark': landmark,
        if (addressLine != null) 'address_line': addressLine,
        if (deliveryNotes != null) 'delivery_notes': deliveryNotes,
        if (customerLat != null) 'customer_lat': customerLat,
        if (customerLng != null) 'customer_lng': customerLng,
        if (deliveryZoneId != null) 'delivery_zone_id': deliveryZoneId,
        if (roadDistanceMeters != null)
          'road_distance_meters': roadDistanceMeters,
        'subtotal': subtotal,
        'delivery_fee': deliveryFee,
        'discount_amount': discountAmount,
        'total': total,
        'extra_prep_minutes': extraPrepMinutes,
        'cart': cart.toJson(),
        if (paymentMethodHint != null) 'payment_method_hint': paymentMethodHint,
        'otp_verified': otpVerified,
        if (orderId != null) 'order_id': orderId,
        if (receiptPrintedAt != null)
          'receipt_printed_at': receiptPrintedAt!.toUtc().toIso8601String(),
        if (confirmedAt != null)
          'confirmed_at': confirmedAt!.toUtc().toIso8601String(),
        if (preparingAt != null)
          'preparing_at': preparingAt!.toUtc().toIso8601String(),
        if (readyAt != null) 'ready_at': readyAt!.toUtc().toIso8601String(),
        if (outForDeliveryAt != null)
          'out_for_delivery_at': outForDeliveryAt!.toUtc().toIso8601String(),
        if (deliveredAt != null)
          'delivered_at': deliveredAt!.toUtc().toIso8601String(),
        if (cancelledAt != null)
          'cancelled_at': cancelledAt!.toUtc().toIso8601String(),
        if (rejectedAt != null)
          'rejected_at': rejectedAt!.toUtc().toIso8601String(),
        if (cancelReason != null) 'cancel_reason': cancelReason,
        if (cancelRestocked != null) 'cancel_restocked': cancelRestocked,
        'created_at': createdAt.toUtc().toIso8601String(),
        'updated_at': updatedAt.toUtc().toIso8601String(),
      };
}

// ── Parse helpers (tolerant of int/num/string wire variants) ────────────────

int _asInt(dynamic v, {int fallback = 0}) {
  if (v is int) return v;
  if (v is num) return v.toInt();
  return int.tryParse(v?.toString() ?? '') ?? fallback;
}

int? _asIntOrNull(dynamic v) {
  if (v == null) return null;
  if (v is int) return v;
  if (v is num) return v.toInt();
  return int.tryParse(v.toString());
}

double? _asDouble(dynamic v) {
  if (v == null) return null;
  if (v is double) return v;
  if (v is num) return v.toDouble();
  return double.tryParse(v.toString());
}

DateTime? _asDate(dynamic v) {
  if (v == null) return null;
  if (v is DateTime) return v;
  return DateTime.tryParse(v.toString());
}

Map<String, dynamic>? _asMap(dynamic v) {
  if (v == null) return null;
  if (v is Map<String, dynamic>) return v;
  if (v is Map) return Map<String, dynamic>.from(v);
  if (v is String && v.isNotEmpty) {
    try {
      final decoded = jsonDecode(v);
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    } catch (_) {}
  }
  return null;
}

List<Map<String, dynamic>> _list(dynamic v) {
  if (v is! List) return const [];
  return v
      .whereType<Map>()
      .map((e) => Map<String, dynamic>.from(e))
      .toList();
}
