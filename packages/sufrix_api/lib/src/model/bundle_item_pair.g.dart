// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bundle_item_pair.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BundleItemPairCWProxy {
  BundleItemPair confidenceAb(double confidenceAb);

  BundleItemPair itemA(ItemKey itemA);

  BundleItemPair itemB(ItemKey itemB);

  BundleItemPair lift(double lift);

  BundleItemPair support(double support);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BundleItemPair(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BundleItemPair(...).copyWith(id: 12, name: "My name")
  /// ````
  BundleItemPair call({
    double confidenceAb,
    ItemKey itemA,
    ItemKey itemB,
    double lift,
    double support,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBundleItemPair.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBundleItemPair.copyWith.fieldName(...)`
class _$BundleItemPairCWProxyImpl implements _$BundleItemPairCWProxy {
  const _$BundleItemPairCWProxyImpl(this._value);

  final BundleItemPair _value;

  @override
  BundleItemPair confidenceAb(double confidenceAb) =>
      this(confidenceAb: confidenceAb);

  @override
  BundleItemPair itemA(ItemKey itemA) => this(itemA: itemA);

  @override
  BundleItemPair itemB(ItemKey itemB) => this(itemB: itemB);

  @override
  BundleItemPair lift(double lift) => this(lift: lift);

  @override
  BundleItemPair support(double support) => this(support: support);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BundleItemPair(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BundleItemPair(...).copyWith(id: 12, name: "My name")
  /// ````
  BundleItemPair call({
    Object? confidenceAb = const $CopyWithPlaceholder(),
    Object? itemA = const $CopyWithPlaceholder(),
    Object? itemB = const $CopyWithPlaceholder(),
    Object? lift = const $CopyWithPlaceholder(),
    Object? support = const $CopyWithPlaceholder(),
  }) {
    return BundleItemPair(
      confidenceAb: confidenceAb == const $CopyWithPlaceholder()
          ? _value.confidenceAb
          // ignore: cast_nullable_to_non_nullable
          : confidenceAb as double,
      itemA: itemA == const $CopyWithPlaceholder()
          ? _value.itemA
          // ignore: cast_nullable_to_non_nullable
          : itemA as ItemKey,
      itemB: itemB == const $CopyWithPlaceholder()
          ? _value.itemB
          // ignore: cast_nullable_to_non_nullable
          : itemB as ItemKey,
      lift: lift == const $CopyWithPlaceholder()
          ? _value.lift
          // ignore: cast_nullable_to_non_nullable
          : lift as double,
      support: support == const $CopyWithPlaceholder()
          ? _value.support
          // ignore: cast_nullable_to_non_nullable
          : support as double,
    );
  }
}

extension $BundleItemPairCopyWith on BundleItemPair {
  /// Returns a callable class that can be used as follows: `instanceOfBundleItemPair.copyWith(...)` or like so:`instanceOfBundleItemPair.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BundleItemPairCWProxy get copyWith => _$BundleItemPairCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BundleItemPair _$BundleItemPairFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'BundleItemPair',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'confidence_ab',
            'item_a',
            'item_b',
            'lift',
            'support',
          ],
        );
        final val = BundleItemPair(
          confidenceAb: $checkedConvert(
            'confidence_ab',
            (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
          ),
          itemA: $checkedConvert(
            'item_a',
            (v) => ItemKey.fromJson(v as Map<String, dynamic>),
          ),
          itemB: $checkedConvert(
            'item_b',
            (v) => ItemKey.fromJson(v as Map<String, dynamic>),
          ),
          lift: $checkedConvert('lift', (v) => (v is String ? double.parse(v) : (v as num).toDouble())),
          support: $checkedConvert('support', (v) => (v is String ? double.parse(v) : (v as num).toDouble())),
        );
        return val;
      },
      fieldKeyMap: const {
        'confidenceAb': 'confidence_ab',
        'itemA': 'item_a',
        'itemB': 'item_b',
      },
    );

Map<String, dynamic> _$BundleItemPairToJson(BundleItemPair instance) =>
    <String, dynamic>{
      'confidence_ab': instance.confidenceAb,
      'item_a': instance.itemA.toJson(),
      'item_b': instance.itemB.toJson(),
      'lift': instance.lift,
      'support': instance.support,
    };
