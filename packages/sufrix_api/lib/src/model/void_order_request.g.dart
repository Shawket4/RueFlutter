// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'void_order_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VoidOrderRequestCWProxy {
  VoidOrderRequest note(String? note);

  VoidOrderRequest reason(String reason);

  VoidOrderRequest restoreInventory(bool? restoreInventory);

  VoidOrderRequest voidedAt(DateTime? voidedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VoidOrderRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VoidOrderRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  VoidOrderRequest call({
    String? note,
    String reason,
    bool? restoreInventory,
    DateTime? voidedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVoidOrderRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVoidOrderRequest.copyWith.fieldName(...)`
class _$VoidOrderRequestCWProxyImpl implements _$VoidOrderRequestCWProxy {
  const _$VoidOrderRequestCWProxyImpl(this._value);

  final VoidOrderRequest _value;

  @override
  VoidOrderRequest note(String? note) => this(note: note);

  @override
  VoidOrderRequest reason(String reason) => this(reason: reason);

  @override
  VoidOrderRequest restoreInventory(bool? restoreInventory) =>
      this(restoreInventory: restoreInventory);

  @override
  VoidOrderRequest voidedAt(DateTime? voidedAt) => this(voidedAt: voidedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VoidOrderRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VoidOrderRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  VoidOrderRequest call({
    Object? note = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? restoreInventory = const $CopyWithPlaceholder(),
    Object? voidedAt = const $CopyWithPlaceholder(),
  }) {
    return VoidOrderRequest(
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
      restoreInventory: restoreInventory == const $CopyWithPlaceholder()
          ? _value.restoreInventory
          // ignore: cast_nullable_to_non_nullable
          : restoreInventory as bool?,
      voidedAt: voidedAt == const $CopyWithPlaceholder()
          ? _value.voidedAt
          // ignore: cast_nullable_to_non_nullable
          : voidedAt as DateTime?,
    );
  }
}

extension $VoidOrderRequestCopyWith on VoidOrderRequest {
  /// Returns a callable class that can be used as follows: `instanceOfVoidOrderRequest.copyWith(...)` or like so:`instanceOfVoidOrderRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VoidOrderRequestCWProxy get copyWith => _$VoidOrderRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoidOrderRequest _$VoidOrderRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'VoidOrderRequest',
      json,
      ($checkedConvert) {
        $checkKeys(json, requiredKeys: const ['reason']);
        final val = VoidOrderRequest(
          note: $checkedConvert('note', (v) => v as String?),
          reason: $checkedConvert('reason', (v) => v as String),
          restoreInventory: $checkedConvert(
            'restore_inventory',
            (v) => v as bool?,
          ),
          voidedAt: $checkedConvert(
            'voided_at',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'restoreInventory': 'restore_inventory',
        'voidedAt': 'voided_at',
      },
    );

Map<String, dynamic> _$VoidOrderRequestToJson(VoidOrderRequest instance) =>
    <String, dynamic>{
      'note': ?instance.note,
      'reason': instance.reason,
      'restore_inventory': ?instance.restoreInventory,
      'voided_at': ?instance.voidedAt?.toIso8601String(),
    };
