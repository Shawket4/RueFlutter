// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bundle_performance_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BundlePerformanceResponseCWProxy {
  BundlePerformanceResponse componentPopularity(
    List<ComponentPopularity> componentPopularity,
  );

  BundlePerformanceResponse grossRevenue(int grossRevenue);

  BundlePerformanceResponse netProfit(int netProfit);

  BundlePerformanceResponse salesVolume(int salesVolume);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BundlePerformanceResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BundlePerformanceResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  BundlePerformanceResponse call({
    List<ComponentPopularity> componentPopularity,
    int grossRevenue,
    int netProfit,
    int salesVolume,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBundlePerformanceResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBundlePerformanceResponse.copyWith.fieldName(...)`
class _$BundlePerformanceResponseCWProxyImpl
    implements _$BundlePerformanceResponseCWProxy {
  const _$BundlePerformanceResponseCWProxyImpl(this._value);

  final BundlePerformanceResponse _value;

  @override
  BundlePerformanceResponse componentPopularity(
    List<ComponentPopularity> componentPopularity,
  ) => this(componentPopularity: componentPopularity);

  @override
  BundlePerformanceResponse grossRevenue(int grossRevenue) =>
      this(grossRevenue: grossRevenue);

  @override
  BundlePerformanceResponse netProfit(int netProfit) =>
      this(netProfit: netProfit);

  @override
  BundlePerformanceResponse salesVolume(int salesVolume) =>
      this(salesVolume: salesVolume);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BundlePerformanceResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BundlePerformanceResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  BundlePerformanceResponse call({
    Object? componentPopularity = const $CopyWithPlaceholder(),
    Object? grossRevenue = const $CopyWithPlaceholder(),
    Object? netProfit = const $CopyWithPlaceholder(),
    Object? salesVolume = const $CopyWithPlaceholder(),
  }) {
    return BundlePerformanceResponse(
      componentPopularity: componentPopularity == const $CopyWithPlaceholder()
          ? _value.componentPopularity
          // ignore: cast_nullable_to_non_nullable
          : componentPopularity as List<ComponentPopularity>,
      grossRevenue: grossRevenue == const $CopyWithPlaceholder()
          ? _value.grossRevenue
          // ignore: cast_nullable_to_non_nullable
          : grossRevenue as int,
      netProfit: netProfit == const $CopyWithPlaceholder()
          ? _value.netProfit
          // ignore: cast_nullable_to_non_nullable
          : netProfit as int,
      salesVolume: salesVolume == const $CopyWithPlaceholder()
          ? _value.salesVolume
          // ignore: cast_nullable_to_non_nullable
          : salesVolume as int,
    );
  }
}

extension $BundlePerformanceResponseCopyWith on BundlePerformanceResponse {
  /// Returns a callable class that can be used as follows: `instanceOfBundlePerformanceResponse.copyWith(...)` or like so:`instanceOfBundlePerformanceResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BundlePerformanceResponseCWProxy get copyWith =>
      _$BundlePerformanceResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BundlePerformanceResponse _$BundlePerformanceResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'BundlePerformanceResponse',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'component_popularity',
        'gross_revenue',
        'net_profit',
        'sales_volume',
      ],
    );
    final val = BundlePerformanceResponse(
      componentPopularity: $checkedConvert(
        'component_popularity',
        (v) => (v as List<dynamic>)
            .map((e) => ComponentPopularity.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      grossRevenue: $checkedConvert('gross_revenue', (v) => (v as num).toInt()),
      netProfit: $checkedConvert('net_profit', (v) => (v as num).toInt()),
      salesVolume: $checkedConvert('sales_volume', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'componentPopularity': 'component_popularity',
    'grossRevenue': 'gross_revenue',
    'netProfit': 'net_profit',
    'salesVolume': 'sales_volume',
  },
);

Map<String, dynamic> _$BundlePerformanceResponseToJson(
  BundlePerformanceResponse instance,
) => <String, dynamic>{
  'component_popularity': instance.componentPopularity
      .map((e) => e.toJson())
      .toList(),
  'gross_revenue': instance.grossRevenue,
  'net_profit': instance.netProfit,
  'sales_volume': instance.salesVolume,
};
