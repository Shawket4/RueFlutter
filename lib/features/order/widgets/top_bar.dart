import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/providers/auth_notifier.dart';
import '../../../core/providers/cart_notifier.dart';
import '../../../core/providers/discount_notifier.dart';
import '../../../core/providers/menu_notifier.dart';
import '../../../core/providers/payment_method_notifier.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/sufrix_logo.dart';
import '../../../shared/widgets/status_chip.dart';
import 'action_drawer.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  TOP BAR — logo · refresh · current order · search ··· avatar
//  (shift stats + sync state live in the bottom action bar)
// ─────────────────────────────────────────────────────────────────────────────
class TopBar extends ConsumerWidget {
  final TextEditingController ctrl;
  final String query;
  final FocusNode? searchFocus;
  const TopBar(
      {super.key, required this.ctrl, required this.query, this.searchFocus});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    // Narrow watches — the bar only shows the order name, user name and
    // menu freshness stamp, so don't rebuild on unrelated state changes.
    final orderName = ref.watch(cartProvider.select((c) => c.displayName));
    final userName = ref.watch(authProvider.select((a) => a.user?.name));
    final cachedAt = ref.watch(menuProvider.select((m) => m.cachedAt));
    final lastSynced = cachedAt != null ? timeShort(cachedAt) : '—';
    final isPhone = context.isPhone;

    return Container(
      color: t.surface,
      padding: const EdgeInsetsDirectional.fromSTEB(14, 10, 14, 10),
      child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SufrixLogo(size: 30, isRounded: true),
                    const SizedBox(width: 10),

                    // Manual menu refresh + freshness stamp.
                    const SyncBtn(),
                    if (!isPhone) ...[
                      const SizedBox(width: 6),
                      Text(lastSynced,
                          style: ui(size: 11, color: t.textMuted)),
                    ],
                    const SizedBox(width: 10),

                    // Current order tab name.
                    StatusChip(
                      label: orderName ?? l10n(context).shellDefaultOrderName,
                      tone: ChipTone.info,
                      icon: Icons.shopping_bag_rounded,
                    ),
                    const SizedBox(width: AppSpace.md),

                    // Search.
                    SizedBox(
                      width: context.responsive(
                          phone: 180, tablet: 240, desktop: 280),
                      child: Container(
                        height: 38,
                        decoration: BoxDecoration(
                          color: t.surfaceAlt,
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                          border: Border.all(color: t.border),
                        ),
                        child: TextField(
                          controller: ctrl,
                          focusNode: searchFocus,
                          style: ui(size: 14, color: t.textPrimary),
                          decoration: InputDecoration(
                            hintText: l10n(context).shellSearchMenu,
                            hintStyle: ui(size: 14, color: t.textMuted),
                            prefixIcon: Icon(Icons.search_rounded,
                                size: 17, color: t.textMuted),
                            suffixIcon: query.isNotEmpty
                                ? GestureDetector(
                                    onTap: ctrl.clear,
                                    child: Icon(Icons.close_rounded,
                                        size: 16, color: t.textMuted))
                                : null,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                            isDense: true,
                            filled: false,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: AppSpace.md),

                    // Avatar → actions drawer.
                    Tooltip(
                      message: l10n(context).shellShiftActions,
                      child: AnimatedPressScale(
                        onTap: () => ActionDrawer.show(context),
                        child: _UserAvatar(name: userName ?? ''),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  USER AVATAR
// ─────────────────────────────────────────────────────────────────────────────
class _UserAvatar extends StatelessWidget {
  final String name;
  const _UserAvatar({required this.name});

  String get _initials {
    final parts = name.trim().split(' ');
    if (parts.isEmpty || parts[0].isEmpty) return '?';
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: t.navyBg,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: t.navy.withOpacity(0.3)),
      ),
      alignment: Alignment.center,
      child: Text(_initials,
          style: ui(size: 12, weight: FontWeight.w700, color: t.navy)),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SYNC BUTTON — manual menu/discount/payment refresh
// ─────────────────────────────────────────────────────────────────────────────

/// Whether a manual refresh is in flight. autoDispose: resets when the button
/// leaves the tree; the spin AnimationController stays in the State object.
final _menuSyncingProvider = StateProvider.autoDispose<bool>((_) => false);

class SyncBtn extends ConsumerStatefulWidget {
  const SyncBtn({super.key});

  @override
  ConsumerState<SyncBtn> createState() => _SyncBtnState();
}

class _SyncBtnState extends ConsumerState<SyncBtn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _spinCtrl;

  @override
  void initState() {
    super.initState();
    _spinCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
  }

  @override
  void dispose() {
    _spinCtrl.dispose();
    super.dispose();
  }

  Future<void> _sync() async {
    if (ref.read(_menuSyncingProvider)) return;
    ref.read(_menuSyncingProvider.notifier).state = true;
    _spinCtrl.repeat();
    try {
      final orgId = ref.read(authProvider).user?.orgId;
      if (orgId != null) {
        await Future.wait([
          ref.read(menuProvider.notifier).load(orgId, force: true),
          ref.read(discountProvider.notifier).load(orgId, force: true),
          ref.read(paymentMethodProvider.notifier).load(orgId, force: true),
        ]);
      }
    } finally {
      if (mounted) {
        _spinCtrl.stop();
        _spinCtrl.reset();
        ref.read(_menuSyncingProvider.notifier).state = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final syncing = ref.watch(_menuSyncingProvider);
    return Tooltip(
      message: l10n(context).shellRefreshMenu,
      child: GestureDetector(
        onTap: _sync,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
              color: t.surfaceAlt,
              borderRadius: BorderRadius.circular(AppRadius.xs),
              border: Border.all(color: t.border)),
          alignment: Alignment.center,
          child: RotationTransition(
            turns: _spinCtrl,
            child: Icon(Icons.sync_rounded,
                size: 18, color: syncing ? t.accent : t.textSecondary),
          ),
        ),
      ),
    );
  }
}
