// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_addon_override_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ChannelAddonOverrideInputCWProxy {
  ChannelAddonOverrideInput addonItemId(String addonItemId);

  ChannelAddonOverrideInput branchId(String branchId);

  ChannelAddonOverrideInput channel(String channel);

  ChannelAddonOverrideInput isAvailable(bool? isAvailable);

  ChannelAddonOverrideInput priceOverride(int? priceOverride);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ChannelAddonOverrideInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ChannelAddonOverrideInput(...).copyWith(id: 12, name: "My name")
  /// ````
  ChannelAddonOverrideInput call({
    String addonItemId,
    String branchId,
    String channel,
    bool? isAvailable,
    int? priceOverride,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfChannelAddonOverrideInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfChannelAddonOverrideInput.copyWith.fieldName(...)`
class _$ChannelAddonOverrideInputCWProxyImpl
    implements _$ChannelAddonOverrideInputCWProxy {
  const _$ChannelAddonOverrideInputCWProxyImpl(this._value);

  final ChannelAddonOverrideInput _value;

  @override
  ChannelAddonOverrideInput addonItemId(String addonItemId) =>
      this(addonItemId: addonItemId);

  @override
  ChannelAddonOverrideInput branchId(String branchId) =>
      this(branchId: branchId);

  @override
  ChannelAddonOverrideInput channel(String channel) => this(channel: channel);

  @override
  ChannelAddonOverrideInput isAvailable(bool? isAvailable) =>
      this(isAvailable: isAvailable);

  @override
  ChannelAddonOverrideInput priceOverride(int? priceOverride) =>
      this(priceOverride: priceOverride);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ChannelAddonOverrideInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ChannelAddonOverrideInput(...).copyWith(id: 12, name: "My name")
  /// ````
  ChannelAddonOverrideInput call({
    Object? addonItemId = const $CopyWithPlaceholder(),
    Object? branchId = const $CopyWithPlaceholder(),
    Object? channel = const $CopyWithPlaceholder(),
    Object? isAvailable = const $CopyWithPlaceholder(),
    Object? priceOverride = const $CopyWithPlaceholder(),
  }) {
    return ChannelAddonOverrideInput(
      addonItemId: addonItemId == const $CopyWithPlaceholder()
          ? _value.addonItemId
          // ignore: cast_nullable_to_non_nullable
          : addonItemId as String,
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String,
      channel: channel == const $CopyWithPlaceholder()
          ? _value.channel
          // ignore: cast_nullable_to_non_nullable
          : channel as String,
      isAvailable: isAvailable == const $CopyWithPlaceholder()
          ? _value.isAvailable
          // ignore: cast_nullable_to_non_nullable
          : isAvailable as bool?,
      priceOverride: priceOverride == const $CopyWithPlaceholder()
          ? _value.priceOverride
          // ignore: cast_nullable_to_non_nullable
          : priceOverride as int?,
    );
  }
}

extension $ChannelAddonOverrideInputCopyWith on ChannelAddonOverrideInput {
  /// Returns a callable class that can be used as follows: `instanceOfChannelAddonOverrideInput.copyWith(...)` or like so:`instanceOfChannelAddonOverrideInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ChannelAddonOverrideInputCWProxy get copyWith =>
      _$ChannelAddonOverrideInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelAddonOverrideInput _$ChannelAddonOverrideInputFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ChannelAddonOverrideInput',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['addon_item_id', 'branch_id', 'channel'],
    );
    final val = ChannelAddonOverrideInput(
      addonItemId: $checkedConvert('addon_item_id', (v) => v as String),
      branchId: $checkedConvert('branch_id', (v) => v as String),
      channel: $checkedConvert('channel', (v) => v as String),
      isAvailable: $checkedConvert('is_available', (v) => v as bool?),
      priceOverride: $checkedConvert(
        'price_override',
        (v) => (v as num?)?.toInt(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'addonItemId': 'addon_item_id',
    'branchId': 'branch_id',
    'isAvailable': 'is_available',
    'priceOverride': 'price_override',
  },
);

Map<String, dynamic> _$ChannelAddonOverrideInputToJson(
  ChannelAddonOverrideInput instance,
) => <String, dynamic>{
  'addon_item_id': instance.addonItemId,
  'branch_id': instance.branchId,
  'channel': instance.channel,
  'is_available': ?instance.isAvailable,
  'price_override': ?instance.priceOverride,
};
