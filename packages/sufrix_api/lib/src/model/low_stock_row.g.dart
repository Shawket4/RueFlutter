// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'low_stock_row.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LowStockRowCWProxy {
  LowStockRow branchId(String branchId);

  LowStockRow branchName(String branchName);

  LowStockRow currentStock(double currentStock);

  LowStockRow deficit(double deficit);

  LowStockRow ingredientName(String ingredientName);

  LowStockRow orgIngredientId(String orgIngredientId);

  LowStockRow reorderThreshold(double reorderThreshold);

  LowStockRow supplierId(String? supplierId);

  LowStockRow supplierName(String? supplierName);

  LowStockRow unit(String unit);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LowStockRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LowStockRow(...).copyWith(id: 12, name: "My name")
  /// ````
  LowStockRow call({
    String branchId,
    String branchName,
    double currentStock,
    double deficit,
    String ingredientName,
    String orgIngredientId,
    double reorderThreshold,
    String? supplierId,
    String? supplierName,
    String unit,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLowStockRow.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLowStockRow.copyWith.fieldName(...)`
class _$LowStockRowCWProxyImpl implements _$LowStockRowCWProxy {
  const _$LowStockRowCWProxyImpl(this._value);

  final LowStockRow _value;

  @override
  LowStockRow branchId(String branchId) => this(branchId: branchId);

  @override
  LowStockRow branchName(String branchName) => this(branchName: branchName);

  @override
  LowStockRow currentStock(double currentStock) =>
      this(currentStock: currentStock);

  @override
  LowStockRow deficit(double deficit) => this(deficit: deficit);

  @override
  LowStockRow ingredientName(String ingredientName) =>
      this(ingredientName: ingredientName);

  @override
  LowStockRow orgIngredientId(String orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  LowStockRow reorderThreshold(double reorderThreshold) =>
      this(reorderThreshold: reorderThreshold);

  @override
  LowStockRow supplierId(String? supplierId) => this(supplierId: supplierId);

  @override
  LowStockRow supplierName(String? supplierName) =>
      this(supplierName: supplierName);

  @override
  LowStockRow unit(String unit) => this(unit: unit);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LowStockRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LowStockRow(...).copyWith(id: 12, name: "My name")
  /// ````
  LowStockRow call({
    Object? branchId = const $CopyWithPlaceholder(),
    Object? branchName = const $CopyWithPlaceholder(),
    Object? currentStock = const $CopyWithPlaceholder(),
    Object? deficit = const $CopyWithPlaceholder(),
    Object? ingredientName = const $CopyWithPlaceholder(),
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? reorderThreshold = const $CopyWithPlaceholder(),
    Object? supplierId = const $CopyWithPlaceholder(),
    Object? supplierName = const $CopyWithPlaceholder(),
    Object? unit = const $CopyWithPlaceholder(),
  }) {
    return LowStockRow(
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String,
      branchName: branchName == const $CopyWithPlaceholder()
          ? _value.branchName
          // ignore: cast_nullable_to_non_nullable
          : branchName as String,
      currentStock: currentStock == const $CopyWithPlaceholder()
          ? _value.currentStock
          // ignore: cast_nullable_to_non_nullable
          : currentStock as double,
      deficit: deficit == const $CopyWithPlaceholder()
          ? _value.deficit
          // ignore: cast_nullable_to_non_nullable
          : deficit as double,
      ingredientName: ingredientName == const $CopyWithPlaceholder()
          ? _value.ingredientName
          // ignore: cast_nullable_to_non_nullable
          : ingredientName as String,
      orgIngredientId: orgIngredientId == const $CopyWithPlaceholder()
          ? _value.orgIngredientId
          // ignore: cast_nullable_to_non_nullable
          : orgIngredientId as String,
      reorderThreshold: reorderThreshold == const $CopyWithPlaceholder()
          ? _value.reorderThreshold
          // ignore: cast_nullable_to_non_nullable
          : reorderThreshold as double,
      supplierId: supplierId == const $CopyWithPlaceholder()
          ? _value.supplierId
          // ignore: cast_nullable_to_non_nullable
          : supplierId as String?,
      supplierName: supplierName == const $CopyWithPlaceholder()
          ? _value.supplierName
          // ignore: cast_nullable_to_non_nullable
          : supplierName as String?,
      unit: unit == const $CopyWithPlaceholder()
          ? _value.unit
          // ignore: cast_nullable_to_non_nullable
          : unit as String,
    );
  }
}

extension $LowStockRowCopyWith on LowStockRow {
  /// Returns a callable class that can be used as follows: `instanceOfLowStockRow.copyWith(...)` or like so:`instanceOfLowStockRow.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LowStockRowCWProxy get copyWith => _$LowStockRowCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LowStockRow _$LowStockRowFromJson(Map<String, dynamic> json) => $checkedCreate(
  'LowStockRow',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'branch_id',
        'branch_name',
        'current_stock',
        'deficit',
        'ingredient_name',
        'org_ingredient_id',
        'reorder_threshold',
        'unit',
      ],
    );
    final val = LowStockRow(
      branchId: $checkedConvert('branch_id', (v) => v as String),
      branchName: $checkedConvert('branch_name', (v) => v as String),
      currentStock: $checkedConvert(
        'current_stock',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
      deficit: $checkedConvert('deficit', (v) => (v is String ? double.parse(v) : (v as num).toDouble())),
      ingredientName: $checkedConvert('ingredient_name', (v) => v as String),
      orgIngredientId: $checkedConvert('org_ingredient_id', (v) => v as String),
      reorderThreshold: $checkedConvert(
        'reorder_threshold',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
      supplierId: $checkedConvert('supplier_id', (v) => v as String?),
      supplierName: $checkedConvert('supplier_name', (v) => v as String?),
      unit: $checkedConvert('unit', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'branchId': 'branch_id',
    'branchName': 'branch_name',
    'currentStock': 'current_stock',
    'ingredientName': 'ingredient_name',
    'orgIngredientId': 'org_ingredient_id',
    'reorderThreshold': 'reorder_threshold',
    'supplierId': 'supplier_id',
    'supplierName': 'supplier_name',
  },
);

Map<String, dynamic> _$LowStockRowToJson(LowStockRow instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'branch_name': instance.branchName,
      'current_stock': instance.currentStock,
      'deficit': instance.deficit,
      'ingredient_name': instance.ingredientName,
      'org_ingredient_id': instance.orgIngredientId,
      'reorder_threshold': instance.reorderThreshold,
      'supplier_id': ?instance.supplierId,
      'supplier_name': ?instance.supplierName,
      'unit': instance.unit,
    };
