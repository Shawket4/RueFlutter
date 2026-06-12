// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_comparison.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BranchComparisonCWProxy {
  BranchComparison avgOrderValue(int avgOrderValue);

  BranchComparison branchId(String branchId);

  BranchComparison branchName(String branchName);

  BranchComparison revenueByMethod(Object? revenueByMethod);

  BranchComparison totalOrders(int totalOrders);

  BranchComparison totalRevenue(int totalRevenue);

  BranchComparison voidRatePct(double voidRatePct);

  BranchComparison voidedOrders(int voidedOrders);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BranchComparison(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BranchComparison(...).copyWith(id: 12, name: "My name")
  /// ````
  BranchComparison call({
    int avgOrderValue,
    String branchId,
    String branchName,
    Object? revenueByMethod,
    int totalOrders,
    int totalRevenue,
    double voidRatePct,
    int voidedOrders,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBranchComparison.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBranchComparison.copyWith.fieldName(...)`
class _$BranchComparisonCWProxyImpl implements _$BranchComparisonCWProxy {
  const _$BranchComparisonCWProxyImpl(this._value);

  final BranchComparison _value;

  @override
  BranchComparison avgOrderValue(int avgOrderValue) =>
      this(avgOrderValue: avgOrderValue);

  @override
  BranchComparison branchId(String branchId) => this(branchId: branchId);

  @override
  BranchComparison branchName(String branchName) =>
      this(branchName: branchName);

  @override
  BranchComparison revenueByMethod(Object? revenueByMethod) =>
      this(revenueByMethod: revenueByMethod);

  @override
  BranchComparison totalOrders(int totalOrders) =>
      this(totalOrders: totalOrders);

  @override
  BranchComparison totalRevenue(int totalRevenue) =>
      this(totalRevenue: totalRevenue);

  @override
  BranchComparison voidRatePct(double voidRatePct) =>
      this(voidRatePct: voidRatePct);

  @override
  BranchComparison voidedOrders(int voidedOrders) =>
      this(voidedOrders: voidedOrders);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BranchComparison(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BranchComparison(...).copyWith(id: 12, name: "My name")
  /// ````
  BranchComparison call({
    Object? avgOrderValue = const $CopyWithPlaceholder(),
    Object? branchId = const $CopyWithPlaceholder(),
    Object? branchName = const $CopyWithPlaceholder(),
    Object? revenueByMethod = const $CopyWithPlaceholder(),
    Object? totalOrders = const $CopyWithPlaceholder(),
    Object? totalRevenue = const $CopyWithPlaceholder(),
    Object? voidRatePct = const $CopyWithPlaceholder(),
    Object? voidedOrders = const $CopyWithPlaceholder(),
  }) {
    return BranchComparison(
      avgOrderValue: avgOrderValue == const $CopyWithPlaceholder()
          ? _value.avgOrderValue
          // ignore: cast_nullable_to_non_nullable
          : avgOrderValue as int,
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String,
      branchName: branchName == const $CopyWithPlaceholder()
          ? _value.branchName
          // ignore: cast_nullable_to_non_nullable
          : branchName as String,
      revenueByMethod: revenueByMethod == const $CopyWithPlaceholder()
          ? _value.revenueByMethod
          // ignore: cast_nullable_to_non_nullable
          : revenueByMethod as Object?,
      totalOrders: totalOrders == const $CopyWithPlaceholder()
          ? _value.totalOrders
          // ignore: cast_nullable_to_non_nullable
          : totalOrders as int,
      totalRevenue: totalRevenue == const $CopyWithPlaceholder()
          ? _value.totalRevenue
          // ignore: cast_nullable_to_non_nullable
          : totalRevenue as int,
      voidRatePct: voidRatePct == const $CopyWithPlaceholder()
          ? _value.voidRatePct
          // ignore: cast_nullable_to_non_nullable
          : voidRatePct as double,
      voidedOrders: voidedOrders == const $CopyWithPlaceholder()
          ? _value.voidedOrders
          // ignore: cast_nullable_to_non_nullable
          : voidedOrders as int,
    );
  }
}

extension $BranchComparisonCopyWith on BranchComparison {
  /// Returns a callable class that can be used as follows: `instanceOfBranchComparison.copyWith(...)` or like so:`instanceOfBranchComparison.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BranchComparisonCWProxy get copyWith => _$BranchComparisonCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchComparison _$BranchComparisonFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'BranchComparison',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'avg_order_value',
        'branch_id',
        'branch_name',
        'revenue_by_method',
        'total_orders',
        'total_revenue',
        'void_rate_pct',
        'voided_orders',
      ],
    );
    final val = BranchComparison(
      avgOrderValue: $checkedConvert(
        'avg_order_value',
        (v) => (v as num).toInt(),
      ),
      branchId: $checkedConvert('branch_id', (v) => v as String),
      branchName: $checkedConvert('branch_name', (v) => v as String),
      revenueByMethod: $checkedConvert('revenue_by_method', (v) => v),
      totalOrders: $checkedConvert('total_orders', (v) => (v as num).toInt()),
      totalRevenue: $checkedConvert('total_revenue', (v) => (v as num).toInt()),
      voidRatePct: $checkedConvert(
        'void_rate_pct',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
      voidedOrders: $checkedConvert('voided_orders', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'avgOrderValue': 'avg_order_value',
    'branchId': 'branch_id',
    'branchName': 'branch_name',
    'revenueByMethod': 'revenue_by_method',
    'totalOrders': 'total_orders',
    'totalRevenue': 'total_revenue',
    'voidRatePct': 'void_rate_pct',
    'voidedOrders': 'voided_orders',
  },
);

Map<String, dynamic> _$BranchComparisonToJson(BranchComparison instance) =>
    <String, dynamic>{
      'avg_order_value': instance.avgOrderValue,
      'branch_id': instance.branchId,
      'branch_name': instance.branchName,
      'revenue_by_method': instance.revenueByMethod,
      'total_orders': instance.totalOrders,
      'total_revenue': instance.totalRevenue,
      'void_rate_pct': instance.voidRatePct,
      'voided_orders': instance.voidedOrders,
    };
