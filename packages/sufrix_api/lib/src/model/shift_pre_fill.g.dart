// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_pre_fill.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ShiftPreFillCWProxy {
  ShiftPreFill hasOpenShift(bool hasOpenShift);

  ShiftPreFill openShift(Shift? openShift);

  ShiftPreFill suggestedOpeningCash(int suggestedOpeningCash);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ShiftPreFill(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ShiftPreFill(...).copyWith(id: 12, name: "My name")
  /// ````
  ShiftPreFill call({
    bool hasOpenShift,
    Shift? openShift,
    int suggestedOpeningCash,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfShiftPreFill.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfShiftPreFill.copyWith.fieldName(...)`
class _$ShiftPreFillCWProxyImpl implements _$ShiftPreFillCWProxy {
  const _$ShiftPreFillCWProxyImpl(this._value);

  final ShiftPreFill _value;

  @override
  ShiftPreFill hasOpenShift(bool hasOpenShift) =>
      this(hasOpenShift: hasOpenShift);

  @override
  ShiftPreFill openShift(Shift? openShift) => this(openShift: openShift);

  @override
  ShiftPreFill suggestedOpeningCash(int suggestedOpeningCash) =>
      this(suggestedOpeningCash: suggestedOpeningCash);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ShiftPreFill(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ShiftPreFill(...).copyWith(id: 12, name: "My name")
  /// ````
  ShiftPreFill call({
    Object? hasOpenShift = const $CopyWithPlaceholder(),
    Object? openShift = const $CopyWithPlaceholder(),
    Object? suggestedOpeningCash = const $CopyWithPlaceholder(),
  }) {
    return ShiftPreFill(
      hasOpenShift: hasOpenShift == const $CopyWithPlaceholder()
          ? _value.hasOpenShift
          // ignore: cast_nullable_to_non_nullable
          : hasOpenShift as bool,
      openShift: openShift == const $CopyWithPlaceholder()
          ? _value.openShift
          // ignore: cast_nullable_to_non_nullable
          : openShift as Shift?,
      suggestedOpeningCash: suggestedOpeningCash == const $CopyWithPlaceholder()
          ? _value.suggestedOpeningCash
          // ignore: cast_nullable_to_non_nullable
          : suggestedOpeningCash as int,
    );
  }
}

extension $ShiftPreFillCopyWith on ShiftPreFill {
  /// Returns a callable class that can be used as follows: `instanceOfShiftPreFill.copyWith(...)` or like so:`instanceOfShiftPreFill.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ShiftPreFillCWProxy get copyWith => _$ShiftPreFillCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShiftPreFill _$ShiftPreFillFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ShiftPreFill',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['has_open_shift', 'suggested_opening_cash'],
        );
        final val = ShiftPreFill(
          hasOpenShift: $checkedConvert('has_open_shift', (v) => v as bool),
          openShift: $checkedConvert(
            'open_shift',
            (v) => v == null ? null : Shift.fromJson(v as Map<String, dynamic>),
          ),
          suggestedOpeningCash: $checkedConvert(
            'suggested_opening_cash',
            (v) => (v as num).toInt(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'hasOpenShift': 'has_open_shift',
        'openShift': 'open_shift',
        'suggestedOpeningCash': 'suggested_opening_cash',
      },
    );

Map<String, dynamic> _$ShiftPreFillToJson(ShiftPreFill instance) =>
    <String, dynamic>{
      'has_open_shift': instance.hasOpenShift,
      'open_shift': ?instance.openShift?.toJson(),
      'suggested_opening_cash': instance.suggestedOpeningCash,
    };
