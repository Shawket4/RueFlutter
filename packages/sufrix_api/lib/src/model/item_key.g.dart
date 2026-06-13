// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_key.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ItemKeyCWProxy {
  ItemKey menuItemId(String menuItemId);

  ItemKey sizeLabel(String sizeLabel);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ItemKey(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ItemKey(...).copyWith(id: 12, name: "My name")
  /// ````
  ItemKey call({String menuItemId, String sizeLabel});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfItemKey.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfItemKey.copyWith.fieldName(...)`
class _$ItemKeyCWProxyImpl implements _$ItemKeyCWProxy {
  const _$ItemKeyCWProxyImpl(this._value);

  final ItemKey _value;

  @override
  ItemKey menuItemId(String menuItemId) => this(menuItemId: menuItemId);

  @override
  ItemKey sizeLabel(String sizeLabel) => this(sizeLabel: sizeLabel);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ItemKey(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ItemKey(...).copyWith(id: 12, name: "My name")
  /// ````
  ItemKey call({
    Object? menuItemId = const $CopyWithPlaceholder(),
    Object? sizeLabel = const $CopyWithPlaceholder(),
  }) {
    return ItemKey(
      menuItemId: menuItemId == const $CopyWithPlaceholder()
          ? _value.menuItemId
          // ignore: cast_nullable_to_non_nullable
          : menuItemId as String,
      sizeLabel: sizeLabel == const $CopyWithPlaceholder()
          ? _value.sizeLabel
          // ignore: cast_nullable_to_non_nullable
          : sizeLabel as String,
    );
  }
}

extension $ItemKeyCopyWith on ItemKey {
  /// Returns a callable class that can be used as follows: `instanceOfItemKey.copyWith(...)` or like so:`instanceOfItemKey.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ItemKeyCWProxy get copyWith => _$ItemKeyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemKey _$ItemKeyFromJson(Map<String, dynamic> json) => $checkedCreate(
  'ItemKey',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['menu_item_id', 'size_label']);
    final val = ItemKey(
      menuItemId: $checkedConvert('menu_item_id', (v) => v as String),
      sizeLabel: $checkedConvert('size_label', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {'menuItemId': 'menu_item_id', 'sizeLabel': 'size_label'},
);

Map<String, dynamic> _$ItemKeyToJson(ItemKey instance) => <String, dynamic>{
  'menu_item_id': instance.menuItemId,
  'size_label': instance.sizeLabel,
};
