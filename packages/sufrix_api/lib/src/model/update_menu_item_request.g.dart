// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_menu_item_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateMenuItemRequestCWProxy {
  UpdateMenuItemRequest basePrice(int? basePrice);

  UpdateMenuItemRequest categoryId(String? categoryId);

  UpdateMenuItemRequest description(String? description);

  UpdateMenuItemRequest descriptionTranslations(
    Object? descriptionTranslations,
  );

  UpdateMenuItemRequest displayOrder(int? displayOrder);

  UpdateMenuItemRequest imageUrl(String? imageUrl);

  UpdateMenuItemRequest isActive(bool? isActive);

  UpdateMenuItemRequest name(String? name);

  UpdateMenuItemRequest nameTranslations(Object? nameTranslations);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateMenuItemRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateMenuItemRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateMenuItemRequest call({
    int? basePrice,
    String? categoryId,
    String? description,
    Object? descriptionTranslations,
    int? displayOrder,
    String? imageUrl,
    bool? isActive,
    String? name,
    Object? nameTranslations,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateMenuItemRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateMenuItemRequest.copyWith.fieldName(...)`
class _$UpdateMenuItemRequestCWProxyImpl
    implements _$UpdateMenuItemRequestCWProxy {
  const _$UpdateMenuItemRequestCWProxyImpl(this._value);

  final UpdateMenuItemRequest _value;

  @override
  UpdateMenuItemRequest basePrice(int? basePrice) => this(basePrice: basePrice);

  @override
  UpdateMenuItemRequest categoryId(String? categoryId) =>
      this(categoryId: categoryId);

  @override
  UpdateMenuItemRequest description(String? description) =>
      this(description: description);

  @override
  UpdateMenuItemRequest descriptionTranslations(
    Object? descriptionTranslations,
  ) => this(descriptionTranslations: descriptionTranslations);

  @override
  UpdateMenuItemRequest displayOrder(int? displayOrder) =>
      this(displayOrder: displayOrder);

  @override
  UpdateMenuItemRequest imageUrl(String? imageUrl) => this(imageUrl: imageUrl);

  @override
  UpdateMenuItemRequest isActive(bool? isActive) => this(isActive: isActive);

  @override
  UpdateMenuItemRequest name(String? name) => this(name: name);

  @override
  UpdateMenuItemRequest nameTranslations(Object? nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateMenuItemRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateMenuItemRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateMenuItemRequest call({
    Object? basePrice = const $CopyWithPlaceholder(),
    Object? categoryId = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? descriptionTranslations = const $CopyWithPlaceholder(),
    Object? displayOrder = const $CopyWithPlaceholder(),
    Object? imageUrl = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
  }) {
    return UpdateMenuItemRequest(
      basePrice: basePrice == const $CopyWithPlaceholder()
          ? _value.basePrice
          // ignore: cast_nullable_to_non_nullable
          : basePrice as int?,
      categoryId: categoryId == const $CopyWithPlaceholder()
          ? _value.categoryId
          // ignore: cast_nullable_to_non_nullable
          : categoryId as String?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      descriptionTranslations:
          descriptionTranslations == const $CopyWithPlaceholder()
          ? _value.descriptionTranslations
          // ignore: cast_nullable_to_non_nullable
          : descriptionTranslations as Object?,
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

extension $UpdateMenuItemRequestCopyWith on UpdateMenuItemRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateMenuItemRequest.copyWith(...)` or like so:`instanceOfUpdateMenuItemRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateMenuItemRequestCWProxy get copyWith =>
      _$UpdateMenuItemRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateMenuItemRequest _$UpdateMenuItemRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'UpdateMenuItemRequest',
  json,
  ($checkedConvert) {
    final val = UpdateMenuItemRequest(
      basePrice: $checkedConvert('base_price', (v) => (v as num?)?.toInt()),
      categoryId: $checkedConvert('category_id', (v) => v as String?),
      description: $checkedConvert('description', (v) => v as String?),
      descriptionTranslations: $checkedConvert(
        'description_translations',
        (v) => v,
      ),
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
    'basePrice': 'base_price',
    'categoryId': 'category_id',
    'descriptionTranslations': 'description_translations',
    'displayOrder': 'display_order',
    'imageUrl': 'image_url',
    'isActive': 'is_active',
    'nameTranslations': 'name_translations',
  },
);

Map<String, dynamic> _$UpdateMenuItemRequestToJson(
  UpdateMenuItemRequest instance,
) => <String, dynamic>{
  'base_price': ?instance.basePrice,
  'category_id': ?instance.categoryId,
  'description': ?instance.description,
  'description_translations': ?instance.descriptionTranslations,
  'display_order': ?instance.displayOrder,
  'image_url': ?instance.imageUrl,
  'is_active': ?instance.isActive,
  'name': ?instance.name,
  'name_translations': ?instance.nameTranslations,
};
