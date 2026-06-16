import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/db/app_database.dart';
import 'core/db/kv_store.dart';
import 'core/l10n/app_localizations.dart';
import 'core/db/outbox_dao.dart';
import 'core/providers/auth_notifier.dart';
import 'core/providers/order_history_notifier.dart';
import 'core/providers/shift_notifier.dart';
import 'core/router/router.dart';
import 'core/services/connectivity_service.dart';
import 'core/services/delivery_realtime_service.dart';
import 'core/services/notification_service.dart';
import 'core/services/offline_queue.dart';
import 'core/providers/locale_notifier.dart';
import 'core/providers/theme_mode_notifier.dart';
import 'core/storage/secure_token_store.dart';
import 'core/storage/storage_service.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_tz.dart';
import 'core/utils/time_utils.dart';
import 'core/widgets/sufrix_logo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load the IANA timezone DB so all display/business-day logic can render in
  // the branch's configured zone (set from authProvider.branch.timezone below),
  // never the device's local zone.
  AppTz.init();

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint('Flutter error: ${details.exceptionAsString()}');
  };

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
  ]);

  // ── Database bootstrap (replaces SharedPreferences) ──────────────────────
  await AppDatabase.instance.init();
  final kv = KvStore(AppDatabase.instance);
  await kv.init(); // hydrate in-memory cache from kv table
  TimeUtils.init(kv); // restore the persisted server-clock offset
  final outboxDao = OutboxDao(AppDatabase.instance);

  // JWT lives in the platform keychain; migrate any legacy plaintext token.
  final tokenStore = SecureTokenStore();
  await tokenStore.init(migrateFrom: kv);

  await ConnectivityService.instance.init();
  await NotificationService.instance.init();

  runApp(ProviderScope(
    overrides: [
      storageServiceProvider.overrideWithValue(StorageService(kv, tokenStore)),
      outboxDaoProvider.overrideWithValue(outboxDao),
    ],
    child: const _App(),
  ));
}

class _App extends ConsumerStatefulWidget {
  const _App();
  @override
  ConsumerState<_App> createState() => _AppState();
}

class _AppState extends ConsumerState<_App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final queue      = ref.read(offlineQueueProvider.notifier);
      final history    = ref.read(orderHistoryProvider.notifier);
      final shiftNotif = ref.read(shiftProvider.notifier);

      // Wire up optimistic replacement callbacks.
      queue.onOrderSynced = (order, localId) {
        history.replaceOrder(localId, order);
        // The synced order is leaving the outbox and now counts toward the
        // server's expected-cash figure — refresh so systemCash doesn't keep
        // a stale queued-cash adjustment (loadSystemCash re-adds whatever is
        // still queued via _queuedCashForShift).
        final current = ref.read(shiftProvider).shift;
        if (current != null && current.id == order.shiftId) {
          shiftNotif.loadSystemCash();
        }
      };
      queue.onVoidSynced      = history.updateOrder;
      queue.onShiftOpenSynced = (shift) {
        final current = ref.read(shiftProvider).shift;
        if (current != null && current.id == shift.id) {
          shiftNotif.updateShiftSynced(shift);
        }
      };
      queue.onShiftCloseSynced = (_) {};
      // A queued offline shift-open was permanently rejected (another shift
      // already holds this branch/teller open) — clear the phantom local shift
      // so the teller stops selling against a shift the server will never accept.
      queue.onShiftOpenRejected = (shiftId, branchId) {
        final current = ref.read(shiftProvider).shift;
        if (current != null && current.id == shiftId) {
          shiftNotif.handleOpenRejected(branchId);
        }
      };

      queue.init();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Coming back to the foreground is when a long-backgrounded JWT is most
    // likely to have expired. Re-validate the session proactively so an expired
    // token routes to /login instead of stranding the teller mid-app.
    if (state == AppLifecycleState.resumed) {
      ref.read(authProvider.notifier).revalidateSession();
      // Re-open the delivery stream (it was dropped on pause) + re-GET to catch
      // anything that arrived while backgrounded.
      ref.read(deliveryRealtimeProvider).reevaluate();
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      // Don't hold a dead socket while backgrounded.
      ref.read(deliveryRealtimeProvider).pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth      = ref.watch(authProvider);
    final router    = ref.watch(routerProvider);
    final locale    = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);

    // Keep the display/business-day clock pointed at the active branch's zone.
    AppTz.setBranchTimezone(auth.branch?.timezone);

    if (auth.isLoading) return const _SplashScreen();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Sufrix POS',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      locale: locale,
      routerConfig: router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      builder: (context, child) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          behavior: HitTestBehavior.translucent,
          child: child,
        );
      },
    );
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light,
    home: Scaffold(
      backgroundColor: AppTokens.light.bg,
      body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        const SufrixLongLogo(height: 56),
        const SizedBox(height: 32),
        SizedBox(width: 24, height: 24,
            child: CircularProgressIndicator(
                strokeWidth: 2.5, color: AppTokens.light.accent)),
      ])),
    ),
  );
}
