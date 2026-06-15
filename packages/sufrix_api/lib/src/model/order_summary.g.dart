// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_summary.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderSummaryCWProxy {
  OrderSummary completed(int completed);

  OrderSummary deliveryFees(int? deliveryFees);

  OrderSummary discounts(int discounts);

  OrderSummary revenue(int revenue);

  OrderSummary tips(int tips);

  OrderSummary voided(int voided);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderSummary(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderSummary(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderSummary call({
    int completed,
    int? deliveryFees,
    int discounts,
    int revenue,
    int tips,
    int voided,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderSummary.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderSummary.copyWith.fieldName(...)`
class _$OrderSummaryCWProxyImpl implements _$OrderSummaryCWProxy {
  const _$OrderSummaryCWProxyImpl(this._value);

  final OrderSummary _value;

  @override
  OrderSummary completed(int completed) => this(completed: completed);

  @override
  OrderSummary deliveryFees(int? deliveryFees) =>
      this(deliveryFees: deliveryFees);

  @override
  OrderSummary discounts(int discounts) => this(discounts: discounts);

  @override
  OrderSummary revenue(int revenue) => this(revenue: revenue);

  @override
  OrderSummary tips(int tips) => this(tips: tips);

  @override
  OrderSummary voided(int voided) => this(voided: voided);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderSummary(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderSummary(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderSummary call({
    Object? completed = const $CopyWithPlaceholder(),
    Object? deliveryFees = const $CopyWithPlaceholder(),
    Object? discounts = const $CopyWithPlaceholder(),
    Object? revenue = const $CopyWithPlaceholder(),
    Object? tips = const $CopyWithPlaceholder(),
    Object? voided = const $CopyWithPlaceholder(),
  }) {
    return OrderSummary(
      completed: completed == const $CopyWithPlaceholder()
          ? _value.completed
          // ignore: cast_nullable_to_non_nullable
          : completed as int,
      deliveryFees: deliveryFees == const $CopyWithPlaceholder()
          ? _value.deliveryFees
          // ignore: cast_nullable_to_non_nullable
          : deliveryFees as int?,
      discounts: discounts == const $CopyWithPlaceholder()
          ? _value.discounts
          // ignore: cast_nullable_to_non_nullable
          : discounts as int,
      revenue: revenue == const $CopyWithPlaceholder()
          ? _value.revenue
          // ignore: cast_nullable_to_non_nullable
          : revenue as int,
      tips: tips == const $CopyWithPlaceholder()
          ? _value.tips
          // ignore: cast_nullable_to_non_nullable
          : tips as int,
      voided: voided == const $CopyWithPlaceholder()
          ? _value.voided
          // ignore: cast_nullable_to_non_nullable
          : voided as int,
    );
  }
}

extension $OrderSummaryCopyWith on OrderSummary {
  /// Returns a callable class that can be used as follows: `instanceOfOrderSummary.copyWith(...)` or like so:`instanceOfOrderSummary.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderSummaryCWProxy get copyWith => _$OrderSummaryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderSummary _$OrderSummaryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderSummary', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['completed', 'discounts', 'revenue', 'tips', 'voided'],
  );
  final val = OrderSummary(
    completed: $checkedConvert('completed', (v) => (v as num).toInt()),
    deliveryFees: $checkedConvert('delivery_fees', (v) => (v as num?)?.toInt()),
    discounts: $checkedConvert('discounts', (v) => (v as num).toInt()),
    revenue: $checkedConvert('revenue', (v) => (v as num).toInt()),
    tips: $checkedConvert('tips', (v) => (v as num).toInt()),
    voided: $checkedConvert('voided', (v) => (v as num).toInt()),
  );
  return val;
}, fieldKeyMap: const {'deliveryFees': 'delivery_fees'});

Map<String, dynamic> _$OrderSummaryToJson(OrderSummary instance) =>
    <String, dynamic>{
      'completed': instance.completed,
      'delivery_fees': ?instance.deliveryFees,
      'discounts': instance.discounts,
      'revenue': instance.revenue,
      'tips': instance.tips,
      'voided': instance.voided,
    };
