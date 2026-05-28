import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/shift_report.dart';

void main() {
  group('PaymentSummaryItem', () {
    test('fromJson & toJson', () {
      final json = {'payment_method': 'cash', 'total': 1500, 'order_count': 5};
      final item = PaymentSummaryItem.fromJson(json);
      expect(item.paymentMethod, 'cash');
      expect(item.total, 1500);
      expect(item.orderCount, 5);
      expect(item.toJson(), json);
    });

    test('displayLabel formatting', () {
      expect(const PaymentSummaryItem(paymentMethod: 'cash', total: 0, orderCount: 0).displayLabel, 'Cash');
      expect(const PaymentSummaryItem(paymentMethod: 'card', total: 0, orderCount: 0).displayLabel, 'Card');
      expect(const PaymentSummaryItem(paymentMethod: 'digital_wallet', total: 0, orderCount: 0).displayLabel, 'Digital Wallet');
      expect(const PaymentSummaryItem(paymentMethod: 'mixed', total: 0, orderCount: 0).displayLabel, 'Mixed');
      expect(const PaymentSummaryItem(paymentMethod: 'talabat_online', total: 0, orderCount: 0).displayLabel, 'Talabat Online');
      expect(const PaymentSummaryItem(paymentMethod: 'talabat_cash', total: 0, orderCount: 0).displayLabel, 'Talabat Cash');
      expect(const PaymentSummaryItem(paymentMethod: 'other_method', total: 0, orderCount: 0).displayLabel, 'Other method');
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
      final now = DateTime.now();
      expect(CashMovementItem(amount: 100, note: '', movedByName: '', createdAt: now).isIn, true);
      expect(CashMovementItem(amount: -100, note: '', movedByName: '', createdAt: now).isIn, false);
    });
  });

  group('ShiftReport', () {
    test('fromJson & toJson', () {
      final json = {
        'shift': {
          'id': 's1',
          'branch_id': 'b1',
          'teller_name': 'John',
          'status': 'open',
          'opening_cash': 1000,
          'closing_cash_declared': null,
          'closing_cash_system': null,
          'opened_at': '2023-01-01T08:00:00.000Z',
          'closed_at': null,
        },
        'payment_summary': [
          {'payment_method': 'cash', 'total': 500, 'order_count': 2}
        ],
        'cash_movements': [
          {'amount': 100, 'note': 'in', 'moved_by_name': 'John', 'created_at': '2023-01-01T09:00:00.000Z'}
        ],
        'total_payments': 500,
        'net_payments': 500,
        'cash_movements_in': 100,
        'cash_movements_out': 0,
        'voided_amount': 0,
        'printed_at': '2023-01-01T12:00:00.000Z',
      };

      final report = ShiftReport.fromJson(json);
      expect(report.shiftId, 's1');
      expect(report.isOpen, true);
      expect(report.paymentSummary.length, 1);
      expect(report.cashMovements.length, 1);
      expect(report.expectedCash, 1600); // 1000 (opening) + 500 (cash payment) + 100 (cash in)
      
      final out = report.toJson();
      expect(out['shift']['id'], 's1');
      expect(out['payment_summary'].length, 1);
    });

    test('expectedCash uses closingCashSystem if present', () {
      final report = ShiftReport(
        shiftId: 's1', branchId: 'b1', tellerName: 'John', status: 'closed',
        openingCash: 1000, closingCashSystem: 2000, openedAt: DateTime.now(),
        paymentSummary: [], cashMovements: [], totalPayments: 0, netPayments: 0,
        cashMovementsIn: 0, cashMovementsOut: 0, totalReturns: 0, printedAt: DateTime.now(),
      );
      expect(report.expectedCash, 2000);
    });
  });
}
