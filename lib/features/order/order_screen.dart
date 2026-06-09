import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/models/shift.dart';
import '../../core/providers/auth_notifier.dart';
import '../../core/providers/menu_notifier.dart';
import '../../core/providers/discount_notifier.dart';
import '../../core/providers/order_history_notifier.dart';
import '../../core/providers/payment_method_notifier.dart';
import '../../core/providers/shift_notifier.dart';
import '../../core/repositories/shift_repository.dart';
import '../../core/services/connectivity_service.dart';
import '../../core/services/offline_queue.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatting.dart';
import '../../core/utils/responsive.dart';
import '../../shared/widgets/sync_status_chip.dart';
import 'widgets/top_bar.dart';
import 'widgets/category_rail.dart';
import 'widgets/menu_grid.dart';
import 'widgets/cart_panel.dart';
import 'widgets/action_drawer.dart';
import '../shift/cash_movement_sheet.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});
  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  final _searchCtrl = TextEditingController();
  String _query = '';
  Timer? _debounce;
  StreamSubscription<bool>? _connectivitySub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _prefetch();
    });

    // Search debounce.
    _searchCtrl.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 180), () {
        if (mounted) {
          setState(() => _query = _searchCtrl.text.trim().toLowerCase());
        }
      });
    });

    // Re-fetch on reconnect.
    _connectivitySub = ConnectivityService.instance.stream.listen((online) {
      if (online && mounted) _prefetch();
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _debounce?.cancel();
    _connectivitySub?.cancel();
    super.dispose();
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
    final isDesktop = context.isDesktop;
    final isTablet = context.isTablet;

    return Scaffold(
      backgroundColor: AppColors.bg,
      floatingActionButton:
          isTablet || isDesktop ? null : const MobileCartFab(),
      body: SafeArea(
        child: Column(children: [
          TopBar(ctrl: _searchCtrl, query: _query),
          Expanded(
            child: isDesktop
                ? Row(children: [
                    if (_query.isEmpty) const CategoryRail(),
                    Expanded(child: _contentArea()),
                    const CartPanel(),
                  ])
                : isTablet
                    ? Row(children: [
                        if (_query.isEmpty) const CategoryRail(),
                        Expanded(child: _contentArea()),
                        const CartPanel(),
                      ])
                    : Row(children: [
                        if (_query.isEmpty) const CategoryRail(),
                        Expanded(child: _contentArea()),
                      ]),
          ),
          const _BottomBar(),
        ]),
      ),
    );
  }

  Widget _contentArea() => AnimatedSwitcher(
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
        child: _query.isNotEmpty
            ? SearchResults(key: ValueKey(_query), query: _query)
            : const MenuGrid(key: ValueKey('grid')),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
//  BOTTOM BAR
// ─────────────────────────────────────────────────────────────────────────────

class _BottomBar extends ConsumerWidget {
  const _BottomBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(orderHistoryProvider);
    final shiftSt = ref.watch(shiftProvider);
    final sync = ref.watch(offlineQueueProvider);

    final active = history.orders.where((o) => o.status != 'voided').toList();
    final orderCount = active.length;
    final salesTotal = active.fold(0, (s, o) => s + o.totalAmount);

    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(top: BorderSide(color: AppColors.border)),
        boxShadow: AppShadows.toolbar,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(children: [
        // Sync status chip (compact).
        const SyncStatusChip(),
        const SizedBox(width: 10),

        // Stats pill.
        if (shiftSt.hasOpenShift)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.bg,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Text(
              '${egp(salesTotal)} · $orderCount order${orderCount == 1 ? '' : 's'}',
              style: cairo(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary),
            ),
          ),

        // Pending sync count.
        if (sync.orderCount > 0) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.cloud_upload_outlined,
                  size: 12, color: AppColors.warning),
              const SizedBox(width: 4),
              Text('${sync.orderCount}',
                  style: cairo(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.warning)),
            ]),
          ),
        ],

        const Spacer(),

        // Always-visible action buttons.
        _BarIconBtn(
          icon: Icons.receipt_long_rounded,
          tooltip: 'Past Orders',
          onTap: () => context.push('/order-history'),
        ),
        _BarIconBtn(
          icon: Icons.payments_outlined,
          tooltip: 'Cash In/Out',
          onTap: () {
            final shift = ref.read(shiftProvider).shift;
            if (shift != null) {
              CashMovementSheet.show(context, shiftId: shift.id);
            }
          },
        ),
        _BarIconBtn(
          icon: Icons.more_horiz_rounded,
          tooltip: 'More',
          onTap: () => ActionDrawer.show(context),
        ),
      ]),
    );
  }
}

class _BarIconBtn extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _BarIconBtn({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Tooltip(
        message: tooltip,
        child: AnimatedPressScale(
          onTap: onTap,
          child: Container(
            width: 36,
            height: 36,
            margin: const EdgeInsets.only(left: 4),
            decoration: BoxDecoration(
              color: AppColors.bg,
              borderRadius: BorderRadius.circular(AppRadius.xs),
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 17, color: AppColors.textSecondary),
          ),
        ),
      );
}
