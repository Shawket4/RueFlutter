import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/auth_notifier.dart';
import '../../../core/providers/shift_notifier.dart';
import '../../../core/repositories/shift_repository.dart';
import '../../../core/services/connectivity_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import '../../shift/cash_movement_sheet.dart';
import '../../shift/shift_report_preview_sheet.dart';
import '../../../core/models/shift.dart';
import '../../../core/services/offline_queue.dart';

class ActionDrawer extends ConsumerWidget {
  final BuildContext parentContext;
  const ActionDrawer({super.key, required this.parentContext});

  static Future<void> show(BuildContext callerContext) => showModalBottomSheet(
        context: callerContext,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (_) => ActionDrawer(parentContext: callerContext),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shiftState = ref.watch(shiftProvider);
    final shift = shiftState.shift;
    final systemCash = shiftState.systemCash;
    final user = ref.watch(authProvider).user;
    final isOnline = ref.watch(isOnlineProvider);
    final syncState = ref.watch(offlineQueueProvider);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Handle ──────────────────────────────────────────────────
            _Handle(),

            // ── Shift status card ────────────────────────────────────────
            if (shift != null) ...[
              _ShiftCard(
                  shift: shift, isOnline: isOnline, systemCash: systemCash),
              const SizedBox(height: 4),
            ],

            // ── Offline banner ───────────────────────────────────────────
            if (!isOnline) ...[
              _OfflineBanner(),
              const SizedBox(height: 2),
            ],

            // ── Section: Orders ──────────────────────────────────────────
            _SectionLabel('Orders'),
            _ActionGroup(children: [
              _ActionTile(
                icon: Icons.receipt_long_rounded,
                label: 'Past Orders',
                onTap: () =>
                    _popThen(() => parentContext.push('/order-history')),
              ),
              _ActionTile(
                icon: Icons.cloud_upload_outlined,
                label: 'Pending Sync',
                badge: syncState.orderCount > 0
                    ? _Badge(
                        label: '${syncState.orderCount} queued',
                        color: isOnline ? _BadgeColor.muted : _BadgeColor.warning,
                      )
                    : null,
                onTap: () =>
                    _popThen(() => parentContext.push('/pending-orders')),
              ),
            ]),

            // ── Section: Cash & Shift ────────────────────────────────────
            _SectionLabel('Cash & Shift'),
            _ActionGroup(children: [
              _ActionTile(
                icon: Icons.payments_outlined,
                label: 'Cash In / Out',
                onTap: () => _popThen(() {
                  if (shift != null) {
                    CashMovementSheet.show(parentContext, shiftId: shift.id);
                  }
                }),
              ),
              _ActionTile(
                icon: Icons.history_rounded,
                label: 'Past Shifts',
                onTap: () =>
                    _popThen(() => parentContext.push('/shift-history')),
              ),
              _ActionTile(
                icon: Icons.print_rounded,
                label: 'Print Report',
                disabled: !isOnline || shift == null,
                onTap: () {
                  Navigator.pop(context);
                  if (shift != null) {
                    _printReport(parentContext, ref, shift.id);
                  }
                },
              ),
            ]),

            // ── Section: System ──────────────────────────────────────────
            _SectionLabel('System'),
            _ActionGroup(children: [
              _ActionTile(
                icon: Icons.settings_outlined,
                label: 'Settings',
                onTap: () => _popThen(() => parentContext.push('/settings')),
              ),
              _ActionTile(
                icon: Icons.lock_outline_rounded,
                label: 'Close Shift',
                danger: true,
                disabled: !isOnline,
                onTap: () {
                  Navigator.pop(context);
                  _confirmClose(parentContext, isOnline);
                },
              ),
            ]),

            // ── Divider + Sign out ───────────────────────────────────────
            const SizedBox(height: 8),
            const Divider(height: 1, color: AppColors.borderLight),
            _SignOutRow(
              userName: user?.name,
              onTap: () {
                Navigator.pop(context);
                _signOut(parentContext, ref);
              },
            ),

            SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
          ],
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
      const SnackBar(
        content: Row(children: [
          SizedBox(
            width: 16,
            height: 16,
            child:
                CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
          ),
          SizedBox(width: 12),
          Text('Loading shift report…'),
        ]),
        duration: Duration(seconds: 15),
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
          content: Text('Failed to load report: $e'),
          backgroundColor: AppColors.danger,
        ));
      }
    }
  }

  void _confirmClose(BuildContext ctx, bool isOnline) {
    if (!isOnline) {
      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
        content: Text('Internet required to close shift'),
      ));
      return;
    }
    showDialog(
      context: ctx,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg)),
        title: Text('Close Shift?', style: cairo(fontWeight: FontWeight.w800)),
        content: Text('You will count cash and inventory on the next screen.',
            style: cairo(fontSize: 14, color: AppColors.textSecondary)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child:
                  Text('Cancel', style: cairo(color: AppColors.textSecondary))),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogCtx);
              ctx.go('/close-shift');
            },
            child: Text('Continue',
                style: cairo(
                    color: AppColors.danger, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut(BuildContext ctx, WidgetRef ref) async {
    final canLeave = await ref.read(authProvider.notifier).canLogout();
    if (!ctx.mounted) return;
    if (canLeave) {
      await ref.read(authProvider.notifier).logout();
    } else {
      showDialog(
        context: ctx,
        builder: (dialogCtx) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg)),
          title: Text('Close Shift First',
              style: cairo(fontWeight: FontWeight.w800)),
          content: Text(
              'You have an open shift. Please close it before signing out.',
              style: cairo(fontSize: 14, color: AppColors.textSecondary)),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(dialogCtx),
                child: Text('Cancel',
                    style: cairo(color: AppColors.textSecondary))),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogCtx);
                ctx.go('/close-shift');
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
}

// ── Handle ───────────────────────────────────────────────────────────────────

class _Handle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Center(
        child: Container(
          width: 36,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.border,
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isOnline ? AppColors.bg : AppColors.warning.withOpacity(0.07),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: isOnline
              ? AppColors.borderLight
              : AppColors.warning.withOpacity(0.25),
          width: 0.5,
        ),
      ),
      child: Row(children: [
        // Status dot
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: isOnline ? AppColors.success : AppColors.warning,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        // Name + meta
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                shift.tellerName,
                style: cairo(fontSize: 13, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 1),
              Text(
                isOnline
                    ? 'Opened ${timeShort(shift.openedAt)} · Opening ${egp(shift.openingCash)}'
                    : 'Opened ${timeShort(shift.openedAt)} · Offline mode',
                style: cairo(fontSize: 11, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // Running total
        Text(
          egp(systemCash),
          style: cairo(fontSize: 13, fontWeight: FontWeight.w700),
        ),
      ]),
    );
  }
}

// ── Offline banner ────────────────────────────────────────────────────────────

class _OfflineBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacity(0.10),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border:
            Border.all(color: AppColors.warning.withOpacity(0.3), width: 0.5),
      ),
      child: Row(children: [
        Icon(Icons.wifi_off_rounded, size: 15, color: AppColors.warning),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'You\'re offline — some actions are unavailable until connection is restored.',
            style: cairo(fontSize: 11, color: AppColors.warning),
          ),
        ),
      ]),
    );
  }
}

// ── Section label ─────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: Text(
        text.toUpperCase(),
        style: cairo(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: AppColors.textMuted,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

// ── Action group (rounded card wrapper) ──────────────────────────────────────

class _ActionGroup extends StatelessWidget {
  final List<Widget> children;
  const _ActionGroup({required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.borderLight, width: 0.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < children.length; i++) ...[
              children[i],
              if (i < children.length - 1)
                const Divider(
                  height: 1,
                  indent: 56,
                  color: AppColors.borderLight,
                ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Badge model ───────────────────────────────────────────────────────────────

enum _BadgeColor { warning, muted }

class _Badge {
  final String label;
  final _BadgeColor color;
  const _Badge({required this.label, required this.color});
}

// ── Action tile ───────────────────────────────────────────────────────────────

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool danger;
  final bool disabled;
  final _Badge? badge;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.danger = false,
    this.disabled = false,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final Color fg = disabled
        ? AppColors.textMuted
        : danger
            ? AppColors.danger
            : AppColors.textPrimary;

    final Color iconBg = disabled
        ? AppColors.borderLight
        : danger
            ? AppColors.danger.withOpacity(0.08)
            : AppColors.bg;

    return AnimatedPressScale(
      onTap: disabled ? null : onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        child: Row(children: [
          // Icon wrap
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, size: 17, color: fg),
          ),
          const SizedBox(width: 12),
          // Label
          Expanded(
            child: Text(
              label,
              style: cairo(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: fg,
              ),
            ),
          ),
          // Optional badge
          if (badge != null) ...[
            _BadgeWidget(badge: badge!),
            const SizedBox(width: 6),
          ],
          // Chevron
          if (!disabled)
            Icon(Icons.chevron_right_rounded,
                size: 17, color: AppColors.border),
        ]),
      ),
    );
  }
}

// ── Badge widget ──────────────────────────────────────────────────────────────

class _BadgeWidget extends StatelessWidget {
  final _Badge badge;
  const _BadgeWidget({required this.badge});

  @override
  Widget build(BuildContext context) {
    final Color bg;
    final Color fg;

    switch (badge.color) {
      case _BadgeColor.warning:
        bg = AppColors.warning.withOpacity(0.12);
        fg = AppColors.warning;
        break;
      case _BadgeColor.muted:
        bg = AppColors.borderLight;
        fg = AppColors.textSecondary;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        badge.label,
        style: cairo(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
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
    return AnimatedPressScale(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(children: [
          const Icon(Icons.logout_rounded,
              size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 10),
          Text(
            'Sign Out',
            style: cairo(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          if (userName != null)
            Text(
              userName!,
              style: cairo(fontSize: 12, color: AppColors.textMuted),
            ),
        ]),
      ),
    );
  }
}
