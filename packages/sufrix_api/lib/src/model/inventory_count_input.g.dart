// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_count_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InventoryCountInputCWProxy {
  InventoryCountInput actualStock(double actualStock);

  InventoryCountInput branchInventoryId(String branchInventoryId);

  InventoryCountInput note(String? note);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InventoryCountInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InventoryCountInput(...).copyWith(id: 12, name: "My name")
  /// ````
  InventoryCountInput call({
    double actualStock,
    String branchInventoryId,
    String? note,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInventoryCountInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInventoryCountInput.copyWith.fieldName(...)`
class _$InventoryCountInputCWProxyImpl implements _$InventoryCountInputCWProxy {
  const _$InventoryCountInputCWProxyImpl(this._value);

  final InventoryCountInput _value;

  @override
  InventoryCountInput actualStock(double actualStock) =>
      this(actualStock: actualStock);

  @override
  InventoryCountInput branchInventoryId(String branchInventoryId) =>
      this(branchInventoryId: branchInventoryId);

  @override
  InventoryCountInput note(String? note) => this(note: note);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InventoryCountInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InventoryCountInput(...).copyWith(id: 12, name: "My name")
  /// ````
  InventoryCountInput call({
    Object? actualStock = const $CopyWithPlaceholder(),
    Object? branchInventoryId = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
  }) {
    return InventoryCountInput(
      actualStock: actualStock == const $CopyWithPlaceholder()
          ? _value.actualStock
          // ignore: cast_nullable_to_non_nullable
          : actualStock as double,
      branchInventoryId: branchInventoryId == const $CopyWithPlaceholder()
          ? _value.branchInventoryId
          // ignore: cast_nullable_to_non_nullable
          : branchInventoryId as String,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
    );
  }
}

extension $InventoryCountInputCopyWith on InventoryCountInput {
  /// Returns a callable class that can be used as follows: `instanceOfInventoryCountInput.copyWith(...)` or like so:`instanceOfInventoryCountInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InventoryCountInputCWProxy get copyWith =>
      _$InventoryCountInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryCountInput _$InventoryCountInputFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'InventoryCountInput',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['actual_stock', 'branch_inventory_id'],
        );
        final val = InventoryCountInput(
          actualStock: $checkedConvert(
            'actual_stock',
            (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
          ),
          branchInventoryId: $checkedConvert(
            'branch_inventory_id',
            (v) => v as String,
          ),
          note: $checkedConvert('note', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'actualStock': 'actual_stock',
        'branchInventoryId': 'branch_inventory_id',
      },
    );

Map<String, dynamic> _$InventoryCountInputToJson(
  InventoryCountInput instance,
) => <String, dynamic>{
  'actual_stock': instance.actualStock,
  'branch_inventory_id': instance.branchInventoryId,
  'note': ?instance.note,
};
