// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_menu.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DeliveryMenuCWProxy {
  DeliveryMenu addons(List<DeliveryAddonOption> addons);

  DeliveryMenu categories(List<DeliveryMenuCategory> categories);

  DeliveryMenu items(List<DeliveryMenuItem> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeliveryMenu(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeliveryMenu(...).copyWith(id: 12, name: "My name")
  /// ````
  DeliveryMenu call({
    List<DeliveryAddonOption> addons,
    List<DeliveryMenuCategory> categories,
    List<DeliveryMenuItem> items,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDeliveryMenu.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDeliveryMenu.copyWith.fieldName(...)`
class _$DeliveryMenuCWProxyImpl implements _$DeliveryMenuCWProxy {
  const _$DeliveryMenuCWProxyImpl(this._value);

  final DeliveryMenu _value;

  @override
  DeliveryMenu addons(List<DeliveryAddonOption> addons) => this(addons: addons);

  @override
  DeliveryMenu categories(List<DeliveryMenuCategory> categories) =>
      this(categories: categories);

  @override
  DeliveryMenu items(List<DeliveryMenuItem> items) => this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeliveryMenu(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeliveryMenu(...).copyWith(id: 12, name: "My name")
  /// ````
  DeliveryMenu call({
    Object? addons = const $CopyWithPlaceholder(),
    Object? categories = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
  }) {
    return DeliveryMenu(
      addons: addons == const $CopyWithPlaceholder()
          ? _value.addons
          // ignore: cast_nullable_to_non_nullable
          : addons as List<DeliveryAddonOption>,
      categories: categories == const $CopyWithPlaceholder()
          ? _value.categories
          // ignore: cast_nullable_to_non_nullable
          : categories as List<DeliveryMenuCategory>,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<DeliveryMenuItem>,
    );
  }
}

extension $DeliveryMenuCopyWith on DeliveryMenu {
  /// Returns a callable class that can be used as follows: `instanceOfDeliveryMenu.copyWith(...)` or like so:`instanceOfDeliveryMenu.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DeliveryMenuCWProxy get copyWith => _$DeliveryMenuCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryMenu _$DeliveryMenuFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DeliveryMenu', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['addons', 'categories', 'items']);
  final val = DeliveryMenu(
    addons: $checkedConvert(
      'addons',
      (v) => (v as List<dynamic>)
          .map((e) => DeliveryAddonOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    categories: $checkedConvert(
      'categories',
      (v) => (v as List<dynamic>)
          .map((e) => DeliveryMenuCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    items: $checkedConvert(
      'items',
      (v) => (v as List<dynamic>)
          .map((e) => DeliveryMenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$DeliveryMenuToJson(DeliveryMenu instance) =>
    <String, dynamic>{
      'addons': instance.addons.map((e) => e.toJson()).toList(),
      'categories': instance.categories.map((e) => e.toJson()).toList(),
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
