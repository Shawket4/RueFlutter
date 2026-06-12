// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_category_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateCategoryRequestCWProxy {
  UpdateCategoryRequest displayOrder(int? displayOrder);

  UpdateCategoryRequest imageUrl(String? imageUrl);

  UpdateCategoryRequest isActive(bool? isActive);

  UpdateCategoryRequest name(String? name);

  UpdateCategoryRequest nameTranslations(Object? nameTranslations);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateCategoryRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateCategoryRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateCategoryRequest call({
    int? displayOrder,
    String? imageUrl,
    bool? isActive,
    String? name,
    Object? nameTranslations,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateCategoryRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateCategoryRequest.copyWith.fieldName(...)`
class _$UpdateCategoryRequestCWProxyImpl
    implements _$UpdateCategoryRequestCWProxy {
  const _$UpdateCategoryRequestCWProxyImpl(this._value);

  final UpdateCategoryRequest _value;

  @override
  UpdateCategoryRequest displayOrder(int? displayOrder) =>
      this(displayOrder: displayOrder);

  @override
  UpdateCategoryRequest imageUrl(String? imageUrl) => this(imageUrl: imageUrl);

  @override
  UpdateCategoryRequest isActive(bool? isActive) => this(isActive: isActive);

  @override
  UpdateCategoryRequest name(String? name) => this(name: name);

  @override
  UpdateCategoryRequest nameTranslations(Object? nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateCategoryRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateCategoryRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateCategoryRequest call({
    Object? displayOrder = const $CopyWithPlaceholder(),
    Object? imageUrl = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
  }) {
    return UpdateCategoryRequest(
      displayOrder: displayOrder == const $CopyWithPlaceholder()
          ? _value.displayOrder
          // ignore: cast_nullable_to_non_nullable
          : displayOrder as int?,
      imageUrl: imageUrl == const $CopyWithPlaceholder()
          ? _value.imageUrl
          // ignore: cast_nullable_to_non_nullable
          : imageUrl as String?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      nameTranslations: nameTranslations == const $CopyWithPlaceholder()
          ? _value.nameTranslations
          // ignore: cast_nullable_to_non_nullable
          : nameTranslations as Object?,
    );
  }
}

extension $UpdateCategoryRequestCopyWith on UpdateCategoryRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateCategoryRequest.copyWith(...)` or like so:`instanceOfUpdateCategoryRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateCategoryRequestCWProxy get copyWith =>
      _$UpdateCategoryRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCategoryRequest _$UpdateCategoryRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'UpdateCategoryRequest',
  json,
  ($checkedConvert) {
    final val = UpdateCategoryRequest(
      displayOrder: $checkedConvert(
        'display_order',
        (v) => (v as num?)?.toInt(),
      ),
      imageUrl: $checkedConvert('image_url', (v) => v as String?),
      isActive: $checkedConvert('is_active', (v) => v as bool?),
      name: $checkedConvert('name', (v) => v as String?),
      nameTranslations: $checkedConvert('name_translations', (v) => v),
    );
    return val;
  },
  fieldKeyMap: const {
    'displayOrder': 'display_order',
    'imageUrl': 'image_url',
    'isActive': 'is_active',
    'nameTranslations': 'name_translations',
  },
);

Map<String, dynamic> _$UpdateCategoryRequestToJson(
  UpdateCategoryRequest instance,
) => <String, dynamic>{
  'display_order': ?instance.displayOrder,
  'image_url': ?instance.imageUrl,
  'is_active': ?instance.isActive,
  'name': ?instance.name,
  'name_translations': ?instance.nameTranslations,
};
