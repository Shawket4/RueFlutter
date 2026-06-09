import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/auth_notifier.dart';
import '../../../core/providers/cart_notifier.dart';
import '../../../core/providers/menu_notifier.dart';
import '../../../core/providers/discount_notifier.dart';
import '../../../core/providers/payment_method_notifier.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/sufrix_logo.dart';
import '../../../shared/widgets/sync_status_chip.dart';
import 'action_drawer.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  TOP BAR
// ─────────────────────────────────────────────────────────────────────────────
class TopBar extends ConsumerWidget {
  final TextEditingController ctrl;
  final String query;
  const TopBar({super.key, required this.ctrl, required this.query});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final user = ref.watch(authProvider).user;
    final cachedAt = ref.watch(menuProvider).cachedAt;
    final lastSynced = cachedAt != null ? timeShort(cachedAt) : '—';

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
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
                    // Sufrix symbol
                    const SufrixLogo(size: 30, isRounded: true),
                    const SizedBox(width: 10),

                    // Sync button
                    const SyncBtn(),
                    const SizedBox(width: 6),
                    Text(lastSynced,
                        style: cairo(fontSize: 11, color: AppColors.textMuted)),
                    const SizedBox(width: 10),
                    const SyncStatusChip(),
                    const SizedBox(width: 10),

                    // Active order name pill
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(AppRadius.xs),
                        border: Border.all(color: AppColors.primary.withOpacity(0.25)),
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(Icons.shopping_bag_rounded,
                            size: 12, color: AppColors.primary),
                        const SizedBox(width: 5),
                        Text(
                          cart.displayName ?? 'Order 1',
                          style: cairo(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary),
                        ),
                      ]),
                    ),
                    const SizedBox(width: 12),

                    // Search bar
                    SizedBox(
                      width: context.isPhone ? 180 : 260,
                      child: Container(
                        height: 38,
                        decoration: BoxDecoration(
                          color: AppColors.bg,
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: TextField(
                          controller: ctrl,
                          style: cairo(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Search menu…',
                            hintStyle: cairo(fontSize: 14, color: AppColors.textMuted),
                            prefixIcon: const Icon(Icons.search_rounded,
                                size: 17, color: AppColors.textMuted),
                            suffixIcon: query.isNotEmpty
                                ? GestureDetector(
                                    onTap: ctrl.clear,
                                    child: const Icon(Icons.close_rounded,
                                        size: 16, color: AppColors.textMuted))
                                : null,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 10),
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
                    // Cart summary pill (tablet/desktop only).
                    if (context.isTablet || context.isDesktop) ...[
                      const SizedBox(width: 12),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        transitionBuilder: (child, anim) => ScaleTransition(
                            scale: anim,
                            child: FadeTransition(opacity: anim, child: child)),
                        child: cart.isEmpty
                            ? const SizedBox.shrink(key: ValueKey('empty'))
                            : Container(
                                key: const ValueKey('pill'),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 7),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: AppShadows.primaryGlow(),
                                ),
                                child: Row(children: [
                                  const Icon(Icons.shopping_bag_outlined,
                                      size: 14, color: Colors.white),
                                  const SizedBox(width: 6),
                                  Text('${cart.count} · ${egp(cart.total)}',
                                      style: cairo(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white)),
                                ]),
                              ),
                      ),
                    ],

                    // User avatar
                    const SizedBox(width: 10),
                    AnimatedPressScale(
                      onTap: () => ActionDrawer.show(context),
                      child: _UserAvatar(name: user?.name ?? ''),
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
  Widget build(BuildContext context) => Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0A2540), Color(0xFF1A3A5C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(9),
        ),
        alignment: Alignment.center,
        child: Text(_initials,
            style: cairo(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
//  SYNC BUTTON
// ─────────────────────────────────────────────────────────────────────────────
class SyncBtn extends ConsumerStatefulWidget {
  const SyncBtn({super.key});

  @override
  ConsumerState<SyncBtn> createState() => _SyncBtnState();
}

class _SyncBtnState extends ConsumerState<SyncBtn>
    with SingleTickerProviderStateMixin {
  bool _syncing = false;
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
    if (_syncing) return;
    setState(() => _syncing = true);
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
        setState(() => _syncing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: _sync,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
              color: AppColors.bg,
              borderRadius: BorderRadius.circular(AppRadius.xs),
              border: Border.all(color: AppColors.border)),
          alignment: Alignment.center,
          child: RotationTransition(
            turns: _spinCtrl,
            child: Icon(Icons.sync_rounded,
                size: 18,
                color: _syncing ? AppColors.primary : AppColors.textSecondary),
          ),
        ),
      );
}
