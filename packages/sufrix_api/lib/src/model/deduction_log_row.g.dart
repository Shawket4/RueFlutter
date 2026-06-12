// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deduction_log_row.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DeductionLogRowCWProxy {
  DeductionLogRow createdAt(DateTime createdAt);

  DeductionLogRow id(String id);

  DeductionLogRow inventoryItemId(String inventoryItemId);

  DeductionLogRow itemName(String itemName);

  DeductionLogRow orderId(String? orderId);

  DeductionLogRow orderItemId(String? orderItemId);

  DeductionLogRow quantityDeducted(double quantityDeducted);

  DeductionLogRow source_(String source_);

  DeductionLogRow unit(String unit);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeductionLogRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeductionLogRow(...).copyWith(id: 12, name: "My name")
  /// ````
  DeductionLogRow call({
    DateTime createdAt,
    String id,
    String inventoryItemId,
    String itemName,
    String? orderId,
    String? orderItemId,
    double quantityDeducted,
    String source_,
    String unit,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDeductionLogRow.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDeductionLogRow.copyWith.fieldName(...)`
class _$DeductionLogRowCWProxyImpl implements _$DeductionLogRowCWProxy {
  const _$DeductionLogRowCWProxyImpl(this._value);

  final DeductionLogRow _value;

  @override
  DeductionLogRow createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  DeductionLogRow id(String id) => this(id: id);

  @override
  DeductionLogRow inventoryItemId(String inventoryItemId) =>
      this(inventoryItemId: inventoryItemId);

  @override
  DeductionLogRow itemName(String itemName) => this(itemName: itemName);

  @override
  DeductionLogRow orderId(String? orderId) => this(orderId: orderId);

  @override
  DeductionLogRow orderItemId(String? orderItemId) =>
      this(orderItemId: orderItemId);

  @override
  DeductionLogRow quantityDeducted(double quantityDeducted) =>
      this(quantityDeducted: quantityDeducted);

  @override
  DeductionLogRow source_(String source_) => this(source_: source_);

  @override
  DeductionLogRow unit(String unit) => this(unit: unit);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeductionLogRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeductionLogRow(...).copyWith(id: 12, name: "My name")
  /// ````
  DeductionLogRow call({
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? inventoryItemId = const $CopyWithPlaceholder(),
    Object? itemName = const $CopyWithPlaceholder(),
    Object? orderId = const $CopyWithPlaceholder(),
    Object? orderItemId = const $CopyWithPlaceholder(),
    Object? quantityDeducted = const $CopyWithPlaceholder(),
    Object? source_ = const $CopyWithPlaceholder(),
    Object? unit = const $CopyWithPlaceholder(),
  }) {
    return DeductionLogRow(
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      inventoryItemId: inventoryItemId == const $CopyWithPlaceholder()
          ? _value.inventoryItemId
          // ignore: cast_nullable_to_non_nullable
          : inventoryItemId as String,
      itemName: itemName == const $CopyWithPlaceholder()
          ? _value.itemName
          // ignore: cast_nullable_to_non_nullable
          : itemName as String,
      orderId: orderId == const $CopyWithPlaceholder()
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String?,
      orderItemId: orderItemId == const $CopyWithPlaceholder()
          ? _value.orderItemId
          // ignore: cast_nullable_to_non_nullable
          : orderItemId as String?,
      quantityDeducted: quantityDeducted == const $CopyWithPlaceholder()
          ? _value.quantityDeducted
          // ignore: cast_nullable_to_non_nullable
          : quantityDeducted as double,
      source_: source_ == const $CopyWithPlaceholder()
          ? _value.source_
          // ignore: cast_nullable_to_non_nullable
          : source_ as String,
      unit: unit == const $CopyWithPlaceholder()
          ? _value.unit
          // ignore: cast_nullable_to_non_nullable
          : unit as String,
    );
  }
}

extension $DeductionLogRowCopyWith on DeductionLogRow {
  /// Returns a callable class that can be used as follows: `instanceOfDeductionLogRow.copyWith(...)` or like so:`instanceOfDeductionLogRow.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DeductionLogRowCWProxy get copyWith => _$DeductionLogRowCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeductionLogRow _$DeductionLogRowFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'DeductionLogRow',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'created_at',
            'id',
            'inventory_item_id',
            'item_name',
            'quantity_deducted',
            'source',
            'unit',
          ],
        );
        final val = DeductionLogRow(
          createdAt: $checkedConvert(
            'created_at',
            (v) => DateTime.parse(v as String),
          ),
          id: $checkedConvert('id', (v) => v as String),
          inventoryItemId: $checkedConvert(
            'inventory_item_id',
            (v) => v as String,
          ),
          itemName: $checkedConvert('item_name', (v) => v as String),
          orderId: $checkedConvert('order_id', (v) => v as String?),
          orderItemId: $checkedConvert('order_item_id', (v) => v as String?),
          quantityDeducted: $checkedConvert(
            'quantity_deducted',
            (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
          ),
          source_: $checkedConvert('source', (v) => v as String),
          unit: $checkedConvert('unit', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'createdAt': 'created_at',
        'inventoryItemId': 'inventory_item_id',
        'itemName': 'item_name',
        'orderId': 'order_id',
        'orderItemId': 'order_item_id',
        'quantityDeducted': 'quantity_deducted',
        'source_': 'source',
      },
    );

Map<String, dynamic> _$DeductionLogRowToJson(DeductionLogRow instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'id': instance.id,
      'inventory_item_id': instance.inventoryItemId,
      'item_name': instance.itemName,
      'order_id': ?instance.orderId,
      'order_item_id': ?instance.orderItemId,
      'quantity_deducted': instance.quantityDeducted,
      'source': instance.source_,
      'unit': instance.unit,
    };
