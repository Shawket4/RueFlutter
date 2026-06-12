import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/login_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/order/order_history_screen.dart';
import '../../features/order/order_screen.dart';
import '../../features/order/pending_orders_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/setup/device_setup_screen.dart';
import '../../features/shift/close_shift_screen.dart';
import '../../features/shift/open_shift_screen.dart';
import '../../features/shift/shift_history_screen.dart';
import '../providers/auth_notifier.dart';
import '../storage/storage_service.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authListenable = _AuthListenable(ref);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: authListenable,
    redirect: (context, state) {
      final auth       = ref.read(authProvider);
      final authed     = auth.isAuthenticated;
      final loading    = auth.isLoading;
      final configured =
          ref.read(storageServiceProvider).isDeviceConfigured;
      final loc        = state.matchedLocation;

      // Never redirect while auth is in progress.
      if (loading) return null;

      if (!authed) {
        // Unconfigured device → one-time manager setup before any login.
        if (!configured) return loc == '/device-setup' ? null : '/device-setup';
        // Configured but signed out → teller PIN login (setup reachable for
        // the post-confirm hop).
        return (loc == '/login' || loc == '/device-setup') ? null : '/login';
      }

      // Authed: an existing session keeps working even if this device was
      // signed in before device-config existed — setup is enforced at the
      // NEXT sign-in. (Gating authed users here looped: /device-setup⇄/home.)
      if (loc == '/login') return '/home';
      if (loc == '/device-setup') return configured ? '/home' : null;

      return null;
    },
    routes: [
      // Classic flat stack — the order screen's bottom action bar is the
      // navigation hub; everything else is pushed on top of it.
      GoRoute(path: '/device-setup',   builder: (_, __) => const DeviceSetupScreen()),
      GoRoute(path: '/login',          builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/home',           builder: (_, __) => const HomeScreen()),
      GoRoute(path: '/open-shift',     builder: (_, __) => const OpenShiftScreen()),
      GoRoute(path: '/close-shift',    builder: (_, __) => const CloseShiftScreen()),
      GoRoute(path: '/order',          builder: (_, __) => const OrderScreen()),
      GoRoute(path: '/order-history',  builder: (_, __) => const OrderHistoryScreen()),
      GoRoute(path: '/pending-orders', builder: (_, __) => const PendingOrdersScreen()),
      GoRoute(path: '/shift-history',  builder: (_, __) => const ShiftHistoryScreen()),
      GoRoute(path: '/settings',       builder: (_, __) => const SettingsScreen()),
    ],
  );
});

class _AuthListenable extends ChangeNotifier {
  _AuthListenable(this._ref) {
    _ref.listen(authProvider, (prev, next) {
      final loadingChanged = prev?.isLoading != next.isLoading;
      final authChanged    = prev?.isAuthenticated != next.isAuthenticated;
      if (loadingChanged || authChanged) notifyListeners();
    });
  }
  final Ref _ref;
}
