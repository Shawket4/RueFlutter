import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/models/shift.dart';
import '../../../core/providers/auth_notifier.dart';
import '../../../core/providers/delivery_orders_notifier.dart';
import '../../../core/providers/shift_notifier.dart';
import '../../../core/repositories/shift_repository.dart';
import '../../../core/services/connectivity_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import '../../../shared/widgets/confirm_sheet.dart';
import '../../../shared/widgets/offline_banner.dart';
import '../../../shared/widgets/responsive_sheet.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/surface_card.dart';
import '../../shift/shift_report_preview_sheet.dart';

/// Bottom drawer with shift-level actions: navigation that doesn't fit the
/// order screen's bottom action bar on small screens (Past Shifts / Settings),
/// plus cash, reports, closing and signing out.
class ActionDrawer extends ConsumerWidget {
  final BuildContext parentContext;
  const ActionDrawer({super.key, required this.parentContext});

  static Future<void> show(BuildContext callerContext) =>
      ResponsiveSheet.show(
        context: callerContext,
        builder: (_) => ActionDrawer(parentContext: callerContext),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final s = l10n(context);
    // Narrow watches — the drawer shows shift, system cash and user name.
    final shift = ref.watch(shiftProvider.select((st) => st.shift));
    final systemCash = ref.watch(shiftProvider.select((st) => st.systemCash));
    final userName = ref.watch(authProvider.select((a) => a.user?.name));
    final isOnline = ref.watch(isOnlineProvider);

    return Container(
      decoration: BoxDecoration(
        color: t.surfaceRaised,
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpace.lg, 0, AppSpace.lg, AppSpace.sm),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _Handle(),

                // ── Shift status card ────────────────────────────────────
                if (shift != null)
                  _ShiftCard(
                      shift: shift,
                      isOnline: isOnline,
                      systemCash: systemCash),

                // ── Degraded-state banner (hides itself when fine) ───────
                const Padding(
                  padding: EdgeInsets.only(top: AppSpace.sm),
                  child: OfflineBanner(margin: EdgeInsets.zero),
                ),

                // ── Browse ───────────────────────────────────────────────
                SectionHeader(title: s.shellBrowse),
                SurfaceCard(
                  padding: EdgeInsets.zero,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    _ActionTile(
                      icon: Icons.delivery_dining_rounded,
                      label: 'Delivery Orders',
                      disabled: shift == null,
                      badge:
                          ref.watch(deliveryOrdersProvider.select((d) => d.activeCount)),
                      onTap: () =>
                          _popThen(() => parentContext.push('/delivery-orders')),
                    ),
                    Divider(height: 1, color: t.borderLight),
                    _ActionTile(
                      icon: Icons.schedule_rounded,
                      label: s.shellPastShifts,
                      onTap: () =>
                          _popThen(() => parentContext.push('/shift-history')),
                    ),
                    Divider(height: 1, color: t.borderLight),
                    _ActionTile(
                      icon: Icons.settings_rounded,
                      label: s.settings,
                      onTap: () =>
                          _popThen(() => parentContext.push('/settings')),
                    ),
                  ]),
                ),

                // ── Cash & shift ─────────────────────────────────────────
                SectionHeader(title: s.shellCashAndShift),
                SurfaceCard(
                  padding: EdgeInsets.zero,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    _ActionTile(
                      icon: Icons.payments_outlined,
                      label: s.shellCashInOut,
                      disabled: !isOnline || shift == null,
                      subtitle: !isOnline ? s.commonCashOfflineHint : null,
                      onTap: () =>
                          _popThen(() => parentContext.push('/cash-movements')),
                    ),
                    Divider(height: 1, color: t.borderLight),
                    _ActionTile(
                      icon: Icons.print_rounded,
                      label: s.commonPrintReport,
                      disabled: !isOnline || shift == null,
                      subtitle: !isOnline ? s.commonRequiresConnection : null,
                      onTap: () {
                        Navigator.pop(context);
                        if (shift != null) {
                          _printReport(parentContext, ref, shift.id);
                        }
                      },
                    ),
                    Divider(height: 1, color: t.borderLight),
                    _ActionTile(
                      icon: Icons.lock_outline_rounded,
                      label: isOnline ? s.shiftClose : s.shiftCloseWillSync,
                      danger: true,
                      onTap: () {
                        Navigator.pop(context);
                        _confirmClose(parentContext, isOnline);
                      },
                    ),
                  ]),
                ),

                // ── Sign out ─────────────────────────────────────────────
                const SizedBox(height: AppSpace.lg),
                Divider(height: 1, color: t.borderLight),
                _SignOutRow(
                  userName: userName,
                  onTap: () {
                    Navigator.pop(context);
                    _signOut(parentContext, ref);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _popThen(VoidCallback action) {
    Navigator.of(parentContext).pop();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (parentContext.mounted) action();
    });
  }

  Future<void> _printReport(
      BuildContext ctx, WidgetRef ref, String shiftId) async {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Row(children: [
          const SizedBox(
            width: 16,
            height: 16,
            child:
                CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Text(l10n(ctx).commonLoading),
        ]),
        duration: const Duration(seconds: 15),
      ),
    );

    try {
      final report = await ref.read(shiftRepositoryProvider).getReport(shiftId);
      if (ctx.mounted) {
        ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
        await ShiftReportPreviewSheet.show(ctx, report);
      }
    } catch (e) {
      if (ctx.mounted) {
        ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text(l10n(ctx).commonFailedLoadReport('$e')),
          backgroundColor: ctx.tokens.danger,
        ));
      }
    }
  }

  /// Closing is always allowed — an offline close is queued on-device and
  /// synced once connection returns.
  Future<void> _confirmClose(BuildContext ctx, bool isOnline) async {
    final s = l10n(ctx);
    final ok = await ConfirmSheet.show(
      ctx,
      title: s.shiftCloseConfirmTitle,
      body: isOnline
          ? s.shiftCloseConfirmBodyOnline
          : s.shiftCloseConfirmBodyOffline,
      confirmLabel: isOnline ? s.commonContinue : s.shiftCloseQueueConfirm,
      destructive: true,
      icon: Icons.lock_outline_rounded,
    );
    if (ok && ctx.mounted) ctx.go('/close-shift');
  }

  Future<void> _signOut(BuildContext ctx, WidgetRef ref) async {
    final canLeave = await ref.read(authProvider.notifier).canLogout();
    if (!ctx.mounted) return;
    if (canLeave) {
      await ref.read(authProvider.notifier).logout();
      return;
    }
    final s = l10n(ctx);
    final goClose = await ConfirmSheet.show(
      ctx,
      title: s.shiftCloseFirstTitle,
      body: s.shiftCloseFirstBody,
      confirmLabel: s.shiftClose,
      destructive: true,
      icon: Icons.lock_outline_rounded,
    );
    if (goClose && ctx.mounted) ctx.go('/close-shift');
  }
}

// ── Handle ───────────────────────────────────────────────────────────────────

class _Handle extends StatelessWidget {
  const _Handle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpace.md, bottom: AppSpace.sm),
      child: Center(
        child: Container(
          width: 36,
          height: 4,
          decoration: BoxDecoration(
            color: context.tokens.border,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}

// ── Shift status card ─────────────────────────────────────────────────────────

class _ShiftCard extends StatelessWidget {
  final Shift shift;
  final bool isOnline;
  final int systemCash;
  const _ShiftCard(
      {required this.shift, required this.isOnline, required this.systemCash});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = l10n(context);
    return SurfaceCard(
      color: isOnline ? t.surfaceAlt : t.warningBg,
      padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpace.lg, vertical: AppSpace.md),
      child: Row(children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: isOnline ? t.success : t.warning,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(shift.tellerName,
                  style: ui(
                      size: 13,
                      weight: FontWeight.w700,
                      color: t.textPrimary)),
              const SizedBox(height: 1),
              Text(
                isOnline
                    ? s.shellShiftOpenedAt(
                        timeShort(shift.openedAt), egp(shift.openingCash))
                    : s.shellShiftOpenedOffline(timeShort(shift.openedAt)),
                style: ui(size: 11, color: t.textSecondary),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpace.sm),
        Text(egp(systemCash),
            style:
                money(size: 13, weight: FontWeight.w700, color: t.textPrimary)),
      ]),
    );
  }
}

// ── Action tile ───────────────────────────────────────────────────────────────

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool danger;
  final bool disabled;
  final String? subtitle;

  /// Optional trailing count badge (e.g. active delivery orders). 0 hides it.
  final int badge;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.danger = false,
    this.disabled = false,
    this.subtitle,
    this.badge = 0,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final Color fg = disabled
        ? t.textMuted
        : danger
            ? t.danger
            : t.textPrimary;

    final Color iconBg = disabled
        ? t.borderLight
        : danger
            ? t.dangerBg
            : t.surfaceAlt;

    return AnimatedPressScale(
      onTap: disabled ? null : onTap,
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 14, vertical: 11),
        child: Row(children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, size: 17, color: fg),
          ),
          const SizedBox(width: AppSpace.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: ui(size: 14, weight: FontWeight.w600, color: fg)),
                if (subtitle != null)
                  Text(subtitle!,
                      style: ui(size: 11, color: t.textMuted, height: 1.3)),
              ],
            ),
          ),
          if (badge > 0 && !disabled)
            Container(
              margin: const EdgeInsetsDirectional.only(start: AppSpace.sm),
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: t.accent,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text('$badge',
                  style: ui(
                      size: 12, weight: FontWeight.w800, color: Colors.white)),
            ),
        ]),
      ),
    );
  }
}

// ── Sign-out row ──────────────────────────────────────────────────────────────

class _SignOutRow extends StatelessWidget {
  final String? userName;
  final VoidCallback onTap;
  const _SignOutRow({required this.userName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return AnimatedPressScale(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpace.xs, vertical: 14),
        child: Row(children: [
          Icon(Icons.logout_rounded, size: 16, color: t.textSecondary),
          const SizedBox(width: 10),
          Text(l10n(context).commonSignOut,
              style: ui(
                  size: 14, weight: FontWeight.w500, color: t.textSecondary)),
          const Spacer(),
          if (userName != null)
            Text(userName!, style: ui(size: 12, color: t.textMuted)),
        ]),
      ),
    );
  }
}
