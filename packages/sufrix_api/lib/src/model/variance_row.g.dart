// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variance_row.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VarianceRowCWProxy {
  VarianceRow countedQty(double? countedQty);

  VarianceRow expectedQty(double expectedQty);

  VarianceRow ingredientName(String ingredientName);

  VarianceRow isFlagged(bool isFlagged);

  VarianceRow orgIngredientId(String orgIngredientId);

  VarianceRow unit(String unit);

  VarianceRow unitCost(int? unitCost);

  VarianceRow variance(double? variance);

  VarianceRow varianceReason(String? varianceReason);

  VarianceRow varianceValue(int? varianceValue);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VarianceRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VarianceRow(...).copyWith(id: 12, name: "My name")
  /// ````
  VarianceRow call({
    double? countedQty,
    double expectedQty,
    String ingredientName,
    bool isFlagged,
    String orgIngredientId,
    String unit,
    int? unitCost,
    double? variance,
    String? varianceReason,
    int? varianceValue,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVarianceRow.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVarianceRow.copyWith.fieldName(...)`
class _$VarianceRowCWProxyImpl implements _$VarianceRowCWProxy {
  const _$VarianceRowCWProxyImpl(this._value);

  final VarianceRow _value;

  @override
  VarianceRow countedQty(double? countedQty) => this(countedQty: countedQty);

  @override
  VarianceRow expectedQty(double expectedQty) => this(expectedQty: expectedQty);

  @override
  VarianceRow ingredientName(String ingredientName) =>
      this(ingredientName: ingredientName);

  @override
  VarianceRow isFlagged(bool isFlagged) => this(isFlagged: isFlagged);

  @override
  VarianceRow orgIngredientId(String orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  VarianceRow unit(String unit) => this(unit: unit);

  @override
  VarianceRow unitCost(int? unitCost) => this(unitCost: unitCost);

  @override
  VarianceRow variance(double? variance) => this(variance: variance);

  @override
  VarianceRow varianceReason(String? varianceReason) =>
      this(varianceReason: varianceReason);

  @override
  VarianceRow varianceValue(int? varianceValue) =>
      this(varianceValue: varianceValue);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VarianceRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VarianceRow(...).copyWith(id: 12, name: "My name")
  /// ````
  VarianceRow call({
    Object? countedQty = const $CopyWithPlaceholder(),
    Object? expectedQty = const $CopyWithPlaceholder(),
    Object? ingredientName = const $CopyWithPlaceholder(),
    Object? isFlagged = const $CopyWithPlaceholder(),
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? unit = const $CopyWithPlaceholder(),
    Object? unitCost = const $CopyWithPlaceholder(),
    Object? variance = const $CopyWithPlaceholder(),
    Object? varianceReason = const $CopyWithPlaceholder(),
    Object? varianceValue = const $CopyWithPlaceholder(),
  }) {
    return VarianceRow(
      countedQty: countedQty == const $CopyWithPlaceholder()
          ? _value.countedQty
          // ignore: cast_nullable_to_non_nullable
          : countedQty as double?,
      expectedQty: expectedQty == const $CopyWithPlaceholder()
          ? _value.expectedQty
          // ignore: cast_nullable_to_non_nullable
          : expectedQty as double,
      ingredientName: ingredientName == const $CopyWithPlaceholder()
          ? _value.ingredientName
          // ignore: cast_nullable_to_non_nullable
          : ingredientName as String,
      isFlagged: isFlagged == const $CopyWithPlaceholder()
          ? _value.isFlagged
          // ignore: cast_nullable_to_non_nullable
          : isFlagged as bool,
      orgIngredientId: orgIngredientId == const $CopyWithPlaceholder()
          ? _value.orgIngredientId
          // ignore: cast_nullable_to_non_nullable
          : orgIngredientId as String,
      unit: unit == const $CopyWithPlaceholder()
          ? _value.unit
          // ignore: cast_nullable_to_non_nullable
          : unit as String,
      unitCost: unitCost == const $CopyWithPlaceholder()
          ? _value.unitCost
          // ignore: cast_nullable_to_non_nullable
          : unitCost as int?,
      variance: variance == const $CopyWithPlaceholder()
          ? _value.variance
          // ignore: cast_nullable_to_non_nullable
          : variance as double?,
      varianceReason: varianceReason == const $CopyWithPlaceholder()
          ? _value.varianceReason
          // ignore: cast_nullable_to_non_nullable
          : varianceReason as String?,
      varianceValue: varianceValue == const $CopyWithPlaceholder()
          ? _value.varianceValue
          // ignore: cast_nullable_to_non_nullable
          : varianceValue as int?,
    );
  }
}

extension $VarianceRowCopyWith on VarianceRow {
  /// Returns a callable class that can be used as follows: `instanceOfVarianceRow.copyWith(...)` or like so:`instanceOfVarianceRow.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VarianceRowCWProxy get copyWith => _$VarianceRowCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VarianceRow _$VarianceRowFromJson(Map<String, dynamic> json) => $checkedCreate(
  'VarianceRow',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'expected_qty',
        'ingredient_name',
        'is_flagged',
        'org_ingredient_id',
        'unit',
      ],
    );
    final val = VarianceRow(
      countedQty: $checkedConvert(
        'counted_qty',
        (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble()),
      ),
      expectedQty: $checkedConvert(
        'expected_qty',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
      ingredientName: $checkedConvert('ingredient_name', (v) => v as String),
      isFlagged: $checkedConvert('is_flagged', (v) => v as bool),
      orgIngredientId: $checkedConvert('org_ingredient_id', (v) => v as String),
      unit: $checkedConvert('unit', (v) => v as String),
      unitCost: $checkedConvert('unit_cost', (v) => (v as num?)?.toInt()),
      variance: $checkedConvert('variance', (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble())),
      varianceReason: $checkedConvert('variance_reason', (v) => v as String?),
      varianceValue: $checkedConvert(
        'variance_value',
        (v) => (v as num?)?.toInt(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'countedQty': 'counted_qty',
    'expectedQty': 'expected_qty',
    'ingredientName': 'ingredient_name',
    'isFlagged': 'is_flagged',
    'orgIngredientId': 'org_ingredient_id',
    'unitCost': 'unit_cost',
    'varianceReason': 'variance_reason',
    'varianceValue': 'variance_value',
  },
);

Map<String, dynamic> _$VarianceRowToJson(VarianceRow instance) =>
    <String, dynamic>{
      'counted_qty': ?instance.countedQty,
      'expected_qty': instance.expectedQty,
      'ingredient_name': instance.ingredientName,
      'is_flagged': instance.isFlagged,
      'org_ingredient_id': instance.orgIngredientId,
      'unit': instance.unit,
      'unit_cost': ?instance.unitCost,
      'variance': ?instance.variance,
      'variance_reason': ?instance.varianceReason,
      'variance_value': ?instance.varianceValue,
    };
