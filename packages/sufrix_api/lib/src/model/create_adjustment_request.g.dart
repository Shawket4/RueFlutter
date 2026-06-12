// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_adjustment_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateAdjustmentRequestCWProxy {
  CreateAdjustmentRequest adjustmentType(String adjustmentType);

  CreateAdjustmentRequest branchInventoryId(String branchInventoryId);

  CreateAdjustmentRequest note(String note);

  CreateAdjustmentRequest quantity(double quantity);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateAdjustmentRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateAdjustmentRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateAdjustmentRequest call({
    String adjustmentType,
    String branchInventoryId,
    String note,
    double quantity,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCreateAdjustmentRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCreateAdjustmentRequest.copyWith.fieldName(...)`
class _$CreateAdjustmentRequestCWProxyImpl
    implements _$CreateAdjustmentRequestCWProxy {
  const _$CreateAdjustmentRequestCWProxyImpl(this._value);

  final CreateAdjustmentRequest _value;

  @override
  CreateAdjustmentRequest adjustmentType(String adjustmentType) =>
      this(adjustmentType: adjustmentType);

  @override
  CreateAdjustmentRequest branchInventoryId(String branchInventoryId) =>
      this(branchInventoryId: branchInventoryId);

  @override
  CreateAdjustmentRequest note(String note) => this(note: note);

  @override
  CreateAdjustmentRequest quantity(double quantity) => this(quantity: quantity);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateAdjustmentRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateAdjustmentRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateAdjustmentRequest call({
    Object? adjustmentType = const $CopyWithPlaceholder(),
    Object? branchInventoryId = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
  }) {
    return CreateAdjustmentRequest(
      adjustmentType: adjustmentType == const $CopyWithPlaceholder()
          ? _value.adjustmentType
          // ignore: cast_nullable_to_non_nullable
          : adjustmentType as String,
      branchInventoryId: branchInventoryId == const $CopyWithPlaceholder()
          ? _value.branchInventoryId
          // ignore: cast_nullable_to_non_nullable
          : branchInventoryId as String,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String,
      quantity: quantity == const $CopyWithPlaceholder()
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as double,
    );
  }
}

extension $CreateAdjustmentRequestCopyWith on CreateAdjustmentRequest {
  /// Returns a callable class that can be used as follows: `instanceOfCreateAdjustmentRequest.copyWith(...)` or like so:`instanceOfCreateAdjustmentRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateAdjustmentRequestCWProxy get copyWith =>
      _$CreateAdjustmentRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAdjustmentRequest _$CreateAdjustmentRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'CreateAdjustmentRequest',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'adjustment_type',
        'branch_inventory_id',
        'note',
        'quantity',
      ],
    );
    final val = CreateAdjustmentRequest(
      adjustmentType: $checkedConvert('adjustment_type', (v) => v as String),
      branchInventoryId: $checkedConvert(
        'branch_inventory_id',
        (v) => v as String,
      ),
      note: $checkedConvert('note', (v) => v as String),
      quantity: $checkedConvert('quantity', (v) => (v is String ? double.parse(v) : (v as num).toDouble())),
    );
    return val;
  },
  fieldKeyMap: const {
    'adjustmentType': 'adjustment_type',
    'branchInventoryId': 'branch_inventory_id',
  },
);

Map<String, dynamic> _$CreateAdjustmentRequestToJson(
  CreateAdjustmentRequest instance,
) => <String, dynamic>{
  'adjustment_type': instance.adjustmentType,
  'branch_inventory_id': instance.branchInventoryId,
  'note': instance.note,
  'quantity': instance.quantity,
};
