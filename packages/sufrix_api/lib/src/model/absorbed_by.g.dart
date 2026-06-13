// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absorbed_by.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AbsorbedByCWProxy {
  AbsorbedBy absorbedCm(double absorbedCm);

  AbsorbedBy absorbedUnits(double absorbedUnits);

  AbsorbedBy key(ItemKey key);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AbsorbedBy(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AbsorbedBy(...).copyWith(id: 12, name: "My name")
  /// ````
  AbsorbedBy call({double absorbedCm, double absorbedUnits, ItemKey key});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAbsorbedBy.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAbsorbedBy.copyWith.fieldName(...)`
class _$AbsorbedByCWProxyImpl implements _$AbsorbedByCWProxy {
  const _$AbsorbedByCWProxyImpl(this._value);

  final AbsorbedBy _value;

  @override
  AbsorbedBy absorbedCm(double absorbedCm) => this(absorbedCm: absorbedCm);

  @override
  AbsorbedBy absorbedUnits(double absorbedUnits) =>
      this(absorbedUnits: absorbedUnits);

  @override
  AbsorbedBy key(ItemKey key) => this(key: key);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AbsorbedBy(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AbsorbedBy(...).copyWith(id: 12, name: "My name")
  /// ````
  AbsorbedBy call({
    Object? absorbedCm = const $CopyWithPlaceholder(),
    Object? absorbedUnits = const $CopyWithPlaceholder(),
    Object? key = const $CopyWithPlaceholder(),
  }) {
    return AbsorbedBy(
      absorbedCm: absorbedCm == const $CopyWithPlaceholder()
          ? _value.absorbedCm
          // ignore: cast_nullable_to_non_nullable
          : absorbedCm as double,
      absorbedUnits: absorbedUnits == const $CopyWithPlaceholder()
          ? _value.absorbedUnits
          // ignore: cast_nullable_to_non_nullable
          : absorbedUnits as double,
      key: key == const $CopyWithPlaceholder()
          ? _value.key
          // ignore: cast_nullable_to_non_nullable
          : key as ItemKey,
    );
  }
}

extension $AbsorbedByCopyWith on AbsorbedBy {
  /// Returns a callable class that can be used as follows: `instanceOfAbsorbedBy.copyWith(...)` or like so:`instanceOfAbsorbedBy.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AbsorbedByCWProxy get copyWith => _$AbsorbedByCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AbsorbedBy _$AbsorbedByFromJson(Map<String, dynamic> json) => $checkedCreate(
  'AbsorbedBy',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['absorbed_cm', 'absorbed_units', 'key'],
    );
    final val = AbsorbedBy(
      absorbedCm: $checkedConvert('absorbed_cm', (v) => (v is String ? double.parse(v) : (v as num).toDouble())),
      absorbedUnits: $checkedConvert(
        'absorbed_units',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
      key: $checkedConvert(
        'key',
        (v) => ItemKey.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'absorbedCm': 'absorbed_cm',
    'absorbedUnits': 'absorbed_units',
  },
);

Map<String, dynamic> _$AbsorbedByToJson(AbsorbedBy instance) =>
    <String, dynamic>{
      'absorbed_cm': instance.absorbedCm,
      'absorbed_units': instance.absorbedUnits,
      'key': instance.key.toJson(),
    };
