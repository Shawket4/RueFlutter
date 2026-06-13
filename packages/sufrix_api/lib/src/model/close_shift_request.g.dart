// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'close_shift_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CloseShiftRequestCWProxy {
  CloseShiftRequest cashNote(String? cashNote);

  CloseShiftRequest closedAt(DateTime? closedAt);

  CloseShiftRequest closingCashDeclared(int closingCashDeclared);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CloseShiftRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CloseShiftRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CloseShiftRequest call({
    String? cashNote,
    DateTime? closedAt,
    int closingCashDeclared,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCloseShiftRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCloseShiftRequest.copyWith.fieldName(...)`
class _$CloseShiftRequestCWProxyImpl implements _$CloseShiftRequestCWProxy {
  const _$CloseShiftRequestCWProxyImpl(this._value);

  final CloseShiftRequest _value;

  @override
  CloseShiftRequest cashNote(String? cashNote) => this(cashNote: cashNote);

  @override
  CloseShiftRequest closedAt(DateTime? closedAt) => this(closedAt: closedAt);

  @override
  CloseShiftRequest closingCashDeclared(int closingCashDeclared) =>
      this(closingCashDeclared: closingCashDeclared);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CloseShiftRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CloseShiftRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CloseShiftRequest call({
    Object? cashNote = const $CopyWithPlaceholder(),
    Object? closedAt = const $CopyWithPlaceholder(),
    Object? closingCashDeclared = const $CopyWithPlaceholder(),
  }) {
    return CloseShiftRequest(
      cashNote: cashNote == const $CopyWithPlaceholder()
          ? _value.cashNote
          // ignore: cast_nullable_to_non_nullable
          : cashNote as String?,
      closedAt: closedAt == const $CopyWithPlaceholder()
          ? _value.closedAt
          // ignore: cast_nullable_to_non_nullable
          : closedAt as DateTime?,
      closingCashDeclared: closingCashDeclared == const $CopyWithPlaceholder()
          ? _value.closingCashDeclared
          // ignore: cast_nullable_to_non_nullable
          : closingCashDeclared as int,
    );
  }
}

extension $CloseShiftRequestCopyWith on CloseShiftRequest {
  /// Returns a callable class that can be used as follows: `instanceOfCloseShiftRequest.copyWith(...)` or like so:`instanceOfCloseShiftRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CloseShiftRequestCWProxy get copyWith =>
      _$CloseShiftRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CloseShiftRequest _$CloseShiftRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CloseShiftRequest',
      json,
      ($checkedConvert) {
        $checkKeys(json, requiredKeys: const ['closing_cash_declared']);
        final val = CloseShiftRequest(
          cashNote: $checkedConvert('cash_note', (v) => v as String?),
          closedAt: $checkedConvert(
            'closed_at',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          closingCashDeclared: $checkedConvert(
            'closing_cash_declared',
            (v) => (v as num).toInt(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'cashNote': 'cash_note',
        'closedAt': 'closed_at',
        'closingCashDeclared': 'closing_cash_declared',
      },
    );

Map<String, dynamic> _$CloseShiftRequestToJson(CloseShiftRequest instance) =>
    <String, dynamic>{
      'cash_note': ?instance.cashNote,
      'closed_at': ?instance.closedAt?.toIso8601String(),
      'closing_cash_declared': instance.closingCashDeclared,
    };
