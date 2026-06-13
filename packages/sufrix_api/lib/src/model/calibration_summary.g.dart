// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calibration_summary.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CalibrationSummaryCWProxy {
  CalibrationSummary branchId(String branchId);

  CalibrationSummary cmInRangePct(double? cmInRangePct);

  CalibrationSummary pointsCm(List<CalibrationPoint> pointsCm);

  CalibrationSummary pointsRevenue(List<CalibrationPoint> pointsRevenue);

  CalibrationSummary revenueInRangePct(double? revenueInRangePct);

  CalibrationSummary since(DateTime? since);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CalibrationSummary(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CalibrationSummary(...).copyWith(id: 12, name: "My name")
  /// ````
  CalibrationSummary call({
    String branchId,
    double? cmInRangePct,
    List<CalibrationPoint> pointsCm,
    List<CalibrationPoint> pointsRevenue,
    double? revenueInRangePct,
    DateTime? since,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCalibrationSummary.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCalibrationSummary.copyWith.fieldName(...)`
class _$CalibrationSummaryCWProxyImpl implements _$CalibrationSummaryCWProxy {
  const _$CalibrationSummaryCWProxyImpl(this._value);

  final CalibrationSummary _value;

  @override
  CalibrationSummary branchId(String branchId) => this(branchId: branchId);

  @override
  CalibrationSummary cmInRangePct(double? cmInRangePct) =>
      this(cmInRangePct: cmInRangePct);

  @override
  CalibrationSummary pointsCm(List<CalibrationPoint> pointsCm) =>
      this(pointsCm: pointsCm);

  @override
  CalibrationSummary pointsRevenue(List<CalibrationPoint> pointsRevenue) =>
      this(pointsRevenue: pointsRevenue);

  @override
  CalibrationSummary revenueInRangePct(double? revenueInRangePct) =>
      this(revenueInRangePct: revenueInRangePct);

  @override
  CalibrationSummary since(DateTime? since) => this(since: since);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CalibrationSummary(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CalibrationSummary(...).copyWith(id: 12, name: "My name")
  /// ````
  CalibrationSummary call({
    Object? branchId = const $CopyWithPlaceholder(),
    Object? cmInRangePct = const $CopyWithPlaceholder(),
    Object? pointsCm = const $CopyWithPlaceholder(),
    Object? pointsRevenue = const $CopyWithPlaceholder(),
    Object? revenueInRangePct = const $CopyWithPlaceholder(),
    Object? since = const $CopyWithPlaceholder(),
  }) {
    return CalibrationSummary(
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String,
      cmInRangePct: cmInRangePct == const $CopyWithPlaceholder()
          ? _value.cmInRangePct
          // ignore: cast_nullable_to_non_nullable
          : cmInRangePct as double?,
      pointsCm: pointsCm == const $CopyWithPlaceholder()
          ? _value.pointsCm
          // ignore: cast_nullable_to_non_nullable
          : pointsCm as List<CalibrationPoint>,
      pointsRevenue: pointsRevenue == const $CopyWithPlaceholder()
          ? _value.pointsRevenue
          // ignore: cast_nullable_to_non_nullable
          : pointsRevenue as List<CalibrationPoint>,
      revenueInRangePct: revenueInRangePct == const $CopyWithPlaceholder()
          ? _value.revenueInRangePct
          // ignore: cast_nullable_to_non_nullable
          : revenueInRangePct as double?,
      since: since == const $CopyWithPlaceholder()
          ? _value.since
          // ignore: cast_nullable_to_non_nullable
          : since as DateTime?,
    );
  }
}

extension $CalibrationSummaryCopyWith on CalibrationSummary {
  /// Returns a callable class that can be used as follows: `instanceOfCalibrationSummary.copyWith(...)` or like so:`instanceOfCalibrationSummary.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CalibrationSummaryCWProxy get copyWith =>
      _$CalibrationSummaryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalibrationSummary _$CalibrationSummaryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'CalibrationSummary',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['branch_id', 'points_cm', 'points_revenue'],
    );
    final val = CalibrationSummary(
      branchId: $checkedConvert('branch_id', (v) => v as String),
      cmInRangePct: $checkedConvert(
        'cm_in_range_pct',
        (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble()),
      ),
      pointsCm: $checkedConvert(
        'points_cm',
        (v) => (v as List<dynamic>)
            .map((e) => CalibrationPoint.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      pointsRevenue: $checkedConvert(
        'points_revenue',
        (v) => (v as List<dynamic>)
            .map((e) => CalibrationPoint.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      revenueInRangePct: $checkedConvert(
        'revenue_in_range_pct',
        (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble()),
      ),
      since: $checkedConvert(
        'since',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'branchId': 'branch_id',
    'cmInRangePct': 'cm_in_range_pct',
    'pointsCm': 'points_cm',
    'pointsRevenue': 'points_revenue',
    'revenueInRangePct': 'revenue_in_range_pct',
  },
);

Map<String, dynamic> _$CalibrationSummaryToJson(CalibrationSummary instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'cm_in_range_pct': ?instance.cmInRangePct,
      'points_cm': instance.pointsCm.map((e) => e.toJson()).toList(),
      'points_revenue': instance.pointsRevenue.map((e) => e.toJson()).toList(),
      'revenue_in_range_pct': ?instance.revenueInRangePct,
      'since': ?instance.since?.toIso8601String(),
    };
