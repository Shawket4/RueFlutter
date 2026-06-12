// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_size.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ItemSizeCWProxy {
  ItemSize displayOrder(int displayOrder);

  ItemSize id(String id);

  ItemSize isActive(bool isActive);

  ItemSize label(String label);

  ItemSize menuItemId(String menuItemId);

  ItemSize priceOverride(int priceOverride);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ItemSize(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ItemSize(...).copyWith(id: 12, name: "My name")
  /// ````
  ItemSize call({
    int displayOrder,
    String id,
    bool isActive,
    String label,
    String menuItemId,
    int priceOverride,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfItemSize.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfItemSize.copyWith.fieldName(...)`
class _$ItemSizeCWProxyImpl implements _$ItemSizeCWProxy {
  const _$ItemSizeCWProxyImpl(this._value);

  final ItemSize _value;

  @override
  ItemSize displayOrder(int displayOrder) => this(displayOrder: displayOrder);

  @override
  ItemSize id(String id) => this(id: id);

  @override
  ItemSize isActive(bool isActive) => this(isActive: isActive);

  @override
  ItemSize label(String label) => this(label: label);

  @override
  ItemSize menuItemId(String menuItemId) => this(menuItemId: menuItemId);

  @override
  ItemSize priceOverride(int priceOverride) =>
      this(priceOverride: priceOverride);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ItemSize(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ItemSize(...).copyWith(id: 12, name: "My name")
  /// ````
  ItemSize call({
    Object? displayOrder = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? label = const $CopyWithPlaceholder(),
    Object? menuItemId = const $CopyWithPlaceholder(),
    Object? priceOverride = const $CopyWithPlaceholder(),
  }) {
    return ItemSize(
      displayOrder: displayOrder == const $CopyWithPlaceholder()
          ? _value.displayOrder
          // ignore: cast_nullable_to_non_nullable
          : displayOrder as int,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
      label: label == const $CopyWithPlaceholder()
          ? _value.label
          // ignore: cast_nullable_to_non_nullable
          : label as String,
      menuItemId: menuItemId == const $CopyWithPlaceholder()
          ? _value.menuItemId
          // ignore: cast_nullable_to_non_nullable
          : menuItemId as String,
      priceOverride: priceOverride == const $CopyWithPlaceholder()
          ? _value.priceOverride
          // ignore: cast_nullable_to_non_nullable
          : priceOverride as int,
    );
  }
}

extension $ItemSizeCopyWith on ItemSize {
  /// Returns a callable class that can be used as follows: `instanceOfItemSize.copyWith(...)` or like so:`instanceOfItemSize.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ItemSizeCWProxy get copyWith => _$ItemSizeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemSize _$ItemSizeFromJson(Map<String, dynamic> json) => $checkedCreate(
  'ItemSize',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'display_order',
        'id',
        'is_active',
        'label',
        'menu_item_id',
        'price_override',
      ],
    );
    final val = ItemSize(
      displayOrder: $checkedConvert('display_order', (v) => (v as num).toInt()),
      id: $checkedConvert('id', (v) => v as String),
      isActive: $checkedConvert('is_active', (v) => v as bool),
      label: $checkedConvert('label', (v) => v as String),
      menuItemId: $checkedConvert('menu_item_id', (v) => v as String),
      priceOverride: $checkedConvert(
        'price_override',
        (v) => (v as num).toInt(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'displayOrder': 'display_order',
    'isActive': 'is_active',
    'menuItemId': 'menu_item_id',
    'priceOverride': 'price_override',
  },
);

Map<String, dynamic> _$ItemSizeToJson(ItemSize instance) => <String, dynamic>{
  'display_order': instance.displayOrder,
  'id': instance.id,
  'is_active': instance.isActive,
  'label': instance.label,
  'menu_item_id': instance.menuItemId,
  'price_override': instance.priceOverride,
};
