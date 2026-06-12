// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_count_row.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InventoryCountRowCWProxy {
  InventoryCountRow actualStock(double actualStock);

  InventoryCountRow branchInventoryId(String branchInventoryId);

  InventoryCountRow discrepancy(double discrepancy);

  InventoryCountRow expectedStock(double expectedStock);

  InventoryCountRow ingredientName(String ingredientName);

  InventoryCountRow isSuspicious(bool isSuspicious);

  InventoryCountRow note(String? note);

  InventoryCountRow unit(String unit);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InventoryCountRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InventoryCountRow(...).copyWith(id: 12, name: "My name")
  /// ````
  InventoryCountRow call({
    double actualStock,
    String branchInventoryId,
    double discrepancy,
    double expectedStock,
    String ingredientName,
    bool isSuspicious,
    String? note,
    String unit,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInventoryCountRow.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInventoryCountRow.copyWith.fieldName(...)`
class _$InventoryCountRowCWProxyImpl implements _$InventoryCountRowCWProxy {
  const _$InventoryCountRowCWProxyImpl(this._value);

  final InventoryCountRow _value;

  @override
  InventoryCountRow actualStock(double actualStock) =>
      this(actualStock: actualStock);

  @override
  InventoryCountRow branchInventoryId(String branchInventoryId) =>
      this(branchInventoryId: branchInventoryId);

  @override
  InventoryCountRow discrepancy(double discrepancy) =>
      this(discrepancy: discrepancy);

  @override
  InventoryCountRow expectedStock(double expectedStock) =>
      this(expectedStock: expectedStock);

  @override
  InventoryCountRow ingredientName(String ingredientName) =>
      this(ingredientName: ingredientName);

  @override
  InventoryCountRow isSuspicious(bool isSuspicious) =>
      this(isSuspicious: isSuspicious);

  @override
  InventoryCountRow note(String? note) => this(note: note);

  @override
  InventoryCountRow unit(String unit) => this(unit: unit);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InventoryCountRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InventoryCountRow(...).copyWith(id: 12, name: "My name")
  /// ````
  InventoryCountRow call({
    Object? actualStock = const $CopyWithPlaceholder(),
    Object? branchInventoryId = const $CopyWithPlaceholder(),
    Object? discrepancy = const $CopyWithPlaceholder(),
    Object? expectedStock = const $CopyWithPlaceholder(),
    Object? ingredientName = const $CopyWithPlaceholder(),
    Object? isSuspicious = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? unit = const $CopyWithPlaceholder(),
  }) {
    return InventoryCountRow(
      actualStock: actualStock == const $CopyWithPlaceholder()
          ? _value.actualStock
          // ignore: cast_nullable_to_non_nullable
          : actualStock as double,
      branchInventoryId: branchInventoryId == const $CopyWithPlaceholder()
          ? _value.branchInventoryId
          // ignore: cast_nullable_to_non_nullable
          : branchInventoryId as String,
      discrepancy: discrepancy == const $CopyWithPlaceholder()
          ? _value.discrepancy
          // ignore: cast_nullable_to_non_nullable
          : discrepancy as double,
      expectedStock: expectedStock == const $CopyWithPlaceholder()
          ? _value.expectedStock
          // ignore: cast_nullable_to_non_nullable
          : expectedStock as double,
      ingredientName: ingredientName == const $CopyWithPlaceholder()
          ? _value.ingredientName
          // ignore: cast_nullable_to_non_nullable
          : ingredientName as String,
      isSuspicious: isSuspicious == const $CopyWithPlaceholder()
          ? _value.isSuspicious
          // ignore: cast_nullable_to_non_nullable
          : isSuspicious as bool,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
      unit: unit == const $CopyWithPlaceholder()
          ? _value.unit
          // ignore: cast_nullable_to_non_nullable
          : unit as String,
    );
  }
}

extension $InventoryCountRowCopyWith on InventoryCountRow {
  /// Returns a callable class that can be used as follows: `instanceOfInventoryCountRow.copyWith(...)` or like so:`instanceOfInventoryCountRow.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InventoryCountRowCWProxy get copyWith =>
      _$InventoryCountRowCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryCountRow _$InventoryCountRowFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'InventoryCountRow',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'actual_stock',
        'branch_inventory_id',
        'discrepancy',
        'expected_stock',
        'ingredient_name',
        'is_suspicious',
        'unit',
      ],
    );
    final val = InventoryCountRow(
      actualStock: $checkedConvert(
        'actual_stock',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
      branchInventoryId: $checkedConvert(
        'branch_inventory_id',
        (v) => v as String,
      ),
      discrepancy: $checkedConvert('discrepancy', (v) => (v is String ? double.parse(v) : (v as num).toDouble())),
      expectedStock: $checkedConvert(
        'expected_stock',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
      ingredientName: $checkedConvert('ingredient_name', (v) => v as String),
      isSuspicious: $checkedConvert('is_suspicious', (v) => v as bool),
      note: $checkedConvert('note', (v) => v as String?),
      unit: $checkedConvert('unit', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'actualStock': 'actual_stock',
    'branchInventoryId': 'branch_inventory_id',
    'expectedStock': 'expected_stock',
    'ingredientName': 'ingredient_name',
    'isSuspicious': 'is_suspicious',
  },
);

Map<String, dynamic> _$InventoryCountRowToJson(InventoryCountRow instance) =>
    <String, dynamic>{
      'actual_stock': instance.actualStock,
      'branch_inventory_id': instance.branchInventoryId,
      'discrepancy': instance.discrepancy,
      'expected_stock': instance.expectedStock,
      'ingredient_name': instance.ingredientName,
      'is_suspicious': instance.isSuspicious,
      'note': ?instance.note,
      'unit': instance.unit,
    };
