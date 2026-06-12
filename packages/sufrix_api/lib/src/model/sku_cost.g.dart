// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sku_cost.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SkuCostCWProxy {
  SkuCost categoryId(String? categoryId);

  SkuCost cost(int? cost);

  SkuCost costMissing(bool costMissing);

  SkuCost foodCostPct(double? foodCostPct);

  SkuCost itemName(String itemName);

  SkuCost marginPct(double? marginPct);

  SkuCost menuItemId(String menuItemId);

  SkuCost price(int price);

  SkuCost sizeLabel(String sizeLabel);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SkuCost(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SkuCost(...).copyWith(id: 12, name: "My name")
  /// ````
  SkuCost call({
    String? categoryId,
    int? cost,
    bool costMissing,
    double? foodCostPct,
    String itemName,
    double? marginPct,
    String menuItemId,
    int price,
    String sizeLabel,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSkuCost.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSkuCost.copyWith.fieldName(...)`
class _$SkuCostCWProxyImpl implements _$SkuCostCWProxy {
  const _$SkuCostCWProxyImpl(this._value);

  final SkuCost _value;

  @override
  SkuCost categoryId(String? categoryId) => this(categoryId: categoryId);

  @override
  SkuCost cost(int? cost) => this(cost: cost);

  @override
  SkuCost costMissing(bool costMissing) => this(costMissing: costMissing);

  @override
  SkuCost foodCostPct(double? foodCostPct) => this(foodCostPct: foodCostPct);

  @override
  SkuCost itemName(String itemName) => this(itemName: itemName);

  @override
  SkuCost marginPct(double? marginPct) => this(marginPct: marginPct);

  @override
  SkuCost menuItemId(String menuItemId) => this(menuItemId: menuItemId);

  @override
  SkuCost price(int price) => this(price: price);

  @override
  SkuCost sizeLabel(String sizeLabel) => this(sizeLabel: sizeLabel);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SkuCost(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SkuCost(...).copyWith(id: 12, name: "My name")
  /// ````
  SkuCost call({
    Object? categoryId = const $CopyWithPlaceholder(),
    Object? cost = const $CopyWithPlaceholder(),
    Object? costMissing = const $CopyWithPlaceholder(),
    Object? foodCostPct = const $CopyWithPlaceholder(),
    Object? itemName = const $CopyWithPlaceholder(),
    Object? marginPct = const $CopyWithPlaceholder(),
    Object? menuItemId = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
    Object? sizeLabel = const $CopyWithPlaceholder(),
  }) {
    return SkuCost(
      categoryId: categoryId == const $CopyWithPlaceholder()
          ? _value.categoryId
          // ignore: cast_nullable_to_non_nullable
          : categoryId as String?,
      cost: cost == const $CopyWithPlaceholder()
          ? _value.cost
          // ignore: cast_nullable_to_non_nullable
          : cost as int?,
      costMissing: costMissing == const $CopyWithPlaceholder()
          ? _value.costMissing
          // ignore: cast_nullable_to_non_nullable
          : costMissing as bool,
      foodCostPct: foodCostPct == const $CopyWithPlaceholder()
          ? _value.foodCostPct
          // ignore: cast_nullable_to_non_nullable
          : foodCostPct as double?,
      itemName: itemName == const $CopyWithPlaceholder()
          ? _value.itemName
          // ignore: cast_nullable_to_non_nullable
          : itemName as String,
      marginPct: marginPct == const $CopyWithPlaceholder()
          ? _value.marginPct
          // ignore: cast_nullable_to_non_nullable
          : marginPct as double?,
      menuItemId: menuItemId == const $CopyWithPlaceholder()
          ? _value.menuItemId
          // ignore: cast_nullable_to_non_nullable
          : menuItemId as String,
      price: price == const $CopyWithPlaceholder()
          ? _value.price
          // ignore: cast_nullable_to_non_nullable
          : price as int,
      sizeLabel: sizeLabel == const $CopyWithPlaceholder()
          ? _value.sizeLabel
          // ignore: cast_nullable_to_non_nullable
          : sizeLabel as String,
    );
  }
}

extension $SkuCostCopyWith on SkuCost {
  /// Returns a callable class that can be used as follows: `instanceOfSkuCost.copyWith(...)` or like so:`instanceOfSkuCost.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SkuCostCWProxy get copyWith => _$SkuCostCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkuCost _$SkuCostFromJson(Map<String, dynamic> json) => $checkedCreate(
  'SkuCost',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'cost_missing',
        'item_name',
        'menu_item_id',
        'price',
        'size_label',
      ],
    );
    final val = SkuCost(
      categoryId: $checkedConvert('category_id', (v) => v as String?),
      cost: $checkedConvert('cost', (v) => (v as num?)?.toInt()),
      costMissing: $checkedConvert('cost_missing', (v) => v as bool),
      foodCostPct: $checkedConvert(
        'food_cost_pct',
        (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble()),
      ),
      itemName: $checkedConvert('item_name', (v) => v as String),
      marginPct: $checkedConvert('margin_pct', (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble())),
      menuItemId: $checkedConvert('menu_item_id', (v) => v as String),
      price: $checkedConvert('price', (v) => (v as num).toInt()),
      sizeLabel: $checkedConvert('size_label', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'categoryId': 'category_id',
    'costMissing': 'cost_missing',
    'foodCostPct': 'food_cost_pct',
    'itemName': 'item_name',
    'marginPct': 'margin_pct',
    'menuItemId': 'menu_item_id',
    'sizeLabel': 'size_label',
  },
);

Map<String, dynamic> _$SkuCostToJson(SkuCost instance) => <String, dynamic>{
  'category_id': ?instance.categoryId,
  'cost': ?instance.cost,
  'cost_missing': instance.costMissing,
  'food_cost_pct': ?instance.foodCostPct,
  'item_name': instance.itemName,
  'margin_pct': ?instance.marginPct,
  'menu_item_id': instance.menuItemId,
  'price': instance.price,
  'size_label': instance.sizeLabel,
};
