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
import '../../shared/widgets/label_value.dart';
import 'void_order_sheet.dart';
import 'widgets/receipt_preview_sheet.dart';
import 'widgets/order_ingredients_sheet.dart';
import 'helpers/payment_helpers.dart';
import '../../core/providers/payment_method_notifier.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  SORT
// ─────────────────────────────────────────────────────────────────────────────
enum _Col { number, payment, time, amount }

class OrderHistoryScreen extends ConsumerStatefulWidget {
  const OrderHistoryScreen({super.key});
  @override
  ConsumerState<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends ConsumerState<OrderHistoryScreen> {
  _Col _sortCol = _Col.time;
  bool _sortAsc = false; // newest first

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
        case _Col.amount:
          cmp = a.totalAmount.compareTo(b.totalAmount);
      }
      return _sortAsc ? cmp : -cmp;
    });
    return list;
  }

  void _onSort(_Col col) {
    setState(() {
      if (_sortCol == col) {
        _sortAsc = !_sortAsc;
      } else {
        _sortCol = col;
        _sortAsc = col == _Col.number; // number defaults asc, rest desc
      }
    });
  }

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

    // Fetch full order if items are empty
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        // ── Top bar ──────────────────────────────────────────────────────
        Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(
              14, MediaQuery.of(context).padding.top + 8, 14, 10),
          child: Row(children: [
            GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                    color: AppColors.bg,
                    borderRadius: BorderRadius.circular(AppRadius.xs),
                    border: Border.all(color: AppColors.border)),
                alignment: Alignment.center,
                child: const Icon(Icons.arrow_back_rounded,
                    size: 18, color: AppColors.textPrimary),
              ),
            ),
            const SizedBox(width: 12),
            Text('Past Orders',
                style: cairo(fontSize: 17, fontWeight: FontWeight.w700)),
            const Spacer(),
            if (shift != null)
              GestureDetector(
                onTap: () =>
                    ref.read(orderHistoryProvider.notifier).refresh(shift.id),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                      color: AppColors.bg,
                      borderRadius: BorderRadius.circular(AppRadius.xs),
                      border: Border.all(color: AppColors.border)),
                  alignment: Alignment.center,
                  child: const Icon(Icons.refresh_rounded,
                      size: 18, color: AppColors.textSecondary),
                ),
              ),
          ]),
        ),
        Container(height: 1, color: AppColors.border),

        // ── Body ─────────────────────────────────────────────────────────
        Expanded(
          child: shift == null
              ? _empty(Icons.lock_outline_rounded, 'No open shift')
              : history.isLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary))
                  : history.error != null
                      ? Padding(
                          padding: const EdgeInsets.all(24),
                          child: ErrorBanner(
                              message: history.error!, onRetry: _load))
                      : history.orders.isEmpty
                          ? _emptyLottie()
                          : _buildTable(history.orders, methods),
        ),
      ]),
    );
  }

  Widget _buildTable(List<Order> orders, List<PaymentMethod> methods) {
    final active = orders.where((o) => o.status != 'voided').toList();
    final total = active.fold<int>(0, (s, o) => s + o.totalAmount);
    final cash = active
        .where((o) => isCashMethod(methods, o.paymentMethod))
        .fold(0, (s, o) => s + o.totalAmount);
    final card = active
        .where((o) =>
            !isCashMethod(methods, o.paymentMethod) &&
            o.paymentMethod != 'mixed')
        .fold(0, (s, o) => s + o.totalAmount);

    final sorted = _sorted(orders);

    return Column(children: [
      // ── Stats bar ─────────────────────────────────────────────────────
      Container(
        color: AppColors.bg,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(children: [
          _Chip('Orders', '${active.length}', AppColors.primary),
          const SizedBox(width: 8),
          _Chip('Total', egp(total), AppColors.success),
          if (cash > 0) ...[
            const SizedBox(width: 8),
            _Chip('Cash', egp(cash), AppColors.textSecondary),
          ],
          if (card > 0) ...[
            const SizedBox(width: 8),
            _Chip('Card', egp(card), const Color(0xFF7C3AED)),
          ],
        ]),
      ),
      Container(height: 1, color: AppColors.border),

      // ── Table Card ────────────────────────────────────────────────────
      Expanded(
        child: Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.borderLight),
            boxShadow: AppShadows.card,
          ),
          child: Column(children: [
            // ── Sort header ───────────────────────────────────────────────
            Container(
              decoration: const BoxDecoration(
                color: AppColors.bg,
                borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: Row(children: [
                _sortHeader('#', _Col.number, width: 52),
                _sortHeader('Payment', _Col.payment, flex: 3),
                _sortHeader('Time', _Col.time, flex: 2),
                _sortHeader('Amount', _Col.amount, width: 90, alignRight: true),
                const SizedBox(width: 28),
              ]),
            ),
            const Divider(height: 1, color: AppColors.borderLight),

            // ── Rows ──────────────────────────────────────────────────────
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: sorted.length,
                separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.borderLight),
                itemBuilder: (_, i) {
                  final o = sorted[i];
                  final isExpanded = _expandedId == o.id;
                  return _OrderRow(
                    order: o,
                    expandedOrder: isExpanded ? _expandedOrder : null,
                    isExpanded: isExpanded,
                    isLoadingDetail: isExpanded && _loadingDetail,
                    onTap: () => _toggleExpand(o),
                    onVoided: _onVoided,
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    ]);
  }

  Widget _sortHeader(String label, _Col col,
      {double? width, int? flex, bool alignRight = false}) {
    final active = _sortCol == col;
    final child = GestureDetector(
      onTap: () => _onSort(col),
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 42,
        alignment: alignRight ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          mainAxisSize: alignRight ? MainAxisSize.min : MainAxisSize.max,
          mainAxisAlignment:
              alignRight ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Text(label,
                style: cairo(
                    fontSize: 11,
                    fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                    color: active ? AppColors.primary : AppColors.textMuted,
                    letterSpacing: 0.5)),
            if (active) ...[
              const SizedBox(width: 3),
              Icon(
                  _sortAsc
                      ? Icons.arrow_upward_rounded
                      : Icons.arrow_downward_rounded,
                  size: 12,
                  color: AppColors.primary),
            ],
          ],
        ),
      ),
    );

    if (width != null) return SizedBox(width: width, child: child);
    return Expanded(flex: flex ?? 1, child: child);
  }

  Widget _empty(IconData icon, String msg) => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 40, color: AppColors.border),
          const SizedBox(height: 12),
          Text(msg, style: cairo(fontSize: 15, color: AppColors.textSecondary)),
        ]),
      );

  Widget _emptyLottie() => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
              width: 160,
              height: 160,
              child: Lottie.asset('assets/lottie/no_orders.json',
                  fit: BoxFit.contain, repeat: true)),
          Text('No orders yet',
              style: cairo(fontSize: 15, color: AppColors.textSecondary)),
        ]),
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
//  ORDER ROW (expandable)
// ═══════════════════════════════════════════════════════════════════════════════

class _OrderRow extends ConsumerWidget {
  final Order order;
  final Order? expandedOrder;
  final bool isExpanded;
  final bool isLoadingDetail;
  final VoidCallback onTap;
  final void Function(Order) onVoided;

  const _OrderRow({
    required this.order,
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
      // ── Main row ────────────────────────────────────────────────────
      GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          color: isExpanded
              ? AppColors.primary.withOpacity(0.04)
              : isVoided
                  ? AppColors.bg.withOpacity(0.4)
                  : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(children: [
            // #
            SizedBox(
              width: 52,
              child: isPending
                  ? const Icon(Icons.sync_rounded,
                      color: AppColors.warning, size: 16)
                  : Text('#${o.orderNumber}',
                      style: cairo(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: isVoided
                              ? AppColors.textMuted
                              : AppColors.primary)),
            ),
            // Payment
            Expanded(
                flex: 3,
                child: Row(children: [
                  _PaymentBadge(method: o.paymentMethod, voided: isVoided),
                  if (isVoided) ...[
                    const SizedBox(width: 5),
                    const _Badge('VOIDED', AppColors.danger),
                  ],
                  if (isPending) ...[
                    const SizedBox(width: 5),
                    const _Badge('PENDING', AppColors.warning),
                  ],
                  if (o.customerName != null) ...[
                    const SizedBox(width: 8),
                    Flexible(
                        child: Text(o.customerName!,
                            overflow: TextOverflow.ellipsis,
                            style: cairo(
                                fontSize: 12, color: AppColors.textMuted))),
                  ],
                ])),
            // Time
            Expanded(
                flex: 2,
                child: Text(timeShort(o.createdAt),
                    style:
                        cairo(fontSize: 13, color: AppColors.textSecondary))),
            // Amount
            SizedBox(
              width: 90,
              child: Text(egp(o.totalAmount),
                  textAlign: TextAlign.right,
                  style: cairo(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isVoided
                          ? AppColors.textMuted
                          : AppColors.textPrimary,
                      decoration:
                          isVoided ? TextDecoration.lineThrough : null)),
            ),
            // Chevron
            SizedBox(
              width: 28,
              child: isLoadingDetail
                  ? const Padding(
                      padding: EdgeInsets.only(left: 6),
                      child: SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                              strokeWidth: 1.5, color: AppColors.primary)))
                  : Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      size: 18,
                      color: AppColors.textMuted),
            ),
          ]),
        ),
      ),

      // ── Expanded section ────────────────────────────────────────────
      if (isExpanded && expandedOrder != null)
        Container(
          color: AppColors.bg.withOpacity(0.5),
          child: _ExpandedSection(
            order: expandedOrder!,
            isLoading: isLoadingDetail,
            onVoided: onVoided,
          ),
        ),
    ]);
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  EXPANDED SECTION
// ═══════════════════════════════════════════════════════════════════════════════

class _ExpandedSection extends ConsumerWidget {
  final Order order;
  final bool isLoading;
  final void Function(Order) onVoided;

  const _ExpandedSection({
    required this.order,
    required this.isLoading,
    required this.onVoided,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final methods = ref.watch(paymentMethodProvider).items;
    final isVoided = order.status == 'voided';
    final isPending = order.status == 'pending_sync';

    return Container(
      color: AppColors.bg,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ── Line items ──────────────────────────────────────────────
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                  child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: AppColors.primary))),
            )
          else if (order.items.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('No item details available',
                  style: cairo(fontSize: 13, color: AppColors.textMuted)),
            )
          else
            ...order.items.map((item) {
              final i = order.items.indexOf(item);
              return Column(children: [
                _ItemRow(item: item, isPending: isPending),
                if (i < order.items.length - 1)
                  const Divider(
                      height: 1,
                      color: AppColors.borderLight,
                      indent: 14,
                      endIndent: 14),
              ]);
            }),

          // ── Totals ──────────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.borderLight)),
            ),
            child: Column(children: [
              LabelValue('Subtotal', egp(order.subtotal)),
              if (order.discountAmount > 0)
                LabelValue('Discount', '− ${egp(order.discountAmount)}',
                    valueColor: AppColors.success),
              if (order.taxAmount > 0)
                LabelValue('Tax (14%)', egp(order.taxAmount)),
              const SizedBox(height: 6),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Total',
                    style: cairo(fontSize: 15, fontWeight: FontWeight.w700)),
                Text(egp(order.totalAmount),
                    style: cairo(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color:
                            isVoided ? AppColors.textMuted : AppColors.primary,
                        decoration:
                            isVoided ? TextDecoration.lineThrough : null)),
              ]),
            ]),
          ),

          // ── Meta + actions ──────────────────────────────────────────
          Container(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.borderLight)),
            ),
            child: Row(children: [
              const Icon(Icons.payments_outlined,
                  size: 14, color: AppColors.textMuted),
              const SizedBox(width: 6),
              Text(methodLabel(methods, 'en', order.paymentMethod),
                  style: cairo(fontSize: 12, color: AppColors.textSecondary)),
              if (order.tellerName.isNotEmpty) ...[
                const SizedBox(width: 14),
                const Icon(Icons.person_outline_rounded,
                    size: 14, color: AppColors.textMuted),
                const SizedBox(width: 4),
                Text(order.tellerName,
                    style: cairo(fontSize: 12, color: AppColors.textSecondary)),
              ],
              if (isVoided && order.voidReason != null) ...[
                const SizedBox(width: 14),
                const Icon(Icons.cancel_outlined,
                    size: 14, color: AppColors.danger),
                const SizedBox(width: 4),
                Text(_voidLabel(order.voidReason!),
                    style: cairo(fontSize: 12, color: AppColors.danger)),
              ],
              const Spacer(),
                _ActionBtn(
                    icon: Icons.print_rounded,
                    label: 'Print',
                    color: AppColors.primary,
                    onTap: () => ReceiptPreviewSheet.show(context, order)),
              if (!isVoided) ...[
                const SizedBox(width: 8),
                _ActionBtn(
                    icon: Icons.cancel_outlined,
                    label: 'Void',
                    color: AppColors.danger,
                    onTap: () => VoidOrderSheet.show(context, order, onVoided)),
              ],
            ]),
          ),
        ]),
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

// ═══════════════════════════════════════════════════════════════════════════════
//  ITEM ROW
// ═══════════════════════════════════════════════════════════════════════════════

class _ItemRow extends StatelessWidget {
  final OrderItem item;
  final bool isPending;
  const _ItemRow({required this.item, this.isPending = false});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.07),
                borderRadius: BorderRadius.circular(6)),
            alignment: Alignment.center,
            child: Text('${item.quantity}',
                style: cairo(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary)),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Row(children: [
                  Expanded(
                    child: Text(
                        item.itemName +
                            (item.sizeLabel != null
                                ? ' · ${normaliseName(item.sizeLabel!)}'
                                : ''),
                        style:
                            cairo(fontSize: 13, fontWeight: FontWeight.w600)),
                  ),
                  if (item.isBundleLine) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text('Combo',
                          style: cairo(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary)),
                    ),
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
                              '– ${normaliseName(c.itemName)}${c.sizeLabel != null ? ' · ${normaliseName(c.sizeLabel!)}' : ''} × $qty',
                              style: cairo(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary),
                            ),
                            if (c.addons.isNotEmpty)
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 2),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: c.addons.map((a) {
                                      final lt = a.priceModifier * a.quantity;
                                      return Text(
                                        a.priceModifier > 0
                                            ? '+ ${normaliseName(a.name)}${a.quantity > 1 ? " ×${a.quantity}" : ""}  ${egp(lt)}'
                                            : '+ ${normaliseName(a.name)}${a.quantity > 1 ? " ×${a.quantity}" : ""}',
                                        style: cairo(
                                            fontSize: 11,
                                            color: AppColors.primary),
                                      );
                                    }).toList()),
                              ),
                            if (c.optionals.isNotEmpty)
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 2),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: c.optionals.map((o) {
                                      return Text(
                                        o.price > 0
                                            ? '+ ${normaliseName(o.name)}  ${egp(o.price)}'
                                            : '+ ${normaliseName(o.name)}',
                                        style: cairo(
                                            fontSize: 11,
                                            color: AppColors.warning),
                                      );
                                    }).toList()),
                              ),
                          ]),
                    );
                  }),
                ] else ...[
                  // Addons
                  if (item.addons.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Wrap(
                        spacing: 4,
                        runSpacing: 3,
                        children: item.addons.map((a) {
                          final hasPrice = a.unitPrice > 0;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                                hasPrice
                                    ? '${normaliseName(a.addonName)}  +${egp(a.lineTotal)}'
                                    : normaliseName(a.addonName),
                                style: cairo(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary)),
                          );
                        }).toList()),
                  ],
                  // Optionals
                  if (item.optionals.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Wrap(
                        spacing: 4,
                        runSpacing: 3,
                        children: item.optionals.map((o) {
                          final hasPrice = o.price > 0;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                                color: AppColors.warning.withOpacity(0.07),
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                                hasPrice
                                    ? '${normaliseName(o.fieldName)}  +${egp(o.price)}'
                                    : normaliseName(o.fieldName),
                                style: cairo(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.warning)),
                          );
                        }).toList()),
                  ],
                ],
                // Ingredients
                if (item.deductions.isNotEmpty || isPending) ...[
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => OrderIngredientsSheet(item: item),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(4)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(Icons.science_rounded,
                            size: 10, color: AppColors.primary),
                        const SizedBox(width: 4),
                        Text('Ingredients',
                            style: cairo(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary)),
                      ]),
                    ),
                  ),
                ],
              ])),
          const SizedBox(width: 10),
          Text(egp(item.lineTotal),
              style: cairo(fontSize: 13, fontWeight: FontWeight.w700)),
        ]),
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
//  SMALL WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

class _Chip extends StatelessWidget {
  final String label, value;
  final Color color;
  const _Chip(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(6)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(label,
              style: cairo(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color.withOpacity(0.8))),
          const SizedBox(width: 6),
          Text(value,
              style: cairo(
                  fontSize: 14, fontWeight: FontWeight.w800, color: color)),
        ]),
      );
}

class _PaymentBadge extends ConsumerWidget {
  final String method;
  final bool voided;
  const _PaymentBadge({required this.method, required this.voided});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final methods = ref.watch(paymentMethodProvider).items;
    final label = methodLabel(methods, 'en', method);
    final color = methodColor(methods, method);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
          color: voided ? AppColors.borderLight : color.withOpacity(0.09),
          borderRadius: BorderRadius.circular(4)),
      child: Text(label,
          style: cairo(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: voided ? AppColors.textMuted : color)),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  const _Badge(this.label, this.color);

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
          color: color.withOpacity(0.09),
          borderRadius: BorderRadius.circular(4)),
      child: Text(label,
          style: cairo(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: 0.3)));
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ActionBtn(
      {required this.icon,
      required this.label,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
              color: color.withOpacity(0.07),
              borderRadius: BorderRadius.circular(6)),
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
