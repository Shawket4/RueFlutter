// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_permission_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserPermissionItemCWProxy {
  UserPermissionItem action(String action);

  UserPermissionItem granted(bool granted);

  UserPermissionItem resource(String resource);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserPermissionItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserPermissionItem(...).copyWith(id: 12, name: "My name")
  /// ````
  UserPermissionItem call({String action, bool granted, String resource});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserPermissionItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserPermissionItem.copyWith.fieldName(...)`
class _$UserPermissionItemCWProxyImpl implements _$UserPermissionItemCWProxy {
  const _$UserPermissionItemCWProxyImpl(this._value);

  final UserPermissionItem _value;

  @override
  UserPermissionItem action(String action) => this(action: action);

  @override
  UserPermissionItem granted(bool granted) => this(granted: granted);

  @override
  UserPermissionItem resource(String resource) => this(resource: resource);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserPermissionItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserPermissionItem(...).copyWith(id: 12, name: "My name")
  /// ````
  UserPermissionItem call({
    Object? action = const $CopyWithPlaceholder(),
    Object? granted = const $CopyWithPlaceholder(),
    Object? resource = const $CopyWithPlaceholder(),
  }) {
    return UserPermissionItem(
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

extension $UserPermissionItemCopyWith on UserPermissionItem {
  /// Returns a callable class that can be used as follows: `instanceOfUserPermissionItem.copyWith(...)` or like so:`instanceOfUserPermissionItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserPermissionItemCWProxy get copyWith =>
      _$UserPermissionItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPermissionItem _$UserPermissionItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UserPermissionItem', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['action', 'granted', 'resource']);
      final val = UserPermissionItem(
        action: $checkedConvert('action', (v) => v as String),
        granted: $checkedConvert('granted', (v) => v as bool),
        resource: $checkedConvert('resource', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$UserPermissionItemToJson(UserPermissionItem instance) =>
    <String, dynamic>{
      'action': instance.action,
      'granted': instance.granted,
      'resource': instance.resource,
    };
