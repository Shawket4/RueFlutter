// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_branch.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserBranchCWProxy {
  UserBranch branchId(String branchId);

  UserBranch branchName(String branchName);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserBranch(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserBranch(...).copyWith(id: 12, name: "My name")
  /// ````
  UserBranch call({String branchId, String branchName});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserBranch.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserBranch.copyWith.fieldName(...)`
class _$UserBranchCWProxyImpl implements _$UserBranchCWProxy {
  const _$UserBranchCWProxyImpl(this._value);

  final UserBranch _value;

  @override
  UserBranch branchId(String branchId) => this(branchId: branchId);

  @override
  UserBranch branchName(String branchName) => this(branchName: branchName);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserBranch(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserBranch(...).copyWith(id: 12, name: "My name")
  /// ````
  UserBranch call({
    Object? branchId = const $CopyWithPlaceholder(),
    Object? branchName = const $CopyWithPlaceholder(),
  }) {
    return UserBranch(
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String,
      branchName: branchName == const $CopyWithPlaceholder()
          ? _value.branchName
          // ignore: cast_nullable_to_non_nullable
          : branchName as String,
    );
  }
}

extension $UserBranchCopyWith on UserBranch {
  /// Returns a callable class that can be used as follows: `instanceOfUserBranch.copyWith(...)` or like so:`instanceOfUserBranch.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserBranchCWProxy get copyWith => _$UserBranchCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBranch _$UserBranchFromJson(Map<String, dynamic> json) => $checkedCreate(
  'UserBranch',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['branch_id', 'branch_name']);
    final val = UserBranch(
      branchId: $checkedConvert('branch_id', (v) => v as String),
      branchName: $checkedConvert('branch_name', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {'branchId': 'branch_id', 'branchName': 'branch_name'},
);

Map<String, dynamic> _$UserBranchToJson(UserBranch instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'branch_name': instance.branchName,
    };
