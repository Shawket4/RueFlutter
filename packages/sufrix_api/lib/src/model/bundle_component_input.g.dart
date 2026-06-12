// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bundle_component_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BundleComponentInputCWProxy {
  BundleComponentInput addons(List<AddonInput>? addons);

  BundleComponentInput itemId(String itemId);

  BundleComponentInput optionalFieldIds(List<String>? optionalFieldIds);

  BundleComponentInput quantity(int quantity);

  BundleComponentInput sizeLabel(String? sizeLabel);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BundleComponentInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BundleComponentInput(...).copyWith(id: 12, name: "My name")
  /// ````
  BundleComponentInput call({
    List<AddonInput>? addons,
    String itemId,
    List<String>? optionalFieldIds,
    int quantity,
    String? sizeLabel,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBundleComponentInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBundleComponentInput.copyWith.fieldName(...)`
class _$BundleComponentInputCWProxyImpl
    implements _$BundleComponentInputCWProxy {
  const _$BundleComponentInputCWProxyImpl(this._value);

  final BundleComponentInput _value;

  @override
  BundleComponentInput addons(List<AddonInput>? addons) => this(addons: addons);

  @override
  BundleComponentInput itemId(String itemId) => this(itemId: itemId);

  @override
  BundleComponentInput optionalFieldIds(List<String>? optionalFieldIds) =>
      this(optionalFieldIds: optionalFieldIds);

  @override
  BundleComponentInput quantity(int quantity) => this(quantity: quantity);

  @override
  BundleComponentInput sizeLabel(String? sizeLabel) =>
      this(sizeLabel: sizeLabel);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BundleComponentInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BundleComponentInput(...).copyWith(id: 12, name: "My name")
  /// ````
  BundleComponentInput call({
    Object? addons = const $CopyWithPlaceholder(),
    Object? itemId = const $CopyWithPlaceholder(),
    Object? optionalFieldIds = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? sizeLabel = const $CopyWithPlaceholder(),
  }) {
    return BundleComponentInput(
      addons: addons == const $CopyWithPlaceholder()
          ? _value.addons
          // ignore: cast_nullable_to_non_nullable
          : addons as List<AddonInput>?,
      itemId: itemId == const $CopyWithPlaceholder()
          ? _value.itemId
          // ignore: cast_nullable_to_non_nullable
          : itemId as String,
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

extension $BundleComponentInputCopyWith on BundleComponentInput {
  /// Returns a callable class that can be used as follows: `instanceOfBundleComponentInput.copyWith(...)` or like so:`instanceOfBundleComponentInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BundleComponentInputCWProxy get copyWith =>
      _$BundleComponentInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BundleComponentInput _$BundleComponentInputFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'BundleComponentInput',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['item_id', 'quantity']);
    final val = BundleComponentInput(
      addons: $checkedConvert(
        'addons',
        (v) => (v as List<dynamic>?)
            ?.map((e) => AddonInput.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      itemId: $checkedConvert('item_id', (v) => v as String),
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
    'itemId': 'item_id',
    'optionalFieldIds': 'optional_field_ids',
    'sizeLabel': 'size_label',
  },
);

Map<String, dynamic> _$BundleComponentInputToJson(
  BundleComponentInput instance,
) => <String, dynamic>{
  'addons': ?instance.addons?.map((e) => e.toJson()).toList(),
  'item_id': instance.itemId,
  'optional_field_ids': ?instance.optionalFieldIds,
  'quantity': instance.quantity,
  'size_label': ?instance.sizeLabel,
};
