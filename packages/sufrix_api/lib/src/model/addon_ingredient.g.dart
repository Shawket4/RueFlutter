// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addon_ingredient.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AddonIngredientCWProxy {
  AddonIngredient addonItemId(String addonItemId);

  AddonIngredient id(String id);

  AddonIngredient ingredientName(String ingredientName);

  AddonIngredient orgIngredientId(String? orgIngredientId);

  AddonIngredient quantityUsed(double quantityUsed);

  AddonIngredient unit(String unit);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddonIngredient(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddonIngredient(...).copyWith(id: 12, name: "My name")
  /// ````
  AddonIngredient call({
    String addonItemId,
    String id,
    String ingredientName,
    String? orgIngredientId,
    double quantityUsed,
    String unit,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAddonIngredient.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAddonIngredient.copyWith.fieldName(...)`
class _$AddonIngredientCWProxyImpl implements _$AddonIngredientCWProxy {
  const _$AddonIngredientCWProxyImpl(this._value);

  final AddonIngredient _value;

  @override
  AddonIngredient addonItemId(String addonItemId) =>
      this(addonItemId: addonItemId);

  @override
  AddonIngredient id(String id) => this(id: id);

  @override
  AddonIngredient ingredientName(String ingredientName) =>
      this(ingredientName: ingredientName);

  @override
  AddonIngredient orgIngredientId(String? orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  AddonIngredient quantityUsed(double quantityUsed) =>
      this(quantityUsed: quantityUsed);

  @override
  AddonIngredient unit(String unit) => this(unit: unit);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddonIngredient(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddonIngredient(...).copyWith(id: 12, name: "My name")
  /// ````
  AddonIngredient call({
    Object? addonItemId = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? ingredientName = const $CopyWithPlaceholder(),
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? quantityUsed = const $CopyWithPlaceholder(),
    Object? unit = const $CopyWithPlaceholder(),
  }) {
    return AddonIngredient(
      addonItemId: addonItemId == const $CopyWithPlaceholder()
          ? _value.addonItemId
          // ignore: cast_nullable_to_non_nullable
          : addonItemId as String,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      ingredientName: ingredientName == const $CopyWithPlaceholder()
          ? _value.ingredientName
          // ignore: cast_nullable_to_non_nullable
          : ingredientName as String,
      orgIngredientId: orgIngredientId == const $CopyWithPlaceholder()
          ? _value.orgIngredientId
          // ignore: cast_nullable_to_non_nullable
          : orgIngredientId as String?,
      quantityUsed: quantityUsed == const $CopyWithPlaceholder()
          ? _value.quantityUsed
          // ignore: cast_nullable_to_non_nullable
          : quantityUsed as double,
      unit: unit == const $CopyWithPlaceholder()
          ? _value.unit
          // ignore: cast_nullable_to_non_nullable
          : unit as String,
    );
  }
}

extension $AddonIngredientCopyWith on AddonIngredient {
  /// Returns a callable class that can be used as follows: `instanceOfAddonIngredient.copyWith(...)` or like so:`instanceOfAddonIngredient.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AddonIngredientCWProxy get copyWith => _$AddonIngredientCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddonIngredient _$AddonIngredientFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'AddonIngredient',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'addon_item_id',
            'id',
            'ingredient_name',
            'quantity_used',
            'unit',
          ],
        );
        final val = AddonIngredient(
          addonItemId: $checkedConvert('addon_item_id', (v) => v as String),
          id: $checkedConvert('id', (v) => v as String),
          ingredientName: $checkedConvert(
            'ingredient_name',
            (v) => v as String,
          ),
          orgIngredientId: $checkedConvert(
            'org_ingredient_id',
            (v) => v as String?,
          ),
          quantityUsed: $checkedConvert(
            'quantity_used',
            (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
          ),
          unit: $checkedConvert('unit', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'addonItemId': 'addon_item_id',
        'ingredientName': 'ingredient_name',
        'orgIngredientId': 'org_ingredient_id',
        'quantityUsed': 'quantity_used',
      },
    );

Map<String, dynamic> _$AddonIngredientToJson(AddonIngredient instance) =>
    <String, dynamic>{
      'addon_item_id': instance.addonItemId,
      'id': instance.id,
      'ingredient_name': instance.ingredientName,
      'org_ingredient_id': ?instance.orgIngredientId,
      'quantity_used': instance.quantityUsed,
      'unit': instance.unit,
    };
