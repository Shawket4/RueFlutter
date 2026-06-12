// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teller_stats.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TellerStatsCWProxy {
  TellerStats avgOrderValue(int avgOrderValue);

  TellerStats orders(int orders);

  TellerStats revenue(int revenue);

  TellerStats shifts(int shifts);

  TellerStats tellerId(String tellerId);

  TellerStats tellerName(String tellerName);

  TellerStats voided(int voided);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TellerStats(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TellerStats(...).copyWith(id: 12, name: "My name")
  /// ````
  TellerStats call({
    int avgOrderValue,
    int orders,
    int revenue,
    int shifts,
    String tellerId,
    String tellerName,
    int voided,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTellerStats.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTellerStats.copyWith.fieldName(...)`
class _$TellerStatsCWProxyImpl implements _$TellerStatsCWProxy {
  const _$TellerStatsCWProxyImpl(this._value);

  final TellerStats _value;

  @override
  TellerStats avgOrderValue(int avgOrderValue) =>
      this(avgOrderValue: avgOrderValue);

  @override
  TellerStats orders(int orders) => this(orders: orders);

  @override
  TellerStats revenue(int revenue) => this(revenue: revenue);

  @override
  TellerStats shifts(int shifts) => this(shifts: shifts);

  @override
  TellerStats tellerId(String tellerId) => this(tellerId: tellerId);

  @override
  TellerStats tellerName(String tellerName) => this(tellerName: tellerName);

  @override
  TellerStats voided(int voided) => this(voided: voided);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TellerStats(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TellerStats(...).copyWith(id: 12, name: "My name")
  /// ````
  TellerStats call({
    Object? avgOrderValue = const $CopyWithPlaceholder(),
    Object? orders = const $CopyWithPlaceholder(),
    Object? revenue = const $CopyWithPlaceholder(),
    Object? shifts = const $CopyWithPlaceholder(),
    Object? tellerId = const $CopyWithPlaceholder(),
    Object? tellerName = const $CopyWithPlaceholder(),
    Object? voided = const $CopyWithPlaceholder(),
  }) {
    return TellerStats(
      avgOrderValue: avgOrderValue == const $CopyWithPlaceholder()
          ? _value.avgOrderValue
          // ignore: cast_nullable_to_non_nullable
          : avgOrderValue as int,
      orders: orders == const $CopyWithPlaceholder()
          ? _value.orders
          // ignore: cast_nullable_to_non_nullable
          : orders as int,
      revenue: revenue == const $CopyWithPlaceholder()
          ? _value.revenue
          // ignore: cast_nullable_to_non_nullable
          : revenue as int,
      shifts: shifts == const $CopyWithPlaceholder()
          ? _value.shifts
          // ignore: cast_nullable_to_non_nullable
          : shifts as int,
      tellerId: tellerId == const $CopyWithPlaceholder()
          ? _value.tellerId
          // ignore: cast_nullable_to_non_nullable
          : tellerId as String,
      tellerName: tellerName == const $CopyWithPlaceholder()
          ? _value.tellerName
          // ignore: cast_nullable_to_non_nullable
          : tellerName as String,
      voided: voided == const $CopyWithPlaceholder()
          ? _value.voided
          // ignore: cast_nullable_to_non_nullable
          : voided as int,
    );
  }
}

extension $TellerStatsCopyWith on TellerStats {
  /// Returns a callable class that can be used as follows: `instanceOfTellerStats.copyWith(...)` or like so:`instanceOfTellerStats.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TellerStatsCWProxy get copyWith => _$TellerStatsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TellerStats _$TellerStatsFromJson(Map<String, dynamic> json) => $checkedCreate(
  'TellerStats',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'avg_order_value',
        'orders',
        'revenue',
        'shifts',
        'teller_id',
        'teller_name',
        'voided',
      ],
    );
    final val = TellerStats(
      avgOrderValue: $checkedConvert(
        'avg_order_value',
        (v) => (v as num).toInt(),
      ),
      orders: $checkedConvert('orders', (v) => (v as num).toInt()),
      revenue: $checkedConvert('revenue', (v) => (v as num).toInt()),
      shifts: $checkedConvert('shifts', (v) => (v as num).toInt()),
      tellerId: $checkedConvert('teller_id', (v) => v as String),
      tellerName: $checkedConvert('teller_name', (v) => v as String),
      voided: $checkedConvert('voided', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'avgOrderValue': 'avg_order_value',
    'tellerId': 'teller_id',
    'tellerName': 'teller_name',
  },
);

Map<String, dynamic> _$TellerStatsToJson(TellerStats instance) =>
    <String, dynamic>{
      'avg_order_value': instance.avgOrderValue,
      'orders': instance.orders,
      'revenue': instance.revenue,
      'shifts': instance.shifts,
      'teller_id': instance.tellerId,
      'teller_name': instance.tellerName,
      'voided': instance.voided,
    };
