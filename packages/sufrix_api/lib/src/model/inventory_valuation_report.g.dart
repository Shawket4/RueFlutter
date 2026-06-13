// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_valuation_report.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InventoryValuationReportCWProxy {
  InventoryValuationReport items(List<ValuationRow> items);

  InventoryValuationReport totalValue(int totalValue);

  InventoryValuationReport unknownCostCount(int unknownCostCount);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InventoryValuationReport(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InventoryValuationReport(...).copyWith(id: 12, name: "My name")
  /// ````
  InventoryValuationReport call({
    List<ValuationRow> items,
    int totalValue,
    int unknownCostCount,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInventoryValuationReport.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInventoryValuationReport.copyWith.fieldName(...)`
class _$InventoryValuationReportCWProxyImpl
    implements _$InventoryValuationReportCWProxy {
  const _$InventoryValuationReportCWProxyImpl(this._value);

  final InventoryValuationReport _value;

  @override
  InventoryValuationReport items(List<ValuationRow> items) =>
      this(items: items);

  @override
  InventoryValuationReport totalValue(int totalValue) =>
      this(totalValue: totalValue);

  @override
  InventoryValuationReport unknownCostCount(int unknownCostCount) =>
      this(unknownCostCount: unknownCostCount);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InventoryValuationReport(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InventoryValuationReport(...).copyWith(id: 12, name: "My name")
  /// ````
  InventoryValuationReport call({
    Object? items = const $CopyWithPlaceholder(),
    Object? totalValue = const $CopyWithPlaceholder(),
    Object? unknownCostCount = const $CopyWithPlaceholder(),
  }) {
    return InventoryValuationReport(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<ValuationRow>,
      totalValue: totalValue == const $CopyWithPlaceholder()
          ? _value.totalValue
          // ignore: cast_nullable_to_non_nullable
          : totalValue as int,
      unknownCostCount: unknownCostCount == const $CopyWithPlaceholder()
          ? _value.unknownCostCount
          // ignore: cast_nullable_to_non_nullable
          : unknownCostCount as int,
    );
  }
}

extension $InventoryValuationReportCopyWith on InventoryValuationReport {
  /// Returns a callable class that can be used as follows: `instanceOfInventoryValuationReport.copyWith(...)` or like so:`instanceOfInventoryValuationReport.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InventoryValuationReportCWProxy get copyWith =>
      _$InventoryValuationReportCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryValuationReport _$InventoryValuationReportFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'InventoryValuationReport',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['items', 'total_value', 'unknown_cost_count'],
    );
    final val = InventoryValuationReport(
      items: $checkedConvert(
        'items',
        (v) => (v as List<dynamic>)
            .map((e) => ValuationRow.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      totalValue: $checkedConvert('total_value', (v) => (v as num).toInt()),
      unknownCostCount: $checkedConvert(
        'unknown_cost_count',
        (v) => (v as num).toInt(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'totalValue': 'total_value',
    'unknownCostCount': 'unknown_cost_count',
  },
);

Map<String, dynamic> _$InventoryValuationReportToJson(
  InventoryValuationReport instance,
) => <String, dynamic>{
  'items': instance.items.map((e) => e.toJson()).toList(),
  'total_value': instance.totalValue,
  'unknown_cost_count': instance.unknownCostCount,
};
