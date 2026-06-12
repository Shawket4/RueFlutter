import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/shift.dart';

void main() {
  final shiftJson = {
    'id': 's1',
    'branch_id': 'b1',
    'teller_id': 't1',
    'teller_name': 'John',
    'status': 'open',
    'opening_cash': 1000,
    'opening_cash_was_edited': false,
    'opened_at': '2023-01-01T08:00:00.000Z',
  };

  group('Shift', () {
    test('fromJson & toJson', () {
      final shift = Shift.fromJson(shiftJson);
      expect(shift.id, 's1');
      expect(shift.isOpen, true);
      expect(shift.openingCash, 1000);
      expect(shift.closedAt, null);
      expect(shift.closingCashDeclared, null);

      final out = shift.toJson();
      expect(out['id'], 's1');
      expect(out['branch_id'], 'b1');
      expect(out['teller_id'], 't1');
      expect(out['teller_name'], 'John');
      expect(out['status'], 'open');
      expect(out['opening_cash'], 1000);
      expect(out['opened_at'], '2023-01-01T08:00:00.000Z');

      // Round-trips through its own toJson (cache compatibility).
      final restored = Shift.fromJson(out);
      expect(restored.id, shift.id);
      expect(restored.openingCash, shift.openingCash);
      expect(restored.isOpen, true);
    });

    test('isOpen is false for closed shifts', () {
      final shift = Shift.fromJson({
        ...shiftJson,
        'status': 'closed',
        'closing_cash_declared': 2000,
        'closing_cash_system': 2100,
        'cash_discrepancy': -100,
        'closed_at': '2023-01-01T18:00:00.000Z',
      });
      expect(shift.isOpen, false);
      expect(shift.closingCashDeclared, 2000);
      expect(shift.closingCashSystem, 2100);
      expect(shift.cashDiscrepancy, -100);
    });
  });

  group('ShiftPreFill', () {
    test('fromJson', () {
      final json = {
        'has_open_shift': true,
        'open_shift': shiftJson,
        'suggested_opening_cash': 1500,
      };

      final preFill = ShiftPreFill.fromJson(json);
      expect(preFill.hasOpenShift, true);
      expect(preFill.openShift?.id, 's1');
      expect(preFill.suggestedOpeningCash, 1500);
    });

    test('fromJson without an open shift', () {
      final preFill = ShiftPreFill.fromJson({
        'has_open_shift': false,
        'suggested_opening_cash': 0,
      });
      expect(preFill.hasOpenShift, false);
      expect(preFill.openShift, null);
    });
  });
}
