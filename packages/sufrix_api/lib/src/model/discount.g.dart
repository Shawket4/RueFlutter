// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DiscountCWProxy {
  Discount createdAt(DateTime createdAt);

  Discount dtype(String dtype);

  Discount id(String id);

  Discount isActive(bool isActive);

  Discount name(String name);

  Discount nameTranslations(Object nameTranslations);

  Discount orgId(String orgId);

  Discount updatedAt(DateTime updatedAt);

  Discount value(int value);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Discount(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Discount(...).copyWith(id: 12, name: "My name")
  /// ````
  Discount call({
    DateTime createdAt,
    String dtype,
    String id,
    bool isActive,
    String name,
    Object nameTranslations,
    String orgId,
    DateTime updatedAt,
    int value,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDiscount.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDiscount.copyWith.fieldName(...)`
class _$DiscountCWProxyImpl implements _$DiscountCWProxy {
  const _$DiscountCWProxyImpl(this._value);

  final Discount _value;

  @override
  Discount createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  Discount dtype(String dtype) => this(dtype: dtype);

  @override
  Discount id(String id) => this(id: id);

  @override
  Discount isActive(bool isActive) => this(isActive: isActive);

  @override
  Discount name(String name) => this(name: name);

  @override
  Discount nameTranslations(Object nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  Discount orgId(String orgId) => this(orgId: orgId);

  @override
  Discount updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override
  Discount value(int value) => this(value: value);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Discount(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Discount(...).copyWith(id: 12, name: "My name")
  /// ````
  Discount call({
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? dtype = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
    Object? orgId = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
  }) {
    return Discount(
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      dtype: dtype == const $CopyWithPlaceholder()
          ? _value.dtype
          // ignore: cast_nullable_to_non_nullable
          : dtype as String,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      nameTranslations: nameTranslations == const $CopyWithPlaceholder()
          ? _value.nameTranslations
          // ignore: cast_nullable_to_non_nullable
          : nameTranslations as Object,
      orgId: orgId == const $CopyWithPlaceholder()
          ? _value.orgId
          // ignore: cast_nullable_to_non_nullable
          : orgId as String,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as int,
    );
  }
}

extension $DiscountCopyWith on Discount {
  /// Returns a callable class that can be used as follows: `instanceOfDiscount.copyWith(...)` or like so:`instanceOfDiscount.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DiscountCWProxy get copyWith => _$DiscountCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Discount _$DiscountFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Discount',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'created_at',
        'dtype',
        'id',
        'is_active',
        'name',
        'name_translations',
        'org_id',
        'updated_at',
        'value',
      ],
    );
    final val = Discount(
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      dtype: $checkedConvert('dtype', (v) => v as String),
      id: $checkedConvert('id', (v) => v as String),
      isActive: $checkedConvert('is_active', (v) => v as bool),
      name: $checkedConvert('name', (v) => v as String),
      nameTranslations: $checkedConvert(
        'name_translations',
        (v) => v as Object,
      ),
      orgId: $checkedConvert('org_id', (v) => v as String),
      updatedAt: $checkedConvert(
        'updated_at',
        (v) => DateTime.parse(v as String),
      ),
      value: $checkedConvert('value', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'createdAt': 'created_at',
    'isActive': 'is_active',
    'nameTranslations': 'name_translations',
    'orgId': 'org_id',
    'updatedAt': 'updated_at',
  },
);

Map<String, dynamic> _$DiscountToJson(Discount instance) => <String, dynamic>{
  'created_at': instance.createdAt.toIso8601String(),
  'dtype': instance.dtype,
  'id': instance.id,
  'is_active': instance.isActive,
  'name': instance.name,
  'name_translations': instance.nameTranslations,
  'org_id': instance.orgId,
  'updated_at': instance.updatedAt.toIso8601String(),
  'value': instance.value,
};
