// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item_recipe.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MenuItemRecipeCWProxy {
  MenuItemRecipe category(String category);

  MenuItemRecipe ingredientName(String ingredientName);

  MenuItemRecipe ingredientUnit(String ingredientUnit);

  MenuItemRecipe orgIngredientId(String? orgIngredientId);

  MenuItemRecipe quantityUsed(double quantityUsed);

  MenuItemRecipe sizeLabel(String sizeLabel);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MenuItemRecipe(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MenuItemRecipe(...).copyWith(id: 12, name: "My name")
  /// ````
  MenuItemRecipe call({
    String category,
    String ingredientName,
    String ingredientUnit,
    String? orgIngredientId,
    double quantityUsed,
    String sizeLabel,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMenuItemRecipe.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMenuItemRecipe.copyWith.fieldName(...)`
class _$MenuItemRecipeCWProxyImpl implements _$MenuItemRecipeCWProxy {
  const _$MenuItemRecipeCWProxyImpl(this._value);

  final MenuItemRecipe _value;

  @override
  MenuItemRecipe category(String category) => this(category: category);

  @override
  MenuItemRecipe ingredientName(String ingredientName) =>
      this(ingredientName: ingredientName);

  @override
  MenuItemRecipe ingredientUnit(String ingredientUnit) =>
      this(ingredientUnit: ingredientUnit);

  @override
  MenuItemRecipe orgIngredientId(String? orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  MenuItemRecipe quantityUsed(double quantityUsed) =>
      this(quantityUsed: quantityUsed);

  @override
  MenuItemRecipe sizeLabel(String sizeLabel) => this(sizeLabel: sizeLabel);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MenuItemRecipe(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MenuItemRecipe(...).copyWith(id: 12, name: "My name")
  /// ````
  MenuItemRecipe call({
    Object? category = const $CopyWithPlaceholder(),
    Object? ingredientName = const $CopyWithPlaceholder(),
    Object? ingredientUnit = const $CopyWithPlaceholder(),
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? quantityUsed = const $CopyWithPlaceholder(),
    Object? sizeLabel = const $CopyWithPlaceholder(),
  }) {
    return MenuItemRecipe(
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as String,
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
      sizeLabel: sizeLabel == const $CopyWithPlaceholder()
          ? _value.sizeLabel
          // ignore: cast_nullable_to_non_nullable
          : sizeLabel as String,
    );
  }
}

extension $MenuItemRecipeCopyWith on MenuItemRecipe {
  /// Returns a callable class that can be used as follows: `instanceOfMenuItemRecipe.copyWith(...)` or like so:`instanceOfMenuItemRecipe.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MenuItemRecipeCWProxy get copyWith => _$MenuItemRecipeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItemRecipe _$MenuItemRecipeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'MenuItemRecipe',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'category',
        'ingredient_name',
        'ingredient_unit',
        'quantity_used',
        'size_label',
      ],
    );
    final val = MenuItemRecipe(
      category: $checkedConvert('category', (v) => v as String),
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
      sizeLabel: $checkedConvert('size_label', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'ingredientName': 'ingredient_name',
    'ingredientUnit': 'ingredient_unit',
    'orgIngredientId': 'org_ingredient_id',
    'quantityUsed': 'quantity_used',
    'sizeLabel': 'size_label',
  },
);

Map<String, dynamic> _$MenuItemRecipeToJson(MenuItemRecipe instance) =>
    <String, dynamic>{
      'category': instance.category,
      'ingredient_name': instance.ingredientName,
      'ingredient_unit': instance.ingredientUnit,
      'org_ingredient_id': ?instance.orgIngredientId,
      'quantity_used': instance.quantityUsed,
      'size_label': instance.sizeLabel,
    };
