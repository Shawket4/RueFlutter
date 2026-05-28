import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/shift.dart';

void main() {
  group('Shift', () {
    test('fromJson & toJson', () {
      final json = {
        'id': 's1',
        'branch_id': 'b1',
        'teller_id': 't1',
        'teller_name': 'John',
        'status': 'open',
        'opening_cash': 1000,
        'closing_cash_declared': null,
        'closing_cash_system': null,
        'cash_discrepancy': null,
        'opened_at': '2023-01-01T08:00:00.000Z',
        'closed_at': null,
      };

      final shift = Shift.fromJson(json);
      expect(shift.id, 's1');
      expect(shift.isOpen, true);
      expect(shift.openingCash, 1000);

      expect(shift.toJson(), json);
    });
  });

  group('ShiftPreFill', () {
    test('fromJson', () {
      final json = {
        'has_open_shift': true,
        'open_shift': {
          'id': 's1',
          'branch_id': 'b1',
          'teller_id': 't1',
          'teller_name': 'John',
          'status': 'open',
          'opening_cash': 1000,
          'closing_cash_declared': null,
          'closing_cash_system': null,
          'cash_discrepancy': null,
          'opened_at': '2023-01-01T08:00:00.000Z',
          'closed_at': null,
        },
        'suggested_opening_cash': 1500,
      };

      final preFill = ShiftPreFill.fromJson(json);
      expect(preFill.hasOpenShift, true);
      expect(preFill.openShift?.id, 's1');
      expect(preFill.suggestedOpeningCash, 1500);
    });
  });
}
