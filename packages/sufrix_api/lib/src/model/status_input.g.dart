// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StatusInputCWProxy {
  StatusInput status(String status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StatusInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StatusInput(...).copyWith(id: 12, name: "My name")
  /// ````
  StatusInput call({String status});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStatusInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStatusInput.copyWith.fieldName(...)`
class _$StatusInputCWProxyImpl implements _$StatusInputCWProxy {
  const _$StatusInputCWProxyImpl(this._value);

  final StatusInput _value;

  @override
  StatusInput status(String status) => this(status: status);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StatusInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StatusInput(...).copyWith(id: 12, name: "My name")
  /// ````
  StatusInput call({Object? status = const $CopyWithPlaceholder()}) {
    return StatusInput(
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String,
    );
  }
}

extension $StatusInputCopyWith on StatusInput {
  /// Returns a callable class that can be used as follows: `instanceOfStatusInput.copyWith(...)` or like so:`instanceOfStatusInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StatusInputCWProxy get copyWith => _$StatusInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusInput _$StatusInputFromJson(Map<String, dynamic> json) =>
    $checkedCreate('StatusInput', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['status']);
      final val = StatusInput(
        status: $checkedConvert('status', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$StatusInputToJson(StatusInput instance) =>
    <String, dynamic>{'status': instance.status};
