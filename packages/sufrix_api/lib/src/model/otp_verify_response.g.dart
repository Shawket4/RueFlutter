// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_verify_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OtpVerifyResponseCWProxy {
  OtpVerifyResponse deviceToken(String deviceToken);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OtpVerifyResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OtpVerifyResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  OtpVerifyResponse call({String deviceToken});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOtpVerifyResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOtpVerifyResponse.copyWith.fieldName(...)`
class _$OtpVerifyResponseCWProxyImpl implements _$OtpVerifyResponseCWProxy {
  const _$OtpVerifyResponseCWProxyImpl(this._value);

  final OtpVerifyResponse _value;

  @override
  OtpVerifyResponse deviceToken(String deviceToken) =>
      this(deviceToken: deviceToken);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OtpVerifyResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OtpVerifyResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  OtpVerifyResponse call({Object? deviceToken = const $CopyWithPlaceholder()}) {
    return OtpVerifyResponse(
      deviceToken: deviceToken == const $CopyWithPlaceholder()
          ? _value.deviceToken
          // ignore: cast_nullable_to_non_nullable
          : deviceToken as String,
    );
  }
}

extension $OtpVerifyResponseCopyWith on OtpVerifyResponse {
  /// Returns a callable class that can be used as follows: `instanceOfOtpVerifyResponse.copyWith(...)` or like so:`instanceOfOtpVerifyResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OtpVerifyResponseCWProxy get copyWith =>
      _$OtpVerifyResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpVerifyResponse _$OtpVerifyResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OtpVerifyResponse', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['device_token']);
      final val = OtpVerifyResponse(
        deviceToken: $checkedConvert('device_token', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'deviceToken': 'device_token'});

Map<String, dynamic> _$OtpVerifyResponseToJson(OtpVerifyResponse instance) =>
    <String, dynamic>{'device_token': instance.deviceToken};
