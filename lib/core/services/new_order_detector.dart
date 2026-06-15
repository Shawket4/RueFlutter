import '../models/delivery_order.dart';

/// Decides which delivery orders are *genuinely new* and should fire an alert,
/// deduping across the three overlapping sources (the seed GET, SSE `created`/
/// `updated` events, and the poll fallback). Pure + dependency-free so the
/// detection logic is unit-testable in isolation from the Ref-heavy realtime
/// service.
///
/// Contract:
///  * The first [reconcile] call SEEDS silently — existing `received` orders are
///    recorded but never alerted (they aren't new to this session).
///  * After seeding, a `received` order whose id we haven't seen is "new" — once.
///  * [isNewFromEvent] is the single-event (SSE) equivalent.
///  * [reset] clears state on shift close / sign out / branch change.
class NewOrderDetector {
  final Set<String> _seen = {};
  bool _seeded = false;

  bool get seeded => _seeded;

  /// Reconcile against a freshly-loaded list (the GET / poll path). Returns the
  /// genuinely-new `received` orders to alert on (empty on the seeding call).
  List<DeliveryOrder> reconcile(Iterable<DeliveryOrder> orders) {
    final received =
        orders.where((o) => o.status == DeliveryStatus.received);
    if (!_seeded) {
      for (final o in received) {
        _seen.add(o.id);
      }
      _seeded = true;
      return const [];
    }
    final fresh = <DeliveryOrder>[];
    for (final o in received) {
      if (_seen.add(o.id)) fresh.add(o);
    }
    return fresh;
  }

  /// A single SSE event. Returns true iff it's a genuinely-new received order
  /// (and we've already seeded — events before the seed never alert).
  bool isNewFromEvent(DeliveryOrder order) {
    final isNew =
        order.status == DeliveryStatus.received && !_seen.contains(order.id);
    _seen.add(order.id);
    return isNew && _seeded;
  }

  void reset() {
    _seen.clear();
    _seeded = false;
  }
}
