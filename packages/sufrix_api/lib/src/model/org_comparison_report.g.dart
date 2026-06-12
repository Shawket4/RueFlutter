// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'org_comparison_report.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrgComparisonReportCWProxy {
  OrgComparisonReport branches(List<BranchComparison> branches);

  OrgComparisonReport from(DateTime? from);

  OrgComparisonReport orgId(String orgId);

  OrgComparisonReport to(DateTime? to);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrgComparisonReport(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrgComparisonReport(...).copyWith(id: 12, name: "My name")
  /// ````
  OrgComparisonReport call({
    List<BranchComparison> branches,
    DateTime? from,
    String orgId,
    DateTime? to,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrgComparisonReport.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrgComparisonReport.copyWith.fieldName(...)`
class _$OrgComparisonReportCWProxyImpl implements _$OrgComparisonReportCWProxy {
  const _$OrgComparisonReportCWProxyImpl(this._value);

  final OrgComparisonReport _value;

  @override
  OrgComparisonReport branches(List<BranchComparison> branches) =>
      this(branches: branches);

  @override
  OrgComparisonReport from(DateTime? from) => this(from: from);

  @override
  OrgComparisonReport orgId(String orgId) => this(orgId: orgId);

  @override
  OrgComparisonReport to(DateTime? to) => this(to: to);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrgComparisonReport(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrgComparisonReport(...).copyWith(id: 12, name: "My name")
  /// ````
  OrgComparisonReport call({
    Object? branches = const $CopyWithPlaceholder(),
    Object? from = const $CopyWithPlaceholder(),
    Object? orgId = const $CopyWithPlaceholder(),
    Object? to = const $CopyWithPlaceholder(),
  }) {
    return OrgComparisonReport(
      branches: branches == const $CopyWithPlaceholder()
          ? _value.branches
          // ignore: cast_nullable_to_non_nullable
          : branches as List<BranchComparison>,
      from: from == const $CopyWithPlaceholder()
          ? _value.from
          // ignore: cast_nullable_to_non_nullable
          : from as DateTime?,
      orgId: orgId == const $CopyWithPlaceholder()
          ? _value.orgId
          // ignore: cast_nullable_to_non_nullable
          : orgId as String,
      to: to == const $CopyWithPlaceholder()
          ? _value.to
          // ignore: cast_nullable_to_non_nullable
          : to as DateTime?,
    );
  }
}

extension $OrgComparisonReportCopyWith on OrgComparisonReport {
  /// Returns a callable class that can be used as follows: `instanceOfOrgComparisonReport.copyWith(...)` or like so:`instanceOfOrgComparisonReport.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrgComparisonReportCWProxy get copyWith =>
      _$OrgComparisonReportCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgComparisonReport _$OrgComparisonReportFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrgComparisonReport', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['branches', 'org_id']);
      final val = OrgComparisonReport(
        branches: $checkedConvert(
          'branches',
          (v) => (v as List<dynamic>)
              .map((e) => BranchComparison.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        from: $checkedConvert(
          'from',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        orgId: $checkedConvert('org_id', (v) => v as String),
        to: $checkedConvert(
          'to',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    }, fieldKeyMap: const {'orgId': 'org_id'});

Map<String, dynamic> _$OrgComparisonReportToJson(
  OrgComparisonReport instance,
) => <String, dynamic>{
  'branches': instance.branches.map((e) => e.toJson()).toList(),
  'from': ?instance.from?.toIso8601String(),
  'org_id': instance.orgId,
  'to': ?instance.to?.toIso8601String(),
};
