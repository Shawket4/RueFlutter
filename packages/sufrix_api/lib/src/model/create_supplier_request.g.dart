// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_supplier_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateSupplierRequestCWProxy {
  CreateSupplierRequest contactName(String? contactName);

  CreateSupplierRequest email(String? email);

  CreateSupplierRequest name(String name);

  CreateSupplierRequest phone(String? phone);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateSupplierRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateSupplierRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateSupplierRequest call({
    String? contactName,
    String? email,
    String name,
    String? phone,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCreateSupplierRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCreateSupplierRequest.copyWith.fieldName(...)`
class _$CreateSupplierRequestCWProxyImpl
    implements _$CreateSupplierRequestCWProxy {
  const _$CreateSupplierRequestCWProxyImpl(this._value);

  final CreateSupplierRequest _value;

  @override
  CreateSupplierRequest contactName(String? contactName) =>
      this(contactName: contactName);

  @override
  CreateSupplierRequest email(String? email) => this(email: email);

  @override
  CreateSupplierRequest name(String name) => this(name: name);

  @override
  CreateSupplierRequest phone(String? phone) => this(phone: phone);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateSupplierRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateSupplierRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateSupplierRequest call({
    Object? contactName = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
  }) {
    return CreateSupplierRequest(
      contactName: contactName == const $CopyWithPlaceholder()
          ? _value.contactName
          // ignore: cast_nullable_to_non_nullable
          : contactName as String?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String?,
    );
  }
}

extension $CreateSupplierRequestCopyWith on CreateSupplierRequest {
  /// Returns a callable class that can be used as follows: `instanceOfCreateSupplierRequest.copyWith(...)` or like so:`instanceOfCreateSupplierRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateSupplierRequestCWProxy get copyWith =>
      _$CreateSupplierRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateSupplierRequest _$CreateSupplierRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('CreateSupplierRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['name']);
  final val = CreateSupplierRequest(
    contactName: $checkedConvert('contact_name', (v) => v as String?),
    email: $checkedConvert('email', (v) => v as String?),
    name: $checkedConvert('name', (v) => v as String),
    phone: $checkedConvert('phone', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {'contactName': 'contact_name'});

Map<String, dynamic> _$CreateSupplierRequestToJson(
  CreateSupplierRequest instance,
) => <String, dynamic>{
  'contact_name': ?instance.contactName,
  'email': ?instance.email,
  'name': instance.name,
  'phone': ?instance.phone,
};
