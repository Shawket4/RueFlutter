// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_addon_option.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DeliveryAddonOptionCWProxy {
  DeliveryAddonOption addonItemId(String addonItemId);

  DeliveryAddonOption isAvailable(bool isAvailable);

  DeliveryAddonOption name(String name);

  DeliveryAddonOption nameTranslations(Object nameTranslations);

  DeliveryAddonOption price(int price);

  DeliveryAddonOption type(String type);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeliveryAddonOption(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeliveryAddonOption(...).copyWith(id: 12, name: "My name")
  /// ````
  DeliveryAddonOption call({
    String addonItemId,
    bool isAvailable,
    String name,
    Object nameTranslations,
    int price,
    String type,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDeliveryAddonOption.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDeliveryAddonOption.copyWith.fieldName(...)`
class _$DeliveryAddonOptionCWProxyImpl implements _$DeliveryAddonOptionCWProxy {
  const _$DeliveryAddonOptionCWProxyImpl(this._value);

  final DeliveryAddonOption _value;

  @override
  DeliveryAddonOption addonItemId(String addonItemId) =>
      this(addonItemId: addonItemId);

  @override
  DeliveryAddonOption isAvailable(bool isAvailable) =>
      this(isAvailable: isAvailable);

  @override
  DeliveryAddonOption name(String name) => this(name: name);

  @override
  DeliveryAddonOption nameTranslations(Object nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  DeliveryAddonOption price(int price) => this(price: price);

  @override
  DeliveryAddonOption type(String type) => this(type: type);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeliveryAddonOption(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeliveryAddonOption(...).copyWith(id: 12, name: "My name")
  /// ````
  DeliveryAddonOption call({
    Object? addonItemId = const $CopyWithPlaceholder(),
    Object? isAvailable = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
  }) {
    return DeliveryAddonOption(
      addonItemId: addonItemId == const $CopyWithPlaceholder()
          ? _value.addonItemId
          // ignore: cast_nullable_to_non_nullable
          : addonItemId as String,
      isAvailable: isAvailable == const $CopyWithPlaceholder()
          ? _value.isAvailable
          // ignore: cast_nullable_to_non_nullable
          : isAvailable as bool,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      nameTranslations: nameTranslations == const $CopyWithPlaceholder()
          ? _value.nameTranslations
          // ignore: cast_nullable_to_non_nullable
          : nameTranslations as Object,
      price: price == const $CopyWithPlaceholder()
          ? _value.price
          // ignore: cast_nullable_to_non_nullable
          : price as int,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as String,
    );
  }
}

extension $DeliveryAddonOptionCopyWith on DeliveryAddonOption {
  /// Returns a callable class that can be used as follows: `instanceOfDeliveryAddonOption.copyWith(...)` or like so:`instanceOfDeliveryAddonOption.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DeliveryAddonOptionCWProxy get copyWith =>
      _$DeliveryAddonOptionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryAddonOption _$DeliveryAddonOptionFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'DeliveryAddonOption',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'addon_item_id',
            'is_available',
            'name',
            'name_translations',
            'price',
            'type',
          ],
        );
        final val = DeliveryAddonOption(
          addonItemId: $checkedConvert('addon_item_id', (v) => v as String),
          isAvailable: $checkedConvert('is_available', (v) => v as bool),
          name: $checkedConvert('name', (v) => v as String),
          nameTranslations: $checkedConvert(
            'name_translations',
            (v) => v as Object,
          ),
          price: $checkedConvert('price', (v) => (v as num).toInt()),
          type: $checkedConvert('type', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'addonItemId': 'addon_item_id',
        'isAvailable': 'is_available',
        'nameTranslations': 'name_translations',
      },
    );

Map<String, dynamic> _$DeliveryAddonOptionToJson(
  DeliveryAddonOption instance,
) => <String, dynamic>{
  'addon_item_id': instance.addonItemId,
  'is_available': instance.isAvailable,
  'name': instance.name,
  'name_translations': instance.nameTranslations,
  'price': instance.price,
  'type': instance.type,
};
