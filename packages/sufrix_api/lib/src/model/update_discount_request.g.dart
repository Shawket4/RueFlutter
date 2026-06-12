// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_discount_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateDiscountRequestCWProxy {
  UpdateDiscountRequest dtype(String? dtype);

  UpdateDiscountRequest isActive(bool? isActive);

  UpdateDiscountRequest name(String? name);

  UpdateDiscountRequest nameTranslations(Object? nameTranslations);

  UpdateDiscountRequest value(int? value);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateDiscountRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateDiscountRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateDiscountRequest call({
    String? dtype,
    bool? isActive,
    String? name,
    Object? nameTranslations,
    int? value,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateDiscountRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateDiscountRequest.copyWith.fieldName(...)`
class _$UpdateDiscountRequestCWProxyImpl
    implements _$UpdateDiscountRequestCWProxy {
  const _$UpdateDiscountRequestCWProxyImpl(this._value);

  final UpdateDiscountRequest _value;

  @override
  UpdateDiscountRequest dtype(String? dtype) => this(dtype: dtype);

  @override
  UpdateDiscountRequest isActive(bool? isActive) => this(isActive: isActive);

  @override
  UpdateDiscountRequest name(String? name) => this(name: name);

  @override
  UpdateDiscountRequest nameTranslations(Object? nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  UpdateDiscountRequest value(int? value) => this(value: value);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateDiscountRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateDiscountRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateDiscountRequest call({
    Object? dtype = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
  }) {
    return UpdateDiscountRequest(
      dtype: dtype == const $CopyWithPlaceholder()
          ? _value.dtype
          // ignore: cast_nullable_to_non_nullable
          : dtype as String?,
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
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as int?,
    );
  }
}

extension $UpdateDiscountRequestCopyWith on UpdateDiscountRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateDiscountRequest.copyWith(...)` or like so:`instanceOfUpdateDiscountRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateDiscountRequestCWProxy get copyWith =>
      _$UpdateDiscountRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateDiscountRequest _$UpdateDiscountRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'UpdateDiscountRequest',
  json,
  ($checkedConvert) {
    final val = UpdateDiscountRequest(
      dtype: $checkedConvert('dtype', (v) => v as String?),
      isActive: $checkedConvert('is_active', (v) => v as bool?),
      name: $checkedConvert('name', (v) => v as String?),
      nameTranslations: $checkedConvert('name_translations', (v) => v),
      value: $checkedConvert('value', (v) => (v as num?)?.toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'isActive': 'is_active',
    'nameTranslations': 'name_translations',
  },
);

Map<String, dynamic> _$UpdateDiscountRequestToJson(
  UpdateDiscountRequest instance,
) => <String, dynamic>{
  'dtype': ?instance.dtype,
  'is_active': ?instance.isActive,
  'name': ?instance.name,
  'name_translations': ?instance.nameTranslations,
  'value': ?instance.value,
};
