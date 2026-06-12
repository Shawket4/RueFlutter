import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/l10n/l10n.dart';
import '../../core/providers/auth_notifier.dart';
import '../../core/providers/shift_notifier.dart';
import '../../core/services/connectivity_service.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatting.dart';
import '../../core/utils/responsive.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/confirm_sheet.dart';
import '../../shared/widgets/empty_state.dart';
import '../../shared/widgets/offline_banner.dart';
import '../../shared/widgets/status_chip.dart';
import '../../shared/widgets/surface_card.dart';

/// Shift-start dashboard — only visible when NO shift is open.
/// On load, if a shift IS open, auto-redirects to `/order`.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  StreamSubscription<bool>? _connectivitySub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
    _connectivitySub = ConnectivityService.instance.stream.listen((online) {
      if (online && mounted) _load();
    });
  }

  @override
  void dispose() {
    _connectivitySub?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    final branchId = ref.read(authProvider).user?.branchId;
    if (branchId == null) return;
    await ref.read(shiftProvider.notifier).load(branchId);

    // If shift is open, redirect to order screen.
    if (mounted && ref.read(shiftProvider).hasOpenShift) {
      context.go('/order');
    }
  }

  Future<void> _onSignOut() async {
    final canLeave = await ref.read(authProvider.notifier).canLogout();
    if (!mounted) return;
    if (canLeave) {
      await ref.read(authProvider.notifier).logout();
      return;
    }
    final s = l10n(context);
    final closeNow = await ConfirmSheet.show(
      context,
      title: s.shiftCloseFirstTitle,
      body: s.shiftCloseFirstBody,
      confirmLabel: s.shiftClose,
      destructive: true,
      icon: Icons.lock_clock_rounded,
    );
    if (closeNow && mounted) context.go('/close-shift');
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final user = ref.watch(authProvider.select((a) => a.user))!;
    final pad = context.responsive(phone: 20, tablet: 32);

    return Scaffold(
      backgroundColor: t.bg,
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Padding(
              padding: EdgeInsets.all(pad),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Greeting + quiet sign-out ──────────────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_greet(context, user.name.split(' ').first),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium),
                            const SizedBox(height: AppSpace.xs),
                            Text(
                              user.role.value.replaceAll('_', ' ').toUpperCase(),
                              style: ui(
                                  size: 11,
                                  weight: FontWeight.w600,
                                  color: t.textMuted,
                                  letterSpacing: 1),
                            ),
                          ],
                        ),
                      ),
                      // Settings must be reachable WITHOUT an open shift —
                      // device reconfiguration only works while no shift is
                      // open, and the order screen (the other Settings entry)
                      // requires one.
                      IconButton(
                        onPressed: () => context.push('/settings'),
                        tooltip: l10n(context).settings,
                        icon: Icon(Icons.settings_rounded,
                            size: 20, color: t.textSecondary),
                      ),
                      IconButton(
                        onPressed: _onSignOut,
                        tooltip: l10n(context).commonSignOut,
                        icon: Icon(Icons.logout_rounded,
                            size: 20, color: t.textSecondary),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: context.responsive(
                          phone: AppSpace.xl, tablet: AppSpace.xxl)),

                  const OfflineBanner(),

                  // ── Content ────────────────────────────────────────────
                  // Leaf consumer: the greeting/header above doesn't rebuild
                  // when shift state changes.
                  Expanded(child: _HomeBody(onRetry: _load)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _greet(BuildContext context, String first) {
    final s = l10n(context);
    final h = DateTime.now().hour;
    if (h < 12) return s.shellGreetingMorning(first);
    if (h < 17) return s.shellGreetingAfternoon(first);
    return s.shellGreetingEvening(first);
  }
}

// ── Body (leaf consumer — narrow rebuild scope) ──────────────────────────────

class _HomeBody extends ConsumerWidget {
  final VoidCallback onRetry;
  const _HomeBody({required this.onRetry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (isLoading, error, hasOpenShift, suggested) = ref.watch(
        shiftProvider.select((s) =>
            (s.isLoading, s.error, s.hasOpenShift, s.suggestedOpeningCash)));

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (error != null && !hasOpenShift) {
      return ErrorState(message: error, onRetry: onRetry);
    }
    return SingleChildScrollView(
      child: _ShiftStatusCard(suggested: suggested),
    );
  }
}

// ── Shift status card ────────────────────────────────────────────────────────

class _ShiftStatusCard extends StatelessWidget {
  final int suggested;
  const _ShiftStatusCard({required this.suggested});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = l10n(context);
    return SurfaceCard(
      padding: const EdgeInsets.all(AppSpace.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: t.navyBg,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(Icons.storefront_rounded, color: t.navy, size: 22),
              ),
              const SizedBox(width: AppSpace.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.shiftNoOpenShift,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(s.shiftOpenPrompt,
                        style: ui(size: 12, color: t.textSecondary)),
                  ],
                ),
              ),
              const SizedBox(width: AppSpace.sm),
              StatusChip(label: s.shiftStatusClosed),
            ],
          ),
          if (suggested > 0) ...[
            const SizedBox(height: AppSpace.lg),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpace.md),
              decoration: BoxDecoration(
                color: t.surfaceAlt,
                borderRadius: BorderRadius.circular(AppRadius.xs),
                border: Border.all(color: t.borderLight),
              ),
              child: Row(
                children: [
                  Icon(Icons.account_balance_wallet_outlined,
                      size: 18, color: t.textSecondary),
                  const SizedBox(width: AppSpace.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.shiftSuggestedOpeningCash,
                            style: ui(
                                size: 12,
                                weight: FontWeight.w600,
                                color: t.textPrimary)),
                        Text(s.shiftCarriedOver,
                            style: ui(size: 11, color: t.textMuted)),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpace.sm),
                  Text(egp(suggested),
                      style: money(size: 15, color: t.textPrimary)),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppSpace.lg),
          AppButton(
            label: s.shiftOpen,
            width: double.infinity,
            icon: Icons.play_arrow_rounded,
            onTap: () => context.go('/open-shift'),
          ),
        ],
      ),
    );
  }
}
