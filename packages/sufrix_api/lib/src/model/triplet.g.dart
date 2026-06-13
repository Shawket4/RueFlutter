// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'triplet.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TripletCWProxy {
  Triplet hi(double hi);

  Triplet lo(double lo);

  Triplet mid(double mid);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Triplet(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Triplet(...).copyWith(id: 12, name: "My name")
  /// ````
  Triplet call({double hi, double lo, double mid});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTriplet.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTriplet.copyWith.fieldName(...)`
class _$TripletCWProxyImpl implements _$TripletCWProxy {
  const _$TripletCWProxyImpl(this._value);

  final Triplet _value;

  @override
  Triplet hi(double hi) => this(hi: hi);

  @override
  Triplet lo(double lo) => this(lo: lo);

  @override
  Triplet mid(double mid) => this(mid: mid);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Triplet(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Triplet(...).copyWith(id: 12, name: "My name")
  /// ````
  Triplet call({
    Object? hi = const $CopyWithPlaceholder(),
    Object? lo = const $CopyWithPlaceholder(),
    Object? mid = const $CopyWithPlaceholder(),
  }) {
    return Triplet(
      hi: hi == const $CopyWithPlaceholder()
          ? _value.hi
          // ignore: cast_nullable_to_non_nullable
          : hi as double,
      lo: lo == const $CopyWithPlaceholder()
          ? _value.lo
          // ignore: cast_nullable_to_non_nullable
          : lo as double,
      mid: mid == const $CopyWithPlaceholder()
          ? _value.mid
          // ignore: cast_nullable_to_non_nullable
          : mid as double,
    );
  }
}

extension $TripletCopyWith on Triplet {
  /// Returns a callable class that can be used as follows: `instanceOfTriplet.copyWith(...)` or like so:`instanceOfTriplet.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TripletCWProxy get copyWith => _$TripletCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Triplet _$TripletFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Triplet', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['hi', 'lo', 'mid']);
      final val = Triplet(
        hi: $checkedConvert('hi', (v) => (v is String ? double.parse(v) : (v as num).toDouble())),
        lo: $checkedConvert('lo', (v) => (v is String ? double.parse(v) : (v as num).toDouble())),
        mid: $checkedConvert('mid', (v) => (v is String ? double.parse(v) : (v as num).toDouble())),
      );
      return val;
    });

Map<String, dynamic> _$TripletToJson(Triplet instance) => <String, dynamic>{
  'hi': instance.hi,
  'lo': instance.lo,
  'mid': instance.mid,
};
