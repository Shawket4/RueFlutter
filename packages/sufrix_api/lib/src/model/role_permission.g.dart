// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_permission.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RolePermissionCWProxy {
  RolePermission action(String action);

  RolePermission granted(bool granted);

  RolePermission resource(String resource);

  RolePermission role(String role);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RolePermission(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RolePermission(...).copyWith(id: 12, name: "My name")
  /// ````
  RolePermission call({
    String action,
    bool granted,
    String resource,
    String role,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRolePermission.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRolePermission.copyWith.fieldName(...)`
class _$RolePermissionCWProxyImpl implements _$RolePermissionCWProxy {
  const _$RolePermissionCWProxyImpl(this._value);

  final RolePermission _value;

  @override
  RolePermission action(String action) => this(action: action);

  @override
  RolePermission granted(bool granted) => this(granted: granted);

  @override
  RolePermission resource(String resource) => this(resource: resource);

  @override
  RolePermission role(String role) => this(role: role);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RolePermission(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RolePermission(...).copyWith(id: 12, name: "My name")
  /// ````
  RolePermission call({
    Object? action = const $CopyWithPlaceholder(),
    Object? granted = const $CopyWithPlaceholder(),
    Object? resource = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
  }) {
    return RolePermission(
      action: action == const $CopyWithPlaceholder()
          ? _value.action
          // ignore: cast_nullable_to_non_nullable
          : action as String,
      granted: granted == const $CopyWithPlaceholder()
          ? _value.granted
          // ignore: cast_nullable_to_non_nullable
          : granted as bool,
      resource: resource == const $CopyWithPlaceholder()
          ? _value.resource
          // ignore: cast_nullable_to_non_nullable
          : resource as String,
      role: role == const $CopyWithPlaceholder()
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as String,
    );
  }
}

extension $RolePermissionCopyWith on RolePermission {
  /// Returns a callable class that can be used as follows: `instanceOfRolePermission.copyWith(...)` or like so:`instanceOfRolePermission.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RolePermissionCWProxy get copyWith => _$RolePermissionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RolePermission _$RolePermissionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RolePermission', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['action', 'granted', 'resource', 'role'],
      );
      final val = RolePermission(
        action: $checkedConvert('action', (v) => v as String),
        granted: $checkedConvert('granted', (v) => v as bool),
        resource: $checkedConvert('resource', (v) => v as String),
        role: $checkedConvert('role', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$RolePermissionToJson(RolePermission instance) =>
    <String, dynamic>{
      'action': instance.action,
      'granted': instance.granted,
      'resource': instance.resource,
      'role': instance.role,
    };
