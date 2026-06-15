// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accepting_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AcceptingInputCWProxy {
  AcceptingInput branchId(String branchId);

  AcceptingInput channel(String channel);

  AcceptingInput mode(String mode);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AcceptingInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AcceptingInput(...).copyWith(id: 12, name: "My name")
  /// ````
  AcceptingInput call({String branchId, String channel, String mode});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAcceptingInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAcceptingInput.copyWith.fieldName(...)`
class _$AcceptingInputCWProxyImpl implements _$AcceptingInputCWProxy {
  const _$AcceptingInputCWProxyImpl(this._value);

  final AcceptingInput _value;

  @override
  AcceptingInput branchId(String branchId) => this(branchId: branchId);

  @override
  AcceptingInput channel(String channel) => this(channel: channel);

  @override
  AcceptingInput mode(String mode) => this(mode: mode);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AcceptingInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AcceptingInput(...).copyWith(id: 12, name: "My name")
  /// ````
  AcceptingInput call({
    Object? branchId = const $CopyWithPlaceholder(),
    Object? channel = const $CopyWithPlaceholder(),
    Object? mode = const $CopyWithPlaceholder(),
  }) {
    return AcceptingInput(
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String,
      channel: channel == const $CopyWithPlaceholder()
          ? _value.channel
          // ignore: cast_nullable_to_non_nullable
          : channel as String,
      mode: mode == const $CopyWithPlaceholder()
          ? _value.mode
          // ignore: cast_nullable_to_non_nullable
          : mode as String,
    );
  }
}

extension $AcceptingInputCopyWith on AcceptingInput {
  /// Returns a callable class that can be used as follows: `instanceOfAcceptingInput.copyWith(...)` or like so:`instanceOfAcceptingInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AcceptingInputCWProxy get copyWith => _$AcceptingInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcceptingInput _$AcceptingInputFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AcceptingInput', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['branch_id', 'channel', 'mode']);
      final val = AcceptingInput(
        branchId: $checkedConvert('branch_id', (v) => v as String),
        channel: $checkedConvert('channel', (v) => v as String),
        mode: $checkedConvert('mode', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'branchId': 'branch_id'});

Map<String, dynamic> _$AcceptingInputToJson(AcceptingInput instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'channel': instance.channel,
      'mode': instance.mode,
    };
