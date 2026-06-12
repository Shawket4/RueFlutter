// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_permissions_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthPermissionsResponseCWProxy {
  AuthPermissionsResponse permissions(List<UserPermissionItem> permissions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthPermissionsResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthPermissionsResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthPermissionsResponse call({List<UserPermissionItem> permissions});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthPermissionsResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthPermissionsResponse.copyWith.fieldName(...)`
class _$AuthPermissionsResponseCWProxyImpl
    implements _$AuthPermissionsResponseCWProxy {
  const _$AuthPermissionsResponseCWProxyImpl(this._value);

  final AuthPermissionsResponse _value;

  @override
  AuthPermissionsResponse permissions(List<UserPermissionItem> permissions) =>
      this(permissions: permissions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthPermissionsResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthPermissionsResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthPermissionsResponse call({
    Object? permissions = const $CopyWithPlaceholder(),
  }) {
    return AuthPermissionsResponse(
      permissions: permissions == const $CopyWithPlaceholder()
          ? _value.permissions
          // ignore: cast_nullable_to_non_nullable
          : permissions as List<UserPermissionItem>,
    );
  }
}

extension $AuthPermissionsResponseCopyWith on AuthPermissionsResponse {
  /// Returns a callable class that can be used as follows: `instanceOfAuthPermissionsResponse.copyWith(...)` or like so:`instanceOfAuthPermissionsResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthPermissionsResponseCWProxy get copyWith =>
      _$AuthPermissionsResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthPermissionsResponse _$AuthPermissionsResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthPermissionsResponse', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['permissions']);
  final val = AuthPermissionsResponse(
    permissions: $checkedConvert(
      'permissions',
      (v) => (v as List<dynamic>)
          .map((e) => UserPermissionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$AuthPermissionsResponseToJson(
  AuthPermissionsResponse instance,
) => <String, dynamic>{
  'permissions': instance.permissions.map((e) => e.toJson()).toList(),
};
