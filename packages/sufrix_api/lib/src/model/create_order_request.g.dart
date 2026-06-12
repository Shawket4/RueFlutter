// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateOrderRequestCWProxy {
  CreateOrderRequest amountTendered(int? amountTendered);

  CreateOrderRequest branchId(String branchId);

  CreateOrderRequest createdAt(DateTime? createdAt);

  CreateOrderRequest customerName(String? customerName);

  CreateOrderRequest discountId(String? discountId);

  CreateOrderRequest discountType(String? discountType);

  CreateOrderRequest discountValue(int? discountValue);

  CreateOrderRequest items(List<OrderItemInput> items);

  CreateOrderRequest notes(String? notes);

  CreateOrderRequest paymentMethod(String paymentMethod);

  CreateOrderRequest paymentSplits(List<PaymentSplitInput>? paymentSplits);

  CreateOrderRequest shiftId(String shiftId);

  CreateOrderRequest tipAmount(int? tipAmount);

  CreateOrderRequest tipPaymentMethod(String? tipPaymentMethod);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateOrderRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateOrderRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateOrderRequest call({
    int? amountTendered,
    String branchId,
    DateTime? createdAt,
    String? customerName,
    String? discountId,
    String? discountType,
    int? discountValue,
    List<OrderItemInput> items,
    String? notes,
    String paymentMethod,
    List<PaymentSplitInput>? paymentSplits,
    String shiftId,
    int? tipAmount,
    String? tipPaymentMethod,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCreateOrderRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCreateOrderRequest.copyWith.fieldName(...)`
class _$CreateOrderRequestCWProxyImpl implements _$CreateOrderRequestCWProxy {
  const _$CreateOrderRequestCWProxyImpl(this._value);

  final CreateOrderRequest _value;

  @override
  CreateOrderRequest amountTendered(int? amountTendered) =>
      this(amountTendered: amountTendered);

  @override
  CreateOrderRequest branchId(String branchId) => this(branchId: branchId);

  @override
  CreateOrderRequest createdAt(DateTime? createdAt) =>
      this(createdAt: createdAt);

  @override
  CreateOrderRequest customerName(String? customerName) =>
      this(customerName: customerName);

  @override
  CreateOrderRequest discountId(String? discountId) =>
      this(discountId: discountId);

  @override
  CreateOrderRequest discountType(String? discountType) =>
      this(discountType: discountType);

  @override
  CreateOrderRequest discountValue(int? discountValue) =>
      this(discountValue: discountValue);

  @override
  CreateOrderRequest items(List<OrderItemInput> items) => this(items: items);

  @override
  CreateOrderRequest notes(String? notes) => this(notes: notes);

  @override
  CreateOrderRequest paymentMethod(String paymentMethod) =>
      this(paymentMethod: paymentMethod);

  @override
  CreateOrderRequest paymentSplits(List<PaymentSplitInput>? paymentSplits) =>
      this(paymentSplits: paymentSplits);

  @override
  CreateOrderRequest shiftId(String shiftId) => this(shiftId: shiftId);

  @override
  CreateOrderRequest tipAmount(int? tipAmount) => this(tipAmount: tipAmount);

  @override
  CreateOrderRequest tipPaymentMethod(String? tipPaymentMethod) =>
      this(tipPaymentMethod: tipPaymentMethod);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateOrderRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateOrderRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateOrderRequest call({
    Object? amountTendered = const $CopyWithPlaceholder(),
    Object? branchId = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? customerName = const $CopyWithPlaceholder(),
    Object? discountId = const $CopyWithPlaceholder(),
    Object? discountType = const $CopyWithPlaceholder(),
    Object? discountValue = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? notes = const $CopyWithPlaceholder(),
    Object? paymentMethod = const $CopyWithPlaceholder(),
    Object? paymentSplits = const $CopyWithPlaceholder(),
    Object? shiftId = const $CopyWithPlaceholder(),
    Object? tipAmount = const $CopyWithPlaceholder(),
    Object? tipPaymentMethod = const $CopyWithPlaceholder(),
  }) {
    return CreateOrderRequest(
      amountTendered: amountTendered == const $CopyWithPlaceholder()
          ? _value.amountTendered
          // ignore: cast_nullable_to_non_nullable
          : amountTendered as int?,
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime?,
      customerName: customerName == const $CopyWithPlaceholder()
          ? _value.customerName
          // ignore: cast_nullable_to_non_nullable
          : customerName as String?,
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
          : discountValue as int?,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<OrderItemInput>,
      notes: notes == const $CopyWithPlaceholder()
          ? _value.notes
          // ignore: cast_nullable_to_non_nullable
          : notes as String?,
      paymentMethod: paymentMethod == const $CopyWithPlaceholder()
          ? _value.paymentMethod
          // ignore: cast_nullable_to_non_nullable
          : paymentMethod as String,
      paymentSplits: paymentSplits == const $CopyWithPlaceholder()
          ? _value.paymentSplits
          // ignore: cast_nullable_to_non_nullable
          : paymentSplits as List<PaymentSplitInput>?,
      shiftId: shiftId == const $CopyWithPlaceholder()
          ? _value.shiftId
          // ignore: cast_nullable_to_non_nullable
          : shiftId as String,
      tipAmount: tipAmount == const $CopyWithPlaceholder()
          ? _value.tipAmount
          // ignore: cast_nullable_to_non_nullable
          : tipAmount as int?,
      tipPaymentMethod: tipPaymentMethod == const $CopyWithPlaceholder()
          ? _value.tipPaymentMethod
          // ignore: cast_nullable_to_non_nullable
          : tipPaymentMethod as String?,
    );
  }
}

extension $CreateOrderRequestCopyWith on CreateOrderRequest {
  /// Returns a callable class that can be used as follows: `instanceOfCreateOrderRequest.copyWith(...)` or like so:`instanceOfCreateOrderRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateOrderRequestCWProxy get copyWith =>
      _$CreateOrderRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderRequest _$CreateOrderRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'CreateOrderRequest',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['branch_id', 'items', 'payment_method', 'shift_id'],
    );
    final val = CreateOrderRequest(
      amountTendered: $checkedConvert(
        'amount_tendered',
        (v) => (v as num?)?.toInt(),
      ),
      branchId: $checkedConvert('branch_id', (v) => v as String),
      createdAt: $checkedConvert(
        'created_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      customerName: $checkedConvert('customer_name', (v) => v as String?),
      discountId: $checkedConvert('discount_id', (v) => v as String?),
      discountType: $checkedConvert('discount_type', (v) => v as String?),
      discountValue: $checkedConvert(
        'discount_value',
        (v) => (v as num?)?.toInt(),
      ),
      items: $checkedConvert(
        'items',
        (v) => (v as List<dynamic>)
            .map((e) => OrderItemInput.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      notes: $checkedConvert('notes', (v) => v as String?),
      paymentMethod: $checkedConvert('payment_method', (v) => v as String),
      paymentSplits: $checkedConvert(
        'payment_splits',
        (v) => (v as List<dynamic>?)
            ?.map((e) => PaymentSplitInput.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      shiftId: $checkedConvert('shift_id', (v) => v as String),
      tipAmount: $checkedConvert('tip_amount', (v) => (v as num?)?.toInt()),
      tipPaymentMethod: $checkedConvert(
        'tip_payment_method',
        (v) => v as String?,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'amountTendered': 'amount_tendered',
    'branchId': 'branch_id',
    'createdAt': 'created_at',
    'customerName': 'customer_name',
    'discountId': 'discount_id',
    'discountType': 'discount_type',
    'discountValue': 'discount_value',
    'paymentMethod': 'payment_method',
    'paymentSplits': 'payment_splits',
    'shiftId': 'shift_id',
    'tipAmount': 'tip_amount',
    'tipPaymentMethod': 'tip_payment_method',
  },
);

Map<String, dynamic> _$CreateOrderRequestToJson(
  CreateOrderRequest instance,
) => <String, dynamic>{
  'amount_tendered': ?instance.amountTendered,
  'branch_id': instance.branchId,
  'created_at': ?instance.createdAt?.toIso8601String(),
  'customer_name': ?instance.customerName,
  'discount_id': ?instance.discountId,
  'discount_type': ?instance.discountType,
  'discount_value': ?instance.discountValue,
  'items': instance.items.map((e) => e.toJson()).toList(),
  'notes': ?instance.notes,
  'payment_method': instance.paymentMethod,
  'payment_splits': ?instance.paymentSplits?.map((e) => e.toJson()).toList(),
  'shift_id': instance.shiftId,
  'tip_amount': ?instance.tipAmount,
  'tip_payment_method': ?instance.tipPaymentMethod,
};
