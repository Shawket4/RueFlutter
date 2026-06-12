// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_discount_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateDiscountRequestCWProxy {
  CreateDiscountRequest dtype(String dtype);

  CreateDiscountRequest isActive(bool? isActive);

  CreateDiscountRequest name(String name);

  CreateDiscountRequest nameTranslations(Object? nameTranslations);

  CreateDiscountRequest orgId(String orgId);

  CreateDiscountRequest value(int value);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateDiscountRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateDiscountRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateDiscountRequest call({
    String dtype,
    bool? isActive,
    String name,
    Object? nameTranslations,
    String orgId,
    int value,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCreateDiscountRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCreateDiscountRequest.copyWith.fieldName(...)`
class _$CreateDiscountRequestCWProxyImpl
    implements _$CreateDiscountRequestCWProxy {
  const _$CreateDiscountRequestCWProxyImpl(this._value);

  final CreateDiscountRequest _value;

  @override
  CreateDiscountRequest dtype(String dtype) => this(dtype: dtype);

  @override
  CreateDiscountRequest isActive(bool? isActive) => this(isActive: isActive);

  @override
  CreateDiscountRequest name(String name) => this(name: name);

  @override
  CreateDiscountRequest nameTranslations(Object? nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  CreateDiscountRequest orgId(String orgId) => this(orgId: orgId);

  @override
  CreateDiscountRequest value(int value) => this(value: value);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateDiscountRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateDiscountRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateDiscountRequest call({
    Object? dtype = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
    Object? orgId = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
  }) {
    return CreateDiscountRequest(
      dtype: dtype == const $CopyWithPlaceholder()
          ? _value.dtype
          // ignore: cast_nullable_to_non_nullable
          : dtype as String,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
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
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as int,
    );
  }
}

extension $CreateDiscountRequestCopyWith on CreateDiscountRequest {
  /// Returns a callable class that can be used as follows: `instanceOfCreateDiscountRequest.copyWith(...)` or like so:`instanceOfCreateDiscountRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateDiscountRequestCWProxy get copyWith =>
      _$CreateDiscountRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateDiscountRequest _$CreateDiscountRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'CreateDiscountRequest',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['dtype', 'name', 'org_id', 'value']);
    final val = CreateDiscountRequest(
      dtype: $checkedConvert('dtype', (v) => v as String),
      isActive: $checkedConvert('is_active', (v) => v as bool?),
      name: $checkedConvert('name', (v) => v as String),
      nameTranslations: $checkedConvert('name_translations', (v) => v),
      orgId: $checkedConvert('org_id', (v) => v as String),
      value: $checkedConvert('value', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'isActive': 'is_active',
    'nameTranslations': 'name_translations',
    'orgId': 'org_id',
  },
);

Map<String, dynamic> _$CreateDiscountRequestToJson(
  CreateDiscountRequest instance,
) => <String, dynamic>{
  'dtype': instance.dtype,
  'is_active': ?instance.isActive,
  'name': instance.name,
  'name_translations': ?instance.nameTranslations,
  'org_id': instance.orgId,
  'value': instance.value,
};
