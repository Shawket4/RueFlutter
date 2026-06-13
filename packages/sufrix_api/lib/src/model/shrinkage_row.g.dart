// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shrinkage_row.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ShrinkageRowCWProxy {
  ShrinkageRow ingredientName(String ingredientName);

  ShrinkageRow orgIngredientId(String orgIngredientId);

  ShrinkageRow reason(String reason);

  ShrinkageRow shrinkageQty(double shrinkageQty);

  ShrinkageRow shrinkageValue(int? shrinkageValue);

  ShrinkageRow unit(String unit);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ShrinkageRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ShrinkageRow(...).copyWith(id: 12, name: "My name")
  /// ````
  ShrinkageRow call({
    String ingredientName,
    String orgIngredientId,
    String reason,
    double shrinkageQty,
    int? shrinkageValue,
    String unit,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfShrinkageRow.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfShrinkageRow.copyWith.fieldName(...)`
class _$ShrinkageRowCWProxyImpl implements _$ShrinkageRowCWProxy {
  const _$ShrinkageRowCWProxyImpl(this._value);

  final ShrinkageRow _value;

  @override
  ShrinkageRow ingredientName(String ingredientName) =>
      this(ingredientName: ingredientName);

  @override
  ShrinkageRow orgIngredientId(String orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  ShrinkageRow reason(String reason) => this(reason: reason);

  @override
  ShrinkageRow shrinkageQty(double shrinkageQty) =>
      this(shrinkageQty: shrinkageQty);

  @override
  ShrinkageRow shrinkageValue(int? shrinkageValue) =>
      this(shrinkageValue: shrinkageValue);

  @override
  ShrinkageRow unit(String unit) => this(unit: unit);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ShrinkageRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ShrinkageRow(...).copyWith(id: 12, name: "My name")
  /// ````
  ShrinkageRow call({
    Object? ingredientName = const $CopyWithPlaceholder(),
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? shrinkageQty = const $CopyWithPlaceholder(),
    Object? shrinkageValue = const $CopyWithPlaceholder(),
    Object? unit = const $CopyWithPlaceholder(),
  }) {
    return ShrinkageRow(
      ingredientName: ingredientName == const $CopyWithPlaceholder()
          ? _value.ingredientName
          // ignore: cast_nullable_to_non_nullable
          : ingredientName as String,
      orgIngredientId: orgIngredientId == const $CopyWithPlaceholder()
          ? _value.orgIngredientId
          // ignore: cast_nullable_to_non_nullable
          : orgIngredientId as String,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
      shrinkageQty: shrinkageQty == const $CopyWithPlaceholder()
          ? _value.shrinkageQty
          // ignore: cast_nullable_to_non_nullable
          : shrinkageQty as double,
      shrinkageValue: shrinkageValue == const $CopyWithPlaceholder()
          ? _value.shrinkageValue
          // ignore: cast_nullable_to_non_nullable
          : shrinkageValue as int?,
      unit: unit == const $CopyWithPlaceholder()
          ? _value.unit
          // ignore: cast_nullable_to_non_nullable
          : unit as String,
    );
  }
}

extension $ShrinkageRowCopyWith on ShrinkageRow {
  /// Returns a callable class that can be used as follows: `instanceOfShrinkageRow.copyWith(...)` or like so:`instanceOfShrinkageRow.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ShrinkageRowCWProxy get copyWith => _$ShrinkageRowCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShrinkageRow _$ShrinkageRowFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ShrinkageRow',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'ingredient_name',
        'org_ingredient_id',
        'reason',
        'shrinkage_qty',
        'unit',
      ],
    );
    final val = ShrinkageRow(
      ingredientName: $checkedConvert('ingredient_name', (v) => v as String),
      orgIngredientId: $checkedConvert('org_ingredient_id', (v) => v as String),
      reason: $checkedConvert('reason', (v) => v as String),
      shrinkageQty: $checkedConvert(
        'shrinkage_qty',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
      shrinkageValue: $checkedConvert(
        'shrinkage_value',
        (v) => (v as num?)?.toInt(),
      ),
      unit: $checkedConvert('unit', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'ingredientName': 'ingredient_name',
    'orgIngredientId': 'org_ingredient_id',
    'shrinkageQty': 'shrinkage_qty',
    'shrinkageValue': 'shrinkage_value',
  },
);

Map<String, dynamic> _$ShrinkageRowToJson(ShrinkageRow instance) =>
    <String, dynamic>{
      'ingredient_name': instance.ingredientName,
      'org_ingredient_id': instance.orgIngredientId,
      'reason': instance.reason,
      'shrinkage_qty': instance.shrinkageQty,
      'shrinkage_value': ?instance.shrinkageValue,
      'unit': instance.unit,
    };
