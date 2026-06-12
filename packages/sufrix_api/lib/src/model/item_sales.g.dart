// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_sales.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ItemSalesCWProxy {
  ItemSales itemName(String itemName);

  ItemSales itemNameTranslations(Object itemNameTranslations);

  ItemSales menuItemId(String menuItemId);

  ItemSales quantitySold(int quantitySold);

  ItemSales revenue(int revenue);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ItemSales(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ItemSales(...).copyWith(id: 12, name: "My name")
  /// ````
  ItemSales call({
    String itemName,
    Object itemNameTranslations,
    String menuItemId,
    int quantitySold,
    int revenue,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfItemSales.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfItemSales.copyWith.fieldName(...)`
class _$ItemSalesCWProxyImpl implements _$ItemSalesCWProxy {
  const _$ItemSalesCWProxyImpl(this._value);

  final ItemSales _value;

  @override
  ItemSales itemName(String itemName) => this(itemName: itemName);

  @override
  ItemSales itemNameTranslations(Object itemNameTranslations) =>
      this(itemNameTranslations: itemNameTranslations);

  @override
  ItemSales menuItemId(String menuItemId) => this(menuItemId: menuItemId);

  @override
  ItemSales quantitySold(int quantitySold) => this(quantitySold: quantitySold);

  @override
  ItemSales revenue(int revenue) => this(revenue: revenue);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ItemSales(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ItemSales(...).copyWith(id: 12, name: "My name")
  /// ````
  ItemSales call({
    Object? itemName = const $CopyWithPlaceholder(),
    Object? itemNameTranslations = const $CopyWithPlaceholder(),
    Object? menuItemId = const $CopyWithPlaceholder(),
    Object? quantitySold = const $CopyWithPlaceholder(),
    Object? revenue = const $CopyWithPlaceholder(),
  }) {
    return ItemSales(
      itemName: itemName == const $CopyWithPlaceholder()
          ? _value.itemName
          // ignore: cast_nullable_to_non_nullable
          : itemName as String,
      itemNameTranslations: itemNameTranslations == const $CopyWithPlaceholder()
          ? _value.itemNameTranslations
          // ignore: cast_nullable_to_non_nullable
          : itemNameTranslations as Object,
      menuItemId: menuItemId == const $CopyWithPlaceholder()
          ? _value.menuItemId
          // ignore: cast_nullable_to_non_nullable
          : menuItemId as String,
      quantitySold: quantitySold == const $CopyWithPlaceholder()
          ? _value.quantitySold
          // ignore: cast_nullable_to_non_nullable
          : quantitySold as int,
      revenue: revenue == const $CopyWithPlaceholder()
          ? _value.revenue
          // ignore: cast_nullable_to_non_nullable
          : revenue as int,
    );
  }
}

extension $ItemSalesCopyWith on ItemSales {
  /// Returns a callable class that can be used as follows: `instanceOfItemSales.copyWith(...)` or like so:`instanceOfItemSales.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ItemSalesCWProxy get copyWith => _$ItemSalesCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemSales _$ItemSalesFromJson(Map<String, dynamic> json) => $checkedCreate(
  'ItemSales',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'item_name',
        'item_name_translations',
        'menu_item_id',
        'quantity_sold',
        'revenue',
      ],
    );
    final val = ItemSales(
      itemName: $checkedConvert('item_name', (v) => v as String),
      itemNameTranslations: $checkedConvert(
        'item_name_translations',
        (v) => v as Object,
      ),
      menuItemId: $checkedConvert('menu_item_id', (v) => v as String),
      quantitySold: $checkedConvert('quantity_sold', (v) => (v as num).toInt()),
      revenue: $checkedConvert('revenue', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'itemName': 'item_name',
    'itemNameTranslations': 'item_name_translations',
    'menuItemId': 'menu_item_id',
    'quantitySold': 'quantity_sold',
  },
);

Map<String, dynamic> _$ItemSalesToJson(ItemSales instance) => <String, dynamic>{
  'item_name': instance.itemName,
  'item_name_translations': instance.itemNameTranslations,
  'menu_item_id': instance.menuItemId,
  'quantity_sold': instance.quantitySold,
  'revenue': instance.revenue,
};
