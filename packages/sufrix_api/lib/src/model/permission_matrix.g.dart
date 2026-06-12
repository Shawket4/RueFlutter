// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission_matrix.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PermissionMatrixCWProxy {
  PermissionMatrix action(String action);

  PermissionMatrix effective(bool effective);

  PermissionMatrix resource(String resource);

  PermissionMatrix roleDefault(bool? roleDefault);

  PermissionMatrix userOverride(bool? userOverride);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PermissionMatrix(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PermissionMatrix(...).copyWith(id: 12, name: "My name")
  /// ````
  PermissionMatrix call({
    String action,
    bool effective,
    String resource,
    bool? roleDefault,
    bool? userOverride,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPermissionMatrix.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPermissionMatrix.copyWith.fieldName(...)`
class _$PermissionMatrixCWProxyImpl implements _$PermissionMatrixCWProxy {
  const _$PermissionMatrixCWProxyImpl(this._value);

  final PermissionMatrix _value;

  @override
  PermissionMatrix action(String action) => this(action: action);

  @override
  PermissionMatrix effective(bool effective) => this(effective: effective);

  @override
  PermissionMatrix resource(String resource) => this(resource: resource);

  @override
  PermissionMatrix roleDefault(bool? roleDefault) =>
      this(roleDefault: roleDefault);

  @override
  PermissionMatrix userOverride(bool? userOverride) =>
      this(userOverride: userOverride);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PermissionMatrix(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PermissionMatrix(...).copyWith(id: 12, name: "My name")
  /// ````
  PermissionMatrix call({
    Object? action = const $CopyWithPlaceholder(),
    Object? effective = const $CopyWithPlaceholder(),
    Object? resource = const $CopyWithPlaceholder(),
    Object? roleDefault = const $CopyWithPlaceholder(),
    Object? userOverride = const $CopyWithPlaceholder(),
  }) {
    return PermissionMatrix(
      action: action == const $CopyWithPlaceholder()
          ? _value.action
          // ignore: cast_nullable_to_non_nullable
          : action as String,
      effective: effective == const $CopyWithPlaceholder()
          ? _value.effective
          // ignore: cast_nullable_to_non_nullable
          : effective as bool,
      resource: resource == const $CopyWithPlaceholder()
          ? _value.resource
          // ignore: cast_nullable_to_non_nullable
          : resource as String,
      roleDefault: roleDefault == const $CopyWithPlaceholder()
          ? _value.roleDefault
          // ignore: cast_nullable_to_non_nullable
          : roleDefault as bool?,
      userOverride: userOverride == const $CopyWithPlaceholder()
          ? _value.userOverride
          // ignore: cast_nullable_to_non_nullable
          : userOverride as bool?,
    );
  }
}

extension $PermissionMatrixCopyWith on PermissionMatrix {
  /// Returns a callable class that can be used as follows: `instanceOfPermissionMatrix.copyWith(...)` or like so:`instanceOfPermissionMatrix.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PermissionMatrixCWProxy get copyWith => _$PermissionMatrixCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PermissionMatrix _$PermissionMatrixFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PermissionMatrix',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['action', 'effective', 'resource'],
        );
        final val = PermissionMatrix(
          action: $checkedConvert('action', (v) => v as String),
          effective: $checkedConvert('effective', (v) => v as bool),
          resource: $checkedConvert('resource', (v) => v as String),
          roleDefault: $checkedConvert('role_default', (v) => v as bool?),
          userOverride: $checkedConvert('user_override', (v) => v as bool?),
        );
        return val;
      },
      fieldKeyMap: const {
        'roleDefault': 'role_default',
        'userOverride': 'user_override',
      },
    );

Map<String, dynamic> _$PermissionMatrixToJson(PermissionMatrix instance) =>
    <String, dynamic>{
      'action': instance.action,
      'effective': instance.effective,
      'resource': instance.resource,
      'role_default': ?instance.roleDefault,
      'user_override': ?instance.userOverride,
    };
