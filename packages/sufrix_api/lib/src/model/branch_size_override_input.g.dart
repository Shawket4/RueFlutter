// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_size_override_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BranchSizeOverrideInputCWProxy {
  BranchSizeOverrideInput priceOverride(int priceOverride);

  BranchSizeOverrideInput sizeLabel(String sizeLabel);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BranchSizeOverrideInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BranchSizeOverrideInput(...).copyWith(id: 12, name: "My name")
  /// ````
  BranchSizeOverrideInput call({int priceOverride, String sizeLabel});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBranchSizeOverrideInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBranchSizeOverrideInput.copyWith.fieldName(...)`
class _$BranchSizeOverrideInputCWProxyImpl
    implements _$BranchSizeOverrideInputCWProxy {
  const _$BranchSizeOverrideInputCWProxyImpl(this._value);

  final BranchSizeOverrideInput _value;

  @override
  BranchSizeOverrideInput priceOverride(int priceOverride) =>
      this(priceOverride: priceOverride);

  @override
  BranchSizeOverrideInput sizeLabel(String sizeLabel) =>
      this(sizeLabel: sizeLabel);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BranchSizeOverrideInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BranchSizeOverrideInput(...).copyWith(id: 12, name: "My name")
  /// ````
  BranchSizeOverrideInput call({
    Object? priceOverride = const $CopyWithPlaceholder(),
    Object? sizeLabel = const $CopyWithPlaceholder(),
  }) {
    return BranchSizeOverrideInput(
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

extension $BranchSizeOverrideInputCopyWith on BranchSizeOverrideInput {
  /// Returns a callable class that can be used as follows: `instanceOfBranchSizeOverrideInput.copyWith(...)` or like so:`instanceOfBranchSizeOverrideInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BranchSizeOverrideInputCWProxy get copyWith =>
      _$BranchSizeOverrideInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchSizeOverrideInput _$BranchSizeOverrideInputFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'BranchSizeOverrideInput',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['price_override', 'size_label']);
    final val = BranchSizeOverrideInput(
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

Map<String, dynamic> _$BranchSizeOverrideInputToJson(
  BranchSizeOverrideInput instance,
) => <String, dynamic>{
  'price_override': instance.priceOverride,
  'size_label': instance.sizeLabel,
};
