// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_bundle_component_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateBundleComponentInputCWProxy {
  CreateBundleComponentInput itemId(String itemId);

  CreateBundleComponentInput position(int? position);

  CreateBundleComponentInput quantity(int quantity);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateBundleComponentInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateBundleComponentInput(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateBundleComponentInput call({String itemId, int? position, int quantity});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCreateBundleComponentInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCreateBundleComponentInput.copyWith.fieldName(...)`
class _$CreateBundleComponentInputCWProxyImpl
    implements _$CreateBundleComponentInputCWProxy {
  const _$CreateBundleComponentInputCWProxyImpl(this._value);

  final CreateBundleComponentInput _value;

  @override
  CreateBundleComponentInput itemId(String itemId) => this(itemId: itemId);

  @override
  CreateBundleComponentInput position(int? position) =>
      this(position: position);

  @override
  CreateBundleComponentInput quantity(int quantity) => this(quantity: quantity);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateBundleComponentInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateBundleComponentInput(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateBundleComponentInput call({
    Object? itemId = const $CopyWithPlaceholder(),
    Object? position = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
  }) {
    return CreateBundleComponentInput(
      itemId: itemId == const $CopyWithPlaceholder()
          ? _value.itemId
          // ignore: cast_nullable_to_non_nullable
          : itemId as String,
      position: position == const $CopyWithPlaceholder()
          ? _value.position
          // ignore: cast_nullable_to_non_nullable
          : position as int?,
      quantity: quantity == const $CopyWithPlaceholder()
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as int,
    );
  }
}

extension $CreateBundleComponentInputCopyWith on CreateBundleComponentInput {
  /// Returns a callable class that can be used as follows: `instanceOfCreateBundleComponentInput.copyWith(...)` or like so:`instanceOfCreateBundleComponentInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateBundleComponentInputCWProxy get copyWith =>
      _$CreateBundleComponentInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateBundleComponentInput _$CreateBundleComponentInputFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('CreateBundleComponentInput', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['item_id', 'quantity']);
  final val = CreateBundleComponentInput(
    itemId: $checkedConvert('item_id', (v) => v as String),
    position: $checkedConvert('position', (v) => (v as num?)?.toInt()),
    quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
  );
  return val;
}, fieldKeyMap: const {'itemId': 'item_id'});

Map<String, dynamic> _$CreateBundleComponentInputToJson(
  CreateBundleComponentInput instance,
) => <String, dynamic>{
  'item_id': instance.itemId,
  'position': ?instance.position,
  'quantity': instance.quantity,
};
