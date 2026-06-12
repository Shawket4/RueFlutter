// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resolve_branch_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ResolveBranchResponseCWProxy {
  ResolveBranchResponse branchId(String branchId);

  ResolveBranchResponse branchName(String branchName);

  ResolveBranchResponse distanceMeters(double distanceMeters);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ResolveBranchResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ResolveBranchResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ResolveBranchResponse call({
    String branchId,
    String branchName,
    double distanceMeters,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfResolveBranchResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfResolveBranchResponse.copyWith.fieldName(...)`
class _$ResolveBranchResponseCWProxyImpl
    implements _$ResolveBranchResponseCWProxy {
  const _$ResolveBranchResponseCWProxyImpl(this._value);

  final ResolveBranchResponse _value;

  @override
  ResolveBranchResponse branchId(String branchId) => this(branchId: branchId);

  @override
  ResolveBranchResponse branchName(String branchName) =>
      this(branchName: branchName);

  @override
  ResolveBranchResponse distanceMeters(double distanceMeters) =>
      this(distanceMeters: distanceMeters);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ResolveBranchResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ResolveBranchResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ResolveBranchResponse call({
    Object? branchId = const $CopyWithPlaceholder(),
    Object? branchName = const $CopyWithPlaceholder(),
    Object? distanceMeters = const $CopyWithPlaceholder(),
  }) {
    return ResolveBranchResponse(
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String,
      branchName: branchName == const $CopyWithPlaceholder()
          ? _value.branchName
          // ignore: cast_nullable_to_non_nullable
          : branchName as String,
      distanceMeters: distanceMeters == const $CopyWithPlaceholder()
          ? _value.distanceMeters
          // ignore: cast_nullable_to_non_nullable
          : distanceMeters as double,
    );
  }
}

extension $ResolveBranchResponseCopyWith on ResolveBranchResponse {
  /// Returns a callable class that can be used as follows: `instanceOfResolveBranchResponse.copyWith(...)` or like so:`instanceOfResolveBranchResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ResolveBranchResponseCWProxy get copyWith =>
      _$ResolveBranchResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResolveBranchResponse _$ResolveBranchResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ResolveBranchResponse',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['branch_id', 'branch_name', 'distance_meters'],
    );
    final val = ResolveBranchResponse(
      branchId: $checkedConvert('branch_id', (v) => v as String),
      branchName: $checkedConvert('branch_name', (v) => v as String),
      distanceMeters: $checkedConvert(
        'distance_meters',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'branchId': 'branch_id',
    'branchName': 'branch_name',
    'distanceMeters': 'distance_meters',
  },
);

Map<String, dynamic> _$ResolveBranchResponseToJson(
  ResolveBranchResponse instance,
) => <String, dynamic>{
  'branch_id': instance.branchId,
  'branch_name': instance.branchName,
  'distance_meters': instance.distanceMeters,
};
