// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_movement.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CashMovementCWProxy {
  CashMovement amount(int amount);

  CashMovement createdAt(DateTime createdAt);

  CashMovement id(String id);

  CashMovement movedBy(String movedBy);

  CashMovement movedByName(String movedByName);

  CashMovement note(String note);

  CashMovement shiftId(String shiftId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CashMovement(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CashMovement(...).copyWith(id: 12, name: "My name")
  /// ````
  CashMovement call({
    int amount,
    DateTime createdAt,
    String id,
    String movedBy,
    String movedByName,
    String note,
    String shiftId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCashMovement.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCashMovement.copyWith.fieldName(...)`
class _$CashMovementCWProxyImpl implements _$CashMovementCWProxy {
  const _$CashMovementCWProxyImpl(this._value);

  final CashMovement _value;

  @override
  CashMovement amount(int amount) => this(amount: amount);

  @override
  CashMovement createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  CashMovement id(String id) => this(id: id);

  @override
  CashMovement movedBy(String movedBy) => this(movedBy: movedBy);

  @override
  CashMovement movedByName(String movedByName) =>
      this(movedByName: movedByName);

  @override
  CashMovement note(String note) => this(note: note);

  @override
  CashMovement shiftId(String shiftId) => this(shiftId: shiftId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CashMovement(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CashMovement(...).copyWith(id: 12, name: "My name")
  /// ````
  CashMovement call({
    Object? amount = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? movedBy = const $CopyWithPlaceholder(),
    Object? movedByName = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? shiftId = const $CopyWithPlaceholder(),
  }) {
    return CashMovement(
      amount: amount == const $CopyWithPlaceholder()
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as int,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      movedBy: movedBy == const $CopyWithPlaceholder()
          ? _value.movedBy
          // ignore: cast_nullable_to_non_nullable
          : movedBy as String,
      movedByName: movedByName == const $CopyWithPlaceholder()
          ? _value.movedByName
          // ignore: cast_nullable_to_non_nullable
          : movedByName as String,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String,
      shiftId: shiftId == const $CopyWithPlaceholder()
          ? _value.shiftId
          // ignore: cast_nullable_to_non_nullable
          : shiftId as String,
    );
  }
}

extension $CashMovementCopyWith on CashMovement {
  /// Returns a callable class that can be used as follows: `instanceOfCashMovement.copyWith(...)` or like so:`instanceOfCashMovement.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CashMovementCWProxy get copyWith => _$CashMovementCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashMovement _$CashMovementFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CashMovement',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'amount',
            'created_at',
            'id',
            'moved_by',
            'moved_by_name',
            'note',
            'shift_id',
          ],
        );
        final val = CashMovement(
          amount: $checkedConvert('amount', (v) => (v as num).toInt()),
          createdAt: $checkedConvert(
            'created_at',
            (v) => DateTime.parse(v as String),
          ),
          id: $checkedConvert('id', (v) => v as String),
          movedBy: $checkedConvert('moved_by', (v) => v as String),
          movedByName: $checkedConvert('moved_by_name', (v) => v as String),
          note: $checkedConvert('note', (v) => v as String),
          shiftId: $checkedConvert('shift_id', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'createdAt': 'created_at',
        'movedBy': 'moved_by',
        'movedByName': 'moved_by_name',
        'shiftId': 'shift_id',
      },
    );

Map<String, dynamic> _$CashMovementToJson(CashMovement instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'created_at': instance.createdAt.toIso8601String(),
      'id': instance.id,
      'moved_by': instance.movedBy,
      'moved_by_name': instance.movedByName,
      'note': instance.note,
      'shift_id': instance.shiftId,
    };
