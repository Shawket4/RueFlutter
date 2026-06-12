// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_bundle_component_addon.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderBundleComponentAddonCWProxy {
  OrderBundleComponentAddon addonItemId(String addonItemId);

  OrderBundleComponentAddon addonName(String addonName);

  OrderBundleComponentAddon componentItemId(String componentItemId);

  OrderBundleComponentAddon id(String id);

  OrderBundleComponentAddon lineTotal(int lineTotal);

  OrderBundleComponentAddon nameTranslations(Object nameTranslations);

  OrderBundleComponentAddon orderLineId(String orderLineId);

  OrderBundleComponentAddon quantity(int quantity);

  OrderBundleComponentAddon unitPrice(int unitPrice);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderBundleComponentAddon(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderBundleComponentAddon(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderBundleComponentAddon call({
    String addonItemId,
    String addonName,
    String componentItemId,
    String id,
    int lineTotal,
    Object nameTranslations,
    String orderLineId,
    int quantity,
    int unitPrice,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderBundleComponentAddon.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderBundleComponentAddon.copyWith.fieldName(...)`
class _$OrderBundleComponentAddonCWProxyImpl
    implements _$OrderBundleComponentAddonCWProxy {
  const _$OrderBundleComponentAddonCWProxyImpl(this._value);

  final OrderBundleComponentAddon _value;

  @override
  OrderBundleComponentAddon addonItemId(String addonItemId) =>
      this(addonItemId: addonItemId);

  @override
  OrderBundleComponentAddon addonName(String addonName) =>
      this(addonName: addonName);

  @override
  OrderBundleComponentAddon componentItemId(String componentItemId) =>
      this(componentItemId: componentItemId);

  @override
  OrderBundleComponentAddon id(String id) => this(id: id);

  @override
  OrderBundleComponentAddon lineTotal(int lineTotal) =>
      this(lineTotal: lineTotal);

  @override
  OrderBundleComponentAddon nameTranslations(Object nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  OrderBundleComponentAddon orderLineId(String orderLineId) =>
      this(orderLineId: orderLineId);

  @override
  OrderBundleComponentAddon quantity(int quantity) => this(quantity: quantity);

  @override
  OrderBundleComponentAddon unitPrice(int unitPrice) =>
      this(unitPrice: unitPrice);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderBundleComponentAddon(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderBundleComponentAddon(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderBundleComponentAddon call({
    Object? addonItemId = const $CopyWithPlaceholder(),
    Object? addonName = const $CopyWithPlaceholder(),
    Object? componentItemId = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? lineTotal = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
    Object? orderLineId = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? unitPrice = const $CopyWithPlaceholder(),
  }) {
    return OrderBundleComponentAddon(
      addonItemId: addonItemId == const $CopyWithPlaceholder()
          ? _value.addonItemId
          // ignore: cast_nullable_to_non_nullable
          : addonItemId as String,
      addonName: addonName == const $CopyWithPlaceholder()
          ? _value.addonName
          // ignore: cast_nullable_to_non_nullable
          : addonName as String,
      componentItemId: componentItemId == const $CopyWithPlaceholder()
          ? _value.componentItemId
          // ignore: cast_nullable_to_non_nullable
          : componentItemId as String,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      lineTotal: lineTotal == const $CopyWithPlaceholder()
          ? _value.lineTotal
          // ignore: cast_nullable_to_non_nullable
          : lineTotal as int,
      nameTranslations: nameTranslations == const $CopyWithPlaceholder()
          ? _value.nameTranslations
          // ignore: cast_nullable_to_non_nullable
          : nameTranslations as Object,
      orderLineId: orderLineId == const $CopyWithPlaceholder()
          ? _value.orderLineId
          // ignore: cast_nullable_to_non_nullable
          : orderLineId as String,
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

extension $OrderBundleComponentAddonCopyWith on OrderBundleComponentAddon {
  /// Returns a callable class that can be used as follows: `instanceOfOrderBundleComponentAddon.copyWith(...)` or like so:`instanceOfOrderBundleComponentAddon.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderBundleComponentAddonCWProxy get copyWith =>
      _$OrderBundleComponentAddonCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderBundleComponentAddon _$OrderBundleComponentAddonFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'OrderBundleComponentAddon',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'addon_item_id',
        'addon_name',
        'component_item_id',
        'id',
        'line_total',
        'name_translations',
        'order_line_id',
        'quantity',
        'unit_price',
      ],
    );
    final val = OrderBundleComponentAddon(
      addonItemId: $checkedConvert('addon_item_id', (v) => v as String),
      addonName: $checkedConvert('addon_name', (v) => v as String),
      componentItemId: $checkedConvert('component_item_id', (v) => v as String),
      id: $checkedConvert('id', (v) => v as String),
      lineTotal: $checkedConvert('line_total', (v) => (v as num).toInt()),
      nameTranslations: $checkedConvert(
        'name_translations',
        (v) => v as Object,
      ),
      orderLineId: $checkedConvert('order_line_id', (v) => v as String),
      quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
      unitPrice: $checkedConvert('unit_price', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'addonItemId': 'addon_item_id',
    'addonName': 'addon_name',
    'componentItemId': 'component_item_id',
    'lineTotal': 'line_total',
    'nameTranslations': 'name_translations',
    'orderLineId': 'order_line_id',
    'unitPrice': 'unit_price',
  },
);

Map<String, dynamic> _$OrderBundleComponentAddonToJson(
  OrderBundleComponentAddon instance,
) => <String, dynamic>{
  'addon_item_id': instance.addonItemId,
  'addon_name': instance.addonName,
  'component_item_id': instance.componentItemId,
  'id': instance.id,
  'line_total': instance.lineTotal,
  'name_translations': instance.nameTranslations,
  'order_line_id': instance.orderLineId,
  'quantity': instance.quantity,
  'unit_price': instance.unitPrice,
};
