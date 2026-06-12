// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_bundle_component_full.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderBundleComponentFullCWProxy {
  OrderBundleComponentFull addons(List<OrderBundleComponentAddon> addons);

  OrderBundleComponentFull itemId(String itemId);

  OrderBundleComponentFull itemName(String itemName);

  OrderBundleComponentFull nameTranslations(Object nameTranslations);

  OrderBundleComponentFull optionals(
    List<OrderBundleComponentOptional> optionals,
  );

  OrderBundleComponentFull quantity(int quantity);

  OrderBundleComponentFull sizeLabel(String? sizeLabel);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderBundleComponentFull(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderBundleComponentFull(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderBundleComponentFull call({
    List<OrderBundleComponentAddon> addons,
    String itemId,
    String itemName,
    Object nameTranslations,
    List<OrderBundleComponentOptional> optionals,
    int quantity,
    String? sizeLabel,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderBundleComponentFull.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderBundleComponentFull.copyWith.fieldName(...)`
class _$OrderBundleComponentFullCWProxyImpl
    implements _$OrderBundleComponentFullCWProxy {
  const _$OrderBundleComponentFullCWProxyImpl(this._value);

  final OrderBundleComponentFull _value;

  @override
  OrderBundleComponentFull addons(List<OrderBundleComponentAddon> addons) =>
      this(addons: addons);

  @override
  OrderBundleComponentFull itemId(String itemId) => this(itemId: itemId);

  @override
  OrderBundleComponentFull itemName(String itemName) =>
      this(itemName: itemName);

  @override
  OrderBundleComponentFull nameTranslations(Object nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  OrderBundleComponentFull optionals(
    List<OrderBundleComponentOptional> optionals,
  ) => this(optionals: optionals);

  @override
  OrderBundleComponentFull quantity(int quantity) => this(quantity: quantity);

  @override
  OrderBundleComponentFull sizeLabel(String? sizeLabel) =>
      this(sizeLabel: sizeLabel);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderBundleComponentFull(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderBundleComponentFull(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderBundleComponentFull call({
    Object? addons = const $CopyWithPlaceholder(),
    Object? itemId = const $CopyWithPlaceholder(),
    Object? itemName = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
    Object? optionals = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? sizeLabel = const $CopyWithPlaceholder(),
  }) {
    return OrderBundleComponentFull(
      addons: addons == const $CopyWithPlaceholder()
          ? _value.addons
          // ignore: cast_nullable_to_non_nullable
          : addons as List<OrderBundleComponentAddon>,
      itemId: itemId == const $CopyWithPlaceholder()
          ? _value.itemId
          // ignore: cast_nullable_to_non_nullable
          : itemId as String,
      itemName: itemName == const $CopyWithPlaceholder()
          ? _value.itemName
          // ignore: cast_nullable_to_non_nullable
          : itemName as String,
      nameTranslations: nameTranslations == const $CopyWithPlaceholder()
          ? _value.nameTranslations
          // ignore: cast_nullable_to_non_nullable
          : nameTranslations as Object,
      optionals: optionals == const $CopyWithPlaceholder()
          ? _value.optionals
          // ignore: cast_nullable_to_non_nullable
          : optionals as List<OrderBundleComponentOptional>,
      quantity: quantity == const $CopyWithPlaceholder()
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as int,
      sizeLabel: sizeLabel == const $CopyWithPlaceholder()
          ? _value.sizeLabel
          // ignore: cast_nullable_to_non_nullable
          : sizeLabel as String?,
    );
  }
}

extension $OrderBundleComponentFullCopyWith on OrderBundleComponentFull {
  /// Returns a callable class that can be used as follows: `instanceOfOrderBundleComponentFull.copyWith(...)` or like so:`instanceOfOrderBundleComponentFull.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderBundleComponentFullCWProxy get copyWith =>
      _$OrderBundleComponentFullCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderBundleComponentFull _$OrderBundleComponentFullFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'OrderBundleComponentFull',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'addons',
        'item_id',
        'item_name',
        'name_translations',
        'optionals',
        'quantity',
      ],
    );
    final val = OrderBundleComponentFull(
      addons: $checkedConvert(
        'addons',
        (v) => (v as List<dynamic>)
            .map(
              (e) =>
                  OrderBundleComponentAddon.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      itemId: $checkedConvert('item_id', (v) => v as String),
      itemName: $checkedConvert('item_name', (v) => v as String),
      nameTranslations: $checkedConvert(
        'name_translations',
        (v) => v as Object,
      ),
      optionals: $checkedConvert(
        'optionals',
        (v) => (v as List<dynamic>)
            .map(
              (e) => OrderBundleComponentOptional.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
      ),
      quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
      sizeLabel: $checkedConvert('size_label', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'itemId': 'item_id',
    'itemName': 'item_name',
    'nameTranslations': 'name_translations',
    'sizeLabel': 'size_label',
  },
);

Map<String, dynamic> _$OrderBundleComponentFullToJson(
  OrderBundleComponentFull instance,
) => <String, dynamic>{
  'addons': instance.addons.map((e) => e.toJson()).toList(),
  'item_id': instance.itemId,
  'item_name': instance.itemName,
  'name_translations': instance.nameTranslations,
  'optionals': instance.optionals.map((e) => e.toJson()).toList(),
  'quantity': instance.quantity,
  'size_label': ?instance.sizeLabel,
};
