import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/delivery_order.dart';
import 'package:sufrix_pos/core/services/new_order_detector.dart';

DeliveryOrder order(String id, DeliveryStatus status) => DeliveryOrder.fromJson({
      'id': id,
      'branch_id': 'br-1',
      'channel': 'in_mall',
      'status': status.wire,
      'customer_name': 'C',
      'customer_phone': '2010',
      'subtotal': 0,
      'delivery_fee': 0,
      'total': 0,
      'extra_prep_minutes': 0,
      'cart': {'lines': []},
      'created_at': '2026-06-15T10:00:00Z',
      'updated_at': '2026-06-15T10:00:00Z',
    });

void main() {
  group('NewOrderDetector', () {
    test('first reconcile seeds silently (no alerts) even with received orders',
        () {
      final d = NewOrderDetector();
      final fresh = d.reconcile([
        order('a', DeliveryStatus.received),
        order('b', DeliveryStatus.received),
      ]);
      expect(fresh, isEmpty);
      expect(d.seeded, true);
    });

    test('after seed, reconcile alerts only on newly-seen received orders', () {
      final d = NewOrderDetector();
      d.reconcile([order('a', DeliveryStatus.received)]); // seed
      final fresh = d.reconcile([
        order('a', DeliveryStatus.received), // already seen
        order('b', DeliveryStatus.received), // new
        order('c', DeliveryStatus.confirmed), // not received → ignored
      ]);
      expect(fresh.map((o) => o.id), ['b']);
    });

    test('reconcile dedups the same id across calls', () {
      final d = NewOrderDetector();
      d.reconcile([]); // seed empty
      expect(d.reconcile([order('x', DeliveryStatus.received)]).map((o) => o.id),
          ['x']);
      // Same order surfaced again by a later poll → no re-alert.
      expect(d.reconcile([order('x', DeliveryStatus.received)]), isEmpty);
    });

    test('isNewFromEvent returns false before seeding (but records the id)', () {
      final d = NewOrderDetector();
      expect(d.isNewFromEvent(order('a', DeliveryStatus.received)), false);
      d.reconcile([]); // seed; 'a' already recorded above
      // A later reconcile that includes 'a' must NOT alert (already recorded).
      expect(d.reconcile([order('a', DeliveryStatus.received)]), isEmpty);
    });

    test('isNewFromEvent after seed: new received → true, repeat → false', () {
      final d = NewOrderDetector();
      d.reconcile([]); // seed
      expect(d.isNewFromEvent(order('a', DeliveryStatus.received)), true);
      expect(d.isNewFromEvent(order('a', DeliveryStatus.received)), false);
      expect(d.isNewFromEvent(order('b', DeliveryStatus.confirmed)), false);
    });

    test('cross-source dedup: SSE event then poll does not double-alert', () {
      final d = NewOrderDetector();
      d.reconcile([order('a', DeliveryStatus.received)]); // seed with A
      // SSE pushes a new B.
      expect(d.isNewFromEvent(order('b', DeliveryStatus.received)), true);
      // A poll then returns A, B, and a brand-new C.
      final fresh = d.reconcile([
        order('a', DeliveryStatus.received),
        order('b', DeliveryStatus.received),
        order('c', DeliveryStatus.received),
      ]);
      expect(fresh.map((o) => o.id), ['c']); // only C is new
    });

    test('reset re-seeds on the next reconcile', () {
      final d = NewOrderDetector();
      d.reconcile([order('a', DeliveryStatus.received)]);
      d.isNewFromEvent(order('b', DeliveryStatus.received));
      d.reset();
      expect(d.seeded, false);
      // After reset, the next reconcile seeds again (no alerts), and previously
      // seen ids are forgotten.
      expect(d.reconcile([order('a', DeliveryStatus.received)]), isEmpty);
      expect(d.seeded, true);
    });
  });
}
