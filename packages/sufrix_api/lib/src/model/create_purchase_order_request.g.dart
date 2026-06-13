// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_purchase_order_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreatePurchaseOrderRequestCWProxy {
  CreatePurchaseOrderRequest expectedAt(DateTime? expectedAt);

  CreatePurchaseOrderRequest lines(List<POLineInput> lines);

  CreatePurchaseOrderRequest note(String? note);

  CreatePurchaseOrderRequest reference(String? reference);

  CreatePurchaseOrderRequest supplierId(String? supplierId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreatePurchaseOrderRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreatePurchaseOrderRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreatePurchaseOrderRequest call({
    DateTime? expectedAt,
    List<POLineInput> lines,
    String? note,
    String? reference,
    String? supplierId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCreatePurchaseOrderRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCreatePurchaseOrderRequest.copyWith.fieldName(...)`
class _$CreatePurchaseOrderRequestCWProxyImpl
    implements _$CreatePurchaseOrderRequestCWProxy {
  const _$CreatePurchaseOrderRequestCWProxyImpl(this._value);

  final CreatePurchaseOrderRequest _value;

  @override
  CreatePurchaseOrderRequest expectedAt(DateTime? expectedAt) =>
      this(expectedAt: expectedAt);

  @override
  CreatePurchaseOrderRequest lines(List<POLineInput> lines) =>
      this(lines: lines);

  @override
  CreatePurchaseOrderRequest note(String? note) => this(note: note);

  @override
  CreatePurchaseOrderRequest reference(String? reference) =>
      this(reference: reference);

  @override
  CreatePurchaseOrderRequest supplierId(String? supplierId) =>
      this(supplierId: supplierId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreatePurchaseOrderRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreatePurchaseOrderRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreatePurchaseOrderRequest call({
    Object? expectedAt = const $CopyWithPlaceholder(),
    Object? lines = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? reference = const $CopyWithPlaceholder(),
    Object? supplierId = const $CopyWithPlaceholder(),
  }) {
    return CreatePurchaseOrderRequest(
      expectedAt: expectedAt == const $CopyWithPlaceholder()
          ? _value.expectedAt
          // ignore: cast_nullable_to_non_nullable
          : expectedAt as DateTime?,
      lines: lines == const $CopyWithPlaceholder()
          ? _value.lines
          // ignore: cast_nullable_to_non_nullable
          : lines as List<POLineInput>,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
      reference: reference == const $CopyWithPlaceholder()
          ? _value.reference
          // ignore: cast_nullable_to_non_nullable
          : reference as String?,
      supplierId: supplierId == const $CopyWithPlaceholder()
          ? _value.supplierId
          // ignore: cast_nullable_to_non_nullable
          : supplierId as String?,
    );
  }
}

extension $CreatePurchaseOrderRequestCopyWith on CreatePurchaseOrderRequest {
  /// Returns a callable class that can be used as follows: `instanceOfCreatePurchaseOrderRequest.copyWith(...)` or like so:`instanceOfCreatePurchaseOrderRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreatePurchaseOrderRequestCWProxy get copyWith =>
      _$CreatePurchaseOrderRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePurchaseOrderRequest _$CreatePurchaseOrderRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'CreatePurchaseOrderRequest',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['lines']);
    final val = CreatePurchaseOrderRequest(
      expectedAt: $checkedConvert(
        'expected_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      lines: $checkedConvert(
        'lines',
        (v) => (v as List<dynamic>)
            .map((e) => POLineInput.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      note: $checkedConvert('note', (v) => v as String?),
      reference: $checkedConvert('reference', (v) => v as String?),
      supplierId: $checkedConvert('supplier_id', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'expectedAt': 'expected_at', 'supplierId': 'supplier_id'},
);

Map<String, dynamic> _$CreatePurchaseOrderRequestToJson(
  CreatePurchaseOrderRequest instance,
) => <String, dynamic>{
  'expected_at': ?instance.expectedAt?.toIso8601String(),
  'lines': instance.lines.map((e) => e.toJson()).toList(),
  'note': ?instance.note,
  'reference': ?instance.reference,
  'supplier_id': ?instance.supplierId,
};
