// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeseries_point.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TimeseriesPointCWProxy {
  TimeseriesPoint discount(int discount);

  TimeseriesPoint orders(int orders);

  TimeseriesPoint period(String period);

  TimeseriesPoint revenue(int revenue);

  TimeseriesPoint revenueByMethod(Object? revenueByMethod);

  TimeseriesPoint tax(int tax);

  TimeseriesPoint voided(int voided);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TimeseriesPoint(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TimeseriesPoint(...).copyWith(id: 12, name: "My name")
  /// ````
  TimeseriesPoint call({
    int discount,
    int orders,
    String period,
    int revenue,
    Object? revenueByMethod,
    int tax,
    int voided,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTimeseriesPoint.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTimeseriesPoint.copyWith.fieldName(...)`
class _$TimeseriesPointCWProxyImpl implements _$TimeseriesPointCWProxy {
  const _$TimeseriesPointCWProxyImpl(this._value);

  final TimeseriesPoint _value;

  @override
  TimeseriesPoint discount(int discount) => this(discount: discount);

  @override
  TimeseriesPoint orders(int orders) => this(orders: orders);

  @override
  TimeseriesPoint period(String period) => this(period: period);

  @override
  TimeseriesPoint revenue(int revenue) => this(revenue: revenue);

  @override
  TimeseriesPoint revenueByMethod(Object? revenueByMethod) =>
      this(revenueByMethod: revenueByMethod);

  @override
  TimeseriesPoint tax(int tax) => this(tax: tax);

  @override
  TimeseriesPoint voided(int voided) => this(voided: voided);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TimeseriesPoint(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TimeseriesPoint(...).copyWith(id: 12, name: "My name")
  /// ````
  TimeseriesPoint call({
    Object? discount = const $CopyWithPlaceholder(),
    Object? orders = const $CopyWithPlaceholder(),
    Object? period = const $CopyWithPlaceholder(),
    Object? revenue = const $CopyWithPlaceholder(),
    Object? revenueByMethod = const $CopyWithPlaceholder(),
    Object? tax = const $CopyWithPlaceholder(),
    Object? voided = const $CopyWithPlaceholder(),
  }) {
    return TimeseriesPoint(
      discount: discount == const $CopyWithPlaceholder()
          ? _value.discount
          // ignore: cast_nullable_to_non_nullable
          : discount as int,
      orders: orders == const $CopyWithPlaceholder()
          ? _value.orders
          // ignore: cast_nullable_to_non_nullable
          : orders as int,
      period: period == const $CopyWithPlaceholder()
          ? _value.period
          // ignore: cast_nullable_to_non_nullable
          : period as String,
      revenue: revenue == const $CopyWithPlaceholder()
          ? _value.revenue
          // ignore: cast_nullable_to_non_nullable
          : revenue as int,
      revenueByMethod: revenueByMethod == const $CopyWithPlaceholder()
          ? _value.revenueByMethod
          // ignore: cast_nullable_to_non_nullable
          : revenueByMethod as Object?,
      tax: tax == const $CopyWithPlaceholder()
          ? _value.tax
          // ignore: cast_nullable_to_non_nullable
          : tax as int,
      voided: voided == const $CopyWithPlaceholder()
          ? _value.voided
          // ignore: cast_nullable_to_non_nullable
          : voided as int,
    );
  }
}

extension $TimeseriesPointCopyWith on TimeseriesPoint {
  /// Returns a callable class that can be used as follows: `instanceOfTimeseriesPoint.copyWith(...)` or like so:`instanceOfTimeseriesPoint.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TimeseriesPointCWProxy get copyWith => _$TimeseriesPointCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeseriesPoint _$TimeseriesPointFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'TimeseriesPoint',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'discount',
            'orders',
            'period',
            'revenue',
            'revenue_by_method',
            'tax',
            'voided',
          ],
        );
        final val = TimeseriesPoint(
          discount: $checkedConvert('discount', (v) => (v as num).toInt()),
          orders: $checkedConvert('orders', (v) => (v as num).toInt()),
          period: $checkedConvert('period', (v) => v as String),
          revenue: $checkedConvert('revenue', (v) => (v as num).toInt()),
          revenueByMethod: $checkedConvert('revenue_by_method', (v) => v),
          tax: $checkedConvert('tax', (v) => (v as num).toInt()),
          voided: $checkedConvert('voided', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {'revenueByMethod': 'revenue_by_method'},
    );

Map<String, dynamic> _$TimeseriesPointToJson(TimeseriesPoint instance) =>
    <String, dynamic>{
      'discount': instance.discount,
      'orders': instance.orders,
      'period': instance.period,
      'revenue': instance.revenue,
      'revenue_by_method': instance.revenueByMethod,
      'tax': instance.tax,
      'voided': instance.voided,
    };
