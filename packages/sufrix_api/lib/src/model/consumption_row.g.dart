// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumption_row.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConsumptionRowCWProxy {
  ConsumptionRow consumedQty(double consumedQty);

  ConsumptionRow consumedValue(int? consumedValue);

  ConsumptionRow ingredientName(String ingredientName);

  ConsumptionRow orgIngredientId(String orgIngredientId);

  ConsumptionRow unit(String unit);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConsumptionRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConsumptionRow(...).copyWith(id: 12, name: "My name")
  /// ````
  ConsumptionRow call({
    double consumedQty,
    int? consumedValue,
    String ingredientName,
    String orgIngredientId,
    String unit,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfConsumptionRow.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfConsumptionRow.copyWith.fieldName(...)`
class _$ConsumptionRowCWProxyImpl implements _$ConsumptionRowCWProxy {
  const _$ConsumptionRowCWProxyImpl(this._value);

  final ConsumptionRow _value;

  @override
  ConsumptionRow consumedQty(double consumedQty) =>
      this(consumedQty: consumedQty);

  @override
  ConsumptionRow consumedValue(int? consumedValue) =>
      this(consumedValue: consumedValue);

  @override
  ConsumptionRow ingredientName(String ingredientName) =>
      this(ingredientName: ingredientName);

  @override
  ConsumptionRow orgIngredientId(String orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  ConsumptionRow unit(String unit) => this(unit: unit);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConsumptionRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConsumptionRow(...).copyWith(id: 12, name: "My name")
  /// ````
  ConsumptionRow call({
    Object? consumedQty = const $CopyWithPlaceholder(),
    Object? consumedValue = const $CopyWithPlaceholder(),
    Object? ingredientName = const $CopyWithPlaceholder(),
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? unit = const $CopyWithPlaceholder(),
  }) {
    return ConsumptionRow(
      consumedQty: consumedQty == const $CopyWithPlaceholder()
          ? _value.consumedQty
          // ignore: cast_nullable_to_non_nullable
          : consumedQty as double,
      consumedValue: consumedValue == const $CopyWithPlaceholder()
          ? _value.consumedValue
          // ignore: cast_nullable_to_non_nullable
          : consumedValue as int?,
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
    );
  }
}

extension $ConsumptionRowCopyWith on ConsumptionRow {
  /// Returns a callable class that can be used as follows: `instanceOfConsumptionRow.copyWith(...)` or like so:`instanceOfConsumptionRow.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ConsumptionRowCWProxy get copyWith => _$ConsumptionRowCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsumptionRow _$ConsumptionRowFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ConsumptionRow',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'consumed_qty',
        'ingredient_name',
        'org_ingredient_id',
        'unit',
      ],
    );
    final val = ConsumptionRow(
      consumedQty: $checkedConvert(
        'consumed_qty',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
      consumedValue: $checkedConvert(
        'consumed_value',
        (v) => (v as num?)?.toInt(),
      ),
      ingredientName: $checkedConvert('ingredient_name', (v) => v as String),
      orgIngredientId: $checkedConvert('org_ingredient_id', (v) => v as String),
      unit: $checkedConvert('unit', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'consumedQty': 'consumed_qty',
    'consumedValue': 'consumed_value',
    'ingredientName': 'ingredient_name',
    'orgIngredientId': 'org_ingredient_id',
  },
);

Map<String, dynamic> _$ConsumptionRowToJson(ConsumptionRow instance) =>
    <String, dynamic>{
      'consumed_qty': instance.consumedQty,
      'consumed_value': ?instance.consumedValue,
      'ingredient_name': instance.ingredientName,
      'org_ingredient_id': instance.orgIngredientId,
      'unit': instance.unit,
    };
