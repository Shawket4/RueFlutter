// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_addon_item_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateAddonItemRequestCWProxy {
  CreateAddonItemRequest addonType(String addonType);

  CreateAddonItemRequest defaultPrice(int defaultPrice);

  CreateAddonItemRequest name(String name);

  CreateAddonItemRequest nameTranslations(Object? nameTranslations);

  CreateAddonItemRequest orgId(String orgId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateAddonItemRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateAddonItemRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateAddonItemRequest call({
    String addonType,
    int defaultPrice,
    String name,
    Object? nameTranslations,
    String orgId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCreateAddonItemRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCreateAddonItemRequest.copyWith.fieldName(...)`
class _$CreateAddonItemRequestCWProxyImpl
    implements _$CreateAddonItemRequestCWProxy {
  const _$CreateAddonItemRequestCWProxyImpl(this._value);

  final CreateAddonItemRequest _value;

  @override
  CreateAddonItemRequest addonType(String addonType) =>
      this(addonType: addonType);

  @override
  CreateAddonItemRequest defaultPrice(int defaultPrice) =>
      this(defaultPrice: defaultPrice);

  @override
  CreateAddonItemRequest name(String name) => this(name: name);

  @override
  CreateAddonItemRequest nameTranslations(Object? nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  CreateAddonItemRequest orgId(String orgId) => this(orgId: orgId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateAddonItemRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateAddonItemRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateAddonItemRequest call({
    Object? addonType = const $CopyWithPlaceholder(),
    Object? defaultPrice = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
    Object? orgId = const $CopyWithPlaceholder(),
  }) {
    return CreateAddonItemRequest(
      addonType: addonType == const $CopyWithPlaceholder()
          ? _value.addonType
          // ignore: cast_nullable_to_non_nullable
          : addonType as String,
      defaultPrice: defaultPrice == const $CopyWithPlaceholder()
          ? _value.defaultPrice
          // ignore: cast_nullable_to_non_nullable
          : defaultPrice as int,
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

extension $CreateAddonItemRequestCopyWith on CreateAddonItemRequest {
  /// Returns a callable class that can be used as follows: `instanceOfCreateAddonItemRequest.copyWith(...)` or like so:`instanceOfCreateAddonItemRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateAddonItemRequestCWProxy get copyWith =>
      _$CreateAddonItemRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAddonItemRequest _$CreateAddonItemRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'CreateAddonItemRequest',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['addon_type', 'default_price', 'name', 'org_id'],
    );
    final val = CreateAddonItemRequest(
      addonType: $checkedConvert('addon_type', (v) => v as String),
      defaultPrice: $checkedConvert('default_price', (v) => (v as num).toInt()),
      name: $checkedConvert('name', (v) => v as String),
      nameTranslations: $checkedConvert('name_translations', (v) => v),
      orgId: $checkedConvert('org_id', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'addonType': 'addon_type',
    'defaultPrice': 'default_price',
    'nameTranslations': 'name_translations',
    'orgId': 'org_id',
  },
);

Map<String, dynamic> _$CreateAddonItemRequestToJson(
  CreateAddonItemRequest instance,
) => <String, dynamic>{
  'addon_type': instance.addonType,
  'default_price': instance.defaultPrice,
  'name': instance.name,
  'name_translations': ?instance.nameTranslations,
  'org_id': instance.orgId,
};
