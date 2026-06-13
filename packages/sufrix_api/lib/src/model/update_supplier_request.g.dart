// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_supplier_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateSupplierRequestCWProxy {
  UpdateSupplierRequest contactName(String? contactName);

  UpdateSupplierRequest email(String? email);

  UpdateSupplierRequest isActive(bool? isActive);

  UpdateSupplierRequest name(String? name);

  UpdateSupplierRequest phone(String? phone);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateSupplierRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateSupplierRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateSupplierRequest call({
    String? contactName,
    String? email,
    bool? isActive,
    String? name,
    String? phone,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateSupplierRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateSupplierRequest.copyWith.fieldName(...)`
class _$UpdateSupplierRequestCWProxyImpl
    implements _$UpdateSupplierRequestCWProxy {
  const _$UpdateSupplierRequestCWProxyImpl(this._value);

  final UpdateSupplierRequest _value;

  @override
  UpdateSupplierRequest contactName(String? contactName) =>
      this(contactName: contactName);

  @override
  UpdateSupplierRequest email(String? email) => this(email: email);

  @override
  UpdateSupplierRequest isActive(bool? isActive) => this(isActive: isActive);

  @override
  UpdateSupplierRequest name(String? name) => this(name: name);

  @override
  UpdateSupplierRequest phone(String? phone) => this(phone: phone);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateSupplierRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateSupplierRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateSupplierRequest call({
    Object? contactName = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
  }) {
    return UpdateSupplierRequest(
      contactName: contactName == const $CopyWithPlaceholder()
          ? _value.contactName
          // ignore: cast_nullable_to_non_nullable
          : contactName as String?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String?,
    );
  }
}

extension $UpdateSupplierRequestCopyWith on UpdateSupplierRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateSupplierRequest.copyWith(...)` or like so:`instanceOfUpdateSupplierRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateSupplierRequestCWProxy get copyWith =>
      _$UpdateSupplierRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateSupplierRequest _$UpdateSupplierRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'UpdateSupplierRequest',
  json,
  ($checkedConvert) {
    final val = UpdateSupplierRequest(
      contactName: $checkedConvert('contact_name', (v) => v as String?),
      email: $checkedConvert('email', (v) => v as String?),
      isActive: $checkedConvert('is_active', (v) => v as bool?),
      name: $checkedConvert('name', (v) => v as String?),
      phone: $checkedConvert('phone', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'contactName': 'contact_name', 'isActive': 'is_active'},
);

Map<String, dynamic> _$UpdateSupplierRequestToJson(
  UpdateSupplierRequest instance,
) => <String, dynamic>{
  'contact_name': ?instance.contactName,
  'email': ?instance.email,
  'is_active': ?instance.isActive,
  'name': ?instance.name,
  'phone': ?instance.phone,
};
