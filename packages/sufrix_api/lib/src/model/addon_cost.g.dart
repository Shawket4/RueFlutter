// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addon_cost.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AddonCostCWProxy {
  AddonCost addonItemId(String addonItemId);

  AddonCost addonType(String addonType);

  AddonCost cost(int? cost);

  AddonCost costMissing(bool costMissing);

  AddonCost marginPct(double? marginPct);

  AddonCost name(String name);

  AddonCost price(int price);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddonCost(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddonCost(...).copyWith(id: 12, name: "My name")
  /// ````
  AddonCost call({
    String addonItemId,
    String addonType,
    int? cost,
    bool costMissing,
    double? marginPct,
    String name,
    int price,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAddonCost.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAddonCost.copyWith.fieldName(...)`
class _$AddonCostCWProxyImpl implements _$AddonCostCWProxy {
  const _$AddonCostCWProxyImpl(this._value);

  final AddonCost _value;

  @override
  AddonCost addonItemId(String addonItemId) => this(addonItemId: addonItemId);

  @override
  AddonCost addonType(String addonType) => this(addonType: addonType);

  @override
  AddonCost cost(int? cost) => this(cost: cost);

  @override
  AddonCost costMissing(bool costMissing) => this(costMissing: costMissing);

  @override
  AddonCost marginPct(double? marginPct) => this(marginPct: marginPct);

  @override
  AddonCost name(String name) => this(name: name);

  @override
  AddonCost price(int price) => this(price: price);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddonCost(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddonCost(...).copyWith(id: 12, name: "My name")
  /// ````
  AddonCost call({
    Object? addonItemId = const $CopyWithPlaceholder(),
    Object? addonType = const $CopyWithPlaceholder(),
    Object? cost = const $CopyWithPlaceholder(),
    Object? costMissing = const $CopyWithPlaceholder(),
    Object? marginPct = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
  }) {
    return AddonCost(
      addonItemId: addonItemId == const $CopyWithPlaceholder()
          ? _value.addonItemId
          // ignore: cast_nullable_to_non_nullable
          : addonItemId as String,
      addonType: addonType == const $CopyWithPlaceholder()
          ? _value.addonType
          // ignore: cast_nullable_to_non_nullable
          : addonType as String,
      cost: cost == const $CopyWithPlaceholder()
          ? _value.cost
          // ignore: cast_nullable_to_non_nullable
          : cost as int?,
      costMissing: costMissing == const $CopyWithPlaceholder()
          ? _value.costMissing
          // ignore: cast_nullable_to_non_nullable
          : costMissing as bool,
      marginPct: marginPct == const $CopyWithPlaceholder()
          ? _value.marginPct
          // ignore: cast_nullable_to_non_nullable
          : marginPct as double?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      price: price == const $CopyWithPlaceholder()
          ? _value.price
          // ignore: cast_nullable_to_non_nullable
          : price as int,
    );
  }
}

extension $AddonCostCopyWith on AddonCost {
  /// Returns a callable class that can be used as follows: `instanceOfAddonCost.copyWith(...)` or like so:`instanceOfAddonCost.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AddonCostCWProxy get copyWith => _$AddonCostCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddonCost _$AddonCostFromJson(Map<String, dynamic> json) => $checkedCreate(
  'AddonCost',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'addon_item_id',
        'addon_type',
        'cost_missing',
        'name',
        'price',
      ],
    );
    final val = AddonCost(
      addonItemId: $checkedConvert('addon_item_id', (v) => v as String),
      addonType: $checkedConvert('addon_type', (v) => v as String),
      cost: $checkedConvert('cost', (v) => (v as num?)?.toInt()),
      costMissing: $checkedConvert('cost_missing', (v) => v as bool),
      marginPct: $checkedConvert('margin_pct', (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble())),
      name: $checkedConvert('name', (v) => v as String),
      price: $checkedConvert('price', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'addonItemId': 'addon_item_id',
    'addonType': 'addon_type',
    'costMissing': 'cost_missing',
    'marginPct': 'margin_pct',
  },
);

Map<String, dynamic> _$AddonCostToJson(AddonCost instance) => <String, dynamic>{
  'addon_item_id': instance.addonItemId,
  'addon_type': instance.addonType,
  'cost': ?instance.cost,
  'cost_missing': instance.costMissing,
  'margin_pct': ?instance.marginPct,
  'name': instance.name,
  'price': instance.price,
};
