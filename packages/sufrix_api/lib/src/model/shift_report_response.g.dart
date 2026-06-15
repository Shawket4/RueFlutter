// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_report_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ShiftReportResponseCWProxy {
  ShiftReportResponse cashMovements(List<CashMovementSummaryRow> cashMovements);

  ShiftReportResponse cashMovementsIn(int cashMovementsIn);

  ShiftReportResponse cashMovementsNet(int cashMovementsNet);

  ShiftReportResponse cashMovementsOut(int cashMovementsOut);

  ShiftReportResponse netPayments(int netPayments);

  ShiftReportResponse paymentSummary(List<PaymentSummaryRow> paymentSummary);

  ShiftReportResponse printedAt(DateTime printedAt);

  ShiftReportResponse shift(Shift shift);

  ShiftReportResponse totalPayments(int totalPayments);

  ShiftReportResponse voidedAmount(int voidedAmount);

  ShiftReportResponse expectedCashAmount(int? expectedCashAmount);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ShiftReportResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ShiftReportResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ShiftReportResponse call({
    List<CashMovementSummaryRow> cashMovements,
    int cashMovementsIn,
    int cashMovementsNet,
    int cashMovementsOut,
    int netPayments,
    List<PaymentSummaryRow> paymentSummary,
    DateTime printedAt,
    Shift shift,
    int totalPayments,
    int voidedAmount,
    int? expectedCashAmount,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfShiftReportResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfShiftReportResponse.copyWith.fieldName(...)`
class _$ShiftReportResponseCWProxyImpl implements _$ShiftReportResponseCWProxy {
  const _$ShiftReportResponseCWProxyImpl(this._value);

  final ShiftReportResponse _value;

  @override
  ShiftReportResponse cashMovements(
    List<CashMovementSummaryRow> cashMovements,
  ) => this(cashMovements: cashMovements);

  @override
  ShiftReportResponse cashMovementsIn(int cashMovementsIn) =>
      this(cashMovementsIn: cashMovementsIn);

  @override
  ShiftReportResponse cashMovementsNet(int cashMovementsNet) =>
      this(cashMovementsNet: cashMovementsNet);

  @override
  ShiftReportResponse cashMovementsOut(int cashMovementsOut) =>
      this(cashMovementsOut: cashMovementsOut);

  @override
  ShiftReportResponse netPayments(int netPayments) =>
      this(netPayments: netPayments);

  @override
  ShiftReportResponse paymentSummary(List<PaymentSummaryRow> paymentSummary) =>
      this(paymentSummary: paymentSummary);

  @override
  ShiftReportResponse printedAt(DateTime printedAt) =>
      this(printedAt: printedAt);

  @override
  ShiftReportResponse shift(Shift shift) => this(shift: shift);

  @override
  ShiftReportResponse totalPayments(int totalPayments) =>
      this(totalPayments: totalPayments);

  @override
  ShiftReportResponse voidedAmount(int voidedAmount) =>
      this(voidedAmount: voidedAmount);

  @override
  ShiftReportResponse expectedCashAmount(int? expectedCashAmount) =>
      this(expectedCashAmount: expectedCashAmount);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ShiftReportResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ShiftReportResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ShiftReportResponse call({
    Object? cashMovements = const $CopyWithPlaceholder(),
    Object? cashMovementsIn = const $CopyWithPlaceholder(),
    Object? cashMovementsNet = const $CopyWithPlaceholder(),
    Object? cashMovementsOut = const $CopyWithPlaceholder(),
    Object? netPayments = const $CopyWithPlaceholder(),
    Object? paymentSummary = const $CopyWithPlaceholder(),
    Object? printedAt = const $CopyWithPlaceholder(),
    Object? shift = const $CopyWithPlaceholder(),
    Object? totalPayments = const $CopyWithPlaceholder(),
    Object? voidedAmount = const $CopyWithPlaceholder(),
    Object? expectedCashAmount = const $CopyWithPlaceholder(),
  }) {
    return ShiftReportResponse(
      cashMovements: cashMovements == const $CopyWithPlaceholder()
          ? _value.cashMovements
          // ignore: cast_nullable_to_non_nullable
          : cashMovements as List<CashMovementSummaryRow>,
      cashMovementsIn: cashMovementsIn == const $CopyWithPlaceholder()
          ? _value.cashMovementsIn
          // ignore: cast_nullable_to_non_nullable
          : cashMovementsIn as int,
      cashMovementsNet: cashMovementsNet == const $CopyWithPlaceholder()
          ? _value.cashMovementsNet
          // ignore: cast_nullable_to_non_nullable
          : cashMovementsNet as int,
      cashMovementsOut: cashMovementsOut == const $CopyWithPlaceholder()
          ? _value.cashMovementsOut
          // ignore: cast_nullable_to_non_nullable
          : cashMovementsOut as int,
      netPayments: netPayments == const $CopyWithPlaceholder()
          ? _value.netPayments
          // ignore: cast_nullable_to_non_nullable
          : netPayments as int,
      paymentSummary: paymentSummary == const $CopyWithPlaceholder()
          ? _value.paymentSummary
          // ignore: cast_nullable_to_non_nullable
          : paymentSummary as List<PaymentSummaryRow>,
      printedAt: printedAt == const $CopyWithPlaceholder()
          ? _value.printedAt
          // ignore: cast_nullable_to_non_nullable
          : printedAt as DateTime,
      shift: shift == const $CopyWithPlaceholder()
          ? _value.shift
          // ignore: cast_nullable_to_non_nullable
          : shift as Shift,
      totalPayments: totalPayments == const $CopyWithPlaceholder()
          ? _value.totalPayments
          // ignore: cast_nullable_to_non_nullable
          : totalPayments as int,
      voidedAmount: voidedAmount == const $CopyWithPlaceholder()
          ? _value.voidedAmount
          // ignore: cast_nullable_to_non_nullable
          : voidedAmount as int,
      expectedCashAmount: expectedCashAmount == const $CopyWithPlaceholder()
          ? _value.expectedCashAmount
          // ignore: cast_nullable_to_non_nullable
          : expectedCashAmount as int?,
    );
  }
}

extension $ShiftReportResponseCopyWith on ShiftReportResponse {
  /// Returns a callable class that can be used as follows: `instanceOfShiftReportResponse.copyWith(...)` or like so:`instanceOfShiftReportResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ShiftReportResponseCWProxy get copyWith =>
      _$ShiftReportResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShiftReportResponse _$ShiftReportResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ShiftReportResponse',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'cash_movements',
        'cash_movements_in',
        'cash_movements_net',
        'cash_movements_out',
        'net_payments',
        'payment_summary',
        'printed_at',
        'shift',
        'total_payments',
        'voided_amount',
      ],
    );
    final val = ShiftReportResponse(
      cashMovements: $checkedConvert(
        'cash_movements',
        (v) => (v as List<dynamic>)
            .map(
              (e) => CashMovementSummaryRow.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      cashMovementsIn: $checkedConvert(
        'cash_movements_in',
        (v) => (v as num).toInt(),
      ),
      cashMovementsNet: $checkedConvert(
        'cash_movements_net',
        (v) => (v as num).toInt(),
      ),
      cashMovementsOut: $checkedConvert(
        'cash_movements_out',
        (v) => (v as num).toInt(),
      ),
      netPayments: $checkedConvert('net_payments', (v) => (v as num).toInt()),
      paymentSummary: $checkedConvert(
        'payment_summary',
        (v) => (v as List<dynamic>)
            .map((e) => PaymentSummaryRow.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      printedAt: $checkedConvert(
        'printed_at',
        (v) => DateTime.parse(v as String),
      ),
      shift: $checkedConvert(
        'shift',
        (v) => Shift.fromJson(v as Map<String, dynamic>),
      ),
      totalPayments: $checkedConvert(
        'total_payments',
        (v) => (v as num).toInt(),
      ),
      voidedAmount: $checkedConvert('voided_amount', (v) => (v as num).toInt()),
      expectedCashAmount: $checkedConvert(
        'expected_cash',
        (v) => (v as num?)?.toInt(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'cashMovements': 'cash_movements',
    'cashMovementsIn': 'cash_movements_in',
    'cashMovementsNet': 'cash_movements_net',
    'cashMovementsOut': 'cash_movements_out',
    'netPayments': 'net_payments',
    'paymentSummary': 'payment_summary',
    'printedAt': 'printed_at',
    'totalPayments': 'total_payments',
    'voidedAmount': 'voided_amount',
    'expectedCashAmount': 'expected_cash',
  },
);

Map<String, dynamic> _$ShiftReportResponseToJson(
  ShiftReportResponse instance,
) => <String, dynamic>{
  'cash_movements': instance.cashMovements.map((e) => e.toJson()).toList(),
  'cash_movements_in': instance.cashMovementsIn,
  'cash_movements_net': instance.cashMovementsNet,
  'cash_movements_out': instance.cashMovementsOut,
  'net_payments': instance.netPayments,
  'payment_summary': instance.paymentSummary.map((e) => e.toJson()).toList(),
  'printed_at': instance.printedAt.toIso8601String(),
  'shift': instance.shift.toJson(),
  'total_payments': instance.totalPayments,
  'voided_amount': instance.voidedAmount,
  'expected_cash': ?instance.expectedCashAmount,
};
