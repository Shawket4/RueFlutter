// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CategoryCWProxy {
  Category createdAt(DateTime createdAt);

  Category deletedAt(DateTime? deletedAt);

  Category id(String id);

  Category imageUrl(String? imageUrl);

  Category isActive(bool isActive);

  Category name(String name);

  Category nameTranslations(Object nameTranslations);

  Category orgId(String orgId);

  Category updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Category(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Category(...).copyWith(id: 12, name: "My name")
  /// ````
  Category call({
    DateTime createdAt,
    DateTime? deletedAt,
    String id,
    String? imageUrl,
    bool isActive,
    String name,
    Object nameTranslations,
    String orgId,
    DateTime updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCategory.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCategory.copyWith.fieldName(...)`
class _$CategoryCWProxyImpl implements _$CategoryCWProxy {
  const _$CategoryCWProxyImpl(this._value);

  final Category _value;

  @override
  Category createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  Category deletedAt(DateTime? deletedAt) => this(deletedAt: deletedAt);

  @override
  Category id(String id) => this(id: id);

  @override
  Category imageUrl(String? imageUrl) => this(imageUrl: imageUrl);

  @override
  Category isActive(bool isActive) => this(isActive: isActive);

  @override
  Category name(String name) => this(name: name);

  @override
  Category nameTranslations(Object nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  Category orgId(String orgId) => this(orgId: orgId);

  @override
  Category updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Category(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Category(...).copyWith(id: 12, name: "My name")
  /// ````
  Category call({
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? deletedAt = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? imageUrl = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
    Object? orgId = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return Category(
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      deletedAt: deletedAt == const $CopyWithPlaceholder()
          ? _value.deletedAt
          // ignore: cast_nullable_to_non_nullable
          : deletedAt as DateTime?,
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

extension $CategoryCopyWith on Category {
  /// Returns a callable class that can be used as follows: `instanceOfCategory.copyWith(...)` or like so:`instanceOfCategory.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CategoryCWProxy get copyWith => _$CategoryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Category',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'created_at',
        'id',
        'is_active',
        'name',
        'name_translations',
        'org_id',
        'updated_at',
      ],
    );
    final val = Category(
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      deletedAt: $checkedConvert(
        'deleted_at',
        (v) => v == null ? null : DateTime.parse(v as String),
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
    'createdAt': 'created_at',
    'deletedAt': 'deleted_at',
    'imageUrl': 'image_url',
    'isActive': 'is_active',
    'nameTranslations': 'name_translations',
    'orgId': 'org_id',
    'updatedAt': 'updated_at',
  },
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'created_at': instance.createdAt.toIso8601String(),
  'deleted_at': ?instance.deletedAt?.toIso8601String(),
  'id': instance.id,
  'image_url': ?instance.imageUrl,
  'is_active': instance.isActive,
  'name': instance.name,
  'name_translations': instance.nameTranslations,
  'org_id': instance.orgId,
  'updated_at': instance.updatedAt.toIso8601String(),
};
