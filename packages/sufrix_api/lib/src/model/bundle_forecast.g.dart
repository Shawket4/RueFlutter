// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bundle_forecast.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BundleForecastCWProxy {
  BundleForecast expectedVelocity(Triplet expectedVelocity);

  BundleForecast haloUnitsX(double haloUnitsX);

  BundleForecast incrementalCm(Triplet? incrementalCm);

  BundleForecast insideBundleUnitsX(double insideBundleUnitsX);

  BundleForecast totalUnitsUpliftX(double totalUnitsUpliftX);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BundleForecast(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BundleForecast(...).copyWith(id: 12, name: "My name")
  /// ````
  BundleForecast call({
    Triplet expectedVelocity,
    double haloUnitsX,
    Triplet? incrementalCm,
    double insideBundleUnitsX,
    double totalUnitsUpliftX,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBundleForecast.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBundleForecast.copyWith.fieldName(...)`
class _$BundleForecastCWProxyImpl implements _$BundleForecastCWProxy {
  const _$BundleForecastCWProxyImpl(this._value);

  final BundleForecast _value;

  @override
  BundleForecast expectedVelocity(Triplet expectedVelocity) =>
      this(expectedVelocity: expectedVelocity);

  @override
  BundleForecast haloUnitsX(double haloUnitsX) => this(haloUnitsX: haloUnitsX);

  @override
  BundleForecast incrementalCm(Triplet? incrementalCm) =>
      this(incrementalCm: incrementalCm);

  @override
  BundleForecast insideBundleUnitsX(double insideBundleUnitsX) =>
      this(insideBundleUnitsX: insideBundleUnitsX);

  @override
  BundleForecast totalUnitsUpliftX(double totalUnitsUpliftX) =>
      this(totalUnitsUpliftX: totalUnitsUpliftX);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BundleForecast(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BundleForecast(...).copyWith(id: 12, name: "My name")
  /// ````
  BundleForecast call({
    Object? expectedVelocity = const $CopyWithPlaceholder(),
    Object? haloUnitsX = const $CopyWithPlaceholder(),
    Object? incrementalCm = const $CopyWithPlaceholder(),
    Object? insideBundleUnitsX = const $CopyWithPlaceholder(),
    Object? totalUnitsUpliftX = const $CopyWithPlaceholder(),
  }) {
    return BundleForecast(
      expectedVelocity: expectedVelocity == const $CopyWithPlaceholder()
          ? _value.expectedVelocity
          // ignore: cast_nullable_to_non_nullable
          : expectedVelocity as Triplet,
      haloUnitsX: haloUnitsX == const $CopyWithPlaceholder()
          ? _value.haloUnitsX
          // ignore: cast_nullable_to_non_nullable
          : haloUnitsX as double,
      incrementalCm: incrementalCm == const $CopyWithPlaceholder()
          ? _value.incrementalCm
          // ignore: cast_nullable_to_non_nullable
          : incrementalCm as Triplet?,
      insideBundleUnitsX: insideBundleUnitsX == const $CopyWithPlaceholder()
          ? _value.insideBundleUnitsX
          // ignore: cast_nullable_to_non_nullable
          : insideBundleUnitsX as double,
      totalUnitsUpliftX: totalUnitsUpliftX == const $CopyWithPlaceholder()
          ? _value.totalUnitsUpliftX
          // ignore: cast_nullable_to_non_nullable
          : totalUnitsUpliftX as double,
    );
  }
}

extension $BundleForecastCopyWith on BundleForecast {
  /// Returns a callable class that can be used as follows: `instanceOfBundleForecast.copyWith(...)` or like so:`instanceOfBundleForecast.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BundleForecastCWProxy get copyWith => _$BundleForecastCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BundleForecast _$BundleForecastFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'BundleForecast',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'expected_velocity',
            'halo_units_x',
            'inside_bundle_units_x',
            'total_units_uplift_x',
          ],
        );
        final val = BundleForecast(
          expectedVelocity: $checkedConvert(
            'expected_velocity',
            (v) => Triplet.fromJson(v as Map<String, dynamic>),
          ),
          haloUnitsX: $checkedConvert(
            'halo_units_x',
            (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
          ),
          incrementalCm: $checkedConvert(
            'incremental_cm',
            (v) =>
                v == null ? null : Triplet.fromJson(v as Map<String, dynamic>),
          ),
          insideBundleUnitsX: $checkedConvert(
            'inside_bundle_units_x',
            (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
          ),
          totalUnitsUpliftX: $checkedConvert(
            'total_units_uplift_x',
            (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'expectedVelocity': 'expected_velocity',
        'haloUnitsX': 'halo_units_x',
        'incrementalCm': 'incremental_cm',
        'insideBundleUnitsX': 'inside_bundle_units_x',
        'totalUnitsUpliftX': 'total_units_uplift_x',
      },
    );

Map<String, dynamic> _$BundleForecastToJson(BundleForecast instance) =>
    <String, dynamic>{
      'expected_velocity': instance.expectedVelocity.toJson(),
      'halo_units_x': instance.haloUnitsX,
      'incremental_cm': ?instance.incrementalCm?.toJson(),
      'inside_bundle_units_x': instance.insideBundleUnitsX,
      'total_units_uplift_x': instance.totalUnitsUpliftX,
    };
