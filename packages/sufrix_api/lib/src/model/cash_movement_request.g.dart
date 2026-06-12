// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_movement_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CashMovementRequestCWProxy {
  CashMovementRequest amount(int amount);

  CashMovementRequest note(String note);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CashMovementRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CashMovementRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CashMovementRequest call({int amount, String note});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCashMovementRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCashMovementRequest.copyWith.fieldName(...)`
class _$CashMovementRequestCWProxyImpl implements _$CashMovementRequestCWProxy {
  const _$CashMovementRequestCWProxyImpl(this._value);

  final CashMovementRequest _value;

  @override
  CashMovementRequest amount(int amount) => this(amount: amount);

  @override
  CashMovementRequest note(String note) => this(note: note);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CashMovementRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CashMovementRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CashMovementRequest call({
    Object? amount = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
  }) {
    return CashMovementRequest(
      amount: amount == const $CopyWithPlaceholder()
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as int,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String,
    );
  }
}

extension $CashMovementRequestCopyWith on CashMovementRequest {
  /// Returns a callable class that can be used as follows: `instanceOfCashMovementRequest.copyWith(...)` or like so:`instanceOfCashMovementRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CashMovementRequestCWProxy get copyWith =>
      _$CashMovementRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashMovementRequest _$CashMovementRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CashMovementRequest', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['amount', 'note']);
      final val = CashMovementRequest(
        amount: $checkedConvert('amount', (v) => (v as num).toInt()),
        note: $checkedConvert('note', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$CashMovementRequestToJson(
  CashMovementRequest instance,
) => <String, dynamic>{'amount': instance.amount, 'note': instance.note};
