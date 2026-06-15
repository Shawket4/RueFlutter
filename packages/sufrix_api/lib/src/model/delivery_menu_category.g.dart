// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_menu_category.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DeliveryMenuCategoryCWProxy {
  DeliveryMenuCategory id(String id);

  DeliveryMenuCategory imageUrl(String? imageUrl);

  DeliveryMenuCategory name(String name);

  DeliveryMenuCategory nameTranslations(Object nameTranslations);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeliveryMenuCategory(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeliveryMenuCategory(...).copyWith(id: 12, name: "My name")
  /// ````
  DeliveryMenuCategory call({
    String id,
    String? imageUrl,
    String name,
    Object nameTranslations,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDeliveryMenuCategory.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDeliveryMenuCategory.copyWith.fieldName(...)`
class _$DeliveryMenuCategoryCWProxyImpl
    implements _$DeliveryMenuCategoryCWProxy {
  const _$DeliveryMenuCategoryCWProxyImpl(this._value);

  final DeliveryMenuCategory _value;

  @override
  DeliveryMenuCategory id(String id) => this(id: id);

  @override
  DeliveryMenuCategory imageUrl(String? imageUrl) => this(imageUrl: imageUrl);

  @override
  DeliveryMenuCategory name(String name) => this(name: name);

  @override
  DeliveryMenuCategory nameTranslations(Object nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeliveryMenuCategory(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeliveryMenuCategory(...).copyWith(id: 12, name: "My name")
  /// ````
  DeliveryMenuCategory call({
    Object? id = const $CopyWithPlaceholder(),
    Object? imageUrl = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
  }) {
    return DeliveryMenuCategory(
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
    );
  }
}

extension $DeliveryMenuCategoryCopyWith on DeliveryMenuCategory {
  /// Returns a callable class that can be used as follows: `instanceOfDeliveryMenuCategory.copyWith(...)` or like so:`instanceOfDeliveryMenuCategory.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DeliveryMenuCategoryCWProxy get copyWith =>
      _$DeliveryMenuCategoryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryMenuCategory _$DeliveryMenuCategoryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'DeliveryMenuCategory',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['id', 'name', 'name_translations']);
    final val = DeliveryMenuCategory(
      id: $checkedConvert('id', (v) => v as String),
      imageUrl: $checkedConvert('image_url', (v) => v as String?),
      name: $checkedConvert('name', (v) => v as String),
      nameTranslations: $checkedConvert(
        'name_translations',
        (v) => v as Object,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'imageUrl': 'image_url',
    'nameTranslations': 'name_translations',
  },
);

Map<String, dynamic> _$DeliveryMenuCategoryToJson(
  DeliveryMenuCategory instance,
) => <String, dynamic>{
  'id': instance.id,
  'image_url': ?instance.imageUrl,
  'name': instance.name,
  'name_translations': instance.nameTranslations,
};
