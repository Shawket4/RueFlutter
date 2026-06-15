// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_menu_discount.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DeliveryMenuDiscountCWProxy {
  DeliveryMenuDiscount dtype(String dtype);

  DeliveryMenuDiscount id(String id);

  DeliveryMenuDiscount name(String name);

  DeliveryMenuDiscount nameTranslations(Object nameTranslations);

  DeliveryMenuDiscount value(int value);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeliveryMenuDiscount(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeliveryMenuDiscount(...).copyWith(id: 12, name: "My name")
  /// ````
  DeliveryMenuDiscount call({
    String dtype,
    String id,
    String name,
    Object nameTranslations,
    int value,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDeliveryMenuDiscount.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDeliveryMenuDiscount.copyWith.fieldName(...)`
class _$DeliveryMenuDiscountCWProxyImpl
    implements _$DeliveryMenuDiscountCWProxy {
  const _$DeliveryMenuDiscountCWProxyImpl(this._value);

  final DeliveryMenuDiscount _value;

  @override
  DeliveryMenuDiscount dtype(String dtype) => this(dtype: dtype);

  @override
  DeliveryMenuDiscount id(String id) => this(id: id);

  @override
  DeliveryMenuDiscount name(String name) => this(name: name);

  @override
  DeliveryMenuDiscount nameTranslations(Object nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  DeliveryMenuDiscount value(int value) => this(value: value);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeliveryMenuDiscount(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeliveryMenuDiscount(...).copyWith(id: 12, name: "My name")
  /// ````
  DeliveryMenuDiscount call({
    Object? dtype = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
  }) {
    return DeliveryMenuDiscount(
      dtype: dtype == const $CopyWithPlaceholder()
          ? _value.dtype
          // ignore: cast_nullable_to_non_nullable
          : dtype as String,
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
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as int,
    );
  }
}

extension $DeliveryMenuDiscountCopyWith on DeliveryMenuDiscount {
  /// Returns a callable class that can be used as follows: `instanceOfDeliveryMenuDiscount.copyWith(...)` or like so:`instanceOfDeliveryMenuDiscount.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DeliveryMenuDiscountCWProxy get copyWith =>
      _$DeliveryMenuDiscountCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryMenuDiscount _$DeliveryMenuDiscountFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'DeliveryMenuDiscount',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['dtype', 'id', 'name', 'name_translations', 'value'],
    );
    final val = DeliveryMenuDiscount(
      dtype: $checkedConvert('dtype', (v) => v as String),
      id: $checkedConvert('id', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      nameTranslations: $checkedConvert(
        'name_translations',
        (v) => v as Object,
      ),
      value: $checkedConvert('value', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {'nameTranslations': 'name_translations'},
);

Map<String, dynamic> _$DeliveryMenuDiscountToJson(
  DeliveryMenuDiscount instance,
) => <String, dynamic>{
  'dtype': instance.dtype,
  'id': instance.id,
  'name': instance.name,
  'name_translations': instance.nameTranslations,
  'value': instance.value,
};
