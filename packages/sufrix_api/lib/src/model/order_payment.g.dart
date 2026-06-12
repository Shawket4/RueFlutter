// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_payment.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderPaymentCWProxy {
  OrderPayment amount(int amount);

  OrderPayment id(String id);

  OrderPayment method(String method);

  OrderPayment orderId(String orderId);

  OrderPayment reference(String? reference);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderPayment(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderPayment(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderPayment call({
    int amount,
    String id,
    String method,
    String orderId,
    String? reference,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderPayment.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderPayment.copyWith.fieldName(...)`
class _$OrderPaymentCWProxyImpl implements _$OrderPaymentCWProxy {
  const _$OrderPaymentCWProxyImpl(this._value);

  final OrderPayment _value;

  @override
  OrderPayment amount(int amount) => this(amount: amount);

  @override
  OrderPayment id(String id) => this(id: id);

  @override
  OrderPayment method(String method) => this(method: method);

  @override
  OrderPayment orderId(String orderId) => this(orderId: orderId);

  @override
  OrderPayment reference(String? reference) => this(reference: reference);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderPayment(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderPayment(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderPayment call({
    Object? amount = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? method = const $CopyWithPlaceholder(),
    Object? orderId = const $CopyWithPlaceholder(),
    Object? reference = const $CopyWithPlaceholder(),
  }) {
    return OrderPayment(
      amount: amount == const $CopyWithPlaceholder()
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as int,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      method: method == const $CopyWithPlaceholder()
          ? _value.method
          // ignore: cast_nullable_to_non_nullable
          : method as String,
      orderId: orderId == const $CopyWithPlaceholder()
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      reference: reference == const $CopyWithPlaceholder()
          ? _value.reference
          // ignore: cast_nullable_to_non_nullable
          : reference as String?,
    );
  }
}

extension $OrderPaymentCopyWith on OrderPayment {
  /// Returns a callable class that can be used as follows: `instanceOfOrderPayment.copyWith(...)` or like so:`instanceOfOrderPayment.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderPaymentCWProxy get copyWith => _$OrderPaymentCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderPayment _$OrderPaymentFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderPayment', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['amount', 'id', 'method', 'order_id'],
      );
      final val = OrderPayment(
        amount: $checkedConvert('amount', (v) => (v as num).toInt()),
        id: $checkedConvert('id', (v) => v as String),
        method: $checkedConvert('method', (v) => v as String),
        orderId: $checkedConvert('order_id', (v) => v as String),
        reference: $checkedConvert('reference', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {'orderId': 'order_id'});

Map<String, dynamic> _$OrderPaymentToJson(OrderPayment instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'id': instance.id,
      'method': instance.method,
      'order_id': instance.orderId,
      'reference': ?instance.reference,
    };
