// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_menu_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DeliveryMenuItemCWProxy {
  DeliveryMenuItem categoryId(String? categoryId);

  DeliveryMenuItem defaultMilkAddonId(String? defaultMilkAddonId);

  DeliveryMenuItem description(String? description);

  DeliveryMenuItem id(String id);

  DeliveryMenuItem imageUrl(String? imageUrl);

  DeliveryMenuItem name(String name);

  DeliveryMenuItem nameTranslations(Object nameTranslations);

  DeliveryMenuItem optionals(List<DeliveryOptionalField> optionals);

  DeliveryMenuItem price(int price);

  DeliveryMenuItem sizes(List<DeliveryMenuSize> sizes);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeliveryMenuItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeliveryMenuItem(...).copyWith(id: 12, name: "My name")
  /// ````
  DeliveryMenuItem call({
    String? categoryId,
    String? defaultMilkAddonId,
    String? description,
    String id,
    String? imageUrl,
    String name,
    Object nameTranslations,
    List<DeliveryOptionalField> optionals,
    int price,
    List<DeliveryMenuSize> sizes,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDeliveryMenuItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDeliveryMenuItem.copyWith.fieldName(...)`
class _$DeliveryMenuItemCWProxyImpl implements _$DeliveryMenuItemCWProxy {
  const _$DeliveryMenuItemCWProxyImpl(this._value);

  final DeliveryMenuItem _value;

  @override
  DeliveryMenuItem categoryId(String? categoryId) =>
      this(categoryId: categoryId);

  @override
  DeliveryMenuItem defaultMilkAddonId(String? defaultMilkAddonId) =>
      this(defaultMilkAddonId: defaultMilkAddonId);

  @override
  DeliveryMenuItem description(String? description) =>
      this(description: description);

  @override
  DeliveryMenuItem id(String id) => this(id: id);

  @override
  DeliveryMenuItem imageUrl(String? imageUrl) => this(imageUrl: imageUrl);

  @override
  DeliveryMenuItem name(String name) => this(name: name);

  @override
  DeliveryMenuItem nameTranslations(Object nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  DeliveryMenuItem optionals(List<DeliveryOptionalField> optionals) =>
      this(optionals: optionals);

  @override
  DeliveryMenuItem price(int price) => this(price: price);

  @override
  DeliveryMenuItem sizes(List<DeliveryMenuSize> sizes) => this(sizes: sizes);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeliveryMenuItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeliveryMenuItem(...).copyWith(id: 12, name: "My name")
  /// ````
  DeliveryMenuItem call({
    Object? categoryId = const $CopyWithPlaceholder(),
    Object? defaultMilkAddonId = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? imageUrl = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
    Object? optionals = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
    Object? sizes = const $CopyWithPlaceholder(),
  }) {
    return DeliveryMenuItem(
      categoryId: categoryId == const $CopyWithPlaceholder()
          ? _value.categoryId
          // ignore: cast_nullable_to_non_nullable
          : categoryId as String?,
      defaultMilkAddonId: defaultMilkAddonId == const $CopyWithPlaceholder()
          ? _value.defaultMilkAddonId
          // ignore: cast_nullable_to_non_nullable
          : defaultMilkAddonId as String?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      imageUrl: imageUrl == const $CopyWithPlaceholder()
          ? _value.imageUrl
          // ignore: cast_nullable_to_non_nullable
          : imageUrl as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      nameTranslations: nameTranslations == const $CopyWithPlaceholder()
          ? _value.nameTranslations
          // ignore: cast_nullable_to_non_nullable
          : nameTranslations as Object,
      optionals: optionals == const $CopyWithPlaceholder()
          ? _value.optionals
          // ignore: cast_nullable_to_non_nullable
          : optionals as List<DeliveryOptionalField>,
      price: price == const $CopyWithPlaceholder()
          ? _value.price
          // ignore: cast_nullable_to_non_nullable
          : price as int,
      sizes: sizes == const $CopyWithPlaceholder()
          ? _value.sizes
          // ignore: cast_nullable_to_non_nullable
          : sizes as List<DeliveryMenuSize>,
    );
  }
}

extension $DeliveryMenuItemCopyWith on DeliveryMenuItem {
  /// Returns a callable class that can be used as follows: `instanceOfDeliveryMenuItem.copyWith(...)` or like so:`instanceOfDeliveryMenuItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DeliveryMenuItemCWProxy get copyWith => _$DeliveryMenuItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryMenuItem _$DeliveryMenuItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'DeliveryMenuItem',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'id',
            'name',
            'name_translations',
            'optionals',
            'price',
            'sizes',
          ],
        );
        final val = DeliveryMenuItem(
          categoryId: $checkedConvert('category_id', (v) => v as String?),
          defaultMilkAddonId: $checkedConvert(
            'default_milk_addon_id',
            (v) => v as String?,
          ),
          description: $checkedConvert('description', (v) => v as String?),
          id: $checkedConvert('id', (v) => v as String),
          imageUrl: $checkedConvert('image_url', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String),
          nameTranslations: $checkedConvert(
            'name_translations',
            (v) => v as Object,
          ),
          optionals: $checkedConvert(
            'optionals',
            (v) => (v as List<dynamic>)
                .map(
                  (e) =>
                      DeliveryOptionalField.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
          ),
          price: $checkedConvert('price', (v) => (v as num).toInt()),
          sizes: $checkedConvert(
            'sizes',
            (v) => (v as List<dynamic>)
                .map(
                  (e) => DeliveryMenuSize.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'categoryId': 'category_id',
        'defaultMilkAddonId': 'default_milk_addon_id',
        'imageUrl': 'image_url',
        'nameTranslations': 'name_translations',
      },
    );

Map<String, dynamic> _$DeliveryMenuItemToJson(DeliveryMenuItem instance) =>
    <String, dynamic>{
      'category_id': ?instance.categoryId,
      'default_milk_addon_id': ?instance.defaultMilkAddonId,
      'description': ?instance.description,
      'id': instance.id,
      'image_url': ?instance.imageUrl,
      'name': instance.name,
      'name_translations': instance.nameTranslations,
      'optionals': instance.optionals.map((e) => e.toJson()).toList(),
      'price': instance.price,
      'sizes': instance.sizes.map((e) => e.toJson()).toList(),
    };
