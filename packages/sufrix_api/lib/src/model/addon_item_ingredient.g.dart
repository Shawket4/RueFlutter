// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addon_item_ingredient.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AddonItemIngredientCWProxy {
  AddonItemIngredient ingredientName(String ingredientName);

  AddonItemIngredient ingredientUnit(String ingredientUnit);

  AddonItemIngredient orgIngredientId(String? orgIngredientId);

  AddonItemIngredient quantityUsed(double quantityUsed);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddonItemIngredient(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddonItemIngredient(...).copyWith(id: 12, name: "My name")
  /// ````
  AddonItemIngredient call({
    String ingredientName,
    String ingredientUnit,
    String? orgIngredientId,
    double quantityUsed,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAddonItemIngredient.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAddonItemIngredient.copyWith.fieldName(...)`
class _$AddonItemIngredientCWProxyImpl implements _$AddonItemIngredientCWProxy {
  const _$AddonItemIngredientCWProxyImpl(this._value);

  final AddonItemIngredient _value;

  @override
  AddonItemIngredient ingredientName(String ingredientName) =>
      this(ingredientName: ingredientName);

  @override
  AddonItemIngredient ingredientUnit(String ingredientUnit) =>
      this(ingredientUnit: ingredientUnit);

  @override
  AddonItemIngredient orgIngredientId(String? orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  AddonItemIngredient quantityUsed(double quantityUsed) =>
      this(quantityUsed: quantityUsed);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddonItemIngredient(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddonItemIngredient(...).copyWith(id: 12, name: "My name")
  /// ````
  AddonItemIngredient call({
    Object? ingredientName = const $CopyWithPlaceholder(),
    Object? ingredientUnit = const $CopyWithPlaceholder(),
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? quantityUsed = const $CopyWithPlaceholder(),
  }) {
    return AddonItemIngredient(
      ingredientName: ingredientName == const $CopyWithPlaceholder()
          ? _value.ingredientName
          // ignore: cast_nullable_to_non_nullable
          : ingredientName as String,
      ingredientUnit: ingredientUnit == const $CopyWithPlaceholder()
          ? _value.ingredientUnit
          // ignore: cast_nullable_to_non_nullable
          : ingredientUnit as String,
      orgIngredientId: orgIngredientId == const $CopyWithPlaceholder()
          ? _value.orgIngredientId
          // ignore: cast_nullable_to_non_nullable
          : orgIngredientId as String?,
      quantityUsed: quantityUsed == const $CopyWithPlaceholder()
          ? _value.quantityUsed
          // ignore: cast_nullable_to_non_nullable
          : quantityUsed as double,
    );
  }
}

extension $AddonItemIngredientCopyWith on AddonItemIngredient {
  /// Returns a callable class that can be used as follows: `instanceOfAddonItemIngredient.copyWith(...)` or like so:`instanceOfAddonItemIngredient.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AddonItemIngredientCWProxy get copyWith =>
      _$AddonItemIngredientCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddonItemIngredient _$AddonItemIngredientFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'AddonItemIngredient',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'ingredient_name',
        'ingredient_unit',
        'quantity_used',
      ],
    );
    final val = AddonItemIngredient(
      ingredientName: $checkedConvert('ingredient_name', (v) => v as String),
      ingredientUnit: $checkedConvert('ingredient_unit', (v) => v as String),
      orgIngredientId: $checkedConvert(
        'org_ingredient_id',
        (v) => v as String?,
      ),
      quantityUsed: $checkedConvert(
        'quantity_used',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'ingredientName': 'ingredient_name',
    'ingredientUnit': 'ingredient_unit',
    'orgIngredientId': 'org_ingredient_id',
    'quantityUsed': 'quantity_used',
  },
);

Map<String, dynamic> _$AddonItemIngredientToJson(
  AddonItemIngredient instance,
) => <String, dynamic>{
  'ingredient_name': instance.ingredientName,
  'ingredient_unit': instance.ingredientUnit,
  'org_ingredient_id': ?instance.orgIngredientId,
  'quantity_used': instance.quantityUsed,
};
