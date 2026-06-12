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
import 'core/services/offline_queue.dart';
import 'core/providers/locale_notifier.dart';
import 'core/providers/theme_mode_notifier.dart';
import 'core/storage/secure_token_store.dart';
import 'core/storage/storage_service.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/sufrix_logo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
  final outboxDao = OutboxDao(AppDatabase.instance);

  // JWT lives in the platform keychain; migrate any legacy plaintext token.
  final tokenStore = SecureTokenStore();
  await tokenStore.init(migrateFrom: kv);

  await ConnectivityService.instance.init();

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

class _AppState extends ConsumerState<_App> {
  @override
  void initState() {
    super.initState();
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

      queue.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth      = ref.watch(authProvider);
    final router    = ref.watch(routerProvider);
    final locale    = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);

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
    home: const Scaffold(
      backgroundColor: AppColors.bg,
      body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        SufrixLongLogo(height: 56),
        SizedBox(height: 32),
        SizedBox(width: 24, height: 24,
            child: CircularProgressIndicator(
                strokeWidth: 2.5, color: AppColors.primary)),
      ])),
    ),
  );
}
