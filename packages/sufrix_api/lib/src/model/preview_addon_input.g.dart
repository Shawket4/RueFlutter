// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preview_addon_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PreviewAddonInputCWProxy {
  PreviewAddonInput addonItemId(String addonItemId);

  PreviewAddonInput quantity(int? quantity);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PreviewAddonInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PreviewAddonInput(...).copyWith(id: 12, name: "My name")
  /// ````
  PreviewAddonInput call({String addonItemId, int? quantity});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPreviewAddonInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPreviewAddonInput.copyWith.fieldName(...)`
class _$PreviewAddonInputCWProxyImpl implements _$PreviewAddonInputCWProxy {
  const _$PreviewAddonInputCWProxyImpl(this._value);

  final PreviewAddonInput _value;

  @override
  PreviewAddonInput addonItemId(String addonItemId) =>
      this(addonItemId: addonItemId);

  @override
  PreviewAddonInput quantity(int? quantity) => this(quantity: quantity);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PreviewAddonInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PreviewAddonInput(...).copyWith(id: 12, name: "My name")
  /// ````
  PreviewAddonInput call({
    Object? addonItemId = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
  }) {
    return PreviewAddonInput(
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

extension $PreviewAddonInputCopyWith on PreviewAddonInput {
  /// Returns a callable class that can be used as follows: `instanceOfPreviewAddonInput.copyWith(...)` or like so:`instanceOfPreviewAddonInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PreviewAddonInputCWProxy get copyWith =>
      _$PreviewAddonInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreviewAddonInput _$PreviewAddonInputFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PreviewAddonInput', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['addon_item_id']);
      final val = PreviewAddonInput(
        addonItemId: $checkedConvert('addon_item_id', (v) => v as String),
        quantity: $checkedConvert('quantity', (v) => (v as num?)?.toInt()),
      );
      return val;
    }, fieldKeyMap: const {'addonItemId': 'addon_item_id'});

Map<String, dynamic> _$PreviewAddonInputToJson(PreviewAddonInput instance) =>
    <String, dynamic>{
      'addon_item_id': instance.addonItemId,
      'quantity': ?instance.quantity,
    };
