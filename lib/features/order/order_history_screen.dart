import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../core/repositories/order_repository.dart';
import '../../core/models/order.dart';
import '../../core/providers/order_history_notifier.dart';
import '../../core/providers/shift_notifier.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatting.dart';
import '../../shared/widgets/error_banner.dart';
import 'void_order_sheet.dart';
import 'widgets/receipt_preview_sheet.dart';
import 'widgets/order_ingredients_sheet.dart';
import 'helpers/payment_helpers.dart';
import '../../core/providers/payment_method_notifier.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  SORT
// ─────────────────────────────────────────────────────────────────────────────
enum _Col { number, payment, time, teller, amount }

class OrderHistoryScreen extends ConsumerStatefulWidget {
  const OrderHistoryScreen({super.key});
  @override
  ConsumerState<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends ConsumerState<OrderHistoryScreen> {
  _Col _sortCol = _Col.number;
  bool _sortAsc = false;

  String? _expandedId;
  Order? _expandedOrder;
  bool _loadingDetail = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final shiftId = ref.read(shiftProvider).shift?.id;
    if (shiftId == null) return;
    await ref
        .read(orderHistoryProvider.notifier)
        .loadForShift(shiftId, force: true);
  }

  List<Order> _sorted(List<Order> orders) {
    final list = List<Order>.of(orders);
    list.sort((a, b) {
      int cmp;
      switch (_sortCol) {
        case _Col.number:
          cmp = a.orderNumber.compareTo(b.orderNumber);
        case _Col.payment:
          cmp = a.paymentMethod.compareTo(b.paymentMethod);
        case _Col.time:
          cmp = a.createdAt.compareTo(b.createdAt);
        case _Col.teller:
          cmp = a.tellerName.compareTo(b.tellerName);
        case _Col.amount:
          cmp = a.totalAmount.compareTo(b.totalAmount);
      }
      return _sortAsc ? cmp : -cmp;
    });
    return list;
  }

  void _onSort(_Col col) => setState(() {
        if (_sortCol == col) {
          _sortAsc = !_sortAsc;
        } else {
          _sortCol = col;
          _sortAsc = col == _Col.number;
        }
      });

  Future<void> _toggleExpand(Order order) async {
    if (_expandedId == order.id) {
      setState(() {
        _expandedId = null;
        _expandedOrder = null;
      });
      return;
    }
    setState(() {
      _expandedId = order.id;
      _expandedOrder = order;
      _loadingDetail = false;
    });

    if (order.items.isEmpty) {
      setState(() => _loadingDetail = true);
      try {
        final full = await ref.read(orderRepositoryProvider).getOrder(order.id);
        if (mounted && _expandedId == order.id) {
          ref.read(orderHistoryProvider.notifier).updateOrder(full);
          setState(() {
            _expandedOrder = full;
            _loadingDetail = false;
          });
        }
      } catch (_) {
        if (mounted) setState(() => _loadingDetail = false);
      }
    }
  }

  void _onVoided(Order voided) {
    ref.read(orderHistoryProvider.notifier).updateOrder(voided);
    if (_expandedId == voided.id) setState(() => _expandedOrder = voided);
  }

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(orderHistoryProvider);
    final shift = ref.watch(shiftProvider).shift;
    final methods = ref.watch(paymentMethodProvider).items;
    final top = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(children: [
        // ── Top bar ────────────────────────────────────────────────────
        _TopBar(
          paddingTop: top,
          onBack: () => context.pop(),
          onRefresh: shift == null
              ? null
              : () => ref.read(orderHistoryProvider.notifier).refresh(shift.id),
        ),

        // ── Body ───────────────────────────────────────────────────────
        Expanded(
          child: shift == null
              ? _EmptyState(
                  icon: Icons.lock_outline_rounded, message: 'No open shift')
              : history.isLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary))
                  : history.error != null
                      ? Padding(
                          padding: const EdgeInsets.all(24),
                          child: ErrorBanner(
                              message: history.error!, onRetry: _load),
                        )
                      : history.orders.isEmpty
                          ? _EmptyLottie()
                          : _Body(
                              orders: history.orders,
                              methods: methods,
                              sortCol: _sortCol,
                              sortAsc: _sortAsc,
                              onSort: _onSort,
                              expandedId: _expandedId,
                              expandedOrder: _expandedOrder,
                              loadingDetail: _loadingDetail,
                              onToggle: _toggleExpand,
                              onVoided: _onVoided,
                              sorted: _sorted,
                            ),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  TOP BAR
// ─────────────────────────────────────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  final double paddingTop;
  final VoidCallback onBack;
  final VoidCallback? onRefresh;
  const _TopBar(
      {required this.paddingTop, required this.onBack, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16, paddingTop + 10, 16, 12),
      child: Row(children: [
        _IconBtn(icon: Icons.arrow_back_rounded, onTap: onBack),
        const SizedBox(width: 14),
        Text('Past Orders',
            style: cairo(fontSize: 18, fontWeight: FontWeight.w700)),
        const Spacer(),
        if (onRefresh != null)
          _IconBtn(icon: Icons.refresh_rounded, onTap: onRefresh!),
      ]),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.bg,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: AppColors.border),
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 18, color: AppColors.textPrimary),
        ),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
//  BODY (stats + table)
// ─────────────────────────────────────────────────────────────────────────────
class _Body extends ConsumerWidget {
  final List<Order> orders;
  final List<PaymentMethod> methods;
  final _Col sortCol;
  final bool sortAsc;
  final void Function(_Col) onSort;
  final String? expandedId;
  final Order? expandedOrder;
  final bool loadingDetail;
  final Future<void> Function(Order) onToggle;
  final void Function(Order) onVoided;
  final List<Order> Function(List<Order>) sorted;

  const _Body({
    required this.orders,
    required this.methods,
    required this.sortCol,
    required this.sortAsc,
    required this.onSort,
    required this.expandedId,
    required this.expandedOrder,
    required this.loadingDetail,
    required this.onToggle,
    required this.onVoided,
    required this.sorted,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final active = orders.where((o) => o.status != 'voided').toList();
    final total = active.fold<int>(0, (s, o) => s + o.totalAmount);

    // Build one stat entry per payment method that actually appears in orders,
    // plus a catch-all "Mixed" bucket. Order matches the methods list ordering.
    final methodStats =
        <({String id, String label, Color color, int amount})>[];

    for (final m in methods) {
      final sum = active
          .where((o) => o.paymentMethod == m.wireFormat)
          .fold<int>(0, (s, o) => s + o.totalAmount);
      if (sum > 0) {
        methodStats.add((
          id: m.id,
          label: m.label('en'),
          color: m.color,
          amount: sum,
        ));
      }
    }

    // Mixed orders (split payment) tracked separately
    final mixedSum = active
        .where((o) => o.paymentMethod == 'mixed')
        .fold<int>(0, (s, o) => s + o.totalAmount);
    if (mixedSum > 0) {
      methodStats.add((
        id: 'mixed',
        label: 'Mixed',
        color: AppColors.warning,
        amount: mixedSum,
      ));
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // ── Stats row ────────────────────────────────────────────────
        // Always show Orders + Total, then one card per active method.
        // Scrollable horizontally if there are many methods.
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: IntrinsicHeight(
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              _StatCard(
                label: 'Orders',
                value: '${active.length}',
                sub: 'this shift',
              ),
              const SizedBox(width: 10),
              _StatCard(
                label: 'Total',
                value: egp(total),
                valueColor: AppColors.success,
                sub: 'active only',
              ),
              ...methodStats.map((m) {
                final pct = total > 0 ? (m.amount / total * 100).round() : 0;
                return Row(mainAxisSize: MainAxisSize.min, children: [
                  const SizedBox(width: 10),
                  _StatCard(
                    label: m.label,
                    value: egp(m.amount),
                    valueColor: m.color,
                    sub: '$pct%',
                  ),
                ]);
              }),
            ]),
          ),
        ),
        const SizedBox(height: 14),

        // ── Table card ───────────────────────────────────────────────
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: AppColors.borderLight),
              boxShadow: AppShadows.card,
            ),
            child: Column(children: [
              // Header
              _TableHeader(sortCol: sortCol, sortAsc: sortAsc, onSort: onSort),
              const Divider(height: 1, color: AppColors.borderLight),
              // Rows
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: sorted(orders).length,
                  separatorBuilder: (_, __) =>
                      const Divider(height: 1, color: AppColors.borderLight),
                  itemBuilder: (_, i) {
                    final o = sorted(orders)[i];
                    final isExp = expandedId == o.id;
                    return _OrderRow(
                      order: o,
                      methods: methods,
                      expandedOrder: isExp ? expandedOrder : null,
                      isExpanded: isExp,
                      isLoadingDetail: isExp && loadingDetail,
                      onTap: () => onToggle(o),
                      onVoided: onVoided,
                    );
                  },
                ),
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  STAT CARD
// ─────────────────────────────────────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String sub;
  final Color? valueColor;
  const _StatCard({
    required this.label,
    required this.value,
    required this.sub,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: 150,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: cairo(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textMuted)),
            const SizedBox(height: 5),
            Text(value,
                style: cairo(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: valueColor ?? AppColors.textPrimary)),
            const SizedBox(height: 2),
            Text(sub, style: cairo(fontSize: 11, color: AppColors.textMuted)),
          ],
        ),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
//  TABLE HEADER
// ─────────────────────────────────────────────────────────────────────────────

// Column flex/width spec shared between header and rows.
// Layout: [#56] [payment flex3] [time flex2] [teller flex2] [amount 110] [chevron 44]
class _ColSpec {
  static const double numW = 56;
  static const int payFlex = 3;
  static const int timeFlex = 2;
  static const int tellerFlex = 2;
  static const double amtW = 110;
  static const double chevW = 44;
}

class _TableHeader extends StatelessWidget {
  final _Col sortCol;
  final bool sortAsc;
  final void Function(_Col) onSort;
  const _TableHeader(
      {required this.sortCol, required this.sortAsc, required this.onSort});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      child: Row(children: [
        _SortCell('#', _Col.number, width: _ColSpec.numW),
        _SortCell('Payment', _Col.payment, flex: _ColSpec.payFlex),
        _SortCell('Time', _Col.time, flex: _ColSpec.timeFlex),
        _SortCell('Teller', _Col.teller, flex: _ColSpec.tellerFlex),
        _SortCell('Amount', _Col.amount,
            width: _ColSpec.amtW, alignRight: true),
        const SizedBox(width: _ColSpec.chevW),
      ]),
    );
  }

  Widget _SortCell(String label, _Col col,
      {double? width, int? flex, bool alignRight = false}) {
    final active = sortCol == col;
    final child = GestureDetector(
      onTap: () => onSort(col),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 42,
        child: Row(
          mainAxisAlignment:
              alignRight ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Text(label,
                style: cairo(
                    fontSize: 11,
                    fontWeight: active ? FontWeight.w700 : FontWeight.w600,
                    color: active ? AppColors.primary : AppColors.textMuted,
                    letterSpacing: 0.4)),
            if (active) ...[
              const SizedBox(width: 3),
              Icon(
                sortAsc
                    ? Icons.arrow_upward_rounded
                    : Icons.arrow_downward_rounded,
                size: 11,
                color: AppColors.primary,
              ),
            ],
          ],
        ),
      ),
    );

    if (width != null) return SizedBox(width: width, child: child);
    return Expanded(flex: flex ?? 1, child: child);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  ORDER ROW (expandable)
// ─────────────────────────────────────────────────────────────────────────────
class _OrderRow extends ConsumerWidget {
  final Order order;
  final List<PaymentMethod> methods;
  final Order? expandedOrder;
  final bool isExpanded;
  final bool isLoadingDetail;
  final VoidCallback onTap;
  final void Function(Order) onVoided;

  const _OrderRow({
    required this.order,
    required this.methods,
    this.expandedOrder,
    required this.isExpanded,
    required this.isLoadingDetail,
    required this.onTap,
    required this.onVoided,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final o = order;
    final isVoided = o.status == 'voided';
    final isPending = o.status == 'pending_sync';

    return Column(mainAxisSize: MainAxisSize.min, children: [
      // ── Main row ──────────────────────────────────────────────────
      GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: isExpanded
              ? AppColors.primary.withOpacity(0.04)
              : isVoided
                  ? AppColors.bg.withOpacity(0.4)
                  : Colors.white,
          child: Opacity(
            opacity: isVoided ? 0.55 : 1.0,
            child: Row(children: [
              // # column
              SizedBox(
                width: _ColSpec.numW,
                child: isPending
                    ? const Icon(Icons.cloud_upload_outlined,
                        size: 16, color: AppColors.warning)
                    : Text('#${o.orderNumber}',
                        style: cairo(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isVoided
                                ? AppColors.textMuted
                                : AppColors.primary)),
              ),
              // Payment column
              Expanded(
                flex: _ColSpec.payFlex,
                child: Row(children: [
                  _PaymentBadge(
                      method: o.paymentMethod,
                      voided: isVoided,
                      methods: methods),
                  if (isVoided) ...[
                    const SizedBox(width: 6),
                    _StatusPill('Voided', AppColors.danger),
                  ],
                  if (isPending) ...[
                    const SizedBox(width: 6),
                    _StatusPill('Pending sync', AppColors.warning),
                  ],
                  if (o.customerName != null) ...[
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(o.customerName!,
                          overflow: TextOverflow.ellipsis,
                          style:
                              cairo(fontSize: 12, color: AppColors.textMuted)),
                    ),
                  ],
                ]),
              ),
              // Time column
              Expanded(
                flex: _ColSpec.timeFlex,
                child: Text(timeShort(o.createdAt),
                    style: cairo(fontSize: 13, color: AppColors.textSecondary)),
              ),
              // Teller column
              Expanded(
                flex: _ColSpec.tellerFlex,
                child: Row(children: [
                  const Icon(Icons.person_outline_rounded,
                      size: 13, color: AppColors.textMuted),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(o.tellerName,
                        overflow: TextOverflow.ellipsis,
                        style: cairo(
                            fontSize: 12, color: AppColors.textSecondary)),
                  ),
                ]),
              ),
              // Amount column
              SizedBox(
                width: _ColSpec.amtW,
                child: Text(egp(o.totalAmount),
                    textAlign: TextAlign.right,
                    style: cairo(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: isVoided
                            ? AppColors.textMuted
                            : AppColors.textPrimary,
                        decoration:
                            isVoided ? TextDecoration.lineThrough : null)),
              ),
              // Chevron
              SizedBox(
                width: _ColSpec.chevW,
                child: isLoadingDetail
                    ? const Center(
                        child: SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                              strokeWidth: 1.5, color: AppColors.primary),
                        ),
                      )
                    : Center(
                        child: AnimatedRotation(
                          duration: const Duration(milliseconds: 180),
                          turns: isExpanded ? 0.5 : 0,
                          child: const Icon(Icons.keyboard_arrow_down_rounded,
                              size: 20, color: AppColors.textMuted),
                        ),
                      ),
              ),
            ]),
          ),
        ),
      ),

      // ── Expanded panel ─────────────────────────────────────────────
      if (isExpanded && expandedOrder != null)
        _ExpandedPanel(
          order: expandedOrder!,
          methods: methods,
          isLoading: isLoadingDetail,
          onVoided: onVoided,
        ),
    ]);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  EXPANDED PANEL
// ─────────────────────────────────────────────────────────────────────────────
class _ExpandedPanel extends ConsumerWidget {
  final Order order;
  final List<PaymentMethod> methods;
  final bool isLoading;
  final void Function(Order) onVoided;

  const _ExpandedPanel({
    required this.order,
    required this.methods,
    required this.isLoading,
    required this.onVoided,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVoided = order.status == 'voided';
    final isPending = order.status == 'pending_sync';

    return Container(
      color: AppColors.bg,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Line items ─────────────────────────────────────────
            if (isLoading)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: AppColors.primary),
                  ),
                ),
              )
            else if (order.items.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('No item details available',
                    style: cairo(fontSize: 13, color: AppColors.textMuted)),
              )
            else
              ...List.generate(order.items.length, (i) {
                final item = order.items[i];
                return Column(mainAxisSize: MainAxisSize.min, children: [
                  _ItemRow(item: item, isPending: isPending),
                  if (i < order.items.length - 1)
                    const Divider(
                        height: 1,
                        color: AppColors.borderLight,
                        indent: 14,
                        endIndent: 14),
                ]);
              }),

            // ── Totals ────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.borderLight)),
              ),
              child: Column(children: [
                _TotalRow('Subtotal', egp(order.subtotal)),
                if (order.discountAmount > 0)
                  _TotalRow('Discount', '− ${egp(order.discountAmount)}',
                      valueColor: AppColors.success),
                if (order.taxAmount > 0)
                  _TotalRow('Tax (14%)', egp(order.taxAmount)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: AppColors.borderLight))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text('Total',
                          style:
                              cairo(fontSize: 15, fontWeight: FontWeight.w700)),
                      Text(egp(order.totalAmount),
                          style: cairo(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: isVoided
                                  ? AppColors.textMuted
                                  : AppColors.primary,
                              decoration: isVoided
                                  ? TextDecoration.lineThrough
                                  : null)),
                    ],
                  ),
                ),
              ]),
            ),

            // ── Meta + actions ────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.borderLight)),
              ),
              child: Row(children: [
                // Payment method
                const Icon(Icons.payments_outlined,
                    size: 13, color: AppColors.textMuted),
                const SizedBox(width: 5),
                Text(methodLabel(methods, 'en', order.paymentMethod),
                    style: cairo(fontSize: 12, color: AppColors.textSecondary)),
                // Teller
                if (order.tellerName.isNotEmpty) ...[
                  _MetaSep(),
                  const Icon(Icons.person_outline_rounded,
                      size: 13, color: AppColors.textMuted),
                  const SizedBox(width: 4),
                  Text(order.tellerName,
                      style:
                          cairo(fontSize: 12, color: AppColors.textSecondary)),
                ],
                // Void reason
                if (isVoided && order.voidReason != null) ...[
                  _MetaSep(),
                  const Icon(Icons.cancel_outlined,
                      size: 13, color: AppColors.danger),
                  const SizedBox(width: 4),
                  Text(_voidLabel(order.voidReason!),
                      style: cairo(fontSize: 12, color: AppColors.danger)),
                ],
                const Spacer(),
                // Actions
                _ActionBtn(
                  icon: Icons.print_rounded,
                  label: 'Print',
                  color: AppColors.primary,
                  onTap: () => ReceiptPreviewSheet.show(context, order),
                ),
                if (!isVoided) ...[
                  const SizedBox(width: 8),
                  _ActionBtn(
                    icon: Icons.cancel_outlined,
                    label: 'Void',
                    color: AppColors.danger,
                    onTap: () => VoidOrderSheet.show(context, order, onVoided),
                  ),
                ],
              ]),
            ),
          ],
        ),
      ),
    );
  }

  static String _voidLabel(String r) {
    if (r.startsWith('other: ')) return r.substring(7);
    return switch (r) {
      'customer_request' => 'Customer request',
      'wrong_order' => 'Wrong order',
      'quality_issue' => 'Quality issue',
      'other' => 'Other',
      _ => r,
    };
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  ITEM ROW
// ─────────────────────────────────────────────────────────────────────────────
class _ItemRow extends StatelessWidget {
  final OrderItem item;
  final bool isPending;
  const _ItemRow({required this.item, this.isPending = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Qty bubble
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.07),
            borderRadius: BorderRadius.circular(7),
          ),
          alignment: Alignment.center,
          child: Text('${item.quantity}',
              style: cairo(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary)),
        ),
        const SizedBox(width: 10),

        // Name + modifiers
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(
                child: Text(
                  item.itemName +
                      (item.sizeLabel != null
                          ? ' · ${normaliseName(item.sizeLabel!)}'
                          : ''),
                  style: cairo(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
              if (item.isBundleLine) ...[
                const SizedBox(width: 6),
                _MiniChip('Combo', AppColors.primary),
              ],
            ]),

            // Bundle components
            if (item.isBundleLine && item.bundleComponents.isNotEmpty) ...[
              const SizedBox(height: 4),
              ...item.bundleComponents.map((c) {
                final qty = c.quantity * item.quantity;
                return Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 3),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '– ${normaliseName(c.itemName)}'
                          '${c.sizeLabel != null ? ' · ${normaliseName(c.sizeLabel!)}' : ''}'
                          ' × $qty',
                          style: cairo(
                              fontSize: 12, color: AppColors.textSecondary),
                        ),
                        if (c.addons.isNotEmpty) ...[
                          const SizedBox(height: 3),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Wrap(
                              spacing: 4,
                              runSpacing: 3,
                              children: c.addons.map((a) {
                                final lt = a.priceModifier * a.quantity;
                                return _AddonChip(
                                  a.priceModifier > 0
                                      ? '+ ${normaliseName(a.name)}${a.quantity > 1 ? " ×${a.quantity}" : ""}  ${egp(lt)}'
                                      : '+ ${normaliseName(a.name)}${a.quantity > 1 ? " ×${a.quantity}" : ""}',
                                  AppColors.primary,
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                        if (c.optionals.isNotEmpty) ...[
                          const SizedBox(height: 3),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Wrap(
                              spacing: 4,
                              runSpacing: 3,
                              children: c.optionals
                                  .map((o) => _AddonChip(
                                        o.price > 0
                                            ? '+ ${normaliseName(o.name)}  ${egp(o.price)}'
                                            : '+ ${normaliseName(o.name)}',
                                        AppColors.warning,
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ]),
                );
              }),
            ] else ...[
              // Addons
              if (item.addons.isNotEmpty) ...[
                const SizedBox(height: 5),
                Wrap(
                  spacing: 4,
                  runSpacing: 3,
                  children: item.addons.map((a) {
                    final hasPrice = a.unitPrice > 0;
                    return _AddonChip(
                      hasPrice
                          ? '${normaliseName(a.addonName)}  +${egp(a.lineTotal)}'
                          : normaliseName(a.addonName),
                      AppColors.primary,
                    );
                  }).toList(),
                ),
              ],
              // Optionals
              if (item.optionals.isNotEmpty) ...[
                const SizedBox(height: 4),
                Wrap(
                  spacing: 4,
                  runSpacing: 3,
                  children: item.optionals.map((o) {
                    final hasPrice = o.price > 0;
                    return _AddonChip(
                      hasPrice
                          ? '${normaliseName(o.fieldName)}  +${egp(o.price)}'
                          : normaliseName(o.fieldName),
                      AppColors.warning,
                    );
                  }).toList(),
                ),
              ],
            ],

            // Ingredients button
            if (item.deductions.isNotEmpty || isPending) ...[
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => OrderIngredientsSheet(item: item),
                ),
                child: _MiniChip('Ingredients', AppColors.primary,
                    icon: Icons.science_rounded),
              ),
            ],
          ]),
        ),

        const SizedBox(width: 10),
        // Line total
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(egp(item.lineTotal),
              style: cairo(fontSize: 13, fontWeight: FontWeight.w600)),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SMALL REUSABLE WIDGETS
// ─────────────────────────────────────────────────────────────────────────────

class _PaymentBadge extends ConsumerWidget {
  final String method;
  final bool voided;
  final List<PaymentMethod> methods;
  const _PaymentBadge(
      {required this.method, required this.voided, required this.methods});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final label = methodLabel(methods, 'en', method);
    final color = methodColor(methods, method);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: voided ? AppColors.borderLight : color.withOpacity(0.09),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(label,
          style: cairo(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: voided ? AppColors.textMuted : color)),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final String label;
  final Color color;
  const _StatusPill(this.label, this.color);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: BoxDecoration(
          color: color.withOpacity(0.09),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(label,
            style: cairo(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: color,
                letterSpacing: 0.2)),
      );
}

class _AddonChip extends StatelessWidget {
  final String label;
  final Color color;
  const _AddonChip(this.label, this.color);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: color.withOpacity(0.07),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(label,
            style:
                cairo(fontSize: 11, fontWeight: FontWeight.w500, color: color)),
      );
}

class _MiniChip extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;
  const _MiniChip(this.label, this.color, {this.icon});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (icon != null) ...[
            Icon(icon, size: 10, color: color),
            const SizedBox(width: 3),
          ],
          Text(label,
              style: cairo(
                  fontSize: 10, fontWeight: FontWeight.w700, color: color)),
        ]),
      );
}

class _TotalRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  const _TotalRow(this.label, this.value, {this.valueColor});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label,
              style: cairo(fontSize: 13, color: AppColors.textSecondary)),
          Text(value,
              style: cairo(
                  fontSize: 13, color: valueColor ?? AppColors.textPrimary)),
        ]),
      );
}

class _MetaSep extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        width: 1,
        height: 12,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        color: AppColors.border,
      );
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.07),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 5),
            Text(label,
                style: cairo(
                    fontSize: 12, fontWeight: FontWeight.w600, color: color)),
          ]),
        ),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
//  EMPTY STATES
// ─────────────────────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;
  const _EmptyState({required this.icon, required this.message});

  @override
  Widget build(BuildContext context) => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 40, color: AppColors.border),
          const SizedBox(height: 12),
          Text(message,
              style: cairo(fontSize: 15, color: AppColors.textSecondary)),
        ]),
      );
}

class _EmptyLottie extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
            width: 160,
            height: 160,
            child: Lottie.asset('assets/lottie/no_orders.json',
                fit: BoxFit.contain, repeat: true),
          ),
          Text('No orders yet',
              style: cairo(fontSize: 15, color: AppColors.textSecondary)),
        ]),
      );
}
