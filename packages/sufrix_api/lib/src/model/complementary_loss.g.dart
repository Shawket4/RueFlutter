// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complementary_loss.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ComplementaryLossCWProxy {
  ComplementaryLoss key(ItemKey key);

  ComplementaryLoss lostCm(double lostCm);

  ComplementaryLoss lostUnits(double lostUnits);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ComplementaryLoss(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ComplementaryLoss(...).copyWith(id: 12, name: "My name")
  /// ````
  ComplementaryLoss call({ItemKey key, double lostCm, double lostUnits});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfComplementaryLoss.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfComplementaryLoss.copyWith.fieldName(...)`
class _$ComplementaryLossCWProxyImpl implements _$ComplementaryLossCWProxy {
  const _$ComplementaryLossCWProxyImpl(this._value);

  final ComplementaryLoss _value;

  @override
  ComplementaryLoss key(ItemKey key) => this(key: key);

  @override
  ComplementaryLoss lostCm(double lostCm) => this(lostCm: lostCm);

  @override
  ComplementaryLoss lostUnits(double lostUnits) => this(lostUnits: lostUnits);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ComplementaryLoss(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ComplementaryLoss(...).copyWith(id: 12, name: "My name")
  /// ````
  ComplementaryLoss call({
    Object? key = const $CopyWithPlaceholder(),
    Object? lostCm = const $CopyWithPlaceholder(),
    Object? lostUnits = const $CopyWithPlaceholder(),
  }) {
    return ComplementaryLoss(
      key: key == const $CopyWithPlaceholder()
          ? _value.key
          // ignore: cast_nullable_to_non_nullable
          : key as ItemKey,
      lostCm: lostCm == const $CopyWithPlaceholder()
          ? _value.lostCm
          // ignore: cast_nullable_to_non_nullable
          : lostCm as double,
      lostUnits: lostUnits == const $CopyWithPlaceholder()
          ? _value.lostUnits
          // ignore: cast_nullable_to_non_nullable
          : lostUnits as double,
    );
  }
}

extension $ComplementaryLossCopyWith on ComplementaryLoss {
  /// Returns a callable class that can be used as follows: `instanceOfComplementaryLoss.copyWith(...)` or like so:`instanceOfComplementaryLoss.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ComplementaryLossCWProxy get copyWith =>
      _$ComplementaryLossCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplementaryLoss _$ComplementaryLossFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ComplementaryLoss',
      json,
      ($checkedConvert) {
        $checkKeys(json, requiredKeys: const ['key', 'lost_cm', 'lost_units']);
        final val = ComplementaryLoss(
          key: $checkedConvert(
            'key',
            (v) => ItemKey.fromJson(v as Map<String, dynamic>),
          ),
          lostCm: $checkedConvert('lost_cm', (v) => (v is String ? double.parse(v) : (v as num).toDouble())),
          lostUnits: $checkedConvert(
            'lost_units',
            (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
          ),
        );
        return val;
      },
      fieldKeyMap: const {'lostCm': 'lost_cm', 'lostUnits': 'lost_units'},
    );

Map<String, dynamic> _$ComplementaryLossToJson(ComplementaryLoss instance) =>
    <String, dynamic>{
      'key': instance.key.toJson(),
      'lost_cm': instance.lostCm,
      'lost_units': instance.lostUnits,
    };
