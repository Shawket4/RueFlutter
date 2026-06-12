// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assign_branch_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AssignBranchRequestCWProxy {
  AssignBranchRequest branchId(String branchId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AssignBranchRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AssignBranchRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AssignBranchRequest call({String branchId});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAssignBranchRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAssignBranchRequest.copyWith.fieldName(...)`
class _$AssignBranchRequestCWProxyImpl implements _$AssignBranchRequestCWProxy {
  const _$AssignBranchRequestCWProxyImpl(this._value);

  final AssignBranchRequest _value;

  @override
  AssignBranchRequest branchId(String branchId) => this(branchId: branchId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AssignBranchRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AssignBranchRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AssignBranchRequest call({Object? branchId = const $CopyWithPlaceholder()}) {
    return AssignBranchRequest(
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String,
    );
  }
}

extension $AssignBranchRequestCopyWith on AssignBranchRequest {
  /// Returns a callable class that can be used as follows: `instanceOfAssignBranchRequest.copyWith(...)` or like so:`instanceOfAssignBranchRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AssignBranchRequestCWProxy get copyWith =>
      _$AssignBranchRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignBranchRequest _$AssignBranchRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AssignBranchRequest', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['branch_id']);
      final val = AssignBranchRequest(
        branchId: $checkedConvert('branch_id', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'branchId': 'branch_id'});

Map<String, dynamic> _$AssignBranchRequestToJson(
  AssignBranchRequest instance,
) => <String, dynamic>{'branch_id': instance.branchId};
