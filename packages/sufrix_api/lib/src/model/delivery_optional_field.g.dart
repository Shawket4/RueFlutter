// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_optional_field.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DeliveryOptionalFieldCWProxy {
  DeliveryOptionalField id(String id);

  DeliveryOptionalField name(String name);

  DeliveryOptionalField nameTranslations(Object nameTranslations);

  DeliveryOptionalField price(int price);

  DeliveryOptionalField sizeLabel(String? sizeLabel);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeliveryOptionalField(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeliveryOptionalField(...).copyWith(id: 12, name: "My name")
  /// ````
  DeliveryOptionalField call({
    String id,
    String name,
    Object nameTranslations,
    int price,
    String? sizeLabel,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDeliveryOptionalField.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDeliveryOptionalField.copyWith.fieldName(...)`
class _$DeliveryOptionalFieldCWProxyImpl
    implements _$DeliveryOptionalFieldCWProxy {
  const _$DeliveryOptionalFieldCWProxyImpl(this._value);

  final DeliveryOptionalField _value;

  @override
  DeliveryOptionalField id(String id) => this(id: id);

  @override
  DeliveryOptionalField name(String name) => this(name: name);

  @override
  DeliveryOptionalField nameTranslations(Object nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  DeliveryOptionalField price(int price) => this(price: price);

  @override
  DeliveryOptionalField sizeLabel(String? sizeLabel) =>
      this(sizeLabel: sizeLabel);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeliveryOptionalField(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeliveryOptionalField(...).copyWith(id: 12, name: "My name")
  /// ````
  DeliveryOptionalField call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
    Object? sizeLabel = const $CopyWithPlaceholder(),
  }) {
    return DeliveryOptionalField(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
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
      sizeLabel: sizeLabel == const $CopyWithPlaceholder()
          ? _value.sizeLabel
          // ignore: cast_nullable_to_non_nullable
          : sizeLabel as String?,
    );
  }
}

extension $DeliveryOptionalFieldCopyWith on DeliveryOptionalField {
  /// Returns a callable class that can be used as follows: `instanceOfDeliveryOptionalField.copyWith(...)` or like so:`instanceOfDeliveryOptionalField.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DeliveryOptionalFieldCWProxy get copyWith =>
      _$DeliveryOptionalFieldCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryOptionalField _$DeliveryOptionalFieldFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'DeliveryOptionalField',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['id', 'name', 'name_translations', 'price'],
    );
    final val = DeliveryOptionalField(
      id: $checkedConvert('id', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      nameTranslations: $checkedConvert(
        'name_translations',
        (v) => v as Object,
      ),
      price: $checkedConvert('price', (v) => (v as num).toInt()),
      sizeLabel: $checkedConvert('size_label', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'nameTranslations': 'name_translations',
    'sizeLabel': 'size_label',
  },
);

Map<String, dynamic> _$DeliveryOptionalFieldToJson(
  DeliveryOptionalField instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'name_translations': instance.nameTranslations,
  'price': instance.price,
  'size_label': ?instance.sizeLabel,
};
