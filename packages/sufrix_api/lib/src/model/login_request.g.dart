// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LoginRequestCWProxy {
  LoginRequest branchId(String? branchId);

  LoginRequest email(String? email);

  LoginRequest name(String? name);

  LoginRequest orgId(String? orgId);

  LoginRequest password(String? password);

  LoginRequest pin(String? pin);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LoginRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LoginRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  LoginRequest call({
    String? branchId,
    String? email,
    String? name,
    String? orgId,
    String? password,
    String? pin,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLoginRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLoginRequest.copyWith.fieldName(...)`
class _$LoginRequestCWProxyImpl implements _$LoginRequestCWProxy {
  const _$LoginRequestCWProxyImpl(this._value);

  final LoginRequest _value;

  @override
  LoginRequest branchId(String? branchId) => this(branchId: branchId);

  @override
  LoginRequest email(String? email) => this(email: email);

  @override
  LoginRequest name(String? name) => this(name: name);

  @override
  LoginRequest orgId(String? orgId) => this(orgId: orgId);

  @override
  LoginRequest password(String? password) => this(password: password);

  @override
  LoginRequest pin(String? pin) => this(pin: pin);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LoginRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LoginRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  LoginRequest call({
    Object? branchId = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? orgId = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? pin = const $CopyWithPlaceholder(),
  }) {
    return LoginRequest(
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      orgId: orgId == const $CopyWithPlaceholder()
          ? _value.orgId
          // ignore: cast_nullable_to_non_nullable
          : orgId as String?,
      password: password == const $CopyWithPlaceholder()
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String?,
      pin: pin == const $CopyWithPlaceholder()
          ? _value.pin
          // ignore: cast_nullable_to_non_nullable
          : pin as String?,
    );
  }
}

extension $LoginRequestCopyWith on LoginRequest {
  /// Returns a callable class that can be used as follows: `instanceOfLoginRequest.copyWith(...)` or like so:`instanceOfLoginRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LoginRequestCWProxy get copyWith => _$LoginRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LoginRequest', json, ($checkedConvert) {
      final val = LoginRequest(
        branchId: $checkedConvert('branch_id', (v) => v as String?),
        email: $checkedConvert('email', (v) => v as String?),
        name: $checkedConvert('name', (v) => v as String?),
        orgId: $checkedConvert('org_id', (v) => v as String?),
        password: $checkedConvert('password', (v) => v as String?),
        pin: $checkedConvert('pin', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {'branchId': 'branch_id', 'orgId': 'org_id'});

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'branch_id': ?instance.branchId,
      'email': ?instance.email,
      'name': ?instance.name,
      'org_id': ?instance.orgId,
      'password': ?instance.password,
      'pin': ?instance.pin,
    };
