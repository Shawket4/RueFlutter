// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_export.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderExportCWProxy {
  OrderExport amountTendered(int? amountTendered);

  OrderExport branchId(String branchId);

  OrderExport changeGiven(int? changeGiven);

  OrderExport createdAt(DateTime createdAt);

  OrderExport customerName(String? customerName);

  OrderExport deliveryFee(int deliveryFee);

  OrderExport deliveryOrderId(String? deliveryOrderId);

  OrderExport discountAmount(int discountAmount);

  OrderExport discountId(String? discountId);

  OrderExport discountType(String? discountType);

  OrderExport discountValue(int discountValue);

  OrderExport id(String id);

  OrderExport notes(String? notes);

  OrderExport orderNumber(int orderNumber);

  OrderExport orderRef(String? orderRef);

  OrderExport orderType(String orderType);

  OrderExport paymentMethod(String paymentMethod);

  OrderExport shiftId(String shiftId);

  OrderExport status(String status);

  OrderExport subtotal(int subtotal);

  OrderExport taxAmount(int taxAmount);

  OrderExport tellerId(String tellerId);

  OrderExport tellerName(String tellerName);

  OrderExport tipAmount(int? tipAmount);

  OrderExport tipPaymentMethod(String? tipPaymentMethod);

  OrderExport totalAmount(int totalAmount);

  OrderExport voidNote(String? voidNote);

  OrderExport voidReason(String? voidReason);

  OrderExport voidedAt(DateTime? voidedAt);

  OrderExport voidedBy(String? voidedBy);

  OrderExport items(List<OrderItemFull> items);

  OrderExport payments(List<OrderPayment> payments);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderExport(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderExport(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderExport call({
    int? amountTendered,
    String branchId,
    int? changeGiven,
    DateTime createdAt,
    String? customerName,
    int deliveryFee,
    String? deliveryOrderId,
    int discountAmount,
    String? discountId,
    String? discountType,
    int discountValue,
    String id,
    String? notes,
    int orderNumber,
    String? orderRef,
    String orderType,
    String paymentMethod,
    String shiftId,
    String status,
    int subtotal,
    int taxAmount,
    String tellerId,
    String tellerName,
    int? tipAmount,
    String? tipPaymentMethod,
    int totalAmount,
    String? voidNote,
    String? voidReason,
    DateTime? voidedAt,
    String? voidedBy,
    List<OrderItemFull> items,
    List<OrderPayment> payments,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderExport.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderExport.copyWith.fieldName(...)`
class _$OrderExportCWProxyImpl implements _$OrderExportCWProxy {
  const _$OrderExportCWProxyImpl(this._value);

  final OrderExport _value;

  @override
  OrderExport amountTendered(int? amountTendered) =>
      this(amountTendered: amountTendered);

  @override
  OrderExport branchId(String branchId) => this(branchId: branchId);

  @override
  OrderExport changeGiven(int? changeGiven) => this(changeGiven: changeGiven);

  @override
  OrderExport createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  OrderExport customerName(String? customerName) =>
      this(customerName: customerName);

  @override
  OrderExport deliveryFee(int deliveryFee) => this(deliveryFee: deliveryFee);

  @override
  OrderExport deliveryOrderId(String? deliveryOrderId) =>
      this(deliveryOrderId: deliveryOrderId);

  @override
  OrderExport discountAmount(int discountAmount) =>
      this(discountAmount: discountAmount);

  @override
  OrderExport discountId(String? discountId) => this(discountId: discountId);

  @override
  OrderExport discountType(String? discountType) =>
      this(discountType: discountType);

  @override
  OrderExport discountValue(int discountValue) =>
      this(discountValue: discountValue);

  @override
  OrderExport id(String id) => this(id: id);

  @override
  OrderExport notes(String? notes) => this(notes: notes);

  @override
  OrderExport orderNumber(int orderNumber) => this(orderNumber: orderNumber);

  @override
  OrderExport orderRef(String? orderRef) => this(orderRef: orderRef);

  @override
  OrderExport orderType(String orderType) => this(orderType: orderType);

  @override
  OrderExport paymentMethod(String paymentMethod) =>
      this(paymentMethod: paymentMethod);

  @override
  OrderExport shiftId(String shiftId) => this(shiftId: shiftId);

  @override
  OrderExport status(String status) => this(status: status);

  @override
  OrderExport subtotal(int subtotal) => this(subtotal: subtotal);

  @override
  OrderExport taxAmount(int taxAmount) => this(taxAmount: taxAmount);

  @override
  OrderExport tellerId(String tellerId) => this(tellerId: tellerId);

  @override
  OrderExport tellerName(String tellerName) => this(tellerName: tellerName);

  @override
  OrderExport tipAmount(int? tipAmount) => this(tipAmount: tipAmount);

  @override
  OrderExport tipPaymentMethod(String? tipPaymentMethod) =>
      this(tipPaymentMethod: tipPaymentMethod);

  @override
  OrderExport totalAmount(int totalAmount) => this(totalAmount: totalAmount);

  @override
  OrderExport voidNote(String? voidNote) => this(voidNote: voidNote);

  @override
  OrderExport voidReason(String? voidReason) => this(voidReason: voidReason);

  @override
  OrderExport voidedAt(DateTime? voidedAt) => this(voidedAt: voidedAt);

  @override
  OrderExport voidedBy(String? voidedBy) => this(voidedBy: voidedBy);

  @override
  OrderExport items(List<OrderItemFull> items) => this(items: items);

  @override
  OrderExport payments(List<OrderPayment> payments) => this(payments: payments);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderExport(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderExport(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderExport call({
    Object? amountTendered = const $CopyWithPlaceholder(),
    Object? branchId = const $CopyWithPlaceholder(),
    Object? changeGiven = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? customerName = const $CopyWithPlaceholder(),
    Object? deliveryFee = const $CopyWithPlaceholder(),
    Object? deliveryOrderId = const $CopyWithPlaceholder(),
    Object? discountAmount = const $CopyWithPlaceholder(),
    Object? discountId = const $CopyWithPlaceholder(),
    Object? discountType = const $CopyWithPlaceholder(),
    Object? discountValue = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? notes = const $CopyWithPlaceholder(),
    Object? orderNumber = const $CopyWithPlaceholder(),
    Object? orderRef = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? paymentMethod = const $CopyWithPlaceholder(),
    Object? shiftId = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? subtotal = const $CopyWithPlaceholder(),
    Object? taxAmount = const $CopyWithPlaceholder(),
    Object? tellerId = const $CopyWithPlaceholder(),
    Object? tellerName = const $CopyWithPlaceholder(),
    Object? tipAmount = const $CopyWithPlaceholder(),
    Object? tipPaymentMethod = const $CopyWithPlaceholder(),
    Object? totalAmount = const $CopyWithPlaceholder(),
    Object? voidNote = const $CopyWithPlaceholder(),
    Object? voidReason = const $CopyWithPlaceholder(),
    Object? voidedAt = const $CopyWithPlaceholder(),
    Object? voidedBy = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? payments = const $CopyWithPlaceholder(),
  }) {
    return OrderExport(
      amountTendered: amountTendered == const $CopyWithPlaceholder()
          ? _value.amountTendered
          // ignore: cast_nullable_to_non_nullable
          : amountTendered as int?,
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String,
      changeGiven: changeGiven == const $CopyWithPlaceholder()
          ? _value.changeGiven
          // ignore: cast_nullable_to_non_nullable
          : changeGiven as int?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      customerName: customerName == const $CopyWithPlaceholder()
          ? _value.customerName
          // ignore: cast_nullable_to_non_nullable
          : customerName as String?,
      deliveryFee: deliveryFee == const $CopyWithPlaceholder()
          ? _value.deliveryFee
          // ignore: cast_nullable_to_non_nullable
          : deliveryFee as int,
      deliveryOrderId: deliveryOrderId == const $CopyWithPlaceholder()
          ? _value.deliveryOrderId
          // ignore: cast_nullable_to_non_nullable
          : deliveryOrderId as String?,
      discountAmount: discountAmount == const $CopyWithPlaceholder()
          ? _value.discountAmount
          // ignore: cast_nullable_to_non_nullable
          : discountAmount as int,
      discountId: discountId == const $CopyWithPlaceholder()
          ? _value.discountId
          // ignore: cast_nullable_to_non_nullable
          : discountId as String?,
      discountType: discountType == const $CopyWithPlaceholder()
          ? _value.discountType
          // ignore: cast_nullable_to_non_nullable
          : discountType as String?,
      discountValue: discountValue == const $CopyWithPlaceholder()
          ? _value.discountValue
          // ignore: cast_nullable_to_non_nullable
          : discountValue as int,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      notes: notes == const $CopyWithPlaceholder()
          ? _value.notes
          // ignore: cast_nullable_to_non_nullable
          : notes as String?,
      orderNumber: orderNumber == const $CopyWithPlaceholder()
          ? _value.orderNumber
          // ignore: cast_nullable_to_non_nullable
          : orderNumber as int,
      orderRef: orderRef == const $CopyWithPlaceholder()
          ? _value.orderRef
          // ignore: cast_nullable_to_non_nullable
          : orderRef as String?,
      orderType: orderType == const $CopyWithPlaceholder()
          ? _value.orderType
          // ignore: cast_nullable_to_non_nullable
          : orderType as String,
      paymentMethod: paymentMethod == const $CopyWithPlaceholder()
          ? _value.paymentMethod
          // ignore: cast_nullable_to_non_nullable
          : paymentMethod as String,
      shiftId: shiftId == const $CopyWithPlaceholder()
          ? _value.shiftId
          // ignore: cast_nullable_to_non_nullable
          : shiftId as String,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String,
      subtotal: subtotal == const $CopyWithPlaceholder()
          ? _value.subtotal
          // ignore: cast_nullable_to_non_nullable
          : subtotal as int,
      taxAmount: taxAmount == const $CopyWithPlaceholder()
          ? _value.taxAmount
          // ignore: cast_nullable_to_non_nullable
          : taxAmount as int,
      tellerId: tellerId == const $CopyWithPlaceholder()
          ? _value.tellerId
          // ignore: cast_nullable_to_non_nullable
          : tellerId as String,
      tellerName: tellerName == const $CopyWithPlaceholder()
          ? _value.tellerName
          // ignore: cast_nullable_to_non_nullable
          : tellerName as String,
      tipAmount: tipAmount == const $CopyWithPlaceholder()
          ? _value.tipAmount
          // ignore: cast_nullable_to_non_nullable
          : tipAmount as int?,
      tipPaymentMethod: tipPaymentMethod == const $CopyWithPlaceholder()
          ? _value.tipPaymentMethod
          // ignore: cast_nullable_to_non_nullable
          : tipPaymentMethod as String?,
      totalAmount: totalAmount == const $CopyWithPlaceholder()
          ? _value.totalAmount
          // ignore: cast_nullable_to_non_nullable
          : totalAmount as int,
      voidNote: voidNote == const $CopyWithPlaceholder()
          ? _value.voidNote
          // ignore: cast_nullable_to_non_nullable
          : voidNote as String?,
      voidReason: voidReason == const $CopyWithPlaceholder()
          ? _value.voidReason
          // ignore: cast_nullable_to_non_nullable
          : voidReason as String?,
      voidedAt: voidedAt == const $CopyWithPlaceholder()
          ? _value.voidedAt
          // ignore: cast_nullable_to_non_nullable
          : voidedAt as DateTime?,
      voidedBy: voidedBy == const $CopyWithPlaceholder()
          ? _value.voidedBy
          // ignore: cast_nullable_to_non_nullable
          : voidedBy as String?,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<OrderItemFull>,
      payments: payments == const $CopyWithPlaceholder()
          ? _value.payments
          // ignore: cast_nullable_to_non_nullable
          : payments as List<OrderPayment>,
    );
  }
}

extension $OrderExportCopyWith on OrderExport {
  /// Returns a callable class that can be used as follows: `instanceOfOrderExport.copyWith(...)` or like so:`instanceOfOrderExport.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderExportCWProxy get copyWith => _$OrderExportCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderExport _$OrderExportFromJson(Map<String, dynamic> json) => $checkedCreate(
  'OrderExport',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'branch_id',
        'created_at',
        'delivery_fee',
        'discount_amount',
        'discount_value',
        'id',
        'order_number',
        'order_type',
        'payment_method',
        'shift_id',
        'status',
        'subtotal',
        'tax_amount',
        'teller_id',
        'teller_name',
        'total_amount',
        'items',
        'payments',
      ],
    );
    final val = OrderExport(
      amountTendered: $checkedConvert(
        'amount_tendered',
        (v) => (v as num?)?.toInt(),
      ),
      branchId: $checkedConvert('branch_id', (v) => v as String),
      changeGiven: $checkedConvert('change_given', (v) => (v as num?)?.toInt()),
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      customerName: $checkedConvert('customer_name', (v) => v as String?),
      deliveryFee: $checkedConvert('delivery_fee', (v) => (v as num).toInt()),
      deliveryOrderId: $checkedConvert(
        'delivery_order_id',
        (v) => v as String?,
      ),
      discountAmount: $checkedConvert(
        'discount_amount',
        (v) => (v as num).toInt(),
      ),
      discountId: $checkedConvert('discount_id', (v) => v as String?),
      discountType: $checkedConvert('discount_type', (v) => v as String?),
      discountValue: $checkedConvert(
        'discount_value',
        (v) => (v as num).toInt(),
      ),
      id: $checkedConvert('id', (v) => v as String),
      notes: $checkedConvert('notes', (v) => v as String?),
      orderNumber: $checkedConvert('order_number', (v) => (v as num).toInt()),
      orderRef: $checkedConvert('order_ref', (v) => v as String?),
      orderType: $checkedConvert('order_type', (v) => v as String),
      paymentMethod: $checkedConvert('payment_method', (v) => v as String),
      shiftId: $checkedConvert('shift_id', (v) => v as String),
      status: $checkedConvert('status', (v) => v as String),
      subtotal: $checkedConvert('subtotal', (v) => (v as num).toInt()),
      taxAmount: $checkedConvert('tax_amount', (v) => (v as num).toInt()),
      tellerId: $checkedConvert('teller_id', (v) => v as String),
      tellerName: $checkedConvert('teller_name', (v) => v as String),
      tipAmount: $checkedConvert('tip_amount', (v) => (v as num?)?.toInt()),
      tipPaymentMethod: $checkedConvert(
        'tip_payment_method',
        (v) => v as String?,
      ),
      totalAmount: $checkedConvert('total_amount', (v) => (v as num).toInt()),
      voidNote: $checkedConvert('void_note', (v) => v as String?),
      voidReason: $checkedConvert('void_reason', (v) => v as String?),
      voidedAt: $checkedConvert(
        'voided_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      voidedBy: $checkedConvert('voided_by', (v) => v as String?),
      items: $checkedConvert(
        'items',
        (v) => (v as List<dynamic>)
            .map((e) => OrderItemFull.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      payments: $checkedConvert(
        'payments',
        (v) => (v as List<dynamic>)
            .map((e) => OrderPayment.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'amountTendered': 'amount_tendered',
    'branchId': 'branch_id',
    'changeGiven': 'change_given',
    'createdAt': 'created_at',
    'customerName': 'customer_name',
    'deliveryFee': 'delivery_fee',
    'deliveryOrderId': 'delivery_order_id',
    'discountAmount': 'discount_amount',
    'discountId': 'discount_id',
    'discountType': 'discount_type',
    'discountValue': 'discount_value',
    'orderNumber': 'order_number',
    'orderRef': 'order_ref',
    'orderType': 'order_type',
    'paymentMethod': 'payment_method',
    'shiftId': 'shift_id',
    'taxAmount': 'tax_amount',
    'tellerId': 'teller_id',
    'tellerName': 'teller_name',
    'tipAmount': 'tip_amount',
    'tipPaymentMethod': 'tip_payment_method',
    'totalAmount': 'total_amount',
    'voidNote': 'void_note',
    'voidReason': 'void_reason',
    'voidedAt': 'voided_at',
    'voidedBy': 'voided_by',
  },
);

Map<String, dynamic> _$OrderExportToJson(OrderExport instance) =>
    <String, dynamic>{
      'amount_tendered': ?instance.amountTendered,
      'branch_id': instance.branchId,
      'change_given': ?instance.changeGiven,
      'created_at': instance.createdAt.toIso8601String(),
      'customer_name': ?instance.customerName,
      'delivery_fee': instance.deliveryFee,
      'delivery_order_id': ?instance.deliveryOrderId,
      'discount_amount': instance.discountAmount,
      'discount_id': ?instance.discountId,
      'discount_type': ?instance.discountType,
      'discount_value': instance.discountValue,
      'id': instance.id,
      'notes': ?instance.notes,
      'order_number': instance.orderNumber,
      'order_ref': ?instance.orderRef,
      'order_type': instance.orderType,
      'payment_method': instance.paymentMethod,
      'shift_id': instance.shiftId,
      'status': instance.status,
      'subtotal': instance.subtotal,
      'tax_amount': instance.taxAmount,
      'teller_id': instance.tellerId,
      'teller_name': instance.tellerName,
      'tip_amount': ?instance.tipAmount,
      'tip_payment_method': ?instance.tipPaymentMethod,
      'total_amount': instance.totalAmount,
      'void_note': ?instance.voidNote,
      'void_reason': ?instance.voidReason,
      'voided_at': ?instance.voidedAt?.toIso8601String(),
      'voided_by': ?instance.voidedBy,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'payments': instance.payments.map((e) => e.toJson()).toList(),
    };
