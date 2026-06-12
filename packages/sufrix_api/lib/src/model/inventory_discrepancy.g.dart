// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_discrepancy.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InventoryDiscrepancyCWProxy {
  InventoryDiscrepancy actualCount(double? actualCount);

  InventoryDiscrepancy branchInventoryId(String branchInventoryId);

  InventoryDiscrepancy discrepancy(double? discrepancy);

  InventoryDiscrepancy expectedStock(double expectedStock);

  InventoryDiscrepancy ingredientName(String ingredientName);

  InventoryDiscrepancy note(String? note);

  InventoryDiscrepancy unit(String unit);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InventoryDiscrepancy(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InventoryDiscrepancy(...).copyWith(id: 12, name: "My name")
  /// ````
  InventoryDiscrepancy call({
    double? actualCount,
    String branchInventoryId,
    double? discrepancy,
    double expectedStock,
    String ingredientName,
    String? note,
    String unit,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInventoryDiscrepancy.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInventoryDiscrepancy.copyWith.fieldName(...)`
class _$InventoryDiscrepancyCWProxyImpl
    implements _$InventoryDiscrepancyCWProxy {
  const _$InventoryDiscrepancyCWProxyImpl(this._value);

  final InventoryDiscrepancy _value;

  @override
  InventoryDiscrepancy actualCount(double? actualCount) =>
      this(actualCount: actualCount);

  @override
  InventoryDiscrepancy branchInventoryId(String branchInventoryId) =>
      this(branchInventoryId: branchInventoryId);

  @override
  InventoryDiscrepancy discrepancy(double? discrepancy) =>
      this(discrepancy: discrepancy);

  @override
  InventoryDiscrepancy expectedStock(double expectedStock) =>
      this(expectedStock: expectedStock);

  @override
  InventoryDiscrepancy ingredientName(String ingredientName) =>
      this(ingredientName: ingredientName);

  @override
  InventoryDiscrepancy note(String? note) => this(note: note);

  @override
  InventoryDiscrepancy unit(String unit) => this(unit: unit);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InventoryDiscrepancy(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InventoryDiscrepancy(...).copyWith(id: 12, name: "My name")
  /// ````
  InventoryDiscrepancy call({
    Object? actualCount = const $CopyWithPlaceholder(),
    Object? branchInventoryId = const $CopyWithPlaceholder(),
    Object? discrepancy = const $CopyWithPlaceholder(),
    Object? expectedStock = const $CopyWithPlaceholder(),
    Object? ingredientName = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? unit = const $CopyWithPlaceholder(),
  }) {
    return InventoryDiscrepancy(
      actualCount: actualCount == const $CopyWithPlaceholder()
          ? _value.actualCount
          // ignore: cast_nullable_to_non_nullable
          : actualCount as double?,
      branchInventoryId: branchInventoryId == const $CopyWithPlaceholder()
          ? _value.branchInventoryId
          // ignore: cast_nullable_to_non_nullable
          : branchInventoryId as String,
      discrepancy: discrepancy == const $CopyWithPlaceholder()
          ? _value.discrepancy
          // ignore: cast_nullable_to_non_nullable
          : discrepancy as double?,
      expectedStock: expectedStock == const $CopyWithPlaceholder()
          ? _value.expectedStock
          // ignore: cast_nullable_to_non_nullable
          : expectedStock as double,
      ingredientName: ingredientName == const $CopyWithPlaceholder()
          ? _value.ingredientName
          // ignore: cast_nullable_to_non_nullable
          : ingredientName as String,
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

extension $InventoryDiscrepancyCopyWith on InventoryDiscrepancy {
  /// Returns a callable class that can be used as follows: `instanceOfInventoryDiscrepancy.copyWith(...)` or like so:`instanceOfInventoryDiscrepancy.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InventoryDiscrepancyCWProxy get copyWith =>
      _$InventoryDiscrepancyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryDiscrepancy _$InventoryDiscrepancyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'InventoryDiscrepancy',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'branch_inventory_id',
        'expected_stock',
        'ingredient_name',
        'unit',
      ],
    );
    final val = InventoryDiscrepancy(
      actualCount: $checkedConvert(
        'actual_count',
        (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble()),
      ),
      branchInventoryId: $checkedConvert(
        'branch_inventory_id',
        (v) => v as String,
      ),
      discrepancy: $checkedConvert(
        'discrepancy',
        (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble()),
      ),
      expectedStock: $checkedConvert(
        'expected_stock',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
      ingredientName: $checkedConvert('ingredient_name', (v) => v as String),
      note: $checkedConvert('note', (v) => v as String?),
      unit: $checkedConvert('unit', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'actualCount': 'actual_count',
    'branchInventoryId': 'branch_inventory_id',
    'expectedStock': 'expected_stock',
    'ingredientName': 'ingredient_name',
  },
);

Map<String, dynamic> _$InventoryDiscrepancyToJson(
  InventoryDiscrepancy instance,
) => <String, dynamic>{
  'actual_count': ?instance.actualCount,
  'branch_inventory_id': instance.branchInventoryId,
  'discrepancy': ?instance.discrepancy,
  'expected_stock': instance.expectedStock,
  'ingredient_name': instance.ingredientName,
  'note': ?instance.note,
  'unit': instance.unit,
};
