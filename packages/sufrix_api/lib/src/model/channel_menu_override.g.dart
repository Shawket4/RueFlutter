// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_menu_override.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ChannelMenuOverrideCWProxy {
  ChannelMenuOverride branchId(String branchId);

  ChannelMenuOverride channel(String channel);

  ChannelMenuOverride isAvailable(bool? isAvailable);

  ChannelMenuOverride menuItemId(String menuItemId);

  ChannelMenuOverride priceOverride(int? priceOverride);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ChannelMenuOverride(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ChannelMenuOverride(...).copyWith(id: 12, name: "My name")
  /// ````
  ChannelMenuOverride call({
    String branchId,
    String channel,
    bool? isAvailable,
    String menuItemId,
    int? priceOverride,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfChannelMenuOverride.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfChannelMenuOverride.copyWith.fieldName(...)`
class _$ChannelMenuOverrideCWProxyImpl implements _$ChannelMenuOverrideCWProxy {
  const _$ChannelMenuOverrideCWProxyImpl(this._value);

  final ChannelMenuOverride _value;

  @override
  ChannelMenuOverride branchId(String branchId) => this(branchId: branchId);

  @override
  ChannelMenuOverride channel(String channel) => this(channel: channel);

  @override
  ChannelMenuOverride isAvailable(bool? isAvailable) =>
      this(isAvailable: isAvailable);

  @override
  ChannelMenuOverride menuItemId(String menuItemId) =>
      this(menuItemId: menuItemId);

  @override
  ChannelMenuOverride priceOverride(int? priceOverride) =>
      this(priceOverride: priceOverride);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ChannelMenuOverride(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ChannelMenuOverride(...).copyWith(id: 12, name: "My name")
  /// ````
  ChannelMenuOverride call({
    Object? branchId = const $CopyWithPlaceholder(),
    Object? channel = const $CopyWithPlaceholder(),
    Object? isAvailable = const $CopyWithPlaceholder(),
    Object? menuItemId = const $CopyWithPlaceholder(),
    Object? priceOverride = const $CopyWithPlaceholder(),
  }) {
    return ChannelMenuOverride(
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
      menuItemId: menuItemId == const $CopyWithPlaceholder()
          ? _value.menuItemId
          // ignore: cast_nullable_to_non_nullable
          : menuItemId as String,
      priceOverride: priceOverride == const $CopyWithPlaceholder()
          ? _value.priceOverride
          // ignore: cast_nullable_to_non_nullable
          : priceOverride as int?,
    );
  }
}

extension $ChannelMenuOverrideCopyWith on ChannelMenuOverride {
  /// Returns a callable class that can be used as follows: `instanceOfChannelMenuOverride.copyWith(...)` or like so:`instanceOfChannelMenuOverride.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ChannelMenuOverrideCWProxy get copyWith =>
      _$ChannelMenuOverrideCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelMenuOverride _$ChannelMenuOverrideFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ChannelMenuOverride',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['branch_id', 'channel', 'menu_item_id'],
        );
        final val = ChannelMenuOverride(
          branchId: $checkedConvert('branch_id', (v) => v as String),
          channel: $checkedConvert('channel', (v) => v as String),
          isAvailable: $checkedConvert('is_available', (v) => v as bool?),
          menuItemId: $checkedConvert('menu_item_id', (v) => v as String),
          priceOverride: $checkedConvert(
            'price_override',
            (v) => (v as num?)?.toInt(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'branchId': 'branch_id',
        'isAvailable': 'is_available',
        'menuItemId': 'menu_item_id',
        'priceOverride': 'price_override',
      },
    );

Map<String, dynamic> _$ChannelMenuOverrideToJson(
  ChannelMenuOverride instance,
) => <String, dynamic>{
  'branch_id': instance.branchId,
  'channel': instance.channel,
  'is_available': ?instance.isAvailable,
  'menu_item_id': instance.menuItemId,
  'price_override': ?instance.priceOverride,
};
