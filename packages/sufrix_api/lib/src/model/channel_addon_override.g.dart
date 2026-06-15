// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_addon_override.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ChannelAddonOverrideCWProxy {
  ChannelAddonOverride addonItemId(String addonItemId);

  ChannelAddonOverride branchId(String branchId);

  ChannelAddonOverride channel(String channel);

  ChannelAddonOverride isAvailable(bool? isAvailable);

  ChannelAddonOverride priceOverride(int? priceOverride);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ChannelAddonOverride(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ChannelAddonOverride(...).copyWith(id: 12, name: "My name")
  /// ````
  ChannelAddonOverride call({
    String addonItemId,
    String branchId,
    String channel,
    bool? isAvailable,
    int? priceOverride,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfChannelAddonOverride.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfChannelAddonOverride.copyWith.fieldName(...)`
class _$ChannelAddonOverrideCWProxyImpl
    implements _$ChannelAddonOverrideCWProxy {
  const _$ChannelAddonOverrideCWProxyImpl(this._value);

  final ChannelAddonOverride _value;

  @override
  ChannelAddonOverride addonItemId(String addonItemId) =>
      this(addonItemId: addonItemId);

  @override
  ChannelAddonOverride branchId(String branchId) => this(branchId: branchId);

  @override
  ChannelAddonOverride channel(String channel) => this(channel: channel);

  @override
  ChannelAddonOverride isAvailable(bool? isAvailable) =>
      this(isAvailable: isAvailable);

  @override
  ChannelAddonOverride priceOverride(int? priceOverride) =>
      this(priceOverride: priceOverride);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ChannelAddonOverride(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ChannelAddonOverride(...).copyWith(id: 12, name: "My name")
  /// ````
  ChannelAddonOverride call({
    Object? addonItemId = const $CopyWithPlaceholder(),
    Object? branchId = const $CopyWithPlaceholder(),
    Object? channel = const $CopyWithPlaceholder(),
    Object? isAvailable = const $CopyWithPlaceholder(),
    Object? priceOverride = const $CopyWithPlaceholder(),
  }) {
    return ChannelAddonOverride(
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

extension $ChannelAddonOverrideCopyWith on ChannelAddonOverride {
  /// Returns a callable class that can be used as follows: `instanceOfChannelAddonOverride.copyWith(...)` or like so:`instanceOfChannelAddonOverride.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ChannelAddonOverrideCWProxy get copyWith =>
      _$ChannelAddonOverrideCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelAddonOverride _$ChannelAddonOverrideFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ChannelAddonOverride',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['addon_item_id', 'branch_id', 'channel'],
    );
    final val = ChannelAddonOverride(
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

Map<String, dynamic> _$ChannelAddonOverrideToJson(
  ChannelAddonOverride instance,
) => <String, dynamic>{
  'addon_item_id': instance.addonItemId,
  'branch_id': instance.branchId,
  'channel': instance.channel,
  'is_available': ?instance.isAvailable,
  'price_override': ?instance.priceOverride,
};
