// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_menu_override_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BranchMenuOverrideInputCWProxy {
  BranchMenuOverrideInput branchId(String branchId);

  BranchMenuOverrideInput isAvailable(bool? isAvailable);

  BranchMenuOverrideInput menuItemId(String menuItemId);

  BranchMenuOverrideInput priceOverride(int? priceOverride);

  BranchMenuOverrideInput sizes(List<BranchSizeOverrideInput>? sizes);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BranchMenuOverrideInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BranchMenuOverrideInput(...).copyWith(id: 12, name: "My name")
  /// ````
  BranchMenuOverrideInput call({
    String branchId,
    bool? isAvailable,
    String menuItemId,
    int? priceOverride,
    List<BranchSizeOverrideInput>? sizes,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBranchMenuOverrideInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBranchMenuOverrideInput.copyWith.fieldName(...)`
class _$BranchMenuOverrideInputCWProxyImpl
    implements _$BranchMenuOverrideInputCWProxy {
  const _$BranchMenuOverrideInputCWProxyImpl(this._value);

  final BranchMenuOverrideInput _value;

  @override
  BranchMenuOverrideInput branchId(String branchId) => this(branchId: branchId);

  @override
  BranchMenuOverrideInput isAvailable(bool? isAvailable) =>
      this(isAvailable: isAvailable);

  @override
  BranchMenuOverrideInput menuItemId(String menuItemId) =>
      this(menuItemId: menuItemId);

  @override
  BranchMenuOverrideInput priceOverride(int? priceOverride) =>
      this(priceOverride: priceOverride);

  @override
  BranchMenuOverrideInput sizes(List<BranchSizeOverrideInput>? sizes) =>
      this(sizes: sizes);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BranchMenuOverrideInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BranchMenuOverrideInput(...).copyWith(id: 12, name: "My name")
  /// ````
  BranchMenuOverrideInput call({
    Object? branchId = const $CopyWithPlaceholder(),
    Object? isAvailable = const $CopyWithPlaceholder(),
    Object? menuItemId = const $CopyWithPlaceholder(),
    Object? priceOverride = const $CopyWithPlaceholder(),
    Object? sizes = const $CopyWithPlaceholder(),
  }) {
    return BranchMenuOverrideInput(
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String,
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
      sizes: sizes == const $CopyWithPlaceholder()
          ? _value.sizes
          // ignore: cast_nullable_to_non_nullable
          : sizes as List<BranchSizeOverrideInput>?,
    );
  }
}

extension $BranchMenuOverrideInputCopyWith on BranchMenuOverrideInput {
  /// Returns a callable class that can be used as follows: `instanceOfBranchMenuOverrideInput.copyWith(...)` or like so:`instanceOfBranchMenuOverrideInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BranchMenuOverrideInputCWProxy get copyWith =>
      _$BranchMenuOverrideInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchMenuOverrideInput _$BranchMenuOverrideInputFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'BranchMenuOverrideInput',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['branch_id', 'menu_item_id']);
    final val = BranchMenuOverrideInput(
      branchId: $checkedConvert('branch_id', (v) => v as String),
      isAvailable: $checkedConvert('is_available', (v) => v as bool?),
      menuItemId: $checkedConvert('menu_item_id', (v) => v as String),
      priceOverride: $checkedConvert(
        'price_override',
        (v) => (v as num?)?.toInt(),
      ),
      sizes: $checkedConvert(
        'sizes',
        (v) => (v as List<dynamic>?)
            ?.map(
              (e) =>
                  BranchSizeOverrideInput.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
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

Map<String, dynamic> _$BranchMenuOverrideInputToJson(
  BranchMenuOverrideInput instance,
) => <String, dynamic>{
  'branch_id': instance.branchId,
  'is_available': ?instance.isAvailable,
  'menu_item_id': instance.menuItemId,
  'price_override': ?instance.priceOverride,
  'sizes': ?instance.sizes?.map((e) => e.toJson()).toList(),
};
