// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_row.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StockRowCWProxy {
  StockRow belowReorder(bool belowReorder);

  StockRow branchInventoryId(String branchInventoryId);

  StockRow costPerUnit(double? costPerUnit);

  StockRow currentStock(double currentStock);

  StockRow ingredientName(String ingredientName);

  StockRow reorderThreshold(double reorderThreshold);

  StockRow unit(String unit);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StockRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StockRow(...).copyWith(id: 12, name: "My name")
  /// ````
  StockRow call({
    bool belowReorder,
    String branchInventoryId,
    double? costPerUnit,
    double currentStock,
    String ingredientName,
    double reorderThreshold,
    String unit,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStockRow.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStockRow.copyWith.fieldName(...)`
class _$StockRowCWProxyImpl implements _$StockRowCWProxy {
  const _$StockRowCWProxyImpl(this._value);

  final StockRow _value;

  @override
  StockRow belowReorder(bool belowReorder) => this(belowReorder: belowReorder);

  @override
  StockRow branchInventoryId(String branchInventoryId) =>
      this(branchInventoryId: branchInventoryId);

  @override
  StockRow costPerUnit(double? costPerUnit) => this(costPerUnit: costPerUnit);

  @override
  StockRow currentStock(double currentStock) =>
      this(currentStock: currentStock);

  @override
  StockRow ingredientName(String ingredientName) =>
      this(ingredientName: ingredientName);

  @override
  StockRow reorderThreshold(double reorderThreshold) =>
      this(reorderThreshold: reorderThreshold);

  @override
  StockRow unit(String unit) => this(unit: unit);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StockRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StockRow(...).copyWith(id: 12, name: "My name")
  /// ````
  StockRow call({
    Object? belowReorder = const $CopyWithPlaceholder(),
    Object? branchInventoryId = const $CopyWithPlaceholder(),
    Object? costPerUnit = const $CopyWithPlaceholder(),
    Object? currentStock = const $CopyWithPlaceholder(),
    Object? ingredientName = const $CopyWithPlaceholder(),
    Object? reorderThreshold = const $CopyWithPlaceholder(),
    Object? unit = const $CopyWithPlaceholder(),
  }) {
    return StockRow(
      belowReorder: belowReorder == const $CopyWithPlaceholder()
          ? _value.belowReorder
          // ignore: cast_nullable_to_non_nullable
          : belowReorder as bool,
      branchInventoryId: branchInventoryId == const $CopyWithPlaceholder()
          ? _value.branchInventoryId
          // ignore: cast_nullable_to_non_nullable
          : branchInventoryId as String,
      costPerUnit: costPerUnit == const $CopyWithPlaceholder()
          ? _value.costPerUnit
          // ignore: cast_nullable_to_non_nullable
          : costPerUnit as double?,
      currentStock: currentStock == const $CopyWithPlaceholder()
          ? _value.currentStock
          // ignore: cast_nullable_to_non_nullable
          : currentStock as double,
      ingredientName: ingredientName == const $CopyWithPlaceholder()
          ? _value.ingredientName
          // ignore: cast_nullable_to_non_nullable
          : ingredientName as String,
      reorderThreshold: reorderThreshold == const $CopyWithPlaceholder()
          ? _value.reorderThreshold
          // ignore: cast_nullable_to_non_nullable
          : reorderThreshold as double,
      unit: unit == const $CopyWithPlaceholder()
          ? _value.unit
          // ignore: cast_nullable_to_non_nullable
          : unit as String,
    );
  }
}

extension $StockRowCopyWith on StockRow {
  /// Returns a callable class that can be used as follows: `instanceOfStockRow.copyWith(...)` or like so:`instanceOfStockRow.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StockRowCWProxy get copyWith => _$StockRowCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockRow _$StockRowFromJson(Map<String, dynamic> json) => $checkedCreate(
  'StockRow',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'below_reorder',
        'branch_inventory_id',
        'current_stock',
        'ingredient_name',
        'reorder_threshold',
        'unit',
      ],
    );
    final val = StockRow(
      belowReorder: $checkedConvert('below_reorder', (v) => v as bool),
      branchInventoryId: $checkedConvert(
        'branch_inventory_id',
        (v) => v as String,
      ),
      costPerUnit: $checkedConvert(
        'cost_per_unit',
        (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble()),
      ),
      currentStock: $checkedConvert(
        'current_stock',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
      ingredientName: $checkedConvert('ingredient_name', (v) => v as String),
      reorderThreshold: $checkedConvert(
        'reorder_threshold',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
      unit: $checkedConvert('unit', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'belowReorder': 'below_reorder',
    'branchInventoryId': 'branch_inventory_id',
    'costPerUnit': 'cost_per_unit',
    'currentStock': 'current_stock',
    'ingredientName': 'ingredient_name',
    'reorderThreshold': 'reorder_threshold',
  },
);

Map<String, dynamic> _$StockRowToJson(StockRow instance) => <String, dynamic>{
  'below_reorder': instance.belowReorder,
  'branch_inventory_id': instance.branchInventoryId,
  'cost_per_unit': ?instance.costPerUnit,
  'current_stock': instance.currentStock,
  'ingredient_name': instance.ingredientName,
  'reorder_threshold': instance.reorderThreshold,
  'unit': instance.unit,
};
