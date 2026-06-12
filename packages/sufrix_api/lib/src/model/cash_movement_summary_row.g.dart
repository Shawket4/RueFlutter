// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_movement_summary_row.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CashMovementSummaryRowCWProxy {
  CashMovementSummaryRow amount(int amount);

  CashMovementSummaryRow createdAt(DateTime createdAt);

  CashMovementSummaryRow movedByName(String movedByName);

  CashMovementSummaryRow note(String note);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CashMovementSummaryRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CashMovementSummaryRow(...).copyWith(id: 12, name: "My name")
  /// ````
  CashMovementSummaryRow call({
    int amount,
    DateTime createdAt,
    String movedByName,
    String note,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCashMovementSummaryRow.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCashMovementSummaryRow.copyWith.fieldName(...)`
class _$CashMovementSummaryRowCWProxyImpl
    implements _$CashMovementSummaryRowCWProxy {
  const _$CashMovementSummaryRowCWProxyImpl(this._value);

  final CashMovementSummaryRow _value;

  @override
  CashMovementSummaryRow amount(int amount) => this(amount: amount);

  @override
  CashMovementSummaryRow createdAt(DateTime createdAt) =>
      this(createdAt: createdAt);

  @override
  CashMovementSummaryRow movedByName(String movedByName) =>
      this(movedByName: movedByName);

  @override
  CashMovementSummaryRow note(String note) => this(note: note);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CashMovementSummaryRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CashMovementSummaryRow(...).copyWith(id: 12, name: "My name")
  /// ````
  CashMovementSummaryRow call({
    Object? amount = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? movedByName = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
  }) {
    return CashMovementSummaryRow(
      amount: amount == const $CopyWithPlaceholder()
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as int,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      movedByName: movedByName == const $CopyWithPlaceholder()
          ? _value.movedByName
          // ignore: cast_nullable_to_non_nullable
          : movedByName as String,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String,
    );
  }
}

extension $CashMovementSummaryRowCopyWith on CashMovementSummaryRow {
  /// Returns a callable class that can be used as follows: `instanceOfCashMovementSummaryRow.copyWith(...)` or like so:`instanceOfCashMovementSummaryRow.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CashMovementSummaryRowCWProxy get copyWith =>
      _$CashMovementSummaryRowCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashMovementSummaryRow _$CashMovementSummaryRowFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'CashMovementSummaryRow',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['amount', 'created_at', 'moved_by_name', 'note'],
    );
    final val = CashMovementSummaryRow(
      amount: $checkedConvert('amount', (v) => (v as num).toInt()),
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      movedByName: $checkedConvert('moved_by_name', (v) => v as String),
      note: $checkedConvert('note', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'createdAt': 'created_at',
    'movedByName': 'moved_by_name',
  },
);

Map<String, dynamic> _$CashMovementSummaryRowToJson(
  CashMovementSummaryRow instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'created_at': instance.createdAt.toIso8601String(),
  'moved_by_name': instance.movedByName,
  'note': instance.note,
};
