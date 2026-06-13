// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bundle_association.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BundleAssociationCWProxy {
  BundleAssociation compositeScore(double compositeScore);

  BundleAssociation pairLifts(List<BundleItemPair> pairLifts);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BundleAssociation(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BundleAssociation(...).copyWith(id: 12, name: "My name")
  /// ````
  BundleAssociation call({
    double compositeScore,
    List<BundleItemPair> pairLifts,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBundleAssociation.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBundleAssociation.copyWith.fieldName(...)`
class _$BundleAssociationCWProxyImpl implements _$BundleAssociationCWProxy {
  const _$BundleAssociationCWProxyImpl(this._value);

  final BundleAssociation _value;

  @override
  BundleAssociation compositeScore(double compositeScore) =>
      this(compositeScore: compositeScore);

  @override
  BundleAssociation pairLifts(List<BundleItemPair> pairLifts) =>
      this(pairLifts: pairLifts);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BundleAssociation(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BundleAssociation(...).copyWith(id: 12, name: "My name")
  /// ````
  BundleAssociation call({
    Object? compositeScore = const $CopyWithPlaceholder(),
    Object? pairLifts = const $CopyWithPlaceholder(),
  }) {
    return BundleAssociation(
      compositeScore: compositeScore == const $CopyWithPlaceholder()
          ? _value.compositeScore
          // ignore: cast_nullable_to_non_nullable
          : compositeScore as double,
      pairLifts: pairLifts == const $CopyWithPlaceholder()
          ? _value.pairLifts
          // ignore: cast_nullable_to_non_nullable
          : pairLifts as List<BundleItemPair>,
    );
  }
}

extension $BundleAssociationCopyWith on BundleAssociation {
  /// Returns a callable class that can be used as follows: `instanceOfBundleAssociation.copyWith(...)` or like so:`instanceOfBundleAssociation.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BundleAssociationCWProxy get copyWith =>
      _$BundleAssociationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BundleAssociation _$BundleAssociationFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'BundleAssociation',
      json,
      ($checkedConvert) {
        $checkKeys(json, requiredKeys: const ['composite_score', 'pair_lifts']);
        final val = BundleAssociation(
          compositeScore: $checkedConvert(
            'composite_score',
            (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
          ),
          pairLifts: $checkedConvert(
            'pair_lifts',
            (v) => (v as List<dynamic>)
                .map((e) => BundleItemPair.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'compositeScore': 'composite_score',
        'pairLifts': 'pair_lifts',
      },
    );

Map<String, dynamic> _$BundleAssociationToJson(BundleAssociation instance) =>
    <String, dynamic>{
      'composite_score': instance.compositeScore,
      'pair_lifts': instance.pairLifts.map((e) => e.toJson()).toList(),
    };
