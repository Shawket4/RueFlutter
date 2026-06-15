// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_request_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OtpRequestResponseCWProxy {
  OtpRequestResponse sent(bool sent);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OtpRequestResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OtpRequestResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  OtpRequestResponse call({bool sent});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOtpRequestResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOtpRequestResponse.copyWith.fieldName(...)`
class _$OtpRequestResponseCWProxyImpl implements _$OtpRequestResponseCWProxy {
  const _$OtpRequestResponseCWProxyImpl(this._value);

  final OtpRequestResponse _value;

  @override
  OtpRequestResponse sent(bool sent) => this(sent: sent);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OtpRequestResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OtpRequestResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  OtpRequestResponse call({Object? sent = const $CopyWithPlaceholder()}) {
    return OtpRequestResponse(
      sent: sent == const $CopyWithPlaceholder()
          ? _value.sent
          // ignore: cast_nullable_to_non_nullable
          : sent as bool,
    );
  }
}

extension $OtpRequestResponseCopyWith on OtpRequestResponse {
  /// Returns a callable class that can be used as follows: `instanceOfOtpRequestResponse.copyWith(...)` or like so:`instanceOfOtpRequestResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OtpRequestResponseCWProxy get copyWith =>
      _$OtpRequestResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpRequestResponse _$OtpRequestResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OtpRequestResponse', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['sent']);
      final val = OtpRequestResponse(
        sent: $checkedConvert('sent', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$OtpRequestResponseToJson(OtpRequestResponse instance) =>
    <String, dynamic>{'sent': instance.sent};
