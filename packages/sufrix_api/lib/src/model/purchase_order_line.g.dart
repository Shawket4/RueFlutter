// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_order_line.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PurchaseOrderLineCWProxy {
  PurchaseOrderLine id(String id);

  PurchaseOrderLine ingredientName(String ingredientName);

  PurchaseOrderLine orgIngredientId(String orgIngredientId);

  PurchaseOrderLine purchaseOrderId(String purchaseOrderId);

  PurchaseOrderLine purchaseUnit(String purchaseUnit);

  PurchaseOrderLine quantityOrdered(double quantityOrdered);

  PurchaseOrderLine quantityReceived(double quantityReceived);

  PurchaseOrderLine unit(String unit);

  PurchaseOrderLine unitCost(int unitCost);

  PurchaseOrderLine unitsPerPurchaseUnit(double unitsPerPurchaseUnit);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PurchaseOrderLine(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PurchaseOrderLine(...).copyWith(id: 12, name: "My name")
  /// ````
  PurchaseOrderLine call({
    String id,
    String ingredientName,
    String orgIngredientId,
    String purchaseOrderId,
    String purchaseUnit,
    double quantityOrdered,
    double quantityReceived,
    String unit,
    int unitCost,
    double unitsPerPurchaseUnit,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPurchaseOrderLine.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPurchaseOrderLine.copyWith.fieldName(...)`
class _$PurchaseOrderLineCWProxyImpl implements _$PurchaseOrderLineCWProxy {
  const _$PurchaseOrderLineCWProxyImpl(this._value);

  final PurchaseOrderLine _value;

  @override
  PurchaseOrderLine id(String id) => this(id: id);

  @override
  PurchaseOrderLine ingredientName(String ingredientName) =>
      this(ingredientName: ingredientName);

  @override
  PurchaseOrderLine orgIngredientId(String orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  PurchaseOrderLine purchaseOrderId(String purchaseOrderId) =>
      this(purchaseOrderId: purchaseOrderId);

  @override
  PurchaseOrderLine purchaseUnit(String purchaseUnit) =>
      this(purchaseUnit: purchaseUnit);

  @override
  PurchaseOrderLine quantityOrdered(double quantityOrdered) =>
      this(quantityOrdered: quantityOrdered);

  @override
  PurchaseOrderLine quantityReceived(double quantityReceived) =>
      this(quantityReceived: quantityReceived);

  @override
  PurchaseOrderLine unit(String unit) => this(unit: unit);

  @override
  PurchaseOrderLine unitCost(int unitCost) => this(unitCost: unitCost);

  @override
  PurchaseOrderLine unitsPerPurchaseUnit(double unitsPerPurchaseUnit) =>
      this(unitsPerPurchaseUnit: unitsPerPurchaseUnit);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PurchaseOrderLine(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PurchaseOrderLine(...).copyWith(id: 12, name: "My name")
  /// ````
  PurchaseOrderLine call({
    Object? id = const $CopyWithPlaceholder(),
    Object? ingredientName = const $CopyWithPlaceholder(),
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? purchaseOrderId = const $CopyWithPlaceholder(),
    Object? purchaseUnit = const $CopyWithPlaceholder(),
    Object? quantityOrdered = const $CopyWithPlaceholder(),
    Object? quantityReceived = const $CopyWithPlaceholder(),
    Object? unit = const $CopyWithPlaceholder(),
    Object? unitCost = const $CopyWithPlaceholder(),
    Object? unitsPerPurchaseUnit = const $CopyWithPlaceholder(),
  }) {
    return PurchaseOrderLine(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      ingredientName: ingredientName == const $CopyWithPlaceholder()
          ? _value.ingredientName
          // ignore: cast_nullable_to_non_nullable
          : ingredientName as String,
      orgIngredientId: orgIngredientId == const $CopyWithPlaceholder()
          ? _value.orgIngredientId
          // ignore: cast_nullable_to_non_nullable
          : orgIngredientId as String,
      purchaseOrderId: purchaseOrderId == const $CopyWithPlaceholder()
          ? _value.purchaseOrderId
          // ignore: cast_nullable_to_non_nullable
          : purchaseOrderId as String,
      purchaseUnit: purchaseUnit == const $CopyWithPlaceholder()
          ? _value.purchaseUnit
          // ignore: cast_nullable_to_non_nullable
          : purchaseUnit as String,
      quantityOrdered: quantityOrdered == const $CopyWithPlaceholder()
          ? _value.quantityOrdered
          // ignore: cast_nullable_to_non_nullable
          : quantityOrdered as double,
      quantityReceived: quantityReceived == const $CopyWithPlaceholder()
          ? _value.quantityReceived
          // ignore: cast_nullable_to_non_nullable
          : quantityReceived as double,
      unit: unit == const $CopyWithPlaceholder()
          ? _value.unit
          // ignore: cast_nullable_to_non_nullable
          : unit as String,
      unitCost: unitCost == const $CopyWithPlaceholder()
          ? _value.unitCost
          // ignore: cast_nullable_to_non_nullable
          : unitCost as int,
      unitsPerPurchaseUnit: unitsPerPurchaseUnit == const $CopyWithPlaceholder()
          ? _value.unitsPerPurchaseUnit
          // ignore: cast_nullable_to_non_nullable
          : unitsPerPurchaseUnit as double,
    );
  }
}

extension $PurchaseOrderLineCopyWith on PurchaseOrderLine {
  /// Returns a callable class that can be used as follows: `instanceOfPurchaseOrderLine.copyWith(...)` or like so:`instanceOfPurchaseOrderLine.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PurchaseOrderLineCWProxy get copyWith =>
      _$PurchaseOrderLineCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseOrderLine _$PurchaseOrderLineFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'PurchaseOrderLine',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'id',
        'ingredient_name',
        'org_ingredient_id',
        'purchase_order_id',
        'purchase_unit',
        'quantity_ordered',
        'quantity_received',
        'unit',
        'unit_cost',
        'units_per_purchase_unit',
      ],
    );
    final val = PurchaseOrderLine(
      id: $checkedConvert('id', (v) => v as String),
      ingredientName: $checkedConvert('ingredient_name', (v) => v as String),
      orgIngredientId: $checkedConvert('org_ingredient_id', (v) => v as String),
      purchaseOrderId: $checkedConvert('purchase_order_id', (v) => v as String),
      purchaseUnit: $checkedConvert('purchase_unit', (v) => v as String),
      quantityOrdered: $checkedConvert(
        'quantity_ordered',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
      quantityReceived: $checkedConvert(
        'quantity_received',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
      unit: $checkedConvert('unit', (v) => v as String),
      unitCost: $checkedConvert('unit_cost', (v) => (v as num).toInt()),
      unitsPerPurchaseUnit: $checkedConvert(
        'units_per_purchase_unit',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'ingredientName': 'ingredient_name',
    'orgIngredientId': 'org_ingredient_id',
    'purchaseOrderId': 'purchase_order_id',
    'purchaseUnit': 'purchase_unit',
    'quantityOrdered': 'quantity_ordered',
    'quantityReceived': 'quantity_received',
    'unitCost': 'unit_cost',
    'unitsPerPurchaseUnit': 'units_per_purchase_unit',
  },
);

Map<String, dynamic> _$PurchaseOrderLineToJson(PurchaseOrderLine instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ingredient_name': instance.ingredientName,
      'org_ingredient_id': instance.orgIngredientId,
      'purchase_order_id': instance.purchaseOrderId,
      'purchase_unit': instance.purchaseUnit,
      'quantity_ordered': instance.quantityOrdered,
      'quantity_received': instance.quantityReceived,
      'unit': instance.unit,
      'unit_cost': instance.unitCost,
      'units_per_purchase_unit': instance.unitsPerPurchaseUnit,
    };
