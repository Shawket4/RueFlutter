// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PermissionCWProxy {
  Permission action(String action);

  Permission granted(bool granted);

  Permission id(String id);

  Permission resource(String resource);

  Permission userId(String userId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Permission(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Permission(...).copyWith(id: 12, name: "My name")
  /// ````
  Permission call({
    String action,
    bool granted,
    String id,
    String resource,
    String userId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPermission.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPermission.copyWith.fieldName(...)`
class _$PermissionCWProxyImpl implements _$PermissionCWProxy {
  const _$PermissionCWProxyImpl(this._value);

  final Permission _value;

  @override
  Permission action(String action) => this(action: action);

  @override
  Permission granted(bool granted) => this(granted: granted);

  @override
  Permission id(String id) => this(id: id);

  @override
  Permission resource(String resource) => this(resource: resource);

  @override
  Permission userId(String userId) => this(userId: userId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Permission(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Permission(...).copyWith(id: 12, name: "My name")
  /// ````
  Permission call({
    Object? action = const $CopyWithPlaceholder(),
    Object? granted = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? resource = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
  }) {
    return Permission(
      action: action == const $CopyWithPlaceholder()
          ? _value.action
          // ignore: cast_nullable_to_non_nullable
          : action as String,
      granted: granted == const $CopyWithPlaceholder()
          ? _value.granted
          // ignore: cast_nullable_to_non_nullable
          : granted as bool,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      resource: resource == const $CopyWithPlaceholder()
          ? _value.resource
          // ignore: cast_nullable_to_non_nullable
          : resource as String,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String,
    );
  }
}

extension $PermissionCopyWith on Permission {
  /// Returns a callable class that can be used as follows: `instanceOfPermission.copyWith(...)` or like so:`instanceOfPermission.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PermissionCWProxy get copyWith => _$PermissionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Permission _$PermissionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Permission', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['action', 'granted', 'id', 'resource', 'user_id'],
      );
      final val = Permission(
        action: $checkedConvert('action', (v) => v as String),
        granted: $checkedConvert('granted', (v) => v as bool),
        id: $checkedConvert('id', (v) => v as String),
        resource: $checkedConvert('resource', (v) => v as String),
        userId: $checkedConvert('user_id', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'userId': 'user_id'});

Map<String, dynamic> _$PermissionToJson(Permission instance) =>
    <String, dynamic>{
      'action': instance.action,
      'granted': instance.granted,
      'id': instance.id,
      'resource': instance.resource,
      'user_id': instance.userId,
    };
