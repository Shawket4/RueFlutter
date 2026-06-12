// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bundle_component_hydrated.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BundleComponentHydratedCWProxy {
  BundleComponentHydrated bundleId(String bundleId);

  BundleComponentHydrated id(String id);

  BundleComponentHydrated itemCost(int itemCost);

  BundleComponentHydrated itemId(String itemId);

  BundleComponentHydrated itemName(String itemName);

  BundleComponentHydrated itemPrice(int itemPrice);

  BundleComponentHydrated position(int position);

  BundleComponentHydrated quantity(int quantity);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BundleComponentHydrated(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BundleComponentHydrated(...).copyWith(id: 12, name: "My name")
  /// ````
  BundleComponentHydrated call({
    String bundleId,
    String id,
    int itemCost,
    String itemId,
    String itemName,
    int itemPrice,
    int position,
    int quantity,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBundleComponentHydrated.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBundleComponentHydrated.copyWith.fieldName(...)`
class _$BundleComponentHydratedCWProxyImpl
    implements _$BundleComponentHydratedCWProxy {
  const _$BundleComponentHydratedCWProxyImpl(this._value);

  final BundleComponentHydrated _value;

  @override
  BundleComponentHydrated bundleId(String bundleId) => this(bundleId: bundleId);

  @override
  BundleComponentHydrated id(String id) => this(id: id);

  @override
  BundleComponentHydrated itemCost(int itemCost) => this(itemCost: itemCost);

  @override
  BundleComponentHydrated itemId(String itemId) => this(itemId: itemId);

  @override
  BundleComponentHydrated itemName(String itemName) => this(itemName: itemName);

  @override
  BundleComponentHydrated itemPrice(int itemPrice) =>
      this(itemPrice: itemPrice);

  @override
  BundleComponentHydrated position(int position) => this(position: position);

  @override
  BundleComponentHydrated quantity(int quantity) => this(quantity: quantity);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BundleComponentHydrated(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BundleComponentHydrated(...).copyWith(id: 12, name: "My name")
  /// ````
  BundleComponentHydrated call({
    Object? bundleId = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? itemCost = const $CopyWithPlaceholder(),
    Object? itemId = const $CopyWithPlaceholder(),
    Object? itemName = const $CopyWithPlaceholder(),
    Object? itemPrice = const $CopyWithPlaceholder(),
    Object? position = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
  }) {
    return BundleComponentHydrated(
      bundleId: bundleId == const $CopyWithPlaceholder()
          ? _value.bundleId
          // ignore: cast_nullable_to_non_nullable
          : bundleId as String,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      itemCost: itemCost == const $CopyWithPlaceholder()
          ? _value.itemCost
          // ignore: cast_nullable_to_non_nullable
          : itemCost as int,
      itemId: itemId == const $CopyWithPlaceholder()
          ? _value.itemId
          // ignore: cast_nullable_to_non_nullable
          : itemId as String,
      itemName: itemName == const $CopyWithPlaceholder()
          ? _value.itemName
          // ignore: cast_nullable_to_non_nullable
          : itemName as String,
      itemPrice: itemPrice == const $CopyWithPlaceholder()
          ? _value.itemPrice
          // ignore: cast_nullable_to_non_nullable
          : itemPrice as int,
      position: position == const $CopyWithPlaceholder()
          ? _value.position
          // ignore: cast_nullable_to_non_nullable
          : position as int,
      quantity: quantity == const $CopyWithPlaceholder()
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as int,
    );
  }
}

extension $BundleComponentHydratedCopyWith on BundleComponentHydrated {
  /// Returns a callable class that can be used as follows: `instanceOfBundleComponentHydrated.copyWith(...)` or like so:`instanceOfBundleComponentHydrated.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BundleComponentHydratedCWProxy get copyWith =>
      _$BundleComponentHydratedCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BundleComponentHydrated _$BundleComponentHydratedFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'BundleComponentHydrated',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'bundle_id',
        'id',
        'item_cost',
        'item_id',
        'item_name',
        'item_price',
        'position',
        'quantity',
      ],
    );
    final val = BundleComponentHydrated(
      bundleId: $checkedConvert('bundle_id', (v) => v as String),
      id: $checkedConvert('id', (v) => v as String),
      itemCost: $checkedConvert('item_cost', (v) => (v as num).toInt()),
      itemId: $checkedConvert('item_id', (v) => v as String),
      itemName: $checkedConvert('item_name', (v) => v as String),
      itemPrice: $checkedConvert('item_price', (v) => (v as num).toInt()),
      position: $checkedConvert('position', (v) => (v as num).toInt()),
      quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'bundleId': 'bundle_id',
    'itemCost': 'item_cost',
    'itemId': 'item_id',
    'itemName': 'item_name',
    'itemPrice': 'item_price',
  },
);

Map<String, dynamic> _$BundleComponentHydratedToJson(
  BundleComponentHydrated instance,
) => <String, dynamic>{
  'bundle_id': instance.bundleId,
  'id': instance.id,
  'item_cost': instance.itemCost,
  'item_id': instance.itemId,
  'item_name': instance.itemName,
  'item_price': instance.itemPrice,
  'position': instance.position,
  'quantity': instance.quantity,
};
