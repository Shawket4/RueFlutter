// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addon_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AddonInputCWProxy {
  AddonInput addonItemId(String addonItemId);

  AddonInput quantity(int? quantity);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddonInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddonInput(...).copyWith(id: 12, name: "My name")
  /// ````
  AddonInput call({String addonItemId, int? quantity});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAddonInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAddonInput.copyWith.fieldName(...)`
class _$AddonInputCWProxyImpl implements _$AddonInputCWProxy {
  const _$AddonInputCWProxyImpl(this._value);

  final AddonInput _value;

  @override
  AddonInput addonItemId(String addonItemId) => this(addonItemId: addonItemId);

  @override
  AddonInput quantity(int? quantity) => this(quantity: quantity);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddonInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddonInput(...).copyWith(id: 12, name: "My name")
  /// ````
  AddonInput call({
    Object? addonItemId = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
  }) {
    return AddonInput(
      addonItemId: addonItemId == const $CopyWithPlaceholder()
          ? _value.addonItemId
          // ignore: cast_nullable_to_non_nullable
          : addonItemId as String,
      quantity: quantity == const $CopyWithPlaceholder()
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as int?,
    );
  }
}

extension $AddonInputCopyWith on AddonInput {
  /// Returns a callable class that can be used as follows: `instanceOfAddonInput.copyWith(...)` or like so:`instanceOfAddonInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AddonInputCWProxy get copyWith => _$AddonInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddonInput _$AddonInputFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AddonInput', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['addon_item_id']);
      final val = AddonInput(
        addonItemId: $checkedConvert('addon_item_id', (v) => v as String),
        quantity: $checkedConvert('quantity', (v) => (v as num?)?.toInt()),
      );
      return val;
    }, fieldKeyMap: const {'addonItemId': 'addon_item_id'});

Map<String, dynamic> _$AddonInputToJson(AddonInput instance) =>
    <String, dynamic>{
      'addon_item_id': instance.addonItemId,
      'quantity': ?instance.quantity,
    };
