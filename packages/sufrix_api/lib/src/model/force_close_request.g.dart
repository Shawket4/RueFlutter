// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'force_close_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ForceCloseRequestCWProxy {
  ForceCloseRequest reason(String? reason);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ForceCloseRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ForceCloseRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ForceCloseRequest call({String? reason});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfForceCloseRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfForceCloseRequest.copyWith.fieldName(...)`
class _$ForceCloseRequestCWProxyImpl implements _$ForceCloseRequestCWProxy {
  const _$ForceCloseRequestCWProxyImpl(this._value);

  final ForceCloseRequest _value;

  @override
  ForceCloseRequest reason(String? reason) => this(reason: reason);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ForceCloseRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ForceCloseRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ForceCloseRequest call({Object? reason = const $CopyWithPlaceholder()}) {
    return ForceCloseRequest(
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String?,
    );
  }
}

extension $ForceCloseRequestCopyWith on ForceCloseRequest {
  /// Returns a callable class that can be used as follows: `instanceOfForceCloseRequest.copyWith(...)` or like so:`instanceOfForceCloseRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ForceCloseRequestCWProxy get copyWith =>
      _$ForceCloseRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForceCloseRequest _$ForceCloseRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ForceCloseRequest', json, ($checkedConvert) {
      final val = ForceCloseRequest(
        reason: $checkedConvert('reason', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ForceCloseRequestToJson(ForceCloseRequest instance) =>
    <String, dynamic>{'reason': ?instance.reason};
