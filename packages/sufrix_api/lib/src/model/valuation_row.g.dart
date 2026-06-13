// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'valuation_row.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ValuationRowCWProxy {
  ValuationRow costPerUnit(int? costPerUnit);

  ValuationRow currentStock(double currentStock);

  ValuationRow ingredientName(String ingredientName);

  ValuationRow orgIngredientId(String orgIngredientId);

  ValuationRow unit(String unit);

  ValuationRow value(int? value);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ValuationRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ValuationRow(...).copyWith(id: 12, name: "My name")
  /// ````
  ValuationRow call({
    int? costPerUnit,
    double currentStock,
    String ingredientName,
    String orgIngredientId,
    String unit,
    int? value,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfValuationRow.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfValuationRow.copyWith.fieldName(...)`
class _$ValuationRowCWProxyImpl implements _$ValuationRowCWProxy {
  const _$ValuationRowCWProxyImpl(this._value);

  final ValuationRow _value;

  @override
  ValuationRow costPerUnit(int? costPerUnit) => this(costPerUnit: costPerUnit);

  @override
  ValuationRow currentStock(double currentStock) =>
      this(currentStock: currentStock);

  @override
  ValuationRow ingredientName(String ingredientName) =>
      this(ingredientName: ingredientName);

  @override
  ValuationRow orgIngredientId(String orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  ValuationRow unit(String unit) => this(unit: unit);

  @override
  ValuationRow value(int? value) => this(value: value);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ValuationRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ValuationRow(...).copyWith(id: 12, name: "My name")
  /// ````
  ValuationRow call({
    Object? costPerUnit = const $CopyWithPlaceholder(),
    Object? currentStock = const $CopyWithPlaceholder(),
    Object? ingredientName = const $CopyWithPlaceholder(),
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? unit = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
  }) {
    return ValuationRow(
      costPerUnit: costPerUnit == const $CopyWithPlaceholder()
          ? _value.costPerUnit
          // ignore: cast_nullable_to_non_nullable
          : costPerUnit as int?,
      currentStock: currentStock == const $CopyWithPlaceholder()
          ? _value.currentStock
          // ignore: cast_nullable_to_non_nullable
          : currentStock as double,
      ingredientName: ingredientName == const $CopyWithPlaceholder()
          ? _value.ingredientName
          // ignore: cast_nullable_to_non_nullable
          : ingredientName as String,
      orgIngredientId: orgIngredientId == const $CopyWithPlaceholder()
          ? _value.orgIngredientId
          // ignore: cast_nullable_to_non_nullable
          : orgIngredientId as String,
      unit: unit == const $CopyWithPlaceholder()
          ? _value.unit
          // ignore: cast_nullable_to_non_nullable
          : unit as String,
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as int?,
    );
  }
}

extension $ValuationRowCopyWith on ValuationRow {
  /// Returns a callable class that can be used as follows: `instanceOfValuationRow.copyWith(...)` or like so:`instanceOfValuationRow.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ValuationRowCWProxy get copyWith => _$ValuationRowCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValuationRow _$ValuationRowFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ValuationRow',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'current_stock',
        'ingredient_name',
        'org_ingredient_id',
        'unit',
      ],
    );
    final val = ValuationRow(
      costPerUnit: $checkedConvert(
        'cost_per_unit',
        (v) => (v as num?)?.toInt(),
      ),
      currentStock: $checkedConvert(
        'current_stock',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
      ingredientName: $checkedConvert('ingredient_name', (v) => v as String),
      orgIngredientId: $checkedConvert('org_ingredient_id', (v) => v as String),
      unit: $checkedConvert('unit', (v) => v as String),
      value: $checkedConvert('value', (v) => (v as num?)?.toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'costPerUnit': 'cost_per_unit',
    'currentStock': 'current_stock',
    'ingredientName': 'ingredient_name',
    'orgIngredientId': 'org_ingredient_id',
  },
);

Map<String, dynamic> _$ValuationRowToJson(ValuationRow instance) =>
    <String, dynamic>{
      'cost_per_unit': ?instance.costPerUnit,
      'current_stock': instance.currentStock,
      'ingredient_name': instance.ingredientName,
      'org_ingredient_id': instance.orgIngredientId,
      'unit': instance.unit,
      'value': ?instance.value,
    };
