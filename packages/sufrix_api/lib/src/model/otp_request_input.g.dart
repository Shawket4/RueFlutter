// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_request_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OtpRequestInputCWProxy {
  OtpRequestInput phone(String phone);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OtpRequestInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OtpRequestInput(...).copyWith(id: 12, name: "My name")
  /// ````
  OtpRequestInput call({String phone});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOtpRequestInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOtpRequestInput.copyWith.fieldName(...)`
class _$OtpRequestInputCWProxyImpl implements _$OtpRequestInputCWProxy {
  const _$OtpRequestInputCWProxyImpl(this._value);

  final OtpRequestInput _value;

  @override
  OtpRequestInput phone(String phone) => this(phone: phone);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OtpRequestInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OtpRequestInput(...).copyWith(id: 12, name: "My name")
  /// ````
  OtpRequestInput call({Object? phone = const $CopyWithPlaceholder()}) {
    return OtpRequestInput(
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String,
    );
  }
}

extension $OtpRequestInputCopyWith on OtpRequestInput {
  /// Returns a callable class that can be used as follows: `instanceOfOtpRequestInput.copyWith(...)` or like so:`instanceOfOtpRequestInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OtpRequestInputCWProxy get copyWith => _$OtpRequestInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpRequestInput _$OtpRequestInputFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OtpRequestInput', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['phone']);
      final val = OtpRequestInput(
        phone: $checkedConvert('phone', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$OtpRequestInputToJson(OtpRequestInput instance) =>
    <String, dynamic>{'phone': instance.phone};
