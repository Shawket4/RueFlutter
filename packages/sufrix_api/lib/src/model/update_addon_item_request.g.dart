// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_addon_item_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateAddonItemRequestCWProxy {
  UpdateAddonItemRequest addonType(String? addonType);

  UpdateAddonItemRequest defaultPrice(int? defaultPrice);

  UpdateAddonItemRequest displayOrder(int? displayOrder);

  UpdateAddonItemRequest isActive(bool? isActive);

  UpdateAddonItemRequest name(String? name);

  UpdateAddonItemRequest nameTranslations(Object? nameTranslations);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateAddonItemRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateAddonItemRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateAddonItemRequest call({
    String? addonType,
    int? defaultPrice,
    int? displayOrder,
    bool? isActive,
    String? name,
    Object? nameTranslations,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateAddonItemRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateAddonItemRequest.copyWith.fieldName(...)`
class _$UpdateAddonItemRequestCWProxyImpl
    implements _$UpdateAddonItemRequestCWProxy {
  const _$UpdateAddonItemRequestCWProxyImpl(this._value);

  final UpdateAddonItemRequest _value;

  @override
  UpdateAddonItemRequest addonType(String? addonType) =>
      this(addonType: addonType);

  @override
  UpdateAddonItemRequest defaultPrice(int? defaultPrice) =>
      this(defaultPrice: defaultPrice);

  @override
  UpdateAddonItemRequest displayOrder(int? displayOrder) =>
      this(displayOrder: displayOrder);

  @override
  UpdateAddonItemRequest isActive(bool? isActive) => this(isActive: isActive);

  @override
  UpdateAddonItemRequest name(String? name) => this(name: name);

  @override
  UpdateAddonItemRequest nameTranslations(Object? nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateAddonItemRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateAddonItemRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateAddonItemRequest call({
    Object? addonType = const $CopyWithPlaceholder(),
    Object? defaultPrice = const $CopyWithPlaceholder(),
    Object? displayOrder = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
  }) {
    return UpdateAddonItemRequest(
      addonType: addonType == const $CopyWithPlaceholder()
          ? _value.addonType
          // ignore: cast_nullable_to_non_nullable
          : addonType as String?,
      defaultPrice: defaultPrice == const $CopyWithPlaceholder()
          ? _value.defaultPrice
          // ignore: cast_nullable_to_non_nullable
          : defaultPrice as int?,
      displayOrder: displayOrder == const $CopyWithPlaceholder()
          ? _value.displayOrder
          // ignore: cast_nullable_to_non_nullable
          : displayOrder as int?,
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

extension $UpdateAddonItemRequestCopyWith on UpdateAddonItemRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateAddonItemRequest.copyWith(...)` or like so:`instanceOfUpdateAddonItemRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateAddonItemRequestCWProxy get copyWith =>
      _$UpdateAddonItemRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAddonItemRequest _$UpdateAddonItemRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'UpdateAddonItemRequest',
  json,
  ($checkedConvert) {
    final val = UpdateAddonItemRequest(
      addonType: $checkedConvert('addon_type', (v) => v as String?),
      defaultPrice: $checkedConvert(
        'default_price',
        (v) => (v as num?)?.toInt(),
      ),
      displayOrder: $checkedConvert(
        'display_order',
        (v) => (v as num?)?.toInt(),
      ),
      isActive: $checkedConvert('is_active', (v) => v as bool?),
      name: $checkedConvert('name', (v) => v as String?),
      nameTranslations: $checkedConvert('name_translations', (v) => v),
    );
    return val;
  },
  fieldKeyMap: const {
    'addonType': 'addon_type',
    'defaultPrice': 'default_price',
    'displayOrder': 'display_order',
    'isActive': 'is_active',
    'nameTranslations': 'name_translations',
  },
);

Map<String, dynamic> _$UpdateAddonItemRequestToJson(
  UpdateAddonItemRequest instance,
) => <String, dynamic>{
  'addon_type': ?instance.addonType,
  'default_price': ?instance.defaultPrice,
  'display_order': ?instance.displayOrder,
  'is_active': ?instance.isActive,
  'name': ?instance.name,
  'name_translations': ?instance.nameTranslations,
};
