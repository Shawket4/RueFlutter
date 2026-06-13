// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_count_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ItemCountInputCWProxy {
  ItemCountInput countedQty(double countedQty);

  ItemCountInput note(String? note);

  ItemCountInput orgIngredientId(String orgIngredientId);

  ItemCountInput varianceReason(String? varianceReason);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ItemCountInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ItemCountInput(...).copyWith(id: 12, name: "My name")
  /// ````
  ItemCountInput call({
    double countedQty,
    String? note,
    String orgIngredientId,
    String? varianceReason,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfItemCountInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfItemCountInput.copyWith.fieldName(...)`
class _$ItemCountInputCWProxyImpl implements _$ItemCountInputCWProxy {
  const _$ItemCountInputCWProxyImpl(this._value);

  final ItemCountInput _value;

  @override
  ItemCountInput countedQty(double countedQty) => this(countedQty: countedQty);

  @override
  ItemCountInput note(String? note) => this(note: note);

  @override
  ItemCountInput orgIngredientId(String orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  ItemCountInput varianceReason(String? varianceReason) =>
      this(varianceReason: varianceReason);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ItemCountInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ItemCountInput(...).copyWith(id: 12, name: "My name")
  /// ````
  ItemCountInput call({
    Object? countedQty = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? varianceReason = const $CopyWithPlaceholder(),
  }) {
    return ItemCountInput(
      countedQty: countedQty == const $CopyWithPlaceholder()
          ? _value.countedQty
          // ignore: cast_nullable_to_non_nullable
          : countedQty as double,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
      orgIngredientId: orgIngredientId == const $CopyWithPlaceholder()
          ? _value.orgIngredientId
          // ignore: cast_nullable_to_non_nullable
          : orgIngredientId as String,
      varianceReason: varianceReason == const $CopyWithPlaceholder()
          ? _value.varianceReason
          // ignore: cast_nullable_to_non_nullable
          : varianceReason as String?,
    );
  }
}

extension $ItemCountInputCopyWith on ItemCountInput {
  /// Returns a callable class that can be used as follows: `instanceOfItemCountInput.copyWith(...)` or like so:`instanceOfItemCountInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ItemCountInputCWProxy get copyWith => _$ItemCountInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemCountInput _$ItemCountInputFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ItemCountInput',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['counted_qty', 'org_ingredient_id']);
    final val = ItemCountInput(
      countedQty: $checkedConvert('counted_qty', (v) => (v is String ? double.parse(v) : (v as num).toDouble())),
      note: $checkedConvert('note', (v) => v as String?),
      orgIngredientId: $checkedConvert('org_ingredient_id', (v) => v as String),
      varianceReason: $checkedConvert('variance_reason', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'countedQty': 'counted_qty',
    'orgIngredientId': 'org_ingredient_id',
    'varianceReason': 'variance_reason',
  },
);

Map<String, dynamic> _$ItemCountInputToJson(ItemCountInput instance) =>
    <String, dynamic>{
      'counted_qty': instance.countedQty,
      'note': ?instance.note,
      'org_ingredient_id': instance.orgIngredientId,
      'variance_reason': ?instance.varianceReason,
    };
