// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'po_line_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$POLineInputCWProxy {
  POLineInput orgIngredientId(String orgIngredientId);

  POLineInput purchaseUnit(String purchaseUnit);

  POLineInput quantityOrdered(double quantityOrdered);

  POLineInput unitCost(int unitCost);

  POLineInput unitsPerPurchaseUnit(double? unitsPerPurchaseUnit);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `POLineInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// POLineInput(...).copyWith(id: 12, name: "My name")
  /// ````
  POLineInput call({
    String orgIngredientId,
    String purchaseUnit,
    double quantityOrdered,
    int unitCost,
    double? unitsPerPurchaseUnit,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPOLineInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPOLineInput.copyWith.fieldName(...)`
class _$POLineInputCWProxyImpl implements _$POLineInputCWProxy {
  const _$POLineInputCWProxyImpl(this._value);

  final POLineInput _value;

  @override
  POLineInput orgIngredientId(String orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  POLineInput purchaseUnit(String purchaseUnit) =>
      this(purchaseUnit: purchaseUnit);

  @override
  POLineInput quantityOrdered(double quantityOrdered) =>
      this(quantityOrdered: quantityOrdered);

  @override
  POLineInput unitCost(int unitCost) => this(unitCost: unitCost);

  @override
  POLineInput unitsPerPurchaseUnit(double? unitsPerPurchaseUnit) =>
      this(unitsPerPurchaseUnit: unitsPerPurchaseUnit);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `POLineInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// POLineInput(...).copyWith(id: 12, name: "My name")
  /// ````
  POLineInput call({
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? purchaseUnit = const $CopyWithPlaceholder(),
    Object? quantityOrdered = const $CopyWithPlaceholder(),
    Object? unitCost = const $CopyWithPlaceholder(),
    Object? unitsPerPurchaseUnit = const $CopyWithPlaceholder(),
  }) {
    return POLineInput(
      orgIngredientId: orgIngredientId == const $CopyWithPlaceholder()
          ? _value.orgIngredientId
          // ignore: cast_nullable_to_non_nullable
          : orgIngredientId as String,
      purchaseUnit: purchaseUnit == const $CopyWithPlaceholder()
          ? _value.purchaseUnit
          // ignore: cast_nullable_to_non_nullable
          : purchaseUnit as String,
      quantityOrdered: quantityOrdered == const $CopyWithPlaceholder()
          ? _value.quantityOrdered
          // ignore: cast_nullable_to_non_nullable
          : quantityOrdered as double,
      unitCost: unitCost == const $CopyWithPlaceholder()
          ? _value.unitCost
          // ignore: cast_nullable_to_non_nullable
          : unitCost as int,
      unitsPerPurchaseUnit: unitsPerPurchaseUnit == const $CopyWithPlaceholder()
          ? _value.unitsPerPurchaseUnit
          // ignore: cast_nullable_to_non_nullable
          : unitsPerPurchaseUnit as double?,
    );
  }
}

extension $POLineInputCopyWith on POLineInput {
  /// Returns a callable class that can be used as follows: `instanceOfPOLineInput.copyWith(...)` or like so:`instanceOfPOLineInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$POLineInputCWProxy get copyWith => _$POLineInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

POLineInput _$POLineInputFromJson(Map<String, dynamic> json) => $checkedCreate(
  'POLineInput',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'org_ingredient_id',
        'purchase_unit',
        'quantity_ordered',
        'unit_cost',
      ],
    );
    final val = POLineInput(
      orgIngredientId: $checkedConvert('org_ingredient_id', (v) => v as String),
      purchaseUnit: $checkedConvert('purchase_unit', (v) => v as String),
      quantityOrdered: $checkedConvert(
        'quantity_ordered',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
      unitCost: $checkedConvert('unit_cost', (v) => (v as num).toInt()),
      unitsPerPurchaseUnit: $checkedConvert(
        'units_per_purchase_unit',
        (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble()),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'orgIngredientId': 'org_ingredient_id',
    'purchaseUnit': 'purchase_unit',
    'quantityOrdered': 'quantity_ordered',
    'unitCost': 'unit_cost',
    'unitsPerPurchaseUnit': 'units_per_purchase_unit',
  },
);

Map<String, dynamic> _$POLineInputToJson(POLineInput instance) =>
    <String, dynamic>{
      'org_ingredient_id': instance.orgIngredientId,
      'purchase_unit': instance.purchaseUnit,
      'quantity_ordered': instance.quantityOrdered,
      'unit_cost': instance.unitCost,
      'units_per_purchase_unit': ?instance.unitsPerPurchaseUnit,
    };
