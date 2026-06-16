import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/auth_notifier.dart';
import '../../../core/providers/shift_notifier.dart';
import '../../../core/services/connectivity_service.dart';
import '../../../core/services/delivery_realtime_service.dart';

/// The connect gate for the delivery realtime service: online + authenticated +
/// a shift open + a known branch. A record so the derived provider only
/// notifies when one of these actually changes.
typedef _DeliveryGate = ({
  bool online,
  bool authed,
  bool shiftOpen,
  String? branchId,
});

final _deliveryGateProvider = Provider<_DeliveryGate>((ref) {
  final auth = ref.watch(authProvider);
  return (
    online: ref.watch(isOnlineProvider),
    authed: auth.user != null && !auth.isOfflineSession,
    shiftOpen: ref.watch(shiftProvider.select((s) => s.shift != null)),
    branchId: auth.user?.branchId ?? auth.branch?.id,
  );
});

/// Invisible coordinator that keeps [deliveryRealtimeProvider] in sync with the
/// connect gate. Mounted once on the order screen (the app's navigation hub) so
/// the realtime connection — and therefore new-order alerts — stays live across
/// navigation while a shift is worked.
class DeliveryRealtimeHost extends ConsumerStatefulWidget {
  const DeliveryRealtimeHost({super.key});

  @override
  ConsumerState<DeliveryRealtimeHost> createState() =>
      _DeliveryRealtimeHostState();
}

class _DeliveryRealtimeHostState extends ConsumerState<DeliveryRealtimeHost> {
  @override
  void initState() {
    super.initState();
    // Subscribe for subsequent gate changes. These notifications fire outside
    // the build phase, so applying them immediately is safe. The subscription
    // is auto-disposed with this State, so it survives navigation but not logout.
    ref.listenManual<_DeliveryGate>(
      _deliveryGateProvider,
      (_, g) => _apply(g),
    );
    // Seed the current gate after the first frame. We can't apply during
    // initState (or any lifecycle): apply() synchronously mutates
    // deliveryOrdersProvider via clear()/loadForBranch(), which Riverpod
    // forbids inside a widget life-cycle.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _apply(ref.read(_deliveryGateProvider));
    });
  }

  void _apply(_DeliveryGate g) =>
      ref.read(deliveryRealtimeProvider).apply(
            online: g.online,
            authed: g.authed,
            shiftOpen: g.shiftOpen,
            branchId: g.branchId,
          );

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
