// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_addon_override.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BranchAddonOverrideCWProxy {
  BranchAddonOverride addonItemId(String addonItemId);

  BranchAddonOverride branchId(String branchId);

  BranchAddonOverride isAvailable(bool isAvailable);

  BranchAddonOverride priceOverride(int? priceOverride);

  BranchAddonOverride updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BranchAddonOverride(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BranchAddonOverride(...).copyWith(id: 12, name: "My name")
  /// ````
  BranchAddonOverride call({
    String addonItemId,
    String branchId,
    bool isAvailable,
    int? priceOverride,
    DateTime updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBranchAddonOverride.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBranchAddonOverride.copyWith.fieldName(...)`
class _$BranchAddonOverrideCWProxyImpl implements _$BranchAddonOverrideCWProxy {
  const _$BranchAddonOverrideCWProxyImpl(this._value);

  final BranchAddonOverride _value;

  @override
  BranchAddonOverride addonItemId(String addonItemId) =>
      this(addonItemId: addonItemId);

  @override
  BranchAddonOverride branchId(String branchId) => this(branchId: branchId);

  @override
  BranchAddonOverride isAvailable(bool isAvailable) =>
      this(isAvailable: isAvailable);

  @override
  BranchAddonOverride priceOverride(int? priceOverride) =>
      this(priceOverride: priceOverride);

  @override
  BranchAddonOverride updatedAt(DateTime updatedAt) =>
      this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BranchAddonOverride(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BranchAddonOverride(...).copyWith(id: 12, name: "My name")
  /// ````
  BranchAddonOverride call({
    Object? addonItemId = const $CopyWithPlaceholder(),
    Object? branchId = const $CopyWithPlaceholder(),
    Object? isAvailable = const $CopyWithPlaceholder(),
    Object? priceOverride = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return BranchAddonOverride(
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
          : isAvailable as bool,
      priceOverride: priceOverride == const $CopyWithPlaceholder()
          ? _value.priceOverride
          // ignore: cast_nullable_to_non_nullable
          : priceOverride as int?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $BranchAddonOverrideCopyWith on BranchAddonOverride {
  /// Returns a callable class that can be used as follows: `instanceOfBranchAddonOverride.copyWith(...)` or like so:`instanceOfBranchAddonOverride.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BranchAddonOverrideCWProxy get copyWith =>
      _$BranchAddonOverrideCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchAddonOverride _$BranchAddonOverrideFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'BranchAddonOverride',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'addon_item_id',
            'branch_id',
            'is_available',
            'updated_at',
          ],
        );
        final val = BranchAddonOverride(
          addonItemId: $checkedConvert('addon_item_id', (v) => v as String),
          branchId: $checkedConvert('branch_id', (v) => v as String),
          isAvailable: $checkedConvert('is_available', (v) => v as bool),
          priceOverride: $checkedConvert(
            'price_override',
            (v) => (v as num?)?.toInt(),
          ),
          updatedAt: $checkedConvert(
            'updated_at',
            (v) => DateTime.parse(v as String),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'addonItemId': 'addon_item_id',
        'branchId': 'branch_id',
        'isAvailable': 'is_available',
        'priceOverride': 'price_override',
        'updatedAt': 'updated_at',
      },
    );

Map<String, dynamic> _$BranchAddonOverrideToJson(
  BranchAddonOverride instance,
) => <String, dynamic>{
  'addon_item_id': instance.addonItemId,
  'branch_id': instance.branchId,
  'is_available': instance.isAvailable,
  'price_override': ?instance.priceOverride,
  'updated_at': instance.updatedAt.toIso8601String(),
};
