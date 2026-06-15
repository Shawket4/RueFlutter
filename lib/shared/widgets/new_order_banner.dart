import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/models/delivery_order.dart';
import '../../core/providers/delivery_orders_notifier.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatting.dart';

/// Holds the most recent brand-new delivery order to surface as an in-app
/// banner, or null when there's nothing to show. Driven by
/// [DeliveryRealtimeService] (the single new-order detection point). It is
/// cleared when the teller ACCEPTS the order (or explicitly dismisses it) —
/// never by merely opening/viewing the queue.
class NewOrderBannerNotifier extends Notifier<DeliveryOrder?> {
  @override
  DeliveryOrder? build() => null;

  void show(DeliveryOrder order) => state = order;
  void dismiss() => state = null;

  /// Clear the banner only if it is currently showing [orderId], so accepting
  /// one order doesn't hide an alert for a different, still-pending order.
  void dismissFor(String orderId) {
    if (state?.id == orderId) state = null;
  }
}

final newOrderBannerProvider =
    NotifierProvider<NewOrderBannerNotifier, DeliveryOrder?>(
        NewOrderBannerNotifier.new);

/// A prominent "new delivery order" banner. Renders nothing when there's no
/// pending order. Tapping it opens the delivery queue (without clearing — the
/// teller must ACCEPT the order to clear it); the ✕ explicitly dismisses. The
/// banner also auto-hides once the order leaves the `received` state (accepted
/// or resolved, including from another device). Mirrors [OfflineBanner]'s
/// placement in a column.
class NewOrderBanner extends ConsumerWidget {
  final EdgeInsetsGeometry margin;
  const NewOrderBanner(
      {super.key, this.margin = const EdgeInsets.only(bottom: 10)});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(newOrderBannerProvider);
    if (order == null) return const SizedBox.shrink();

    // Viewing must not clear the alert — only acceptance does. Auto-hide once
    // the live order has been acted on (status advanced past `received`).
    final accepted = ref.watch(deliveryOrdersProvider.select((d) => d.orders
        .any((o) => o.id == order.id && o.status != DeliveryStatus.received)));
    if (accepted) return const SizedBox.shrink();

    final t = context.tokens;
    final ref0 = order.deliveryRef ?? 'New delivery order';

    return Padding(
      padding: margin,
      child: AnimatedPressScale(
        onTap: () => context.push('/delivery-orders'),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsetsDirectional.fromSTEB(12, 10, 8, 10),
          decoration: BoxDecoration(
            color: t.accentBg,
            borderRadius: BorderRadius.circular(AppRadius.xs),
            border: Border.all(color: t.accent.withOpacity(0.35)),
          ),
          child: Row(children: [
            Icon(Icons.delivery_dining_rounded, size: 18, color: t.accent),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('New delivery order · $ref0',
                      style: ui(
                          size: 13,
                          weight: FontWeight.w800,
                          color: t.accent)),
                  const SizedBox(height: 1),
                  Text('${order.customerName} · ${egp(order.total)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: ui(size: 11, color: t.textSecondary)),
                ],
              ),
            ),
            const SizedBox(width: 6),
            Text('View',
                style:
                    ui(size: 12, weight: FontWeight.w700, color: t.accent)),
            IconButton(
              icon: Icon(Icons.close_rounded, size: 18, color: t.textMuted),
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              constraints:
                  const BoxConstraints(minWidth: 32, minHeight: 32),
              onPressed: () =>
                  ref.read(newOrderBannerProvider.notifier).dismiss(),
            ),
          ]),
        ),
      ),
    );
  }
}
