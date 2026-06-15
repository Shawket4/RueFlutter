// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_line_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CartLineInputCWProxy {
  CartLineInput addons(List<AddonInput>? addons);

  CartLineInput menuItemId(String menuItemId);

  CartLineInput notes(String? notes);

  CartLineInput optionalFieldIds(List<String>? optionalFieldIds);

  CartLineInput quantity(int quantity);

  CartLineInput sizeLabel(String? sizeLabel);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CartLineInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CartLineInput(...).copyWith(id: 12, name: "My name")
  /// ````
  CartLineInput call({
    List<AddonInput>? addons,
    String menuItemId,
    String? notes,
    List<String>? optionalFieldIds,
    int quantity,
    String? sizeLabel,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCartLineInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCartLineInput.copyWith.fieldName(...)`
class _$CartLineInputCWProxyImpl implements _$CartLineInputCWProxy {
  const _$CartLineInputCWProxyImpl(this._value);

  final CartLineInput _value;

  @override
  CartLineInput addons(List<AddonInput>? addons) => this(addons: addons);

  @override
  CartLineInput menuItemId(String menuItemId) => this(menuItemId: menuItemId);

  @override
  CartLineInput notes(String? notes) => this(notes: notes);

  @override
  CartLineInput optionalFieldIds(List<String>? optionalFieldIds) =>
      this(optionalFieldIds: optionalFieldIds);

  @override
  CartLineInput quantity(int quantity) => this(quantity: quantity);

  @override
  CartLineInput sizeLabel(String? sizeLabel) => this(sizeLabel: sizeLabel);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CartLineInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CartLineInput(...).copyWith(id: 12, name: "My name")
  /// ````
  CartLineInput call({
    Object? addons = const $CopyWithPlaceholder(),
    Object? menuItemId = const $CopyWithPlaceholder(),
    Object? notes = const $CopyWithPlaceholder(),
    Object? optionalFieldIds = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? sizeLabel = const $CopyWithPlaceholder(),
  }) {
    return CartLineInput(
      addons: addons == const $CopyWithPlaceholder()
          ? _value.addons
          // ignore: cast_nullable_to_non_nullable
          : addons as List<AddonInput>?,
      menuItemId: menuItemId == const $CopyWithPlaceholder()
          ? _value.menuItemId
          // ignore: cast_nullable_to_non_nullable
          : menuItemId as String,
      notes: notes == const $CopyWithPlaceholder()
          ? _value.notes
          // ignore: cast_nullable_to_non_nullable
          : notes as String?,
      optionalFieldIds: optionalFieldIds == const $CopyWithPlaceholder()
          ? _value.optionalFieldIds
          // ignore: cast_nullable_to_non_nullable
          : optionalFieldIds as List<String>?,
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

extension $CartLineInputCopyWith on CartLineInput {
  /// Returns a callable class that can be used as follows: `instanceOfCartLineInput.copyWith(...)` or like so:`instanceOfCartLineInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CartLineInputCWProxy get copyWith => _$CartLineInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartLineInput _$CartLineInputFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CartLineInput',
      json,
      ($checkedConvert) {
        $checkKeys(json, requiredKeys: const ['menu_item_id', 'quantity']);
        final val = CartLineInput(
          addons: $checkedConvert(
            'addons',
            (v) => (v as List<dynamic>?)
                ?.map((e) => AddonInput.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
          menuItemId: $checkedConvert('menu_item_id', (v) => v as String),
          notes: $checkedConvert('notes', (v) => v as String?),
          optionalFieldIds: $checkedConvert(
            'optional_field_ids',
            (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
          ),
          quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
          sizeLabel: $checkedConvert('size_label', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'menuItemId': 'menu_item_id',
        'optionalFieldIds': 'optional_field_ids',
        'sizeLabel': 'size_label',
      },
    );

Map<String, dynamic> _$CartLineInputToJson(CartLineInput instance) =>
    <String, dynamic>{
      'addons': ?instance.addons?.map((e) => e.toJson()).toList(),
      'menu_item_id': instance.menuItemId,
      'notes': ?instance.notes,
      'optional_field_ids': ?instance.optionalFieldIds,
      'quantity': instance.quantity,
      'size_label': ?instance.sizeLabel,
    };
