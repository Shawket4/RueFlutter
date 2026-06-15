// Façade over the OpenAPI-generated wire models (packages/sufrix_api).
// The app's flattened ShiftReport maps to the spec's ShiftReportResponse
// (shift fields live on the embedded `shift`).
import 'package:sufrix_api/sufrix_api.dart';

export 'package:sufrix_api/sufrix_api.dart'
    show ShiftReportResponse, PaymentSummaryRow, CashMovementSummaryRow;

typedef ShiftReport = ShiftReportResponse;
typedef PaymentSummaryItem = PaymentSummaryRow;
typedef CashMovementItem = CashMovementSummaryRow;

extension ShiftReportX on ShiftReportResponse {
  String get shiftId => shift.id;
  String get branchId => shift.branchId;
  String get tellerName => shift.tellerName;
  String get status => shift.status;
  int get openingCash => shift.openingCash;
  int? get closingCashDeclared => shift.closingCashDeclared;
  int? get closingCashSystem => shift.closingCashSystem;
  DateTime get openedAt => shift.openedAt;
  DateTime? get closedAt => shift.closedAt;

  /// Wire name is `voided_amount`; the app calls it "returns".
  int get totalReturns => voidedAmount;

  bool get isOpen => shift.status == 'open';

  // `expectedCash` is now a required, server-authoritative field on the wire
  // model (the backend computes it with the exact formula it snapshots at
  // close, so the teller's preview can't drift from what gets recorded). Read
  // it directly via `report.expectedCash`.
}

extension PaymentSummaryItemX on PaymentSummaryRow {
  String get displayLabel => switch (paymentMethod) {
        'cash' => 'Cash',
        'card' => 'Card',
        'digital_wallet' => 'Digital Wallet',
        'mixed' => 'Mixed',
        'talabat_online' => 'Talabat Online',
        'talabat_cash' => 'Talabat Cash',
        _ => paymentMethod[0].toUpperCase() +
            paymentMethod.substring(1).replaceAll('_', ' '),
      };
}

extension CashMovementItemX on CashMovementSummaryRow {
  bool get isIn => amount > 0;
}
