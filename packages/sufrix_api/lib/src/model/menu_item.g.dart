// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MenuItemCWProxy {
  MenuItem basePrice(int basePrice);

  MenuItem categoryId(String? categoryId);

  MenuItem createdAt(DateTime createdAt);

  MenuItem defaultMilkAddonId(String? defaultMilkAddonId);

  MenuItem deletedAt(DateTime? deletedAt);

  MenuItem description(String? description);

  MenuItem descriptionTranslations(Object descriptionTranslations);

  MenuItem id(String id);

  MenuItem imageUrl(String? imageUrl);

  MenuItem isActive(bool isActive);

  MenuItem name(String name);

  MenuItem nameTranslations(Object nameTranslations);

  MenuItem orgId(String orgId);

  MenuItem updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MenuItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MenuItem(...).copyWith(id: 12, name: "My name")
  /// ````
  MenuItem call({
    int basePrice,
    String? categoryId,
    DateTime createdAt,
    String? defaultMilkAddonId,
    DateTime? deletedAt,
    String? description,
    Object descriptionTranslations,
    String id,
    String? imageUrl,
    bool isActive,
    String name,
    Object nameTranslations,
    String orgId,
    DateTime updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMenuItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMenuItem.copyWith.fieldName(...)`
class _$MenuItemCWProxyImpl implements _$MenuItemCWProxy {
  const _$MenuItemCWProxyImpl(this._value);

  final MenuItem _value;

  @override
  MenuItem basePrice(int basePrice) => this(basePrice: basePrice);

  @override
  MenuItem categoryId(String? categoryId) => this(categoryId: categoryId);

  @override
  MenuItem createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  MenuItem defaultMilkAddonId(String? defaultMilkAddonId) =>
      this(defaultMilkAddonId: defaultMilkAddonId);

  @override
  MenuItem deletedAt(DateTime? deletedAt) => this(deletedAt: deletedAt);

  @override
  MenuItem description(String? description) => this(description: description);

  @override
  MenuItem descriptionTranslations(Object descriptionTranslations) =>
      this(descriptionTranslations: descriptionTranslations);

  @override
  MenuItem id(String id) => this(id: id);

  @override
  MenuItem imageUrl(String? imageUrl) => this(imageUrl: imageUrl);

  @override
  MenuItem isActive(bool isActive) => this(isActive: isActive);

  @override
  MenuItem name(String name) => this(name: name);

  @override
  MenuItem nameTranslations(Object nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  MenuItem orgId(String orgId) => this(orgId: orgId);

  @override
  MenuItem updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MenuItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MenuItem(...).copyWith(id: 12, name: "My name")
  /// ````
  MenuItem call({
    Object? basePrice = const $CopyWithPlaceholder(),
    Object? categoryId = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? defaultMilkAddonId = const $CopyWithPlaceholder(),
    Object? deletedAt = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? descriptionTranslations = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? imageUrl = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
    Object? orgId = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return MenuItem(
      basePrice: basePrice == const $CopyWithPlaceholder()
          ? _value.basePrice
          // ignore: cast_nullable_to_non_nullable
          : basePrice as int,
      categoryId: categoryId == const $CopyWithPlaceholder()
          ? _value.categoryId
          // ignore: cast_nullable_to_non_nullable
          : categoryId as String?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      defaultMilkAddonId: defaultMilkAddonId == const $CopyWithPlaceholder()
          ? _value.defaultMilkAddonId
          // ignore: cast_nullable_to_non_nullable
          : defaultMilkAddonId as String?,
      deletedAt: deletedAt == const $CopyWithPlaceholder()
          ? _value.deletedAt
          // ignore: cast_nullable_to_non_nullable
          : deletedAt as DateTime?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      descriptionTranslations:
          descriptionTranslations == const $CopyWithPlaceholder()
          ? _value.descriptionTranslations
          // ignore: cast_nullable_to_non_nullable
          : descriptionTranslations as Object,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      imageUrl: imageUrl == const $CopyWithPlaceholder()
          ? _value.imageUrl
          // ignore: cast_nullable_to_non_nullable
          : imageUrl as String?,
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
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $MenuItemCopyWith on MenuItem {
  /// Returns a callable class that can be used as follows: `instanceOfMenuItem.copyWith(...)` or like so:`instanceOfMenuItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MenuItemCWProxy get copyWith => _$MenuItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) => $checkedCreate(
  'MenuItem',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'base_price',
        'created_at',
        'description_translations',
        'id',
        'is_active',
        'name',
        'name_translations',
        'org_id',
        'updated_at',
      ],
    );
    final val = MenuItem(
      basePrice: $checkedConvert('base_price', (v) => (v as num).toInt()),
      categoryId: $checkedConvert('category_id', (v) => v as String?),
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      defaultMilkAddonId: $checkedConvert(
        'default_milk_addon_id',
        (v) => v as String?,
      ),
      deletedAt: $checkedConvert(
        'deleted_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      description: $checkedConvert('description', (v) => v as String?),
      descriptionTranslations: $checkedConvert(
        'description_translations',
        (v) => v as Object,
      ),
      id: $checkedConvert('id', (v) => v as String),
      imageUrl: $checkedConvert('image_url', (v) => v as String?),
      isActive: $checkedConvert('is_active', (v) => v as bool),
      name: $checkedConvert('name', (v) => v as String),
      nameTranslations: $checkedConvert(
        'name_translations',
        (v) => v as Object,
      ),
      orgId: $checkedConvert('org_id', (v) => v as String),
      updatedAt: $checkedConvert(
        'updated_at',
        (v) => DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'basePrice': 'base_price',
    'categoryId': 'category_id',
    'createdAt': 'created_at',
    'defaultMilkAddonId': 'default_milk_addon_id',
    'deletedAt': 'deleted_at',
    'descriptionTranslations': 'description_translations',
    'imageUrl': 'image_url',
    'isActive': 'is_active',
    'nameTranslations': 'name_translations',
    'orgId': 'org_id',
    'updatedAt': 'updated_at',
  },
);

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{
  'base_price': instance.basePrice,
  'category_id': ?instance.categoryId,
  'created_at': instance.createdAt.toIso8601String(),
  'default_milk_addon_id': ?instance.defaultMilkAddonId,
  'deleted_at': ?instance.deletedAt?.toIso8601String(),
  'description': ?instance.description,
  'description_translations': instance.descriptionTranslations,
  'id': instance.id,
  'image_url': ?instance.imageUrl,
  'is_active': instance.isActive,
  'name': instance.name,
  'name_translations': instance.nameTranslations,
  'org_id': instance.orgId,
  'updated_at': instance.updatedAt.toIso8601String(),
};
