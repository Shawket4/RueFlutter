// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_transfer_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateTransferRequestCWProxy {
  CreateTransferRequest destinationBranchId(String destinationBranchId);

  CreateTransferRequest note(String? note);

  CreateTransferRequest orgIngredientId(String orgIngredientId);

  CreateTransferRequest quantity(double quantity);

  CreateTransferRequest sourceBranchId(String sourceBranchId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateTransferRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateTransferRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateTransferRequest call({
    String destinationBranchId,
    String? note,
    String orgIngredientId,
    double quantity,
    String sourceBranchId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCreateTransferRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCreateTransferRequest.copyWith.fieldName(...)`
class _$CreateTransferRequestCWProxyImpl
    implements _$CreateTransferRequestCWProxy {
  const _$CreateTransferRequestCWProxyImpl(this._value);

  final CreateTransferRequest _value;

  @override
  CreateTransferRequest destinationBranchId(String destinationBranchId) =>
      this(destinationBranchId: destinationBranchId);

  @override
  CreateTransferRequest note(String? note) => this(note: note);

  @override
  CreateTransferRequest orgIngredientId(String orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  CreateTransferRequest quantity(double quantity) => this(quantity: quantity);

  @override
  CreateTransferRequest sourceBranchId(String sourceBranchId) =>
      this(sourceBranchId: sourceBranchId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateTransferRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateTransferRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateTransferRequest call({
    Object? destinationBranchId = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? sourceBranchId = const $CopyWithPlaceholder(),
  }) {
    return CreateTransferRequest(
      destinationBranchId: destinationBranchId == const $CopyWithPlaceholder()
          ? _value.destinationBranchId
          // ignore: cast_nullable_to_non_nullable
          : destinationBranchId as String,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
      orgIngredientId: orgIngredientId == const $CopyWithPlaceholder()
          ? _value.orgIngredientId
          // ignore: cast_nullable_to_non_nullable
          : orgIngredientId as String,
      quantity: quantity == const $CopyWithPlaceholder()
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as double,
      sourceBranchId: sourceBranchId == const $CopyWithPlaceholder()
          ? _value.sourceBranchId
          // ignore: cast_nullable_to_non_nullable
          : sourceBranchId as String,
    );
  }
}

extension $CreateTransferRequestCopyWith on CreateTransferRequest {
  /// Returns a callable class that can be used as follows: `instanceOfCreateTransferRequest.copyWith(...)` or like so:`instanceOfCreateTransferRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateTransferRequestCWProxy get copyWith =>
      _$CreateTransferRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTransferRequest _$CreateTransferRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'CreateTransferRequest',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'destination_branch_id',
        'org_ingredient_id',
        'quantity',
        'source_branch_id',
      ],
    );
    final val = CreateTransferRequest(
      destinationBranchId: $checkedConvert(
        'destination_branch_id',
        (v) => v as String,
      ),
      note: $checkedConvert('note', (v) => v as String?),
      orgIngredientId: $checkedConvert('org_ingredient_id', (v) => v as String),
      quantity: $checkedConvert('quantity', (v) => (v is String ? double.parse(v) : (v as num).toDouble())),
      sourceBranchId: $checkedConvert('source_branch_id', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'destinationBranchId': 'destination_branch_id',
    'orgIngredientId': 'org_ingredient_id',
    'sourceBranchId': 'source_branch_id',
  },
);

Map<String, dynamic> _$CreateTransferRequestToJson(
  CreateTransferRequest instance,
) => <String, dynamic>{
  'destination_branch_id': instance.destinationBranchId,
  'note': ?instance.note,
  'org_ingredient_id': instance.orgIngredientId,
  'quantity': instance.quantity,
  'source_branch_id': instance.sourceBranchId,
};
