// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resolve_branch_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ResolveBranchRequestCWProxy {
  ResolveBranchRequest latitude(double latitude);

  ResolveBranchRequest longitude(double longitude);

  ResolveBranchRequest orgId(String orgId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ResolveBranchRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ResolveBranchRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ResolveBranchRequest call({double latitude, double longitude, String orgId});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfResolveBranchRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfResolveBranchRequest.copyWith.fieldName(...)`
class _$ResolveBranchRequestCWProxyImpl
    implements _$ResolveBranchRequestCWProxy {
  const _$ResolveBranchRequestCWProxyImpl(this._value);

  final ResolveBranchRequest _value;

  @override
  ResolveBranchRequest latitude(double latitude) => this(latitude: latitude);

  @override
  ResolveBranchRequest longitude(double longitude) =>
      this(longitude: longitude);

  @override
  ResolveBranchRequest orgId(String orgId) => this(orgId: orgId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ResolveBranchRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ResolveBranchRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ResolveBranchRequest call({
    Object? latitude = const $CopyWithPlaceholder(),
    Object? longitude = const $CopyWithPlaceholder(),
    Object? orgId = const $CopyWithPlaceholder(),
  }) {
    return ResolveBranchRequest(
      latitude: latitude == const $CopyWithPlaceholder()
          ? _value.latitude
          // ignore: cast_nullable_to_non_nullable
          : latitude as double,
      longitude: longitude == const $CopyWithPlaceholder()
          ? _value.longitude
          // ignore: cast_nullable_to_non_nullable
          : longitude as double,
      orgId: orgId == const $CopyWithPlaceholder()
          ? _value.orgId
          // ignore: cast_nullable_to_non_nullable
          : orgId as String,
    );
  }
}

extension $ResolveBranchRequestCopyWith on ResolveBranchRequest {
  /// Returns a callable class that can be used as follows: `instanceOfResolveBranchRequest.copyWith(...)` or like so:`instanceOfResolveBranchRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ResolveBranchRequestCWProxy get copyWith =>
      _$ResolveBranchRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResolveBranchRequest _$ResolveBranchRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ResolveBranchRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['latitude', 'longitude', 'org_id']);
  final val = ResolveBranchRequest(
    latitude: $checkedConvert('latitude', (v) => (v is String ? double.parse(v) : (v as num).toDouble())),
    longitude: $checkedConvert('longitude', (v) => (v is String ? double.parse(v) : (v as num).toDouble())),
    orgId: $checkedConvert('org_id', (v) => v as String),
  );
  return val;
}, fieldKeyMap: const {'orgId': 'org_id'});

Map<String, dynamic> _$ResolveBranchRequestToJson(
  ResolveBranchRequest instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'org_id': instance.orgId,
};
