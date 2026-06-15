import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/shift_report.dart';

import '../../helpers/model_fixtures.dart';

void main() {
  group('PaymentSummaryItem', () {
    test('fromJson & toJson', () {
      final json = {
        'payment_method': 'cash',
        'is_cash': true,
        'total': 1500,
        'order_count': 5
      };
      final item = PaymentSummaryItem.fromJson(json);
      expect(item.paymentMethod, 'cash');
      expect(item.isCash, true);
      expect(item.total, 1500);
      expect(item.orderCount, 5);
      expect(item.toJson(), json);
    });

    test('displayLabel formatting', () {
      expect(makePaymentSummaryItem(paymentMethod: 'cash').displayLabel, 'Cash');
      expect(makePaymentSummaryItem(paymentMethod: 'card', isCash: false).displayLabel, 'Card');
      expect(makePaymentSummaryItem(paymentMethod: 'digital_wallet', isCash: false).displayLabel, 'Digital Wallet');
      expect(makePaymentSummaryItem(paymentMethod: 'mixed', isCash: false).displayLabel, 'Mixed');
      expect(makePaymentSummaryItem(paymentMethod: 'talabat_online', isCash: false).displayLabel, 'Talabat Online');
      expect(makePaymentSummaryItem(paymentMethod: 'talabat_cash').displayLabel, 'Talabat Cash');
      expect(makePaymentSummaryItem(paymentMethod: 'other_method', isCash: false).displayLabel, 'Other method');
    });
  });

  group('CashMovementItem', () {
    test('fromJson & toJson', () {
      final json = {
        'amount': 100,
        'note': 'tip',
        'moved_by_name': 'John',
        'created_at': '2023-01-01T12:00:00.000Z',
      };
      final item = CashMovementItem.fromJson(json);
      expect(item.amount, 100);
      expect(item.note, 'tip');
      expect(item.movedByName, 'John');
      expect(item.isIn, true);
      expect(item.toJson(), json);
    });

    test('isIn', () {
      expect(makeCashMovementItem(amount: 100).isIn, true);
      expect(makeCashMovementItem(amount: -100).isIn, false);
    });
  });

  group('ShiftReport', () {
    test('fromJson & toJson', () {
      final json = {
        'shift': {
          'id': 's1',
          'branch_id': 'b1',
          'teller_id': 't1',
          'teller_name': 'John',
          'status': 'open',
          'opening_cash': 1000,
          'opening_cash_was_edited': false,
          'opened_at': '2023-01-01T08:00:00.000Z',
        },
        'payment_summary': [
          {'payment_method': 'cash', 'is_cash': true, 'total': 500, 'order_count': 2}
        ],
        'cash_movements': [
          {'amount': 100, 'note': 'in', 'moved_by_name': 'John', 'created_at': '2023-01-01T09:00:00.000Z'}
        ],
        'total_payments': 500,
        'net_payments': 500,
        'cash_movements_in': 100,
        'cash_movements_out': 0,
        'cash_movements_net': 100,
        'voided_amount': 0,
        // Server-authoritative expected cash (required on every report):
        // 1000 (opening) + 500 (cash payment) + 100 (cash in).
        'expected_cash': 1600,
        'printed_at': '2023-01-01T12:00:00.000Z',
      };

      final report = ShiftReport.fromJson(json);
      expect(report.shiftId, 's1');
      expect(report.branchId, 'b1');
      expect(report.tellerName, 'John');
      expect(report.isOpen, true);
      expect(report.openingCash, 1000);
      expect(report.totalReturns, 0);
      expect(report.paymentSummary.length, 1);
      expect(report.cashMovements.length, 1);
      expect(report.expectedCash, 1600);

      final out = report.toJson();
      expect(out['shift']['id'], 's1');
      expect(out['payment_summary'].length, 1);
      expect(out['voided_amount'], 0);
      expect(out['cash_movements_in'], 100);
    });

    test('expectedCash is the server-authoritative field', () {
      final report = makeShiftReport(
        shift: makeShift(
          status: 'closed',
          openingCash: 1000,
          closingCashSystem: 2000,
        ),
        expectedCash: 2000,
      );
      expect(report.expectedCash, 2000);
      expect(report.isOpen, false);
    });
  });
}
