// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_menu_item_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateMenuItemRequestCWProxy {
  CreateMenuItemRequest basePrice(int basePrice);

  CreateMenuItemRequest categoryId(String categoryId);

  CreateMenuItemRequest description(String? description);

  CreateMenuItemRequest descriptionTranslations(
    Object? descriptionTranslations,
  );

  CreateMenuItemRequest displayOrder(int? displayOrder);

  CreateMenuItemRequest imageUrl(String? imageUrl);

  CreateMenuItemRequest name(String name);

  CreateMenuItemRequest nameTranslations(Object? nameTranslations);

  CreateMenuItemRequest orgId(String orgId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateMenuItemRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateMenuItemRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateMenuItemRequest call({
    int basePrice,
    String categoryId,
    String? description,
    Object? descriptionTranslations,
    int? displayOrder,
    String? imageUrl,
    String name,
    Object? nameTranslations,
    String orgId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCreateMenuItemRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCreateMenuItemRequest.copyWith.fieldName(...)`
class _$CreateMenuItemRequestCWProxyImpl
    implements _$CreateMenuItemRequestCWProxy {
  const _$CreateMenuItemRequestCWProxyImpl(this._value);

  final CreateMenuItemRequest _value;

  @override
  CreateMenuItemRequest basePrice(int basePrice) => this(basePrice: basePrice);

  @override
  CreateMenuItemRequest categoryId(String categoryId) =>
      this(categoryId: categoryId);

  @override
  CreateMenuItemRequest description(String? description) =>
      this(description: description);

  @override
  CreateMenuItemRequest descriptionTranslations(
    Object? descriptionTranslations,
  ) => this(descriptionTranslations: descriptionTranslations);

  @override
  CreateMenuItemRequest displayOrder(int? displayOrder) =>
      this(displayOrder: displayOrder);

  @override
  CreateMenuItemRequest imageUrl(String? imageUrl) => this(imageUrl: imageUrl);

  @override
  CreateMenuItemRequest name(String name) => this(name: name);

  @override
  CreateMenuItemRequest nameTranslations(Object? nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  CreateMenuItemRequest orgId(String orgId) => this(orgId: orgId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateMenuItemRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateMenuItemRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateMenuItemRequest call({
    Object? basePrice = const $CopyWithPlaceholder(),
    Object? categoryId = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? descriptionTranslations = const $CopyWithPlaceholder(),
    Object? displayOrder = const $CopyWithPlaceholder(),
    Object? imageUrl = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
    Object? orgId = const $CopyWithPlaceholder(),
  }) {
    return CreateMenuItemRequest(
      basePrice: basePrice == const $CopyWithPlaceholder()
          ? _value.basePrice
          // ignore: cast_nullable_to_non_nullable
          : basePrice as int,
      categoryId: categoryId == const $CopyWithPlaceholder()
          ? _value.categoryId
          // ignore: cast_nullable_to_non_nullable
          : categoryId as String,
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

extension $CreateMenuItemRequestCopyWith on CreateMenuItemRequest {
  /// Returns a callable class that can be used as follows: `instanceOfCreateMenuItemRequest.copyWith(...)` or like so:`instanceOfCreateMenuItemRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateMenuItemRequestCWProxy get copyWith =>
      _$CreateMenuItemRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateMenuItemRequest _$CreateMenuItemRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'CreateMenuItemRequest',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['base_price', 'category_id', 'name', 'org_id'],
    );
    final val = CreateMenuItemRequest(
      basePrice: $checkedConvert('base_price', (v) => (v as num).toInt()),
      categoryId: $checkedConvert('category_id', (v) => v as String),
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
      name: $checkedConvert('name', (v) => v as String),
      nameTranslations: $checkedConvert('name_translations', (v) => v),
      orgId: $checkedConvert('org_id', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'basePrice': 'base_price',
    'categoryId': 'category_id',
    'descriptionTranslations': 'description_translations',
    'displayOrder': 'display_order',
    'imageUrl': 'image_url',
    'nameTranslations': 'name_translations',
    'orgId': 'org_id',
  },
);

Map<String, dynamic> _$CreateMenuItemRequestToJson(
  CreateMenuItemRequest instance,
) => <String, dynamic>{
  'base_price': instance.basePrice,
  'category_id': instance.categoryId,
  'description': ?instance.description,
  'description_translations': ?instance.descriptionTranslations,
  'display_order': ?instance.displayOrder,
  'image_url': ?instance.imageUrl,
  'name': instance.name,
  'name_translations': ?instance.nameTranslations,
  'org_id': instance.orgId,
};
