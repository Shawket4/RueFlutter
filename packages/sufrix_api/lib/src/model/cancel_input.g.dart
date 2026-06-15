// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CancelInputCWProxy {
  CancelInput reason(String? reason);

  CancelInput restoreInventory(bool? restoreInventory);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CancelInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CancelInput(...).copyWith(id: 12, name: "My name")
  /// ````
  CancelInput call({String? reason, bool? restoreInventory});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCancelInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCancelInput.copyWith.fieldName(...)`
class _$CancelInputCWProxyImpl implements _$CancelInputCWProxy {
  const _$CancelInputCWProxyImpl(this._value);

  final CancelInput _value;

  @override
  CancelInput reason(String? reason) => this(reason: reason);

  @override
  CancelInput restoreInventory(bool? restoreInventory) =>
      this(restoreInventory: restoreInventory);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CancelInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CancelInput(...).copyWith(id: 12, name: "My name")
  /// ````
  CancelInput call({
    Object? reason = const $CopyWithPlaceholder(),
    Object? restoreInventory = const $CopyWithPlaceholder(),
  }) {
    return CancelInput(
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String?,
      restoreInventory: restoreInventory == const $CopyWithPlaceholder()
          ? _value.restoreInventory
          // ignore: cast_nullable_to_non_nullable
          : restoreInventory as bool?,
    );
  }
}

extension $CancelInputCopyWith on CancelInput {
  /// Returns a callable class that can be used as follows: `instanceOfCancelInput.copyWith(...)` or like so:`instanceOfCancelInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CancelInputCWProxy get copyWith => _$CancelInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelInput _$CancelInputFromJson(Map<String, dynamic> json) => $checkedCreate(
  'CancelInput',
  json,
  ($checkedConvert) {
    final val = CancelInput(
      reason: $checkedConvert('reason', (v) => v as String?),
      restoreInventory: $checkedConvert('restore_inventory', (v) => v as bool?),
    );
    return val;
  },
  fieldKeyMap: const {'restoreInventory': 'restore_inventory'},
);

Map<String, dynamic> _$CancelInputToJson(CancelInput instance) =>
    <String, dynamic>{
      'reason': ?instance.reason,
      'restore_inventory': ?instance.restoreInventory,
    };
