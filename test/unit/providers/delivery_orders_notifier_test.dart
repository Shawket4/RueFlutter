import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/delivery_order.dart';
import 'package:sufrix_pos/core/providers/delivery_orders_notifier.dart';
import 'package:sufrix_pos/shared/widgets/new_order_banner.dart';

DeliveryOrder _order(String id, DeliveryStatus status) =>
    DeliveryOrder.fromJson({
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
  group('DeliveryOrdersState counts', () {
    test('newCount counts only received; activeCount counts non-terminal', () {
      final state = DeliveryOrdersState(orders: [
        _order('a', DeliveryStatus.received),
        _order('b', DeliveryStatus.received),
        _order('c', DeliveryStatus.preparing),
        _order('d', DeliveryStatus.delivered), // terminal
        _order('e', DeliveryStatus.rejected), // terminal
      ]);
      expect(state.newCount, 2); // a, b
      expect(state.activeCount, 3); // a, b, c
    });

    test('no received orders → newCount 0', () {
      final state = DeliveryOrdersState(orders: [
        _order('c', DeliveryStatus.confirmed),
      ]);
      expect(state.newCount, 0);
      expect(state.activeCount, 1);
    });
  });

  group('NewOrderBannerNotifier.dismissFor', () {
    test('clears only the matching order (accepting one keeps others)', () {
      final c = ProviderContainer();
      addTearDown(c.dispose);
      final notifier = c.read(newOrderBannerProvider.notifier);

      notifier.show(_order('x', DeliveryStatus.received));
      expect(c.read(newOrderBannerProvider)?.id, 'x');

      // A different order being accepted must NOT clear this banner.
      notifier.dismissFor('y');
      expect(c.read(newOrderBannerProvider)?.id, 'x');

      // Accepting the shown order clears it.
      notifier.dismissFor('x');
      expect(c.read(newOrderBannerProvider), isNull);
    });
  });
}
