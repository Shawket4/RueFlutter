// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SupplierCWProxy {
  Supplier contactName(String? contactName);

  Supplier createdAt(DateTime createdAt);

  Supplier email(String? email);

  Supplier id(String id);

  Supplier isActive(bool isActive);

  Supplier name(String name);

  Supplier orgId(String orgId);

  Supplier phone(String? phone);

  Supplier updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Supplier(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Supplier(...).copyWith(id: 12, name: "My name")
  /// ````
  Supplier call({
    String? contactName,
    DateTime createdAt,
    String? email,
    String id,
    bool isActive,
    String name,
    String orgId,
    String? phone,
    DateTime updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSupplier.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSupplier.copyWith.fieldName(...)`
class _$SupplierCWProxyImpl implements _$SupplierCWProxy {
  const _$SupplierCWProxyImpl(this._value);

  final Supplier _value;

  @override
  Supplier contactName(String? contactName) => this(contactName: contactName);

  @override
  Supplier createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  Supplier email(String? email) => this(email: email);

  @override
  Supplier id(String id) => this(id: id);

  @override
  Supplier isActive(bool isActive) => this(isActive: isActive);

  @override
  Supplier name(String name) => this(name: name);

  @override
  Supplier orgId(String orgId) => this(orgId: orgId);

  @override
  Supplier phone(String? phone) => this(phone: phone);

  @override
  Supplier updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Supplier(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Supplier(...).copyWith(id: 12, name: "My name")
  /// ````
  Supplier call({
    Object? contactName = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? orgId = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return Supplier(
      contactName: contactName == const $CopyWithPlaceholder()
          ? _value.contactName
          // ignore: cast_nullable_to_non_nullable
          : contactName as String?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
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
      orgId: orgId == const $CopyWithPlaceholder()
          ? _value.orgId
          // ignore: cast_nullable_to_non_nullable
          : orgId as String,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $SupplierCopyWith on Supplier {
  /// Returns a callable class that can be used as follows: `instanceOfSupplier.copyWith(...)` or like so:`instanceOfSupplier.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SupplierCWProxy get copyWith => _$SupplierCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Supplier _$SupplierFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Supplier',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'created_at',
        'id',
        'is_active',
        'name',
        'org_id',
        'updated_at',
      ],
    );
    final val = Supplier(
      contactName: $checkedConvert('contact_name', (v) => v as String?),
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      email: $checkedConvert('email', (v) => v as String?),
      id: $checkedConvert('id', (v) => v as String),
      isActive: $checkedConvert('is_active', (v) => v as bool),
      name: $checkedConvert('name', (v) => v as String),
      orgId: $checkedConvert('org_id', (v) => v as String),
      phone: $checkedConvert('phone', (v) => v as String?),
      updatedAt: $checkedConvert(
        'updated_at',
        (v) => DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'contactName': 'contact_name',
    'createdAt': 'created_at',
    'isActive': 'is_active',
    'orgId': 'org_id',
    'updatedAt': 'updated_at',
  },
);

Map<String, dynamic> _$SupplierToJson(Supplier instance) => <String, dynamic>{
  'contact_name': ?instance.contactName,
  'created_at': instance.createdAt.toIso8601String(),
  'email': ?instance.email,
  'id': instance.id,
  'is_active': instance.isActive,
  'name': instance.name,
  'org_id': instance.orgId,
  'phone': ?instance.phone,
  'updated_at': instance.updatedAt.toIso8601String(),
};
