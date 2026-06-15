// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_override_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ChannelOverrideInputCWProxy {
  ChannelOverrideInput branchId(String branchId);

  ChannelOverrideInput channel(String channel);

  ChannelOverrideInput isAvailable(bool? isAvailable);

  ChannelOverrideInput menuItemId(String menuItemId);

  ChannelOverrideInput priceOverride(int? priceOverride);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ChannelOverrideInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ChannelOverrideInput(...).copyWith(id: 12, name: "My name")
  /// ````
  ChannelOverrideInput call({
    String branchId,
    String channel,
    bool? isAvailable,
    String menuItemId,
    int? priceOverride,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfChannelOverrideInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfChannelOverrideInput.copyWith.fieldName(...)`
class _$ChannelOverrideInputCWProxyImpl
    implements _$ChannelOverrideInputCWProxy {
  const _$ChannelOverrideInputCWProxyImpl(this._value);

  final ChannelOverrideInput _value;

  @override
  ChannelOverrideInput branchId(String branchId) => this(branchId: branchId);

  @override
  ChannelOverrideInput channel(String channel) => this(channel: channel);

  @override
  ChannelOverrideInput isAvailable(bool? isAvailable) =>
      this(isAvailable: isAvailable);

  @override
  ChannelOverrideInput menuItemId(String menuItemId) =>
      this(menuItemId: menuItemId);

  @override
  ChannelOverrideInput priceOverride(int? priceOverride) =>
      this(priceOverride: priceOverride);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ChannelOverrideInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ChannelOverrideInput(...).copyWith(id: 12, name: "My name")
  /// ````
  ChannelOverrideInput call({
    Object? branchId = const $CopyWithPlaceholder(),
    Object? channel = const $CopyWithPlaceholder(),
    Object? isAvailable = const $CopyWithPlaceholder(),
    Object? menuItemId = const $CopyWithPlaceholder(),
    Object? priceOverride = const $CopyWithPlaceholder(),
  }) {
    return ChannelOverrideInput(
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

extension $ChannelOverrideInputCopyWith on ChannelOverrideInput {
  /// Returns a callable class that can be used as follows: `instanceOfChannelOverrideInput.copyWith(...)` or like so:`instanceOfChannelOverrideInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ChannelOverrideInputCWProxy get copyWith =>
      _$ChannelOverrideInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelOverrideInput _$ChannelOverrideInputFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ChannelOverrideInput',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['branch_id', 'channel', 'menu_item_id'],
    );
    final val = ChannelOverrideInput(
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

Map<String, dynamic> _$ChannelOverrideInputToJson(
  ChannelOverrideInput instance,
) => <String, dynamic>{
  'branch_id': instance.branchId,
  'channel': instance.channel,
  'is_available': ?instance.isAvailable,
  'menu_item_id': instance.menuItemId,
  'price_override': ?instance.priceOverride,
};
