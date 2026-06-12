// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upsert_role_permission_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpsertRolePermissionRequestCWProxy {
  UpsertRolePermissionRequest action(String action);

  UpsertRolePermissionRequest granted(bool granted);

  UpsertRolePermissionRequest resource(String resource);

  UpsertRolePermissionRequest role(String role);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpsertRolePermissionRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpsertRolePermissionRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpsertRolePermissionRequest call({
    String action,
    bool granted,
    String resource,
    String role,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpsertRolePermissionRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpsertRolePermissionRequest.copyWith.fieldName(...)`
class _$UpsertRolePermissionRequestCWProxyImpl
    implements _$UpsertRolePermissionRequestCWProxy {
  const _$UpsertRolePermissionRequestCWProxyImpl(this._value);

  final UpsertRolePermissionRequest _value;

  @override
  UpsertRolePermissionRequest action(String action) => this(action: action);

  @override
  UpsertRolePermissionRequest granted(bool granted) => this(granted: granted);

  @override
  UpsertRolePermissionRequest resource(String resource) =>
      this(resource: resource);

  @override
  UpsertRolePermissionRequest role(String role) => this(role: role);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpsertRolePermissionRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpsertRolePermissionRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpsertRolePermissionRequest call({
    Object? action = const $CopyWithPlaceholder(),
    Object? granted = const $CopyWithPlaceholder(),
    Object? resource = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
  }) {
    return UpsertRolePermissionRequest(
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

extension $UpsertRolePermissionRequestCopyWith on UpsertRolePermissionRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpsertRolePermissionRequest.copyWith(...)` or like so:`instanceOfUpsertRolePermissionRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpsertRolePermissionRequestCWProxy get copyWith =>
      _$UpsertRolePermissionRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpsertRolePermissionRequest _$UpsertRolePermissionRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UpsertRolePermissionRequest', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['action', 'granted', 'resource', 'role'],
  );
  final val = UpsertRolePermissionRequest(
    action: $checkedConvert('action', (v) => v as String),
    granted: $checkedConvert('granted', (v) => v as bool),
    resource: $checkedConvert('resource', (v) => v as String),
    role: $checkedConvert('role', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$UpsertRolePermissionRequestToJson(
  UpsertRolePermissionRequest instance,
) => <String, dynamic>{
  'action': instance.action,
  'granted': instance.granted,
  'resource': instance.resource,
  'role': instance.role,
};
