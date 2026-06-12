// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_engineering_report.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MenuEngineeringReportCWProxy {
  MenuEngineeringReport branchId(String branchId);

  MenuEngineeringReport from(DateTime? from);

  MenuEngineeringReport rows(List<MenuEngineeringRow> rows);

  MenuEngineeringReport rowsCostMissing(int rowsCostMissing);

  MenuEngineeringReport to(DateTime? to);

  MenuEngineeringReport totalCost(int totalCost);

  MenuEngineeringReport totalProfit(int totalProfit);

  MenuEngineeringReport totalSales(int totalSales);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MenuEngineeringReport(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MenuEngineeringReport(...).copyWith(id: 12, name: "My name")
  /// ````
  MenuEngineeringReport call({
    String branchId,
    DateTime? from,
    List<MenuEngineeringRow> rows,
    int rowsCostMissing,
    DateTime? to,
    int totalCost,
    int totalProfit,
    int totalSales,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMenuEngineeringReport.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMenuEngineeringReport.copyWith.fieldName(...)`
class _$MenuEngineeringReportCWProxyImpl
    implements _$MenuEngineeringReportCWProxy {
  const _$MenuEngineeringReportCWProxyImpl(this._value);

  final MenuEngineeringReport _value;

  @override
  MenuEngineeringReport branchId(String branchId) => this(branchId: branchId);

  @override
  MenuEngineeringReport from(DateTime? from) => this(from: from);

  @override
  MenuEngineeringReport rows(List<MenuEngineeringRow> rows) => this(rows: rows);

  @override
  MenuEngineeringReport rowsCostMissing(int rowsCostMissing) =>
      this(rowsCostMissing: rowsCostMissing);

  @override
  MenuEngineeringReport to(DateTime? to) => this(to: to);

  @override
  MenuEngineeringReport totalCost(int totalCost) => this(totalCost: totalCost);

  @override
  MenuEngineeringReport totalProfit(int totalProfit) =>
      this(totalProfit: totalProfit);

  @override
  MenuEngineeringReport totalSales(int totalSales) =>
      this(totalSales: totalSales);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MenuEngineeringReport(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MenuEngineeringReport(...).copyWith(id: 12, name: "My name")
  /// ````
  MenuEngineeringReport call({
    Object? branchId = const $CopyWithPlaceholder(),
    Object? from = const $CopyWithPlaceholder(),
    Object? rows = const $CopyWithPlaceholder(),
    Object? rowsCostMissing = const $CopyWithPlaceholder(),
    Object? to = const $CopyWithPlaceholder(),
    Object? totalCost = const $CopyWithPlaceholder(),
    Object? totalProfit = const $CopyWithPlaceholder(),
    Object? totalSales = const $CopyWithPlaceholder(),
  }) {
    return MenuEngineeringReport(
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String,
      from: from == const $CopyWithPlaceholder()
          ? _value.from
          // ignore: cast_nullable_to_non_nullable
          : from as DateTime?,
      rows: rows == const $CopyWithPlaceholder()
          ? _value.rows
          // ignore: cast_nullable_to_non_nullable
          : rows as List<MenuEngineeringRow>,
      rowsCostMissing: rowsCostMissing == const $CopyWithPlaceholder()
          ? _value.rowsCostMissing
          // ignore: cast_nullable_to_non_nullable
          : rowsCostMissing as int,
      to: to == const $CopyWithPlaceholder()
          ? _value.to
          // ignore: cast_nullable_to_non_nullable
          : to as DateTime?,
      totalCost: totalCost == const $CopyWithPlaceholder()
          ? _value.totalCost
          // ignore: cast_nullable_to_non_nullable
          : totalCost as int,
      totalProfit: totalProfit == const $CopyWithPlaceholder()
          ? _value.totalProfit
          // ignore: cast_nullable_to_non_nullable
          : totalProfit as int,
      totalSales: totalSales == const $CopyWithPlaceholder()
          ? _value.totalSales
          // ignore: cast_nullable_to_non_nullable
          : totalSales as int,
    );
  }
}

extension $MenuEngineeringReportCopyWith on MenuEngineeringReport {
  /// Returns a callable class that can be used as follows: `instanceOfMenuEngineeringReport.copyWith(...)` or like so:`instanceOfMenuEngineeringReport.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MenuEngineeringReportCWProxy get copyWith =>
      _$MenuEngineeringReportCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuEngineeringReport _$MenuEngineeringReportFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'MenuEngineeringReport',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'branch_id',
        'rows',
        'rows_cost_missing',
        'total_cost',
        'total_profit',
        'total_sales',
      ],
    );
    final val = MenuEngineeringReport(
      branchId: $checkedConvert('branch_id', (v) => v as String),
      from: $checkedConvert(
        'from',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      rows: $checkedConvert(
        'rows',
        (v) => (v as List<dynamic>)
            .map((e) => MenuEngineeringRow.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      rowsCostMissing: $checkedConvert(
        'rows_cost_missing',
        (v) => (v as num).toInt(),
      ),
      to: $checkedConvert(
        'to',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      totalCost: $checkedConvert('total_cost', (v) => (v as num).toInt()),
      totalProfit: $checkedConvert('total_profit', (v) => (v as num).toInt()),
      totalSales: $checkedConvert('total_sales', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'branchId': 'branch_id',
    'rowsCostMissing': 'rows_cost_missing',
    'totalCost': 'total_cost',
    'totalProfit': 'total_profit',
    'totalSales': 'total_sales',
  },
);

Map<String, dynamic> _$MenuEngineeringReportToJson(
  MenuEngineeringReport instance,
) => <String, dynamic>{
  'branch_id': instance.branchId,
  'from': ?instance.from?.toIso8601String(),
  'rows': instance.rows.map((e) => e.toJson()).toList(),
  'rows_cost_missing': instance.rowsCostMissing,
  'to': ?instance.to?.toIso8601String(),
  'total_cost': instance.totalCost,
  'total_profit': instance.totalProfit,
  'total_sales': instance.totalSales,
};
