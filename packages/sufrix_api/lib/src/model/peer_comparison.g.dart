// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peer_comparison.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PeerComparisonCWProxy {
  PeerComparison medianCmPerUnitPeers(double? medianCmPerUnitPeers);

  PeerComparison medianEffectivePricePeers(double medianEffectivePricePeers);

  PeerComparison medianMarginPctPeers(double? medianMarginPctPeers);

  PeerComparison sameCategoryCount(int sameCategoryCount);

  PeerComparison yourPosition(PeerPosition yourPosition);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PeerComparison(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PeerComparison(...).copyWith(id: 12, name: "My name")
  /// ````
  PeerComparison call({
    double? medianCmPerUnitPeers,
    double medianEffectivePricePeers,
    double? medianMarginPctPeers,
    int sameCategoryCount,
    PeerPosition yourPosition,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPeerComparison.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPeerComparison.copyWith.fieldName(...)`
class _$PeerComparisonCWProxyImpl implements _$PeerComparisonCWProxy {
  const _$PeerComparisonCWProxyImpl(this._value);

  final PeerComparison _value;

  @override
  PeerComparison medianCmPerUnitPeers(double? medianCmPerUnitPeers) =>
      this(medianCmPerUnitPeers: medianCmPerUnitPeers);

  @override
  PeerComparison medianEffectivePricePeers(double medianEffectivePricePeers) =>
      this(medianEffectivePricePeers: medianEffectivePricePeers);

  @override
  PeerComparison medianMarginPctPeers(double? medianMarginPctPeers) =>
      this(medianMarginPctPeers: medianMarginPctPeers);

  @override
  PeerComparison sameCategoryCount(int sameCategoryCount) =>
      this(sameCategoryCount: sameCategoryCount);

  @override
  PeerComparison yourPosition(PeerPosition yourPosition) =>
      this(yourPosition: yourPosition);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PeerComparison(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PeerComparison(...).copyWith(id: 12, name: "My name")
  /// ````
  PeerComparison call({
    Object? medianCmPerUnitPeers = const $CopyWithPlaceholder(),
    Object? medianEffectivePricePeers = const $CopyWithPlaceholder(),
    Object? medianMarginPctPeers = const $CopyWithPlaceholder(),
    Object? sameCategoryCount = const $CopyWithPlaceholder(),
    Object? yourPosition = const $CopyWithPlaceholder(),
  }) {
    return PeerComparison(
      medianCmPerUnitPeers: medianCmPerUnitPeers == const $CopyWithPlaceholder()
          ? _value.medianCmPerUnitPeers
          // ignore: cast_nullable_to_non_nullable
          : medianCmPerUnitPeers as double?,
      medianEffectivePricePeers:
          medianEffectivePricePeers == const $CopyWithPlaceholder()
          ? _value.medianEffectivePricePeers
          // ignore: cast_nullable_to_non_nullable
          : medianEffectivePricePeers as double,
      medianMarginPctPeers: medianMarginPctPeers == const $CopyWithPlaceholder()
          ? _value.medianMarginPctPeers
          // ignore: cast_nullable_to_non_nullable
          : medianMarginPctPeers as double?,
      sameCategoryCount: sameCategoryCount == const $CopyWithPlaceholder()
          ? _value.sameCategoryCount
          // ignore: cast_nullable_to_non_nullable
          : sameCategoryCount as int,
      yourPosition: yourPosition == const $CopyWithPlaceholder()
          ? _value.yourPosition
          // ignore: cast_nullable_to_non_nullable
          : yourPosition as PeerPosition,
    );
  }
}

extension $PeerComparisonCopyWith on PeerComparison {
  /// Returns a callable class that can be used as follows: `instanceOfPeerComparison.copyWith(...)` or like so:`instanceOfPeerComparison.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PeerComparisonCWProxy get copyWith => _$PeerComparisonCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeerComparison _$PeerComparisonFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PeerComparison',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'median_effective_price_peers',
            'same_category_count',
            'your_position',
          ],
        );
        final val = PeerComparison(
          medianCmPerUnitPeers: $checkedConvert(
            'median_cm_per_unit_peers',
            (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble()),
          ),
          medianEffectivePricePeers: $checkedConvert(
            'median_effective_price_peers',
            (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
          ),
          medianMarginPctPeers: $checkedConvert(
            'median_margin_pct_peers',
            (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble()),
          ),
          sameCategoryCount: $checkedConvert(
            'same_category_count',
            (v) => (v as num).toInt(),
          ),
          yourPosition: $checkedConvert(
            'your_position',
            (v) => $enumDecode(
              _$PeerPositionEnumMap,
              v,
              unknownValue: PeerPosition.unknownDefaultOpenApi,
            ),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'medianCmPerUnitPeers': 'median_cm_per_unit_peers',
        'medianEffectivePricePeers': 'median_effective_price_peers',
        'medianMarginPctPeers': 'median_margin_pct_peers',
        'sameCategoryCount': 'same_category_count',
        'yourPosition': 'your_position',
      },
    );

Map<String, dynamic> _$PeerComparisonToJson(PeerComparison instance) =>
    <String, dynamic>{
      'median_cm_per_unit_peers': ?instance.medianCmPerUnitPeers,
      'median_effective_price_peers': instance.medianEffectivePricePeers,
      'median_margin_pct_peers': ?instance.medianMarginPctPeers,
      'same_category_count': instance.sameCategoryCount,
      'your_position': _$PeerPositionEnumMap[instance.yourPosition]!,
    };

const _$PeerPositionEnumMap = {
  PeerPosition.above: 'above',
  PeerPosition.at: 'at',
  PeerPosition.below: 'below',
  PeerPosition.unknownDefaultOpenApi: 'unknown_default_open_api',
};
