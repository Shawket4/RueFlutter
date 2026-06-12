// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_summary_row.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaymentSummaryRowCWProxy {
  PaymentSummaryRow isCash(bool isCash);

  PaymentSummaryRow orderCount(int orderCount);

  PaymentSummaryRow paymentMethod(String paymentMethod);

  PaymentSummaryRow total(int total);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaymentSummaryRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaymentSummaryRow(...).copyWith(id: 12, name: "My name")
  /// ````
  PaymentSummaryRow call({
    bool isCash,
    int orderCount,
    String paymentMethod,
    int total,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPaymentSummaryRow.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPaymentSummaryRow.copyWith.fieldName(...)`
class _$PaymentSummaryRowCWProxyImpl implements _$PaymentSummaryRowCWProxy {
  const _$PaymentSummaryRowCWProxyImpl(this._value);

  final PaymentSummaryRow _value;

  @override
  PaymentSummaryRow isCash(bool isCash) => this(isCash: isCash);

  @override
  PaymentSummaryRow orderCount(int orderCount) => this(orderCount: orderCount);

  @override
  PaymentSummaryRow paymentMethod(String paymentMethod) =>
      this(paymentMethod: paymentMethod);

  @override
  PaymentSummaryRow total(int total) => this(total: total);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaymentSummaryRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaymentSummaryRow(...).copyWith(id: 12, name: "My name")
  /// ````
  PaymentSummaryRow call({
    Object? isCash = const $CopyWithPlaceholder(),
    Object? orderCount = const $CopyWithPlaceholder(),
    Object? paymentMethod = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
  }) {
    return PaymentSummaryRow(
      isCash: isCash == const $CopyWithPlaceholder()
          ? _value.isCash
          // ignore: cast_nullable_to_non_nullable
          : isCash as bool,
      orderCount: orderCount == const $CopyWithPlaceholder()
          ? _value.orderCount
          // ignore: cast_nullable_to_non_nullable
          : orderCount as int,
      paymentMethod: paymentMethod == const $CopyWithPlaceholder()
          ? _value.paymentMethod
          // ignore: cast_nullable_to_non_nullable
          : paymentMethod as String,
      total: total == const $CopyWithPlaceholder()
          ? _value.total
          // ignore: cast_nullable_to_non_nullable
          : total as int,
    );
  }
}

extension $PaymentSummaryRowCopyWith on PaymentSummaryRow {
  /// Returns a callable class that can be used as follows: `instanceOfPaymentSummaryRow.copyWith(...)` or like so:`instanceOfPaymentSummaryRow.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaymentSummaryRowCWProxy get copyWith =>
      _$PaymentSummaryRowCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentSummaryRow _$PaymentSummaryRowFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PaymentSummaryRow',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'is_cash',
            'order_count',
            'payment_method',
            'total',
          ],
        );
        final val = PaymentSummaryRow(
          isCash: $checkedConvert('is_cash', (v) => v as bool),
          orderCount: $checkedConvert('order_count', (v) => (v as num).toInt()),
          paymentMethod: $checkedConvert('payment_method', (v) => v as String),
          total: $checkedConvert('total', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'isCash': 'is_cash',
        'orderCount': 'order_count',
        'paymentMethod': 'payment_method',
      },
    );

Map<String, dynamic> _$PaymentSummaryRowToJson(PaymentSummaryRow instance) =>
    <String, dynamic>{
      'is_cash': instance.isCash,
      'order_count': instance.orderCount,
      'payment_method': instance.paymentMethod,
      'total': instance.total,
    };
