// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_size_override.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BranchSizeOverrideCWProxy {
  BranchSizeOverride priceOverride(int priceOverride);

  BranchSizeOverride sizeLabel(String sizeLabel);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BranchSizeOverride(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BranchSizeOverride(...).copyWith(id: 12, name: "My name")
  /// ````
  BranchSizeOverride call({int priceOverride, String sizeLabel});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBranchSizeOverride.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBranchSizeOverride.copyWith.fieldName(...)`
class _$BranchSizeOverrideCWProxyImpl implements _$BranchSizeOverrideCWProxy {
  const _$BranchSizeOverrideCWProxyImpl(this._value);

  final BranchSizeOverride _value;

  @override
  BranchSizeOverride priceOverride(int priceOverride) =>
      this(priceOverride: priceOverride);

  @override
  BranchSizeOverride sizeLabel(String sizeLabel) => this(sizeLabel: sizeLabel);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BranchSizeOverride(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BranchSizeOverride(...).copyWith(id: 12, name: "My name")
  /// ````
  BranchSizeOverride call({
    Object? priceOverride = const $CopyWithPlaceholder(),
    Object? sizeLabel = const $CopyWithPlaceholder(),
  }) {
    return BranchSizeOverride(
      priceOverride: priceOverride == const $CopyWithPlaceholder()
          ? _value.priceOverride
          // ignore: cast_nullable_to_non_nullable
          : priceOverride as int,
      sizeLabel: sizeLabel == const $CopyWithPlaceholder()
          ? _value.sizeLabel
          // ignore: cast_nullable_to_non_nullable
          : sizeLabel as String,
    );
  }
}

extension $BranchSizeOverrideCopyWith on BranchSizeOverride {
  /// Returns a callable class that can be used as follows: `instanceOfBranchSizeOverride.copyWith(...)` or like so:`instanceOfBranchSizeOverride.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BranchSizeOverrideCWProxy get copyWith =>
      _$BranchSizeOverrideCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchSizeOverride _$BranchSizeOverrideFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'BranchSizeOverride',
      json,
      ($checkedConvert) {
        $checkKeys(json, requiredKeys: const ['price_override', 'size_label']);
        final val = BranchSizeOverride(
          priceOverride: $checkedConvert(
            'price_override',
            (v) => (v as num).toInt(),
          ),
          sizeLabel: $checkedConvert('size_label', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'priceOverride': 'price_override',
        'sizeLabel': 'size_label',
      },
    );

Map<String, dynamic> _$BranchSizeOverrideToJson(BranchSizeOverride instance) =>
    <String, dynamic>{
      'price_override': instance.priceOverride,
      'size_label': instance.sizeLabel,
    };
