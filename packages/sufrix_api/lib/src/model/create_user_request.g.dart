// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_user_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateUserRequestCWProxy {
  CreateUserRequest branchIds(List<String>? branchIds);

  CreateUserRequest email(String? email);

  CreateUserRequest name(String name);

  CreateUserRequest orgId(String orgId);

  CreateUserRequest password(String? password);

  CreateUserRequest phone(String? phone);

  CreateUserRequest pin(String? pin);

  CreateUserRequest role(UserRole role);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateUserRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateUserRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateUserRequest call({
    List<String>? branchIds,
    String? email,
    String name,
    String orgId,
    String? password,
    String? phone,
    String? pin,
    UserRole role,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCreateUserRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCreateUserRequest.copyWith.fieldName(...)`
class _$CreateUserRequestCWProxyImpl implements _$CreateUserRequestCWProxy {
  const _$CreateUserRequestCWProxyImpl(this._value);

  final CreateUserRequest _value;

  @override
  CreateUserRequest branchIds(List<String>? branchIds) =>
      this(branchIds: branchIds);

  @override
  CreateUserRequest email(String? email) => this(email: email);

  @override
  CreateUserRequest name(String name) => this(name: name);

  @override
  CreateUserRequest orgId(String orgId) => this(orgId: orgId);

  @override
  CreateUserRequest password(String? password) => this(password: password);

  @override
  CreateUserRequest phone(String? phone) => this(phone: phone);

  @override
  CreateUserRequest pin(String? pin) => this(pin: pin);

  @override
  CreateUserRequest role(UserRole role) => this(role: role);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateUserRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateUserRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateUserRequest call({
    Object? branchIds = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? orgId = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? pin = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
  }) {
    return CreateUserRequest(
      branchIds: branchIds == const $CopyWithPlaceholder()
          ? _value.branchIds
          // ignore: cast_nullable_to_non_nullable
          : branchIds as List<String>?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      orgId: orgId == const $CopyWithPlaceholder()
          ? _value.orgId
          // ignore: cast_nullable_to_non_nullable
          : orgId as String,
      password: password == const $CopyWithPlaceholder()
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String?,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String?,
      pin: pin == const $CopyWithPlaceholder()
          ? _value.pin
          // ignore: cast_nullable_to_non_nullable
          : pin as String?,
      role: role == const $CopyWithPlaceholder()
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as UserRole,
    );
  }
}

extension $CreateUserRequestCopyWith on CreateUserRequest {
  /// Returns a callable class that can be used as follows: `instanceOfCreateUserRequest.copyWith(...)` or like so:`instanceOfCreateUserRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateUserRequestCWProxy get copyWith =>
      _$CreateUserRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserRequest _$CreateUserRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CreateUserRequest',
      json,
      ($checkedConvert) {
        $checkKeys(json, requiredKeys: const ['name', 'org_id', 'role']);
        final val = CreateUserRequest(
          branchIds: $checkedConvert(
            'branch_ids',
            (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
          ),
          email: $checkedConvert('email', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String),
          orgId: $checkedConvert('org_id', (v) => v as String),
          password: $checkedConvert('password', (v) => v as String?),
          phone: $checkedConvert('phone', (v) => v as String?),
          pin: $checkedConvert('pin', (v) => v as String?),
          role: $checkedConvert(
            'role',
            (v) => $enumDecode(
              _$UserRoleEnumMap,
              v,
              unknownValue: UserRole.unknownDefaultOpenApi,
            ),
          ),
        );
        return val;
      },
      fieldKeyMap: const {'branchIds': 'branch_ids', 'orgId': 'org_id'},
    );

Map<String, dynamic> _$CreateUserRequestToJson(CreateUserRequest instance) =>
    <String, dynamic>{
      'branch_ids': ?instance.branchIds,
      'email': ?instance.email,
      'name': instance.name,
      'org_id': instance.orgId,
      'password': ?instance.password,
      'phone': ?instance.phone,
      'pin': ?instance.pin,
      'role': _$UserRoleEnumMap[instance.role]!,
    };

const _$UserRoleEnumMap = {
  UserRole.superAdmin: 'super_admin',
  UserRole.orgAdmin: 'org_admin',
  UserRole.branchManager: 'branch_manager',
  UserRole.teller: 'teller',
  UserRole.unknownDefaultOpenApi: 'unknown_default_open_api',
};
