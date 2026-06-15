// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_verify_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OtpVerifyInputCWProxy {
  OtpVerifyInput code(String code);

  OtpVerifyInput phone(String phone);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OtpVerifyInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OtpVerifyInput(...).copyWith(id: 12, name: "My name")
  /// ````
  OtpVerifyInput call({String code, String phone});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOtpVerifyInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOtpVerifyInput.copyWith.fieldName(...)`
class _$OtpVerifyInputCWProxyImpl implements _$OtpVerifyInputCWProxy {
  const _$OtpVerifyInputCWProxyImpl(this._value);

  final OtpVerifyInput _value;

  @override
  OtpVerifyInput code(String code) => this(code: code);

  @override
  OtpVerifyInput phone(String phone) => this(phone: phone);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OtpVerifyInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OtpVerifyInput(...).copyWith(id: 12, name: "My name")
  /// ````
  OtpVerifyInput call({
    Object? code = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
  }) {
    return OtpVerifyInput(
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String,
    );
  }
}

extension $OtpVerifyInputCopyWith on OtpVerifyInput {
  /// Returns a callable class that can be used as follows: `instanceOfOtpVerifyInput.copyWith(...)` or like so:`instanceOfOtpVerifyInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OtpVerifyInputCWProxy get copyWith => _$OtpVerifyInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpVerifyInput _$OtpVerifyInputFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OtpVerifyInput', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['code', 'phone']);
      final val = OtpVerifyInput(
        code: $checkedConvert('code', (v) => v as String),
        phone: $checkedConvert('phone', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$OtpVerifyInputToJson(OtpVerifyInput instance) =>
    <String, dynamic>{'code': instance.code, 'phone': instance.phone};
