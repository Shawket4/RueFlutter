// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upsert_permission_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpsertPermissionRequestCWProxy {
  UpsertPermissionRequest action(String action);

  UpsertPermissionRequest granted(bool granted);

  UpsertPermissionRequest resource(String resource);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpsertPermissionRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpsertPermissionRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpsertPermissionRequest call({String action, bool granted, String resource});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpsertPermissionRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpsertPermissionRequest.copyWith.fieldName(...)`
class _$UpsertPermissionRequestCWProxyImpl
    implements _$UpsertPermissionRequestCWProxy {
  const _$UpsertPermissionRequestCWProxyImpl(this._value);

  final UpsertPermissionRequest _value;

  @override
  UpsertPermissionRequest action(String action) => this(action: action);

  @override
  UpsertPermissionRequest granted(bool granted) => this(granted: granted);

  @override
  UpsertPermissionRequest resource(String resource) => this(resource: resource);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpsertPermissionRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpsertPermissionRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpsertPermissionRequest call({
    Object? action = const $CopyWithPlaceholder(),
    Object? granted = const $CopyWithPlaceholder(),
    Object? resource = const $CopyWithPlaceholder(),
  }) {
    return UpsertPermissionRequest(
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
    );
  }
}

extension $UpsertPermissionRequestCopyWith on UpsertPermissionRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpsertPermissionRequest.copyWith(...)` or like so:`instanceOfUpsertPermissionRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpsertPermissionRequestCWProxy get copyWith =>
      _$UpsertPermissionRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpsertPermissionRequest _$UpsertPermissionRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UpsertPermissionRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['action', 'granted', 'resource']);
  final val = UpsertPermissionRequest(
    action: $checkedConvert('action', (v) => v as String),
    granted: $checkedConvert('granted', (v) => v as bool),
    resource: $checkedConvert('resource', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$UpsertPermissionRequestToJson(
  UpsertPermissionRequest instance,
) => <String, dynamic>{
  'action': instance.action,
  'granted': instance.granted,
  'resource': instance.resource,
};
