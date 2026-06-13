// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receive_purchase_order_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReceivePurchaseOrderRequestCWProxy {
  ReceivePurchaseOrderRequest lines(List<ReceiveLineInput> lines);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReceivePurchaseOrderRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReceivePurchaseOrderRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ReceivePurchaseOrderRequest call({List<ReceiveLineInput> lines});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReceivePurchaseOrderRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReceivePurchaseOrderRequest.copyWith.fieldName(...)`
class _$ReceivePurchaseOrderRequestCWProxyImpl
    implements _$ReceivePurchaseOrderRequestCWProxy {
  const _$ReceivePurchaseOrderRequestCWProxyImpl(this._value);

  final ReceivePurchaseOrderRequest _value;

  @override
  ReceivePurchaseOrderRequest lines(List<ReceiveLineInput> lines) =>
      this(lines: lines);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReceivePurchaseOrderRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReceivePurchaseOrderRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ReceivePurchaseOrderRequest call({
    Object? lines = const $CopyWithPlaceholder(),
  }) {
    return ReceivePurchaseOrderRequest(
      lines: lines == const $CopyWithPlaceholder()
          ? _value.lines
          // ignore: cast_nullable_to_non_nullable
          : lines as List<ReceiveLineInput>,
    );
  }
}

extension $ReceivePurchaseOrderRequestCopyWith on ReceivePurchaseOrderRequest {
  /// Returns a callable class that can be used as follows: `instanceOfReceivePurchaseOrderRequest.copyWith(...)` or like so:`instanceOfReceivePurchaseOrderRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReceivePurchaseOrderRequestCWProxy get copyWith =>
      _$ReceivePurchaseOrderRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceivePurchaseOrderRequest _$ReceivePurchaseOrderRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ReceivePurchaseOrderRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['lines']);
  final val = ReceivePurchaseOrderRequest(
    lines: $checkedConvert(
      'lines',
      (v) => (v as List<dynamic>)
          .map((e) => ReceiveLineInput.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$ReceivePurchaseOrderRequestToJson(
  ReceivePurchaseOrderRequest instance,
) => <String, dynamic>{'lines': instance.lines.map((e) => e.toJson()).toList()};
