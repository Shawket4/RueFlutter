// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_addon.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderItemAddonCWProxy {
  OrderItemAddon addonItemId(String addonItemId);

  OrderItemAddon addonName(String addonName);

  OrderItemAddon id(String id);

  OrderItemAddon lineCost(int? lineCost);

  OrderItemAddon lineTotal(int lineTotal);

  OrderItemAddon nameTranslations(Object nameTranslations);

  OrderItemAddon orderItemId(String orderItemId);

  OrderItemAddon quantity(int quantity);

  OrderItemAddon unitPrice(int unitPrice);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderItemAddon(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderItemAddon(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderItemAddon call({
    String addonItemId,
    String addonName,
    String id,
    int? lineCost,
    int lineTotal,
    Object nameTranslations,
    String orderItemId,
    int quantity,
    int unitPrice,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderItemAddon.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderItemAddon.copyWith.fieldName(...)`
class _$OrderItemAddonCWProxyImpl implements _$OrderItemAddonCWProxy {
  const _$OrderItemAddonCWProxyImpl(this._value);

  final OrderItemAddon _value;

  @override
  OrderItemAddon addonItemId(String addonItemId) =>
      this(addonItemId: addonItemId);

  @override
  OrderItemAddon addonName(String addonName) => this(addonName: addonName);

  @override
  OrderItemAddon id(String id) => this(id: id);

  @override
  OrderItemAddon lineCost(int? lineCost) => this(lineCost: lineCost);

  @override
  OrderItemAddon lineTotal(int lineTotal) => this(lineTotal: lineTotal);

  @override
  OrderItemAddon nameTranslations(Object nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  OrderItemAddon orderItemId(String orderItemId) =>
      this(orderItemId: orderItemId);

  @override
  OrderItemAddon quantity(int quantity) => this(quantity: quantity);

  @override
  OrderItemAddon unitPrice(int unitPrice) => this(unitPrice: unitPrice);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderItemAddon(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderItemAddon(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderItemAddon call({
    Object? addonItemId = const $CopyWithPlaceholder(),
    Object? addonName = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? lineCost = const $CopyWithPlaceholder(),
    Object? lineTotal = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
    Object? orderItemId = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? unitPrice = const $CopyWithPlaceholder(),
  }) {
    return OrderItemAddon(
      addonItemId: addonItemId == const $CopyWithPlaceholder()
          ? _value.addonItemId
          // ignore: cast_nullable_to_non_nullable
          : addonItemId as String,
      addonName: addonName == const $CopyWithPlaceholder()
          ? _value.addonName
          // ignore: cast_nullable_to_non_nullable
          : addonName as String,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      lineCost: lineCost == const $CopyWithPlaceholder()
          ? _value.lineCost
          // ignore: cast_nullable_to_non_nullable
          : lineCost as int?,
      lineTotal: lineTotal == const $CopyWithPlaceholder()
          ? _value.lineTotal
          // ignore: cast_nullable_to_non_nullable
          : lineTotal as int,
      nameTranslations: nameTranslations == const $CopyWithPlaceholder()
          ? _value.nameTranslations
          // ignore: cast_nullable_to_non_nullable
          : nameTranslations as Object,
      orderItemId: orderItemId == const $CopyWithPlaceholder()
          ? _value.orderItemId
          // ignore: cast_nullable_to_non_nullable
          : orderItemId as String,
      quantity: quantity == const $CopyWithPlaceholder()
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as int,
      unitPrice: unitPrice == const $CopyWithPlaceholder()
          ? _value.unitPrice
          // ignore: cast_nullable_to_non_nullable
          : unitPrice as int,
    );
  }
}

extension $OrderItemAddonCopyWith on OrderItemAddon {
  /// Returns a callable class that can be used as follows: `instanceOfOrderItemAddon.copyWith(...)` or like so:`instanceOfOrderItemAddon.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderItemAddonCWProxy get copyWith => _$OrderItemAddonCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemAddon _$OrderItemAddonFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'OrderItemAddon',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'addon_item_id',
            'addon_name',
            'id',
            'line_total',
            'name_translations',
            'order_item_id',
            'quantity',
            'unit_price',
          ],
        );
        final val = OrderItemAddon(
          addonItemId: $checkedConvert('addon_item_id', (v) => v as String),
          addonName: $checkedConvert('addon_name', (v) => v as String),
          id: $checkedConvert('id', (v) => v as String),
          lineCost: $checkedConvert('line_cost', (v) => (v as num?)?.toInt()),
          lineTotal: $checkedConvert('line_total', (v) => (v as num).toInt()),
          nameTranslations: $checkedConvert(
            'name_translations',
            (v) => v as Object,
          ),
          orderItemId: $checkedConvert('order_item_id', (v) => v as String),
          quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
          unitPrice: $checkedConvert('unit_price', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'addonItemId': 'addon_item_id',
        'addonName': 'addon_name',
        'lineCost': 'line_cost',
        'lineTotal': 'line_total',
        'nameTranslations': 'name_translations',
        'orderItemId': 'order_item_id',
        'unitPrice': 'unit_price',
      },
    );

Map<String, dynamic> _$OrderItemAddonToJson(OrderItemAddon instance) =>
    <String, dynamic>{
      'addon_item_id': instance.addonItemId,
      'addon_name': instance.addonName,
      'id': instance.id,
      'line_cost': ?instance.lineCost,
      'line_total': instance.lineTotal,
      'name_translations': instance.nameTranslations,
      'order_item_id': instance.orderItemId,
      'quantity': instance.quantity,
      'unit_price': instance.unitPrice,
    };
