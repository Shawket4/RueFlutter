// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderItemInputCWProxy {
  OrderItemInput addons(List<AddonInput> addons);

  OrderItemInput bundleComponents(List<BundleComponentInput>? bundleComponents);

  OrderItemInput bundleId(String? bundleId);

  OrderItemInput menuItemId(String? menuItemId);

  OrderItemInput notes(String? notes);

  OrderItemInput optionalFieldIds(List<String> optionalFieldIds);

  OrderItemInput quantity(int quantity);

  OrderItemInput sizeLabel(String? sizeLabel);

  OrderItemInput unitPrice(int? unitPrice);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderItemInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderItemInput(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderItemInput call({
    List<AddonInput> addons,
    List<BundleComponentInput>? bundleComponents,
    String? bundleId,
    String? menuItemId,
    String? notes,
    List<String> optionalFieldIds,
    int quantity,
    String? sizeLabel,
    int? unitPrice,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderItemInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderItemInput.copyWith.fieldName(...)`
class _$OrderItemInputCWProxyImpl implements _$OrderItemInputCWProxy {
  const _$OrderItemInputCWProxyImpl(this._value);

  final OrderItemInput _value;

  @override
  OrderItemInput addons(List<AddonInput> addons) => this(addons: addons);

  @override
  OrderItemInput bundleComponents(
    List<BundleComponentInput>? bundleComponents,
  ) => this(bundleComponents: bundleComponents);

  @override
  OrderItemInput bundleId(String? bundleId) => this(bundleId: bundleId);

  @override
  OrderItemInput menuItemId(String? menuItemId) => this(menuItemId: menuItemId);

  @override
  OrderItemInput notes(String? notes) => this(notes: notes);

  @override
  OrderItemInput optionalFieldIds(List<String> optionalFieldIds) =>
      this(optionalFieldIds: optionalFieldIds);

  @override
  OrderItemInput quantity(int quantity) => this(quantity: quantity);

  @override
  OrderItemInput sizeLabel(String? sizeLabel) => this(sizeLabel: sizeLabel);

  @override
  OrderItemInput unitPrice(int? unitPrice) => this(unitPrice: unitPrice);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderItemInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderItemInput(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderItemInput call({
    Object? addons = const $CopyWithPlaceholder(),
    Object? bundleComponents = const $CopyWithPlaceholder(),
    Object? bundleId = const $CopyWithPlaceholder(),
    Object? menuItemId = const $CopyWithPlaceholder(),
    Object? notes = const $CopyWithPlaceholder(),
    Object? optionalFieldIds = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? sizeLabel = const $CopyWithPlaceholder(),
    Object? unitPrice = const $CopyWithPlaceholder(),
  }) {
    return OrderItemInput(
      addons: addons == const $CopyWithPlaceholder()
          ? _value.addons
          // ignore: cast_nullable_to_non_nullable
          : addons as List<AddonInput>,
      bundleComponents: bundleComponents == const $CopyWithPlaceholder()
          ? _value.bundleComponents
          // ignore: cast_nullable_to_non_nullable
          : bundleComponents as List<BundleComponentInput>?,
      bundleId: bundleId == const $CopyWithPlaceholder()
          ? _value.bundleId
          // ignore: cast_nullable_to_non_nullable
          : bundleId as String?,
      menuItemId: menuItemId == const $CopyWithPlaceholder()
          ? _value.menuItemId
          // ignore: cast_nullable_to_non_nullable
          : menuItemId as String?,
      notes: notes == const $CopyWithPlaceholder()
          ? _value.notes
          // ignore: cast_nullable_to_non_nullable
          : notes as String?,
      optionalFieldIds: optionalFieldIds == const $CopyWithPlaceholder()
          ? _value.optionalFieldIds
          // ignore: cast_nullable_to_non_nullable
          : optionalFieldIds as List<String>,
      quantity: quantity == const $CopyWithPlaceholder()
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as int,
      sizeLabel: sizeLabel == const $CopyWithPlaceholder()
          ? _value.sizeLabel
          // ignore: cast_nullable_to_non_nullable
          : sizeLabel as String?,
      unitPrice: unitPrice == const $CopyWithPlaceholder()
          ? _value.unitPrice
          // ignore: cast_nullable_to_non_nullable
          : unitPrice as int?,
    );
  }
}

extension $OrderItemInputCopyWith on OrderItemInput {
  /// Returns a callable class that can be used as follows: `instanceOfOrderItemInput.copyWith(...)` or like so:`instanceOfOrderItemInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderItemInputCWProxy get copyWith => _$OrderItemInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemInput _$OrderItemInputFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'OrderItemInput',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['addons', 'optional_field_ids', 'quantity'],
        );
        final val = OrderItemInput(
          addons: $checkedConvert(
            'addons',
            (v) => (v as List<dynamic>)
                .map((e) => AddonInput.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
          bundleComponents: $checkedConvert(
            'bundle_components',
            (v) => (v as List<dynamic>?)
                ?.map(
                  (e) =>
                      BundleComponentInput.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
          ),
          bundleId: $checkedConvert('bundle_id', (v) => v as String?),
          menuItemId: $checkedConvert('menu_item_id', (v) => v as String?),
          notes: $checkedConvert('notes', (v) => v as String?),
          optionalFieldIds: $checkedConvert(
            'optional_field_ids',
            (v) => (v as List<dynamic>).map((e) => e as String).toList(),
          ),
          quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
          sizeLabel: $checkedConvert('size_label', (v) => v as String?),
          unitPrice: $checkedConvert('unit_price', (v) => (v as num?)?.toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'bundleComponents': 'bundle_components',
        'bundleId': 'bundle_id',
        'menuItemId': 'menu_item_id',
        'optionalFieldIds': 'optional_field_ids',
        'sizeLabel': 'size_label',
        'unitPrice': 'unit_price',
      },
    );

Map<String, dynamic> _$OrderItemInputToJson(OrderItemInput instance) =>
    <String, dynamic>{
      'addons': instance.addons.map((e) => e.toJson()).toList(),
      'bundle_components': ?instance.bundleComponents
          ?.map((e) => e.toJson())
          .toList(),
      'bundle_id': ?instance.bundleId,
      'menu_item_id': ?instance.menuItemId,
      'notes': ?instance.notes,
      'optional_field_ids': instance.optionalFieldIds,
      'quantity': instance.quantity,
      'size_label': ?instance.sizeLabel,
      'unit_price': ?instance.unitPrice,
    };
