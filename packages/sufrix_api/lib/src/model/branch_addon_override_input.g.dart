// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_addon_override_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BranchAddonOverrideInputCWProxy {
  BranchAddonOverrideInput addonItemId(String addonItemId);

  BranchAddonOverrideInput branchId(String branchId);

  BranchAddonOverrideInput isAvailable(bool? isAvailable);

  BranchAddonOverrideInput priceOverride(int? priceOverride);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BranchAddonOverrideInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BranchAddonOverrideInput(...).copyWith(id: 12, name: "My name")
  /// ````
  BranchAddonOverrideInput call({
    String addonItemId,
    String branchId,
    bool? isAvailable,
    int? priceOverride,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBranchAddonOverrideInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBranchAddonOverrideInput.copyWith.fieldName(...)`
class _$BranchAddonOverrideInputCWProxyImpl
    implements _$BranchAddonOverrideInputCWProxy {
  const _$BranchAddonOverrideInputCWProxyImpl(this._value);

  final BranchAddonOverrideInput _value;

  @override
  BranchAddonOverrideInput addonItemId(String addonItemId) =>
      this(addonItemId: addonItemId);

  @override
  BranchAddonOverrideInput branchId(String branchId) =>
      this(branchId: branchId);

  @override
  BranchAddonOverrideInput isAvailable(bool? isAvailable) =>
      this(isAvailable: isAvailable);

  @override
  BranchAddonOverrideInput priceOverride(int? priceOverride) =>
      this(priceOverride: priceOverride);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BranchAddonOverrideInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BranchAddonOverrideInput(...).copyWith(id: 12, name: "My name")
  /// ````
  BranchAddonOverrideInput call({
    Object? addonItemId = const $CopyWithPlaceholder(),
    Object? branchId = const $CopyWithPlaceholder(),
    Object? isAvailable = const $CopyWithPlaceholder(),
    Object? priceOverride = const $CopyWithPlaceholder(),
  }) {
    return BranchAddonOverrideInput(
      addonItemId: addonItemId == const $CopyWithPlaceholder()
          ? _value.addonItemId
          // ignore: cast_nullable_to_non_nullable
          : addonItemId as String,
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String,
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

extension $BranchAddonOverrideInputCopyWith on BranchAddonOverrideInput {
  /// Returns a callable class that can be used as follows: `instanceOfBranchAddonOverrideInput.copyWith(...)` or like so:`instanceOfBranchAddonOverrideInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BranchAddonOverrideInputCWProxy get copyWith =>
      _$BranchAddonOverrideInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchAddonOverrideInput _$BranchAddonOverrideInputFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'BranchAddonOverrideInput',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['addon_item_id', 'branch_id']);
    final val = BranchAddonOverrideInput(
      addonItemId: $checkedConvert('addon_item_id', (v) => v as String),
      branchId: $checkedConvert('branch_id', (v) => v as String),
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

Map<String, dynamic> _$BranchAddonOverrideInputToJson(
  BranchAddonOverrideInput instance,
) => <String, dynamic>{
  'addon_item_id': instance.addonItemId,
  'branch_id': instance.branchId,
  'is_available': ?instance.isAvailable,
  'price_override': ?instance.priceOverride,
};
