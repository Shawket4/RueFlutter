// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_anchors.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PriceAnchorsCWProxy {
  PriceAnchors costPlus(double? costPlus);

  PriceAnchors peerMedian(double peerMedian);

  PriceAnchors statusQuo(double statusQuo);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PriceAnchors(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PriceAnchors(...).copyWith(id: 12, name: "My name")
  /// ````
  PriceAnchors call({double? costPlus, double peerMedian, double statusQuo});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPriceAnchors.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPriceAnchors.copyWith.fieldName(...)`
class _$PriceAnchorsCWProxyImpl implements _$PriceAnchorsCWProxy {
  const _$PriceAnchorsCWProxyImpl(this._value);

  final PriceAnchors _value;

  @override
  PriceAnchors costPlus(double? costPlus) => this(costPlus: costPlus);

  @override
  PriceAnchors peerMedian(double peerMedian) => this(peerMedian: peerMedian);

  @override
  PriceAnchors statusQuo(double statusQuo) => this(statusQuo: statusQuo);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PriceAnchors(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PriceAnchors(...).copyWith(id: 12, name: "My name")
  /// ````
  PriceAnchors call({
    Object? costPlus = const $CopyWithPlaceholder(),
    Object? peerMedian = const $CopyWithPlaceholder(),
    Object? statusQuo = const $CopyWithPlaceholder(),
  }) {
    return PriceAnchors(
      costPlus: costPlus == const $CopyWithPlaceholder()
          ? _value.costPlus
          // ignore: cast_nullable_to_non_nullable
          : costPlus as double?,
      peerMedian: peerMedian == const $CopyWithPlaceholder()
          ? _value.peerMedian
          // ignore: cast_nullable_to_non_nullable
          : peerMedian as double,
      statusQuo: statusQuo == const $CopyWithPlaceholder()
          ? _value.statusQuo
          // ignore: cast_nullable_to_non_nullable
          : statusQuo as double,
    );
  }
}

extension $PriceAnchorsCopyWith on PriceAnchors {
  /// Returns a callable class that can be used as follows: `instanceOfPriceAnchors.copyWith(...)` or like so:`instanceOfPriceAnchors.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PriceAnchorsCWProxy get copyWith => _$PriceAnchorsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceAnchors _$PriceAnchorsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'PriceAnchors',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['peer_median', 'status_quo']);
    final val = PriceAnchors(
      costPlus: $checkedConvert('cost_plus', (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble())),
      peerMedian: $checkedConvert('peer_median', (v) => (v is String ? double.parse(v) : (v as num).toDouble())),
      statusQuo: $checkedConvert('status_quo', (v) => (v is String ? double.parse(v) : (v as num).toDouble())),
    );
    return val;
  },
  fieldKeyMap: const {
    'costPlus': 'cost_plus',
    'peerMedian': 'peer_median',
    'statusQuo': 'status_quo',
  },
);

Map<String, dynamic> _$PriceAnchorsToJson(PriceAnchors instance) =>
    <String, dynamic>{
      'cost_plus': ?instance.costPlus,
      'peer_median': instance.peerMedian,
      'status_quo': instance.statusQuo,
    };
