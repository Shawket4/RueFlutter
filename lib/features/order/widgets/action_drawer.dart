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

/// Slide-up action drawer accessible from the order screen bottom bar.
///
/// [parentContext] is the order-screen context that survives after the drawer
/// is popped.  All navigation / sheet-showing uses it instead of the drawer's
/// own context (which becomes unmounted after `Navigator.pop`).
class ActionDrawer extends ConsumerWidget {
  final BuildContext parentContext;
  const ActionDrawer({super.key, required this.parentContext});

  static Future<void> show(BuildContext callerContext) =>
      showModalBottomSheet(
        context: callerContext,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (_) => ActionDrawer(parentContext: callerContext),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shift    = ref.watch(shiftProvider).shift;
    final user     = ref.watch(authProvider).user;
    final isOnline = ref.watch(isOnlineProvider);

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: AppShadows.md,
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        // ── Handle ────────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 6),
          child: Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),

        // ── Shift info header ────────────────────────────────────────────
        if (shift != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
            child: Row(children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shift.tellerName,
                      style: cairo(
                          fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Opened ${timeShort(shift.openedAt)} · Opening ${egp(shift.openingCash)}',
                      style: cairo(
                          fontSize: 11, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ]),
          ),

        const Divider(height: 20),

        // ── Action grid ──────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: [
            Row(children: [
              _ActionTile(
                icon: Icons.receipt_long_rounded,
                label: 'Past Orders',
                onTap: () => _popThen(() => parentContext.push('/order-history')),
              ),
              _ActionTile(
                icon: Icons.pending_actions_rounded,
                label: 'Pending',
                onTap: () => _popThen(() => parentContext.push('/pending-orders')),
              ),
              _ActionTile(
                icon: Icons.payments_outlined,
                label: 'Cash In/Out',
                onTap: () => _popThen(() {
                  if (shift != null) {
                    CashMovementSheet.show(parentContext, shiftId: shift.id);
                  }
                }),
              ),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              _ActionTile(
                icon: Icons.history_rounded,
                label: 'Shift History',
                onTap: () => _popThen(() => parentContext.push('/shift-history')),
              ),
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
            const SizedBox(height: 8),
            Row(children: [
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
              _ActionTile(
                icon: Icons.pending_actions_rounded,
                label: 'Pending Sync',
                onTap: () => _popThen(() => parentContext.push('/pending-orders')),
              ),
              // Spacer tile for symmetry.
              const Expanded(child: SizedBox()),
            ]),
          ]),
        ),

        const SizedBox(height: 8),
        const Divider(height: 1),

        // ── Sign out ─────────────────────────────────────────────────────
        AnimatedPressScale(
          onTap: () {
            Navigator.pop(context);
            _signOut(parentContext, ref);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(children: [
              const Icon(Icons.logout_rounded,
                  size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 10),
              Text('Sign Out',
                  style: cairo(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary)),
              const Spacer(),
              if (user != null)
                Text(user.name,
                    style:
                        cairo(fontSize: 12, color: AppColors.textMuted)),
            ]),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
      ]),
    );
  }

  /// Pop the drawer, then run [action] using the parent context.
  void _popThen(VoidCallback action) {
    // Use parentContext's navigator to pop the bottom sheet, then run action.
    Navigator.of(parentContext).pop();
    // Schedule the action after the pop completes.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (parentContext.mounted) action();
    });
  }

  Future<void> _printReport(
      BuildContext ctx, WidgetRef ref, String shiftId) async {
    // Show a loading indicator via snack while fetching.
    ScaffoldMessenger.of(ctx).showSnackBar(
      const SnackBar(
        content: Row(children: [
          SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: Colors.white)),
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
        title:
            Text('Close Shift?', style: cairo(fontWeight: FontWeight.w800)),
        content: Text(
            'You will count cash and inventory on the next screen.',
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
              'You have an open shift. You must close it before signing out.',
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

// ── Action Tile ──────────────────────────────────────────────────────────────

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool danger;
  final bool disabled;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.danger   = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final fg = disabled
        ? AppColors.textMuted
        : danger
            ? AppColors.danger
            : AppColors.textPrimary;
    final bg = disabled
        ? AppColors.borderLight
        : danger
            ? AppColors.danger.withOpacity(0.06)
            : AppColors.bg;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: AnimatedPressScale(
          onTap: disabled ? null : onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(icon, size: 20, color: fg),
              const SizedBox(height: 6),
              Text(label,
                  textAlign: TextAlign.center,
                  style: cairo(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: fg)),
            ]),
          ),
        ),
      ),
    );
  }
}
