// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prep_time_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PrepTimeInputCWProxy {
  PrepTimeInput extraPrepMinutes(int extraPrepMinutes);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PrepTimeInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PrepTimeInput(...).copyWith(id: 12, name: "My name")
  /// ````
  PrepTimeInput call({int extraPrepMinutes});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPrepTimeInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPrepTimeInput.copyWith.fieldName(...)`
class _$PrepTimeInputCWProxyImpl implements _$PrepTimeInputCWProxy {
  const _$PrepTimeInputCWProxyImpl(this._value);

  final PrepTimeInput _value;

  @override
  PrepTimeInput extraPrepMinutes(int extraPrepMinutes) =>
      this(extraPrepMinutes: extraPrepMinutes);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PrepTimeInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PrepTimeInput(...).copyWith(id: 12, name: "My name")
  /// ````
  PrepTimeInput call({
    Object? extraPrepMinutes = const $CopyWithPlaceholder(),
  }) {
    return PrepTimeInput(
      extraPrepMinutes: extraPrepMinutes == const $CopyWithPlaceholder()
          ? _value.extraPrepMinutes
          // ignore: cast_nullable_to_non_nullable
          : extraPrepMinutes as int,
    );
  }
}

extension $PrepTimeInputCopyWith on PrepTimeInput {
  /// Returns a callable class that can be used as follows: `instanceOfPrepTimeInput.copyWith(...)` or like so:`instanceOfPrepTimeInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PrepTimeInputCWProxy get copyWith => _$PrepTimeInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrepTimeInput _$PrepTimeInputFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PrepTimeInput',
      json,
      ($checkedConvert) {
        $checkKeys(json, requiredKeys: const ['extra_prep_minutes']);
        final val = PrepTimeInput(
          extraPrepMinutes: $checkedConvert(
            'extra_prep_minutes',
            (v) => (v as num).toInt(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {'extraPrepMinutes': 'extra_prep_minutes'},
    );

Map<String, dynamic> _$PrepTimeInputToJson(PrepTimeInput instance) =>
    <String, dynamic>{'extra_prep_minutes': instance.extraPrepMinutes};
