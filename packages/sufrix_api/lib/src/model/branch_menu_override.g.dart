// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_menu_override.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BranchMenuOverrideCWProxy {
  BranchMenuOverride branchId(String branchId);

  BranchMenuOverride isAvailable(bool isAvailable);

  BranchMenuOverride menuItemId(String menuItemId);

  BranchMenuOverride priceOverride(int? priceOverride);

  BranchMenuOverride sizes(List<BranchSizeOverride>? sizes);

  BranchMenuOverride updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BranchMenuOverride(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BranchMenuOverride(...).copyWith(id: 12, name: "My name")
  /// ````
  BranchMenuOverride call({
    String branchId,
    bool isAvailable,
    String menuItemId,
    int? priceOverride,
    List<BranchSizeOverride>? sizes,
    DateTime updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBranchMenuOverride.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBranchMenuOverride.copyWith.fieldName(...)`
class _$BranchMenuOverrideCWProxyImpl implements _$BranchMenuOverrideCWProxy {
  const _$BranchMenuOverrideCWProxyImpl(this._value);

  final BranchMenuOverride _value;

  @override
  BranchMenuOverride branchId(String branchId) => this(branchId: branchId);

  @override
  BranchMenuOverride isAvailable(bool isAvailable) =>
      this(isAvailable: isAvailable);

  @override
  BranchMenuOverride menuItemId(String menuItemId) =>
      this(menuItemId: menuItemId);

  @override
  BranchMenuOverride priceOverride(int? priceOverride) =>
      this(priceOverride: priceOverride);

  @override
  BranchMenuOverride sizes(List<BranchSizeOverride>? sizes) =>
      this(sizes: sizes);

  @override
  BranchMenuOverride updatedAt(DateTime updatedAt) =>
      this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BranchMenuOverride(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BranchMenuOverride(...).copyWith(id: 12, name: "My name")
  /// ````
  BranchMenuOverride call({
    Object? branchId = const $CopyWithPlaceholder(),
    Object? isAvailable = const $CopyWithPlaceholder(),
    Object? menuItemId = const $CopyWithPlaceholder(),
    Object? priceOverride = const $CopyWithPlaceholder(),
    Object? sizes = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return BranchMenuOverride(
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String,
      isAvailable: isAvailable == const $CopyWithPlaceholder()
          ? _value.isAvailable
          // ignore: cast_nullable_to_non_nullable
          : isAvailable as bool,
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
          : sizes as List<BranchSizeOverride>?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $BranchMenuOverrideCopyWith on BranchMenuOverride {
  /// Returns a callable class that can be used as follows: `instanceOfBranchMenuOverride.copyWith(...)` or like so:`instanceOfBranchMenuOverride.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BranchMenuOverrideCWProxy get copyWith =>
      _$BranchMenuOverrideCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchMenuOverride _$BranchMenuOverrideFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'BranchMenuOverride',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'branch_id',
            'is_available',
            'menu_item_id',
            'updated_at',
          ],
        );
        final val = BranchMenuOverride(
          branchId: $checkedConvert('branch_id', (v) => v as String),
          isAvailable: $checkedConvert('is_available', (v) => v as bool),
          menuItemId: $checkedConvert('menu_item_id', (v) => v as String),
          priceOverride: $checkedConvert(
            'price_override',
            (v) => (v as num?)?.toInt(),
          ),
          sizes: $checkedConvert(
            'sizes',
            (v) => (v as List<dynamic>?)
                ?.map(
                  (e) => BranchSizeOverride.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
          ),
          updatedAt: $checkedConvert(
            'updated_at',
            (v) => DateTime.parse(v as String),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'branchId': 'branch_id',
        'isAvailable': 'is_available',
        'menuItemId': 'menu_item_id',
        'priceOverride': 'price_override',
        'updatedAt': 'updated_at',
      },
    );

Map<String, dynamic> _$BranchMenuOverrideToJson(BranchMenuOverride instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'is_available': instance.isAvailable,
      'menu_item_id': instance.menuItemId,
      'price_override': ?instance.priceOverride,
      'sizes': ?instance.sizes?.map((e) => e.toJson()).toList(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
