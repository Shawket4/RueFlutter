// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_category_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateCategoryRequestCWProxy {
  CreateCategoryRequest imageUrl(String? imageUrl);

  CreateCategoryRequest name(String name);

  CreateCategoryRequest nameTranslations(Object? nameTranslations);

  CreateCategoryRequest orgId(String orgId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateCategoryRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateCategoryRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateCategoryRequest call({
    String? imageUrl,
    String name,
    Object? nameTranslations,
    String orgId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCreateCategoryRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCreateCategoryRequest.copyWith.fieldName(...)`
class _$CreateCategoryRequestCWProxyImpl
    implements _$CreateCategoryRequestCWProxy {
  const _$CreateCategoryRequestCWProxyImpl(this._value);

  final CreateCategoryRequest _value;

  @override
  CreateCategoryRequest imageUrl(String? imageUrl) => this(imageUrl: imageUrl);

  @override
  CreateCategoryRequest name(String name) => this(name: name);

  @override
  CreateCategoryRequest nameTranslations(Object? nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  CreateCategoryRequest orgId(String orgId) => this(orgId: orgId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateCategoryRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateCategoryRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateCategoryRequest call({
    Object? imageUrl = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
    Object? orgId = const $CopyWithPlaceholder(),
  }) {
    return CreateCategoryRequest(
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
          : nameTranslations as Object?,
      orgId: orgId == const $CopyWithPlaceholder()
          ? _value.orgId
          // ignore: cast_nullable_to_non_nullable
          : orgId as String,
    );
  }
}

extension $CreateCategoryRequestCopyWith on CreateCategoryRequest {
  /// Returns a callable class that can be used as follows: `instanceOfCreateCategoryRequest.copyWith(...)` or like so:`instanceOfCreateCategoryRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateCategoryRequestCWProxy get copyWith =>
      _$CreateCategoryRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCategoryRequest _$CreateCategoryRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'CreateCategoryRequest',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['name', 'org_id']);
    final val = CreateCategoryRequest(
      imageUrl: $checkedConvert('image_url', (v) => v as String?),
      name: $checkedConvert('name', (v) => v as String),
      nameTranslations: $checkedConvert('name_translations', (v) => v),
      orgId: $checkedConvert('org_id', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'imageUrl': 'image_url',
    'nameTranslations': 'name_translations',
    'orgId': 'org_id',
  },
);

Map<String, dynamic> _$CreateCategoryRequestToJson(
  CreateCategoryRequest instance,
) => <String, dynamic>{
  'image_url': ?instance.imageUrl,
  'name': instance.name,
  'name_translations': ?instance.nameTranslations,
  'org_id': instance.orgId,
};
