import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers/auth_notifier.dart';
import '../../core/providers/shift_notifier.dart';
import '../../core/services/connectivity_service.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatting.dart';
import '../../core/utils/responsive.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/card_container.dart';
import '../../core/widgets/sufrix_logo.dart';

/// Home screen — only visible when NO shift is open.
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
    } else {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg)),
          title: Text('Close Shift First',
              style: cairo(fontWeight: FontWeight.w800)),
          content: Text(
            'You have an open shift. You must close it before signing out.',
            style: cairo(fontSize: 14, color: AppColors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child:
                  Text('Cancel', style: cairo(color: AppColors.textSecondary)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                context.go('/close-shift');
              },
              child: Text('Close Shift',
                  style: cairo(
                      color: AppColors.danger, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user    = ref.watch(authProvider).user!;
    final shiftSt = ref.watch(shiftProvider);
    final isTablet = context.isTablet || context.isDesktop;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(isTablet ? 36 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ─────────────────────────────────────────────
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                SufrixLongLogo(height: isTablet ? 40 : 34),
                const Spacer(),
                Text(user.name,
                    style: cairo(
                        fontSize: isTablet ? 14 : 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary)),
                const SizedBox(width: 12),
                _SignOutBtn(onTap: _onSignOut),
              ]),
              SizedBox(height: isTablet ? 36 : 28),

              // ── Greeting ───────────────────────────────────────────
              Text(_greet(user.name.split(' ').first),
                  style: cairo(
                      fontSize: isTablet ? 28 : 22,
                      fontWeight: FontWeight.w800)),
              const SizedBox(height: 2),
              Text(user.role.replaceAll('_', ' ').toUpperCase(),
                  style: cairo(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMuted,
                      letterSpacing: 1)),
              SizedBox(height: isTablet ? 32 : 24),

              // ── Content ────────────────────────────────────────────
              if (shiftSt.isLoading)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.primary)),
                )
              else if (shiftSt.error != null && !shiftSt.hasOpenShift)
                _ErrorBanner(message: shiftSt.error!, onRetry: _load)
              else ...[
                _NoShiftCard(
                  suggested: shiftSt.suggestedOpeningCash,
                  isTablet: isTablet,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: isTablet ? 480 : double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => context.push('/shift-history'),
                    icon: const Icon(Icons.history_rounded, size: 16),
                    label: Text('View Past Shifts',
                        style: cairo(fontSize: 13, fontWeight: FontWeight.w600)),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppRadius.sm)),
                      side: const BorderSide(color: AppColors.border),
                      foregroundColor: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _greet(String first) {
    final h = DateTime.now().hour;
    final w = h < 12
        ? 'Morning'
        : h < 17
            ? 'Afternoon'
            : 'Evening';
    return 'Good $w, $first';
  }
}

// ── No Shift Card ───────────────────────────────────────────────────────────

class _NoShiftCard extends StatelessWidget {
  final int suggested;
  final bool isTablet;
  const _NoShiftCard({required this.suggested, required this.isTablet});

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: isTablet ? 480 : double.infinity),
        child: CardContainer(
          padding: EdgeInsets.all(isTablet ? 28 : 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.wb_sunny_outlined,
                      color: AppColors.primary, size: 22),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('No Open Shift',
                        style: cairo(
                            fontSize: isTablet ? 18 : 16,
                            fontWeight: FontWeight.w700)),
                    if (suggested > 0)
                      Text('Last closing: ${egp(suggested)}',
                          style: cairo(
                              fontSize: 12,
                              color: AppColors.textSecondary)),
                  ],
                ),
              ]),
              const SizedBox(height: 22),
              AppButton(
                label: 'Open Shift',
                width: double.infinity,
                icon: Icons.play_arrow_rounded,
                onTap: () => context.go('/open-shift'),
              ),
            ],
          ),
        ),
      );
}

// ── Sign Out Button ─────────────────────────────────────────────────────────

class _SignOutBtn extends StatelessWidget {
  final VoidCallback onTap;
  const _SignOutBtn({required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11),
              border: Border.all(color: AppColors.border)),
          alignment: Alignment.center,
          child: const Icon(Icons.logout_rounded,
              size: 15, color: AppColors.textSecondary),
        ),
      );
}

// ── Error Banner ────────────────────────────────────────────────────────────

class _ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorBanner({required this.message, required this.onRetry});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
            color: AppColors.danger.withOpacity(0.06),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.danger.withOpacity(0.2))),
        child: Row(children: [
          const Icon(Icons.error_outline_rounded,
              color: AppColors.danger, size: 18),
          const SizedBox(width: 10),
          Expanded(
              child: Text(message,
                  style: cairo(fontSize: 13, color: AppColors.danger))),
          TextButton(
              onPressed: onRetry,
              child: Text('Retry',
                  style: cairo(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary))),
        ]),
      );
}
