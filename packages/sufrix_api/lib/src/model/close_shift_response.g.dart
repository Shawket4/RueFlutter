// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'close_shift_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CloseShiftResponseCWProxy {
  CloseShiftResponse shift(Shift shift);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CloseShiftResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CloseShiftResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  CloseShiftResponse call({Shift shift});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCloseShiftResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCloseShiftResponse.copyWith.fieldName(...)`
class _$CloseShiftResponseCWProxyImpl implements _$CloseShiftResponseCWProxy {
  const _$CloseShiftResponseCWProxyImpl(this._value);

  final CloseShiftResponse _value;

  @override
  CloseShiftResponse shift(Shift shift) => this(shift: shift);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CloseShiftResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CloseShiftResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  CloseShiftResponse call({Object? shift = const $CopyWithPlaceholder()}) {
    return CloseShiftResponse(
      shift: shift == const $CopyWithPlaceholder()
          ? _value.shift
          // ignore: cast_nullable_to_non_nullable
          : shift as Shift,
    );
  }
}

extension $CloseShiftResponseCopyWith on CloseShiftResponse {
  /// Returns a callable class that can be used as follows: `instanceOfCloseShiftResponse.copyWith(...)` or like so:`instanceOfCloseShiftResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CloseShiftResponseCWProxy get copyWith =>
      _$CloseShiftResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CloseShiftResponse _$CloseShiftResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CloseShiftResponse', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['shift']);
      final val = CloseShiftResponse(
        shift: $checkedConvert(
          'shift',
          (v) => Shift.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CloseShiftResponseToJson(CloseShiftResponse instance) =>
    <String, dynamic>{'shift': instance.shift.toJson()};
