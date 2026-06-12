// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateUserRequestCWProxy {
  UpdateUserRequest email(String? email);

  UpdateUserRequest isActive(bool? isActive);

  UpdateUserRequest name(String? name);

  UpdateUserRequest password(String? password);

  UpdateUserRequest phone(String? phone);

  UpdateUserRequest pin(String? pin);

  UpdateUserRequest role(UserRole? role);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateUserRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateUserRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateUserRequest call({
    String? email,
    bool? isActive,
    String? name,
    String? password,
    String? phone,
    String? pin,
    UserRole? role,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateUserRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateUserRequest.copyWith.fieldName(...)`
class _$UpdateUserRequestCWProxyImpl implements _$UpdateUserRequestCWProxy {
  const _$UpdateUserRequestCWProxyImpl(this._value);

  final UpdateUserRequest _value;

  @override
  UpdateUserRequest email(String? email) => this(email: email);

  @override
  UpdateUserRequest isActive(bool? isActive) => this(isActive: isActive);

  @override
  UpdateUserRequest name(String? name) => this(name: name);

  @override
  UpdateUserRequest password(String? password) => this(password: password);

  @override
  UpdateUserRequest phone(String? phone) => this(phone: phone);

  @override
  UpdateUserRequest pin(String? pin) => this(pin: pin);

  @override
  UpdateUserRequest role(UserRole? role) => this(role: role);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateUserRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateUserRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateUserRequest call({
    Object? email = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? pin = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
  }) {
    return UpdateUserRequest(
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
          : role as UserRole?,
    );
  }
}

extension $UpdateUserRequestCopyWith on UpdateUserRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateUserRequest.copyWith(...)` or like so:`instanceOfUpdateUserRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateUserRequestCWProxy get copyWith =>
      _$UpdateUserRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserRequest _$UpdateUserRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateUserRequest', json, ($checkedConvert) {
      final val = UpdateUserRequest(
        email: $checkedConvert('email', (v) => v as String?),
        isActive: $checkedConvert('is_active', (v) => v as bool?),
        name: $checkedConvert('name', (v) => v as String?),
        password: $checkedConvert('password', (v) => v as String?),
        phone: $checkedConvert('phone', (v) => v as String?),
        pin: $checkedConvert('pin', (v) => v as String?),
        role: $checkedConvert(
          'role',
          (v) => $enumDecodeNullable(
            _$UserRoleEnumMap,
            v,
            unknownValue: UserRole.unknownDefaultOpenApi,
          ),
        ),
      );
      return val;
    }, fieldKeyMap: const {'isActive': 'is_active'});

Map<String, dynamic> _$UpdateUserRequestToJson(UpdateUserRequest instance) =>
    <String, dynamic>{
      'email': ?instance.email,
      'is_active': ?instance.isActive,
      'name': ?instance.name,
      'password': ?instance.password,
      'phone': ?instance.phone,
      'pin': ?instance.pin,
      'role': ?_$UserRoleEnumMap[instance.role],
    };

const _$UserRoleEnumMap = {
  UserRole.superAdmin: 'super_admin',
  UserRole.orgAdmin: 'org_admin',
  UserRole.branchManager: 'branch_manager',
  UserRole.teller: 'teller',
  UserRole.unknownDefaultOpenApi: 'unknown_default_open_api',
};
