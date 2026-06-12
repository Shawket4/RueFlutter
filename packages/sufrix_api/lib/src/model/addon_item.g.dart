// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addon_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AddonItemCWProxy {
  AddonItem addonType(String addonType);

  AddonItem createdAt(DateTime createdAt);

  AddonItem defaultPrice(int defaultPrice);

  AddonItem displayOrder(int displayOrder);

  AddonItem id(String id);

  AddonItem ingredients(List<AddonItemIngredient>? ingredients);

  AddonItem isActive(bool isActive);

  AddonItem name(String name);

  AddonItem nameTranslations(Object nameTranslations);

  AddonItem orgId(String orgId);

  AddonItem primaryIngredientId(String? primaryIngredientId);

  AddonItem updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddonItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddonItem(...).copyWith(id: 12, name: "My name")
  /// ````
  AddonItem call({
    String addonType,
    DateTime createdAt,
    int defaultPrice,
    int displayOrder,
    String id,
    List<AddonItemIngredient>? ingredients,
    bool isActive,
    String name,
    Object nameTranslations,
    String orgId,
    String? primaryIngredientId,
    DateTime updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAddonItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAddonItem.copyWith.fieldName(...)`
class _$AddonItemCWProxyImpl implements _$AddonItemCWProxy {
  const _$AddonItemCWProxyImpl(this._value);

  final AddonItem _value;

  @override
  AddonItem addonType(String addonType) => this(addonType: addonType);

  @override
  AddonItem createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  AddonItem defaultPrice(int defaultPrice) => this(defaultPrice: defaultPrice);

  @override
  AddonItem displayOrder(int displayOrder) => this(displayOrder: displayOrder);

  @override
  AddonItem id(String id) => this(id: id);

  @override
  AddonItem ingredients(List<AddonItemIngredient>? ingredients) =>
      this(ingredients: ingredients);

  @override
  AddonItem isActive(bool isActive) => this(isActive: isActive);

  @override
  AddonItem name(String name) => this(name: name);

  @override
  AddonItem nameTranslations(Object nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  AddonItem orgId(String orgId) => this(orgId: orgId);

  @override
  AddonItem primaryIngredientId(String? primaryIngredientId) =>
      this(primaryIngredientId: primaryIngredientId);

  @override
  AddonItem updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddonItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddonItem(...).copyWith(id: 12, name: "My name")
  /// ````
  AddonItem call({
    Object? addonType = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? defaultPrice = const $CopyWithPlaceholder(),
    Object? displayOrder = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? ingredients = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
    Object? orgId = const $CopyWithPlaceholder(),
    Object? primaryIngredientId = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return AddonItem(
      addonType: addonType == const $CopyWithPlaceholder()
          ? _value.addonType
          // ignore: cast_nullable_to_non_nullable
          : addonType as String,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      defaultPrice: defaultPrice == const $CopyWithPlaceholder()
          ? _value.defaultPrice
          // ignore: cast_nullable_to_non_nullable
          : defaultPrice as int,
      displayOrder: displayOrder == const $CopyWithPlaceholder()
          ? _value.displayOrder
          // ignore: cast_nullable_to_non_nullable
          : displayOrder as int,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      ingredients: ingredients == const $CopyWithPlaceholder()
          ? _value.ingredients
          // ignore: cast_nullable_to_non_nullable
          : ingredients as List<AddonItemIngredient>?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      nameTranslations: nameTranslations == const $CopyWithPlaceholder()
          ? _value.nameTranslations
          // ignore: cast_nullable_to_non_nullable
          : nameTranslations as Object,
      orgId: orgId == const $CopyWithPlaceholder()
          ? _value.orgId
          // ignore: cast_nullable_to_non_nullable
          : orgId as String,
      primaryIngredientId: primaryIngredientId == const $CopyWithPlaceholder()
          ? _value.primaryIngredientId
          // ignore: cast_nullable_to_non_nullable
          : primaryIngredientId as String?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $AddonItemCopyWith on AddonItem {
  /// Returns a callable class that can be used as follows: `instanceOfAddonItem.copyWith(...)` or like so:`instanceOfAddonItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AddonItemCWProxy get copyWith => _$AddonItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddonItem _$AddonItemFromJson(Map<String, dynamic> json) => $checkedCreate(
  'AddonItem',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'addon_type',
        'created_at',
        'default_price',
        'display_order',
        'id',
        'is_active',
        'name',
        'name_translations',
        'org_id',
        'updated_at',
      ],
    );
    final val = AddonItem(
      addonType: $checkedConvert('addon_type', (v) => v as String),
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      defaultPrice: $checkedConvert('default_price', (v) => (v as num).toInt()),
      displayOrder: $checkedConvert('display_order', (v) => (v as num).toInt()),
      id: $checkedConvert('id', (v) => v as String),
      ingredients: $checkedConvert(
        'ingredients',
        (v) => (v as List<dynamic>?)
            ?.map(
              (e) => AddonItemIngredient.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      isActive: $checkedConvert('is_active', (v) => v as bool),
      name: $checkedConvert('name', (v) => v as String),
      nameTranslations: $checkedConvert(
        'name_translations',
        (v) => v as Object,
      ),
      orgId: $checkedConvert('org_id', (v) => v as String),
      primaryIngredientId: $checkedConvert(
        'primary_ingredient_id',
        (v) => v as String?,
      ),
      updatedAt: $checkedConvert(
        'updated_at',
        (v) => DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'addonType': 'addon_type',
    'createdAt': 'created_at',
    'defaultPrice': 'default_price',
    'displayOrder': 'display_order',
    'isActive': 'is_active',
    'nameTranslations': 'name_translations',
    'orgId': 'org_id',
    'primaryIngredientId': 'primary_ingredient_id',
    'updatedAt': 'updated_at',
  },
);

Map<String, dynamic> _$AddonItemToJson(AddonItem instance) => <String, dynamic>{
  'addon_type': instance.addonType,
  'created_at': instance.createdAt.toIso8601String(),
  'default_price': instance.defaultPrice,
  'display_order': instance.displayOrder,
  'id': instance.id,
  'ingredients': ?instance.ingredients?.map((e) => e.toJson()).toList(),
  'is_active': instance.isActive,
  'name': instance.name,
  'name_translations': instance.nameTranslations,
  'org_id': instance.orgId,
  'primary_ingredient_id': ?instance.primaryIngredientId,
  'updated_at': instance.updatedAt.toIso8601String(),
};
