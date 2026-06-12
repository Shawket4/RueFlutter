// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_user_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateUserResponseCWProxy {
  CreateUserResponse user(UserPublic user);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateUserResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateUserResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateUserResponse call({UserPublic user});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCreateUserResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCreateUserResponse.copyWith.fieldName(...)`
class _$CreateUserResponseCWProxyImpl implements _$CreateUserResponseCWProxy {
  const _$CreateUserResponseCWProxyImpl(this._value);

  final CreateUserResponse _value;

  @override
  CreateUserResponse user(UserPublic user) => this(user: user);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateUserResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateUserResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateUserResponse call({Object? user = const $CopyWithPlaceholder()}) {
    return CreateUserResponse(
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as UserPublic,
    );
  }
}

extension $CreateUserResponseCopyWith on CreateUserResponse {
  /// Returns a callable class that can be used as follows: `instanceOfCreateUserResponse.copyWith(...)` or like so:`instanceOfCreateUserResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateUserResponseCWProxy get copyWith =>
      _$CreateUserResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserResponse _$CreateUserResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CreateUserResponse', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['user']);
      final val = CreateUserResponse(
        user: $checkedConvert(
          'user',
          (v) => UserPublic.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CreateUserResponseToJson(CreateUserResponse instance) =>
    <String, dynamic>{'user': instance.user.toJson()};
