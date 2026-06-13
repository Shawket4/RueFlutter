// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bundle_suggestion.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BundleSuggestionCWProxy {
  BundleSuggestion association(BundleAssociation association);

  BundleSuggestion bundleCm(int? bundleCm);

  BundleSuggestion bundleCost(int? bundleCost);

  BundleSuggestion bundleDiscountPct(double bundleDiscountPct);

  BundleSuggestion bundleItems(List<ItemKey> bundleItems);

  BundleSuggestion bundleListPrice(int bundleListPrice);

  BundleSuggestion bundleMarginPct(double? bundleMarginPct);

  BundleSuggestion bundleSuggestedPrice(int bundleSuggestedPrice);

  BundleSuggestion explanation(String explanation);

  BundleSuggestion focusItem(ItemKey focusItem);

  BundleSuggestion forecast(BundleForecast forecast);

  BundleSuggestion guardClips(List<GuardClip> guardClips);

  BundleSuggestion missingCosts(bool missingCosts);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BundleSuggestion(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BundleSuggestion(...).copyWith(id: 12, name: "My name")
  /// ````
  BundleSuggestion call({
    BundleAssociation association,
    int? bundleCm,
    int? bundleCost,
    double bundleDiscountPct,
    List<ItemKey> bundleItems,
    int bundleListPrice,
    double? bundleMarginPct,
    int bundleSuggestedPrice,
    String explanation,
    ItemKey focusItem,
    BundleForecast forecast,
    List<GuardClip> guardClips,
    bool missingCosts,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBundleSuggestion.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBundleSuggestion.copyWith.fieldName(...)`
class _$BundleSuggestionCWProxyImpl implements _$BundleSuggestionCWProxy {
  const _$BundleSuggestionCWProxyImpl(this._value);

  final BundleSuggestion _value;

  @override
  BundleSuggestion association(BundleAssociation association) =>
      this(association: association);

  @override
  BundleSuggestion bundleCm(int? bundleCm) => this(bundleCm: bundleCm);

  @override
  BundleSuggestion bundleCost(int? bundleCost) => this(bundleCost: bundleCost);

  @override
  BundleSuggestion bundleDiscountPct(double bundleDiscountPct) =>
      this(bundleDiscountPct: bundleDiscountPct);

  @override
  BundleSuggestion bundleItems(List<ItemKey> bundleItems) =>
      this(bundleItems: bundleItems);

  @override
  BundleSuggestion bundleListPrice(int bundleListPrice) =>
      this(bundleListPrice: bundleListPrice);

  @override
  BundleSuggestion bundleMarginPct(double? bundleMarginPct) =>
      this(bundleMarginPct: bundleMarginPct);

  @override
  BundleSuggestion bundleSuggestedPrice(int bundleSuggestedPrice) =>
      this(bundleSuggestedPrice: bundleSuggestedPrice);

  @override
  BundleSuggestion explanation(String explanation) =>
      this(explanation: explanation);

  @override
  BundleSuggestion focusItem(ItemKey focusItem) => this(focusItem: focusItem);

  @override
  BundleSuggestion forecast(BundleForecast forecast) =>
      this(forecast: forecast);

  @override
  BundleSuggestion guardClips(List<GuardClip> guardClips) =>
      this(guardClips: guardClips);

  @override
  BundleSuggestion missingCosts(bool missingCosts) =>
      this(missingCosts: missingCosts);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BundleSuggestion(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BundleSuggestion(...).copyWith(id: 12, name: "My name")
  /// ````
  BundleSuggestion call({
    Object? association = const $CopyWithPlaceholder(),
    Object? bundleCm = const $CopyWithPlaceholder(),
    Object? bundleCost = const $CopyWithPlaceholder(),
    Object? bundleDiscountPct = const $CopyWithPlaceholder(),
    Object? bundleItems = const $CopyWithPlaceholder(),
    Object? bundleListPrice = const $CopyWithPlaceholder(),
    Object? bundleMarginPct = const $CopyWithPlaceholder(),
    Object? bundleSuggestedPrice = const $CopyWithPlaceholder(),
    Object? explanation = const $CopyWithPlaceholder(),
    Object? focusItem = const $CopyWithPlaceholder(),
    Object? forecast = const $CopyWithPlaceholder(),
    Object? guardClips = const $CopyWithPlaceholder(),
    Object? missingCosts = const $CopyWithPlaceholder(),
  }) {
    return BundleSuggestion(
      association: association == const $CopyWithPlaceholder()
          ? _value.association
          // ignore: cast_nullable_to_non_nullable
          : association as BundleAssociation,
      bundleCm: bundleCm == const $CopyWithPlaceholder()
          ? _value.bundleCm
          // ignore: cast_nullable_to_non_nullable
          : bundleCm as int?,
      bundleCost: bundleCost == const $CopyWithPlaceholder()
          ? _value.bundleCost
          // ignore: cast_nullable_to_non_nullable
          : bundleCost as int?,
      bundleDiscountPct: bundleDiscountPct == const $CopyWithPlaceholder()
          ? _value.bundleDiscountPct
          // ignore: cast_nullable_to_non_nullable
          : bundleDiscountPct as double,
      bundleItems: bundleItems == const $CopyWithPlaceholder()
          ? _value.bundleItems
          // ignore: cast_nullable_to_non_nullable
          : bundleItems as List<ItemKey>,
      bundleListPrice: bundleListPrice == const $CopyWithPlaceholder()
          ? _value.bundleListPrice
          // ignore: cast_nullable_to_non_nullable
          : bundleListPrice as int,
      bundleMarginPct: bundleMarginPct == const $CopyWithPlaceholder()
          ? _value.bundleMarginPct
          // ignore: cast_nullable_to_non_nullable
          : bundleMarginPct as double?,
      bundleSuggestedPrice: bundleSuggestedPrice == const $CopyWithPlaceholder()
          ? _value.bundleSuggestedPrice
          // ignore: cast_nullable_to_non_nullable
          : bundleSuggestedPrice as int,
      explanation: explanation == const $CopyWithPlaceholder()
          ? _value.explanation
          // ignore: cast_nullable_to_non_nullable
          : explanation as String,
      focusItem: focusItem == const $CopyWithPlaceholder()
          ? _value.focusItem
          // ignore: cast_nullable_to_non_nullable
          : focusItem as ItemKey,
      forecast: forecast == const $CopyWithPlaceholder()
          ? _value.forecast
          // ignore: cast_nullable_to_non_nullable
          : forecast as BundleForecast,
      guardClips: guardClips == const $CopyWithPlaceholder()
          ? _value.guardClips
          // ignore: cast_nullable_to_non_nullable
          : guardClips as List<GuardClip>,
      missingCosts: missingCosts == const $CopyWithPlaceholder()
          ? _value.missingCosts
          // ignore: cast_nullable_to_non_nullable
          : missingCosts as bool,
    );
  }
}

extension $BundleSuggestionCopyWith on BundleSuggestion {
  /// Returns a callable class that can be used as follows: `instanceOfBundleSuggestion.copyWith(...)` or like so:`instanceOfBundleSuggestion.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BundleSuggestionCWProxy get copyWith => _$BundleSuggestionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BundleSuggestion _$BundleSuggestionFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'BundleSuggestion',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'association',
            'bundle_discount_pct',
            'bundle_items',
            'bundle_list_price',
            'bundle_suggested_price',
            'explanation',
            'focus_item',
            'forecast',
            'guard_clips',
            'missing_costs',
          ],
        );
        final val = BundleSuggestion(
          association: $checkedConvert(
            'association',
            (v) => BundleAssociation.fromJson(v as Map<String, dynamic>),
          ),
          bundleCm: $checkedConvert('bundle_cm', (v) => (v as num?)?.toInt()),
          bundleCost: $checkedConvert(
            'bundle_cost',
            (v) => (v as num?)?.toInt(),
          ),
          bundleDiscountPct: $checkedConvert(
            'bundle_discount_pct',
            (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
          ),
          bundleItems: $checkedConvert(
            'bundle_items',
            (v) => (v as List<dynamic>)
                .map((e) => ItemKey.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
          bundleListPrice: $checkedConvert(
            'bundle_list_price',
            (v) => (v as num).toInt(),
          ),
          bundleMarginPct: $checkedConvert(
            'bundle_margin_pct',
            (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble()),
          ),
          bundleSuggestedPrice: $checkedConvert(
            'bundle_suggested_price',
            (v) => (v as num).toInt(),
          ),
          explanation: $checkedConvert('explanation', (v) => v as String),
          focusItem: $checkedConvert(
            'focus_item',
            (v) => ItemKey.fromJson(v as Map<String, dynamic>),
          ),
          forecast: $checkedConvert(
            'forecast',
            (v) => BundleForecast.fromJson(v as Map<String, dynamic>),
          ),
          guardClips: $checkedConvert(
            'guard_clips',
            (v) => (v as List<dynamic>)
                .map((e) => $enumDecode(_$GuardClipEnumMap, e))
                .toList(),
          ),
          missingCosts: $checkedConvert('missing_costs', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {
        'bundleCm': 'bundle_cm',
        'bundleCost': 'bundle_cost',
        'bundleDiscountPct': 'bundle_discount_pct',
        'bundleItems': 'bundle_items',
        'bundleListPrice': 'bundle_list_price',
        'bundleMarginPct': 'bundle_margin_pct',
        'bundleSuggestedPrice': 'bundle_suggested_price',
        'focusItem': 'focus_item',
        'guardClips': 'guard_clips',
        'missingCosts': 'missing_costs',
      },
    );

Map<String, dynamic> _$BundleSuggestionToJson(BundleSuggestion instance) =>
    <String, dynamic>{
      'association': instance.association.toJson(),
      'bundle_cm': ?instance.bundleCm,
      'bundle_cost': ?instance.bundleCost,
      'bundle_discount_pct': instance.bundleDiscountPct,
      'bundle_items': instance.bundleItems.map((e) => e.toJson()).toList(),
      'bundle_list_price': instance.bundleListPrice,
      'bundle_margin_pct': ?instance.bundleMarginPct,
      'bundle_suggested_price': instance.bundleSuggestedPrice,
      'explanation': instance.explanation,
      'focus_item': instance.focusItem.toJson(),
      'forecast': instance.forecast.toJson(),
      'guard_clips': instance.guardClips
          .map((e) => _$GuardClipEnumMap[e]!)
          .toList(),
      'missing_costs': instance.missingCosts,
    };

const _$GuardClipEnumMap = {
  GuardClip.marginFloor: 'margin_floor',
  GuardClip.changeCap: 'change_cap',
  GuardClip.culturalRounding: 'cultural_rounding',
  GuardClip.unknownDefaultOpenApi: 'unknown_default_open_api',
};
