// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finalize_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FinalizeInputCWProxy {
  FinalizeInput paymentMethod(String paymentMethod);

  FinalizeInput shiftId(String shiftId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FinalizeInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FinalizeInput(...).copyWith(id: 12, name: "My name")
  /// ````
  FinalizeInput call({String paymentMethod, String shiftId});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfFinalizeInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfFinalizeInput.copyWith.fieldName(...)`
class _$FinalizeInputCWProxyImpl implements _$FinalizeInputCWProxy {
  const _$FinalizeInputCWProxyImpl(this._value);

  final FinalizeInput _value;

  @override
  FinalizeInput paymentMethod(String paymentMethod) =>
      this(paymentMethod: paymentMethod);

  @override
  FinalizeInput shiftId(String shiftId) => this(shiftId: shiftId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FinalizeInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FinalizeInput(...).copyWith(id: 12, name: "My name")
  /// ````
  FinalizeInput call({
    Object? paymentMethod = const $CopyWithPlaceholder(),
    Object? shiftId = const $CopyWithPlaceholder(),
  }) {
    return FinalizeInput(
      paymentMethod: paymentMethod == const $CopyWithPlaceholder()
          ? _value.paymentMethod
          // ignore: cast_nullable_to_non_nullable
          : paymentMethod as String,
      shiftId: shiftId == const $CopyWithPlaceholder()
          ? _value.shiftId
          // ignore: cast_nullable_to_non_nullable
          : shiftId as String,
    );
  }
}

extension $FinalizeInputCopyWith on FinalizeInput {
  /// Returns a callable class that can be used as follows: `instanceOfFinalizeInput.copyWith(...)` or like so:`instanceOfFinalizeInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FinalizeInputCWProxy get copyWith => _$FinalizeInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinalizeInput _$FinalizeInputFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'FinalizeInput',
      json,
      ($checkedConvert) {
        $checkKeys(json, requiredKeys: const ['payment_method', 'shift_id']);
        final val = FinalizeInput(
          paymentMethod: $checkedConvert('payment_method', (v) => v as String),
          shiftId: $checkedConvert('shift_id', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'paymentMethod': 'payment_method',
        'shiftId': 'shift_id',
      },
    );

Map<String, dynamic> _$FinalizeInputToJson(FinalizeInput instance) =>
    <String, dynamic>{
      'payment_method': instance.paymentMethod,
      'shift_id': instance.shiftId,
    };
