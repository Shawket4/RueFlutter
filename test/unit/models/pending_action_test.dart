import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/pending_action.dart';

void main() {
  final now = DateTime.utc(2023, 1, 1, 12, 0);

  group('PendingShiftOpen', () {
    test('fromJson & toJson', () {
      final json = {
        'local_id': 'l1',
        'type': 'shiftOpen',
        'created_at': now.toIso8601String(),
        'retry_count': 1,
        'last_error': 'err',
        'branch_id': 'b1',
        'shift_id': 's1',
        'opening_cash': 1000,
        'opened_at': now.toIso8601String(),
      };

      final action = PendingShiftOpen.fromJson(json);
      expect(action.localId, 'l1');
      expect(action.retryCount, 1);
      expect(action.lastError, 'err');
      expect(action.openingCash, 1000);

      expect(action.toJson(), json);
    });

    test('withIncrementedRetry & withResetRetry', () {
      final action = PendingShiftOpen(
        localId: 'l1', createdAt: now, branchId: 'b1', shiftId: 's1',
        openingCash: 1000, openedAt: now,
      );

      final inc = action.withIncrementedRetry('error message');
      expect(inc.retryCount, 1);
      expect(inc.lastError, 'error message');

      final reset = inc.withResetRetry();
      expect(reset.retryCount, 0);
      expect(reset.lastError, null);
    });
  });

  group('PendingOrder', () {
    test('fromJson & toJson', () {
      final json = {
        'local_id': 'l2',
        'type': 'order',
        'created_at': now.toIso8601String(),
        'retry_count': 0,
        'last_error': null,
        'branch_id': 'b1',
        'shift_id': 's1',
        'payment_method': 'cash',
        'customer_name': 'John',
        'discount_type': null,
        'discount_value': null,
        'discount_id': null,
        'amount_tendered': 1500,
        'tip_amount': 50,
        'tip_payment_method': 'cash',
        'ordered_at': now.toIso8601String(),
        'items': []
      };

      final action = PendingOrder.fromJson(json);
      expect(action.localId, 'l2');
      expect(action.paymentMethod, 'cash');
      expect(action.customerName, 'John');
      expect(action.amountTendered, 1500);

      expect(action.toJson(), json);
    });
  });

  group('PendingShiftClose', () {
    test('fromJson & toJson', () {
      final json = {
        'local_id': 'l3',
        'type': 'shiftClose',
        'created_at': now.toIso8601String(),
        'retry_count': 0,
        'last_error': null,
        'branch_id': 'b1',
        'shift_id': 's1',
        'closing_cash': 2000,
        'cash_note': null,
        'inventory_counts': [],
        'closed_at': now.toIso8601String(),
      };

      final action = PendingShiftClose.fromJson(json);
      expect(action.localId, 'l3');
      expect(action.closingCash, 2000);

      expect(action.toJson(), json);
    });
  });

  group('PendingVoidOrder', () {
    test('fromJson & toJson', () {
      final json = {
        'local_id': 'l4',
        'type': 'voidOrder',
        'created_at': now.toIso8601String(),
        'retry_count': 0,
        'last_error': null,
        'order_id': 'o1',
        'reason': 'wrong order',
        'restore_inventory': true,
        'voided_at': now.toIso8601String(),
      };

      final action = PendingVoidOrder.fromJson(json);
      expect(action.orderId, 'o1');
      expect(action.reason, 'wrong order');
      expect(action.restoreInventory, true);

      expect(action.toJson(), json);
    });
  });

  group('PendingCashMovement', () {
    test('fromJson & toJson', () {
      final json = {
        'local_id': 'l5',
        'type': 'cashMovement',
        'created_at': now.toIso8601String(),
        'retry_count': 0,
        'last_error': null,
        'shift_id': 's1',
        'amount': 100,
        'note': 'test',
      };

      final action = PendingCashMovement.fromJson(json);
      expect(action.amount, 100);
      expect(action.note, 'test');

      expect(action.toJson(), json);
    });
  });

  group('PendingAction base fromJson', () {
    test('parses correct subclass', () {
      final json = {
        'local_id': 'l1',
        'type': 'shiftOpen',
        'created_at': now.toIso8601String(),
        'branch_id': 'b1',
        'shift_id': 's1',
        'opening_cash': 1000,
        'opened_at': now.toIso8601String(),
      };

      final action = PendingAction.fromJson(json);
      expect(action, isA<PendingShiftOpen>());
    });
  });
}
