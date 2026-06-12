// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_public.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserPublicCWProxy {
  UserPublic branchId(String? branchId);

  UserPublic email(String? email);

  UserPublic id(String id);

  UserPublic isActive(bool isActive);

  UserPublic name(String name);

  UserPublic orgId(String? orgId);

  UserPublic phone(String? phone);

  UserPublic role(UserRole role);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserPublic(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserPublic(...).copyWith(id: 12, name: "My name")
  /// ````
  UserPublic call({
    String? branchId,
    String? email,
    String id,
    bool isActive,
    String name,
    String? orgId,
    String? phone,
    UserRole role,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserPublic.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserPublic.copyWith.fieldName(...)`
class _$UserPublicCWProxyImpl implements _$UserPublicCWProxy {
  const _$UserPublicCWProxyImpl(this._value);

  final UserPublic _value;

  @override
  UserPublic branchId(String? branchId) => this(branchId: branchId);

  @override
  UserPublic email(String? email) => this(email: email);

  @override
  UserPublic id(String id) => this(id: id);

  @override
  UserPublic isActive(bool isActive) => this(isActive: isActive);

  @override
  UserPublic name(String name) => this(name: name);

  @override
  UserPublic orgId(String? orgId) => this(orgId: orgId);

  @override
  UserPublic phone(String? phone) => this(phone: phone);

  @override
  UserPublic role(UserRole role) => this(role: role);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserPublic(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserPublic(...).copyWith(id: 12, name: "My name")
  /// ````
  UserPublic call({
    Object? branchId = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? orgId = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
  }) {
    return UserPublic(
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String?,
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
          : orgId as String?,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String?,
      role: role == const $CopyWithPlaceholder()
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as UserRole,
    );
  }
}

extension $UserPublicCopyWith on UserPublic {
  /// Returns a callable class that can be used as follows: `instanceOfUserPublic.copyWith(...)` or like so:`instanceOfUserPublic.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserPublicCWProxy get copyWith => _$UserPublicCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPublic _$UserPublicFromJson(Map<String, dynamic> json) => $checkedCreate(
  'UserPublic',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['id', 'is_active', 'name', 'role']);
    final val = UserPublic(
      branchId: $checkedConvert('branch_id', (v) => v as String?),
      email: $checkedConvert('email', (v) => v as String?),
      id: $checkedConvert('id', (v) => v as String),
      isActive: $checkedConvert('is_active', (v) => v as bool),
      name: $checkedConvert('name', (v) => v as String),
      orgId: $checkedConvert('org_id', (v) => v as String?),
      phone: $checkedConvert('phone', (v) => v as String?),
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
  fieldKeyMap: const {
    'branchId': 'branch_id',
    'isActive': 'is_active',
    'orgId': 'org_id',
  },
);

Map<String, dynamic> _$UserPublicToJson(UserPublic instance) =>
    <String, dynamic>{
      'branch_id': ?instance.branchId,
      'email': ?instance.email,
      'id': instance.id,
      'is_active': instance.isActive,
      'name': instance.name,
      'org_id': ?instance.orgId,
      'phone': ?instance.phone,
      'role': _$UserRoleEnumMap[instance.role]!,
    };

const _$UserRoleEnumMap = {
  UserRole.superAdmin: 'super_admin',
  UserRole.orgAdmin: 'org_admin',
  UserRole.branchManager: 'branch_manager',
  UserRole.teller: 'teller',
  UserRole.unknownDefaultOpenApi: 'unknown_default_open_api',
};
