// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variance_report.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VarianceReportCWProxy {
  VarianceReport netVarianceValue(int netVarianceValue);

  VarianceReport rows(List<VarianceRow> rows);

  VarianceReport stocktakeId(String stocktakeId);

  VarianceReport totalOverageValue(int totalOverageValue);

  VarianceReport totalShrinkageValue(int totalShrinkageValue);

  VarianceReport unknownCostCount(int unknownCostCount);

  VarianceReport varianceThresholdPct(double varianceThresholdPct);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VarianceReport(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VarianceReport(...).copyWith(id: 12, name: "My name")
  /// ````
  VarianceReport call({
    int netVarianceValue,
    List<VarianceRow> rows,
    String stocktakeId,
    int totalOverageValue,
    int totalShrinkageValue,
    int unknownCostCount,
    double varianceThresholdPct,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVarianceReport.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVarianceReport.copyWith.fieldName(...)`
class _$VarianceReportCWProxyImpl implements _$VarianceReportCWProxy {
  const _$VarianceReportCWProxyImpl(this._value);

  final VarianceReport _value;

  @override
  VarianceReport netVarianceValue(int netVarianceValue) =>
      this(netVarianceValue: netVarianceValue);

  @override
  VarianceReport rows(List<VarianceRow> rows) => this(rows: rows);

  @override
  VarianceReport stocktakeId(String stocktakeId) =>
      this(stocktakeId: stocktakeId);

  @override
  VarianceReport totalOverageValue(int totalOverageValue) =>
      this(totalOverageValue: totalOverageValue);

  @override
  VarianceReport totalShrinkageValue(int totalShrinkageValue) =>
      this(totalShrinkageValue: totalShrinkageValue);

  @override
  VarianceReport unknownCostCount(int unknownCostCount) =>
      this(unknownCostCount: unknownCostCount);

  @override
  VarianceReport varianceThresholdPct(double varianceThresholdPct) =>
      this(varianceThresholdPct: varianceThresholdPct);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VarianceReport(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VarianceReport(...).copyWith(id: 12, name: "My name")
  /// ````
  VarianceReport call({
    Object? netVarianceValue = const $CopyWithPlaceholder(),
    Object? rows = const $CopyWithPlaceholder(),
    Object? stocktakeId = const $CopyWithPlaceholder(),
    Object? totalOverageValue = const $CopyWithPlaceholder(),
    Object? totalShrinkageValue = const $CopyWithPlaceholder(),
    Object? unknownCostCount = const $CopyWithPlaceholder(),
    Object? varianceThresholdPct = const $CopyWithPlaceholder(),
  }) {
    return VarianceReport(
      netVarianceValue: netVarianceValue == const $CopyWithPlaceholder()
          ? _value.netVarianceValue
          // ignore: cast_nullable_to_non_nullable
          : netVarianceValue as int,
      rows: rows == const $CopyWithPlaceholder()
          ? _value.rows
          // ignore: cast_nullable_to_non_nullable
          : rows as List<VarianceRow>,
      stocktakeId: stocktakeId == const $CopyWithPlaceholder()
          ? _value.stocktakeId
          // ignore: cast_nullable_to_non_nullable
          : stocktakeId as String,
      totalOverageValue: totalOverageValue == const $CopyWithPlaceholder()
          ? _value.totalOverageValue
          // ignore: cast_nullable_to_non_nullable
          : totalOverageValue as int,
      totalShrinkageValue: totalShrinkageValue == const $CopyWithPlaceholder()
          ? _value.totalShrinkageValue
          // ignore: cast_nullable_to_non_nullable
          : totalShrinkageValue as int,
      unknownCostCount: unknownCostCount == const $CopyWithPlaceholder()
          ? _value.unknownCostCount
          // ignore: cast_nullable_to_non_nullable
          : unknownCostCount as int,
      varianceThresholdPct: varianceThresholdPct == const $CopyWithPlaceholder()
          ? _value.varianceThresholdPct
          // ignore: cast_nullable_to_non_nullable
          : varianceThresholdPct as double,
    );
  }
}

extension $VarianceReportCopyWith on VarianceReport {
  /// Returns a callable class that can be used as follows: `instanceOfVarianceReport.copyWith(...)` or like so:`instanceOfVarianceReport.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VarianceReportCWProxy get copyWith => _$VarianceReportCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VarianceReport _$VarianceReportFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'VarianceReport',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'net_variance_value',
            'rows',
            'stocktake_id',
            'total_overage_value',
            'total_shrinkage_value',
            'unknown_cost_count',
            'variance_threshold_pct',
          ],
        );
        final val = VarianceReport(
          netVarianceValue: $checkedConvert(
            'net_variance_value',
            (v) => (v as num).toInt(),
          ),
          rows: $checkedConvert(
            'rows',
            (v) => (v as List<dynamic>)
                .map((e) => VarianceRow.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
          stocktakeId: $checkedConvert('stocktake_id', (v) => v as String),
          totalOverageValue: $checkedConvert(
            'total_overage_value',
            (v) => (v as num).toInt(),
          ),
          totalShrinkageValue: $checkedConvert(
            'total_shrinkage_value',
            (v) => (v as num).toInt(),
          ),
          unknownCostCount: $checkedConvert(
            'unknown_cost_count',
            (v) => (v as num).toInt(),
          ),
          varianceThresholdPct: $checkedConvert(
            'variance_threshold_pct',
            (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'netVarianceValue': 'net_variance_value',
        'stocktakeId': 'stocktake_id',
        'totalOverageValue': 'total_overage_value',
        'totalShrinkageValue': 'total_shrinkage_value',
        'unknownCostCount': 'unknown_cost_count',
        'varianceThresholdPct': 'variance_threshold_pct',
      },
    );

Map<String, dynamic> _$VarianceReportToJson(VarianceReport instance) =>
    <String, dynamic>{
      'net_variance_value': instance.netVarianceValue,
      'rows': instance.rows.map((e) => e.toJson()).toList(),
      'stocktake_id': instance.stocktakeId,
      'total_overage_value': instance.totalOverageValue,
      'total_shrinkage_value': instance.totalShrinkageValue,
      'unknown_cost_count': instance.unknownCostCount,
      'variance_threshold_pct': instance.varianceThresholdPct,
    };
