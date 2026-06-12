// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drink_recipe.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DrinkRecipeCWProxy {
  DrinkRecipe id(String id);

  DrinkRecipe ingredientName(String ingredientName);

  DrinkRecipe menuItemId(String menuItemId);

  DrinkRecipe orgIngredientId(String? orgIngredientId);

  DrinkRecipe quantityUsed(double quantityUsed);

  DrinkRecipe sizeLabel(String sizeLabel);

  DrinkRecipe unit(String unit);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DrinkRecipe(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DrinkRecipe(...).copyWith(id: 12, name: "My name")
  /// ````
  DrinkRecipe call({
    String id,
    String ingredientName,
    String menuItemId,
    String? orgIngredientId,
    double quantityUsed,
    String sizeLabel,
    String unit,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDrinkRecipe.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDrinkRecipe.copyWith.fieldName(...)`
class _$DrinkRecipeCWProxyImpl implements _$DrinkRecipeCWProxy {
  const _$DrinkRecipeCWProxyImpl(this._value);

  final DrinkRecipe _value;

  @override
  DrinkRecipe id(String id) => this(id: id);

  @override
  DrinkRecipe ingredientName(String ingredientName) =>
      this(ingredientName: ingredientName);

  @override
  DrinkRecipe menuItemId(String menuItemId) => this(menuItemId: menuItemId);

  @override
  DrinkRecipe orgIngredientId(String? orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  DrinkRecipe quantityUsed(double quantityUsed) =>
      this(quantityUsed: quantityUsed);

  @override
  DrinkRecipe sizeLabel(String sizeLabel) => this(sizeLabel: sizeLabel);

  @override
  DrinkRecipe unit(String unit) => this(unit: unit);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DrinkRecipe(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DrinkRecipe(...).copyWith(id: 12, name: "My name")
  /// ````
  DrinkRecipe call({
    Object? id = const $CopyWithPlaceholder(),
    Object? ingredientName = const $CopyWithPlaceholder(),
    Object? menuItemId = const $CopyWithPlaceholder(),
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? quantityUsed = const $CopyWithPlaceholder(),
    Object? sizeLabel = const $CopyWithPlaceholder(),
    Object? unit = const $CopyWithPlaceholder(),
  }) {
    return DrinkRecipe(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      ingredientName: ingredientName == const $CopyWithPlaceholder()
          ? _value.ingredientName
          // ignore: cast_nullable_to_non_nullable
          : ingredientName as String,
      menuItemId: menuItemId == const $CopyWithPlaceholder()
          ? _value.menuItemId
          // ignore: cast_nullable_to_non_nullable
          : menuItemId as String,
      orgIngredientId: orgIngredientId == const $CopyWithPlaceholder()
          ? _value.orgIngredientId
          // ignore: cast_nullable_to_non_nullable
          : orgIngredientId as String?,
      quantityUsed: quantityUsed == const $CopyWithPlaceholder()
          ? _value.quantityUsed
          // ignore: cast_nullable_to_non_nullable
          : quantityUsed as double,
      sizeLabel: sizeLabel == const $CopyWithPlaceholder()
          ? _value.sizeLabel
          // ignore: cast_nullable_to_non_nullable
          : sizeLabel as String,
      unit: unit == const $CopyWithPlaceholder()
          ? _value.unit
          // ignore: cast_nullable_to_non_nullable
          : unit as String,
    );
  }
}

extension $DrinkRecipeCopyWith on DrinkRecipe {
  /// Returns a callable class that can be used as follows: `instanceOfDrinkRecipe.copyWith(...)` or like so:`instanceOfDrinkRecipe.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DrinkRecipeCWProxy get copyWith => _$DrinkRecipeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrinkRecipe _$DrinkRecipeFromJson(Map<String, dynamic> json) => $checkedCreate(
  'DrinkRecipe',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'id',
        'ingredient_name',
        'menu_item_id',
        'quantity_used',
        'size_label',
        'unit',
      ],
    );
    final val = DrinkRecipe(
      id: $checkedConvert('id', (v) => v as String),
      ingredientName: $checkedConvert('ingredient_name', (v) => v as String),
      menuItemId: $checkedConvert('menu_item_id', (v) => v as String),
      orgIngredientId: $checkedConvert(
        'org_ingredient_id',
        (v) => v as String?,
      ),
      quantityUsed: $checkedConvert(
        'quantity_used',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
      sizeLabel: $checkedConvert('size_label', (v) => v as String),
      unit: $checkedConvert('unit', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'ingredientName': 'ingredient_name',
    'menuItemId': 'menu_item_id',
    'orgIngredientId': 'org_ingredient_id',
    'quantityUsed': 'quantity_used',
    'sizeLabel': 'size_label',
  },
);

Map<String, dynamic> _$DrinkRecipeToJson(DrinkRecipe instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ingredient_name': instance.ingredientName,
      'menu_item_id': instance.menuItemId,
      'org_ingredient_id': ?instance.orgIngredientId,
      'quantity_used': instance.quantityUsed,
      'size_label': instance.sizeLabel,
      'unit': instance.unit,
    };
