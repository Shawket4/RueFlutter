import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/l10n/l10n.dart';
import '../../core/models/shift.dart';
import '../../core/providers/auth_notifier.dart';
import '../../core/providers/cart_notifier.dart';
import '../../core/providers/discount_notifier.dart';
import '../../core/providers/menu_notifier.dart';
import '../../core/providers/order_history_notifier.dart';
import '../../core/providers/payment_method_notifier.dart';
import '../../core/providers/shift_notifier.dart';
import '../../core/repositories/shift_repository.dart';
import '../../core/services/connectivity_service.dart';
import '../../core/services/offline_queue.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatting.dart';
import '../../core/utils/responsive.dart';
import '../../shared/widgets/offline_banner.dart';
import '../../shared/widgets/sync_status_chip.dart';
import '../shift/cash_movement_sheet.dart';
import 'checkout/checkout_sheet.dart';
import 'widgets/action_drawer.dart';
import 'widgets/cart_panel.dart';
import 'widgets/category_rail.dart';
import 'widgets/menu_grid.dart';
import 'widgets/top_bar.dart';

/// Debounced search query the grid filters on. The raw text lives in the
/// screen's TextEditingController; this holds the trimmed, lowercased value.
/// autoDispose: clears when the order screen leaves the tree.
final _searchQueryProvider = StateProvider.autoDispose<String>((_) => '');

/// The selling screen — the navigation hub of the app. The bottom action bar
/// carries shift stats, sync state and every shift-level destination; other
/// screens are pushed on top of this one.
///
/// Layout:
///   desktop & tablet-landscape → category rail · grid · cart panel
///   tablet-portrait            → category rail · grid · cart FAB/sheet
///   phone                      → category strip · grid · cart FAB/sheet
class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});
  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  final _searchCtrl = TextEditingController();
  final _searchFocus = FocusNode();
  Timer? _debounce;
  StreamSubscription<bool>? _connectivitySub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _prefetch();
    });

    // Search debounce (180 ms) — the Timer stays here; the query lives in
    // [_searchQueryProvider].
    _searchCtrl.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 180), () {
        if (mounted) {
          ref.read(_searchQueryProvider.notifier).state =
              _searchCtrl.text.trim().toLowerCase();
        }
      });
    });

    // Re-fetch on reconnect.
    _connectivitySub = ConnectivityService.instance.stream.listen((online) {
      if (online && mounted) _prefetch();
    });

    // Desktop keyboard shortcuts.
    HardwareKeyboard.instance.addHandler(_handleKey);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleKey);
    _searchCtrl.dispose();
    _searchFocus.dispose();
    _debounce?.cancel();
    _connectivitySub?.cancel();
    super.dispose();
  }

  /// Desktop shortcuts: '/' or Ctrl+F focuses search; Enter opens checkout
  /// when the cart has items. Inactive while a sheet/dialog is on top.
  bool _handleKey(KeyEvent event) {
    if (event is! KeyDownEvent) return false;
    if (!mounted || !context.isDesktop) return false;
    final route = ModalRoute.of(context);
    if (route != null && !route.isCurrent) return false;

    final key = event.logicalKey;
    final hw = HardwareKeyboard.instance;
    final ctrlF = key == LogicalKeyboardKey.keyF &&
        (hw.isControlPressed || hw.isMetaPressed);
    if (ctrlF || (key == LogicalKeyboardKey.slash && !_searchFocus.hasFocus)) {
      _searchFocus.requestFocus();
      return true;
    }

    if (key == LogicalKeyboardKey.enter ||
        key == LogicalKeyboardKey.numpadEnter) {
      final cart = ref.read(cartProvider);
      if (!cart.isEmpty) {
        CheckoutSheet.show(context);
        return true;
      }
    }
    return false;
  }

  /// Bounded concurrent prefetch — same logic that was in HomeScreen._load().
  Future<void> _prefetch() async {
    final auth = ref.read(authProvider);
    final branchId = auth.user?.branchId;
    final orgId = auth.user?.orgId;
    if (branchId == null) return;

    // Phase 1: shift notifier serves local cache instantly.
    await ref.read(shiftProvider.notifier).load(branchId);

    final shift = ref.read(shiftProvider).shift;
    if (orgId != null) {
      unawaited(Future.wait([
        ref
            .read(shiftRepositoryProvider)
            .fetchShiftsFresh(branchId)
            .catchError((_) => <Shift>[]),
        if (shift != null)
          ref
              .read(orderHistoryProvider.notifier)
              .loadForShift(shift.id) // This serves local cache first
              .catchError((_) {}),
        ref
            .read(shiftProvider.notifier)
            .loadInventory(branchId)
            .catchError((_) {}),
        ref.read(menuProvider.notifier).load(orgId).catchError((_) {}),
        ref.read(discountProvider.notifier).load(orgId).catchError((_) {}),
        ref.read(paymentMethodProvider.notifier).load(orgId).catchError((_) {}),
      ]));
    }

    if (shift != null) {
      unawaited(
        ref.read(shiftProvider.notifier).loadSystemCash().catchError((_) {}),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final query = ref.watch(_searchQueryProvider);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final showCartPanel =
        context.isDesktop || (context.isTablet && isLandscape);
    final showRail = !context.isPhone;

    return Scaffold(
      backgroundColor: t.bg,
      floatingActionButton: showCartPanel ? null : const MobileCartFab(),
      body: SafeArea(
        child: Column(children: [
          TopBar(ctrl: _searchCtrl, query: query, searchFocus: _searchFocus),
          const OfflineBanner(
              margin: EdgeInsetsDirectional.fromSTEB(10, 6, 10, 0)),
          Expanded(
            child: Row(children: [
              if (showRail && query.isEmpty) const CategoryRail(),
              Expanded(
                child: Column(children: [
                  if (!showRail && query.isEmpty) const CategoryStrip(),
                  Expanded(child: _contentArea(query)),
                ]),
              ),
              if (showCartPanel) const CartPanel(),
            ]),
          ),
          const _BottomActionBar(),
        ]),
      ),
    );
  }

  Widget _contentArea(String query) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, anim) => FadeTransition(
          opacity: anim,
          child: SlideTransition(
            position:
                Tween<Offset>(begin: const Offset(0, 0.03), end: Offset.zero)
                    .animate(anim),
            child: child,
          ),
        ),
        child: query.isNotEmpty
            ? SearchResults(key: ValueKey(query), query: query)
            : const MenuGrid(key: ValueKey('grid')),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
//  BOTTOM ACTION BAR — sync state · shift stats ··· all shift destinations
//
//  tablet/desktop → icon+label buttons for every action
//  phone          → stats + Sync + Past Orders + More (rest in ActionDrawer)
// ─────────────────────────────────────────────────────────────────────────────

class _BottomActionBar extends ConsumerWidget {
  const _BottomActionBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final s = l10n(context);
    final compact = context.isPhone;
    // Narrow watches — only the fields this bar renders.
    final badgeCount = ref.watch(
        offlineQueueProvider.select((q) => q.totalCount + q.stuckCount));
    final badgeDanger =
        ref.watch(offlineQueueProvider.select((q) => q.hasStuck));
    final isOnline = ref.watch(isOnlineProvider);
    final shift = ref.watch(shiftProvider.select((s) => s.shift));

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: t.surface,
        border: Border(top: BorderSide(color: t.border)),
        boxShadow: [
          BoxShadow(
              color: t.shadow, blurRadius: 12, offset: const Offset(0, -2)),
        ],
      ),
      padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpace.md, AppSpace.sm - 2, AppSpace.md, AppSpace.sm - 2),
      child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Queue / connectivity state (hides itself when idle).
                    SyncStatusChip(),
                    SizedBox(width: AppSpace.sm),
                    // At-a-glance shift stats.
                    _ShiftStatsPill(),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _BarAction(
                      icon: Icons.receipt_long_rounded,
                      label: s.shellPastOrders,
                      compact: compact,
                      onTap: () => context.push('/order-history'),
                    ),
                    _BarAction(
                      icon: Icons.sync_rounded,
                      label: s.shellSync,
                      compact: compact,
                      badgeCount: badgeCount,
                      badgeDanger: badgeDanger,
                      onTap: () => context.push('/pending-orders'),
                    ),
                    if (!compact) ...[
                      _BarAction(
                        icon: Icons.payments_outlined,
                        label: s.shellCashInOut,
                        compact: compact,
                        disabled: !isOnline || shift == null,
                        tooltip: !isOnline ? s.commonCashOfflineHint : null,
                        onTap: () {
                          if (shift != null) {
                            CashMovementSheet.show(context, shiftId: shift.id);
                          }
                        },
                      ),
                      _BarAction(
                        icon: Icons.schedule_rounded,
                        label: s.shellPastShifts,
                        compact: compact,
                        onTap: () => context.push('/shift-history'),
                      ),
                      _BarAction(
                        icon: Icons.settings_rounded,
                        label: s.settings,
                        compact: compact,
                        onTap: () => context.push('/settings'),
                      ),
                    ],
                    _BarAction(
                      icon: Icons.more_horiz_rounded,
                      label: s.shellMore,
                      compact: compact,
                      onTap: () => ActionDrawer.show(context),
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

// ── Shift stats — sales total · order count for the open shift ───────────────

class _ShiftStatsPill extends ConsumerWidget {
  const _ShiftStatsPill();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final hasOpenShift =
        ref.watch(shiftProvider.select((s) => s.hasOpenShift));
    if (!hasOpenShift) return const SizedBox.shrink();

    // Derive both stats inside the selector so the pill only rebuilds when
    // the count/total pair actually changes.
    final (orderCount, salesTotal) =
        ref.watch(orderHistoryProvider.select((h) {
      var count = 0, total = 0;
      for (final o in h.orders) {
        if (o.status != 'voided') {
          count++;
          total += o.totalAmount;
        }
      }
      return (count, total);
    }));

    return Container(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: t.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: t.borderLight),
      ),
      child: Text.rich(
        TextSpan(children: [
          TextSpan(
              text: egp(salesTotal),
              style: money(
                  size: 11, weight: FontWeight.w700, color: t.textPrimary)),
          TextSpan(
              text: ' · ${l10n(context).commonOrdersCount(orderCount)}',
              style: ui(
                  size: 11,
                  weight: FontWeight.w600,
                  color: t.textSecondary)),
        ]),
      ),
    );
  }
}

// ── Action button — icon-only on phone, icon+label on tablet/desktop ─────────

class _BarAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool compact;
  final bool disabled;
  final String? tooltip;
  final int badgeCount;
  final bool badgeDanger;
  final VoidCallback onTap;

  const _BarAction({
    required this.icon,
    required this.label,
    required this.compact,
    required this.onTap,
    this.disabled = false,
    this.tooltip,
    this.badgeCount = 0,
    this.badgeDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final fg = disabled ? t.textMuted : t.textSecondary;

    Widget iconWidget = Icon(icon, size: 17, color: fg);
    if (badgeCount > 0) {
      iconWidget = Badge(
        backgroundColor: badgeDanger ? t.danger : t.accent,
        label: Text('$badgeCount',
            style: ui(size: 10, weight: FontWeight.w700, color: Colors.white)),
        child: iconWidget,
      );
    }

    return Tooltip(
      message: tooltip ?? label,
      child: AnimatedPressScale(
        onTap: disabled ? null : onTap,
        child: Container(
          height: 36,
          width: compact ? 36 : null,
          margin: const EdgeInsetsDirectional.only(start: AppSpace.xs),
          padding: compact
              ? EdgeInsets.zero
              : const EdgeInsetsDirectional.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: t.surfaceAlt,
            borderRadius: BorderRadius.circular(AppRadius.xs),
            border: Border.all(color: t.borderLight),
          ),
          alignment: Alignment.center,
          child: compact
              ? iconWidget
              : Row(mainAxisSize: MainAxisSize.min, children: [
                  iconWidget,
                  const SizedBox(width: 6),
                  Text(label,
                      style:
                          ui(size: 12, weight: FontWeight.w600, color: fg)),
                ]),
        ),
      ),
    );
  }
}
