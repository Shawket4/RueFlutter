import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/db/outbox_dao.dart';
import '../../core/models/cart.dart';
import '../../core/models/pending_action.dart';
import '../../core/services/offline_queue.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatting.dart';

class PendingOrdersScreen extends ConsumerWidget {
  const PendingOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queue = ref.watch(offlineQueueProvider);

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
                width: 36, height: 36,
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
            Text('Pending Sync',
                style: cairo(fontSize: 17, fontWeight: FontWeight.w700)),
            const Spacer(),
            if (queue.isSyncing)
              const Padding(
                padding: EdgeInsets.all(8),
                child: SizedBox(
                    width: 18, height: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: AppColors.primary)),
              )
            else
              GestureDetector(
                onTap: () =>
                    ref.read(offlineQueueProvider.notifier).syncAll(),
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                      color: AppColors.bg,
                      borderRadius: BorderRadius.circular(AppRadius.xs),
                      border: Border.all(color: AppColors.border)),
                  alignment: Alignment.center,
                  child: const Icon(Icons.sync_rounded,
                      size: 18, color: AppColors.textSecondary),
                ),
              ),
          ]),
        ),
        Container(height: 1, color: AppColors.border),

        // ── Body ─────────────────────────────────────────────────────────
        Expanded(
          child: queue.isEmpty
              ? Center(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.check_circle_outline_rounded,
                      size: 48, color: AppColors.success.withOpacity(0.5)),
                  const SizedBox(height: 14),
                  Text('All synced',
                      style: cairo(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary)),
                ]))
              : Column(children: [
                  // Stats
                  Container(
                    color: AppColors.bg,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Row(children: [
                      if (queue.shiftOpenCount > 0)
                        _Chip('${queue.shiftOpenCount} shift open',
                            AppColors.primary),
                      if (queue.orderCount > 0) ...[
                        if (queue.shiftOpenCount > 0)
                          const SizedBox(width: 8),
                        _Chip(
                            '${queue.orderCount} orders', AppColors.success),
                      ],
                      if (queue.shiftCloseCount > 0) ...[
                        const SizedBox(width: 8),
                        _Chip('${queue.shiftCloseCount} shift close',
                            AppColors.warning),
                      ],
                      if (queue.voidCount > 0) ...[
                        const SizedBox(width: 8),
                        _Chip('${queue.voidCount} voids', AppColors.danger),
                      ],
                      if (queue.cashCount > 0) ...[
                        const SizedBox(width: 8),
                        _Chip('${queue.cashCount} cash', AppColors.success),
                      ],
                      if (queue.hasStuck) ...[
                        const SizedBox(width: 8),
                        _Chip('${queue.stuckCount} stuck', AppColors.danger),
                      ],
                    ]),
                  ),
                  Container(height: 1, color: AppColors.border),

                  // List
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: queue.entries.length,
                      itemBuilder: (_, i) {
                        final entry = queue.entries[i];
                        final isStuck = entry.status == 'dead';
                        return _EntryRow(
                          entry: entry,
                          isStuck: isStuck,
                          onDiscard: () => ref
                              .read(offlineQueueProvider.notifier)
                              .discard(entry.localId),
                          onRetry: isStuck
                              ? () => ref
                                  .read(offlineQueueProvider.notifier)
                                  .resetRetry(entry.localId)
                              : null,
                        );
                      },
                    ),
                  ),
                ]),
        ),
      ]),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color color;
  const _Chip(this.label, this.color);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(6)),
        child: Text(label,
            style: cairo(
                fontSize: 12, fontWeight: FontWeight.w700, color: color)),
      );
}

class _EntryRow extends StatelessWidget {
  final OutboxEntry entry;
  final bool isStuck;
  final VoidCallback onDiscard;
  final VoidCallback? onRetry;

  const _EntryRow({
    required this.entry,
    required this.isStuck,
    required this.onDiscard,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final typeEnum = PendingActionType.values.asNameMap()[entry.type];
    final (icon, label, color) = switch (typeEnum) {
      PendingActionType.shiftOpen    => (Icons.play_arrow_rounded,    'Open Shift',    AppColors.primary),
      PendingActionType.order        => (Icons.receipt_rounded,        'Order',         AppColors.success),
      PendingActionType.shiftClose   => (Icons.lock_outline_rounded,   'Close Shift',   AppColors.warning),
      PendingActionType.voidOrder    => (Icons.cancel_outlined,        'Void Order',    AppColors.danger),
      PendingActionType.cashMovement => (Icons.payments_outlined,      'Cash Movement', AppColors.success),
      null                           => (Icons.help_outline_rounded,   'Unknown',       AppColors.textMuted),
    };

    final subtitle = _subtitle();

    return GestureDetector(
      onTap: typeEnum == PendingActionType.order
          ? () => _showOrderDetails(context, entry.payloadMap)
          : null,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: isStuck ? AppColors.danger.withOpacity(0.02) : Colors.white,
          border: const Border(
              bottom: BorderSide(color: AppColors.borderLight)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Icon
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(
                color: color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: Icon(icon, size: 17, color: color),
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Row(children: [
                  Text(label,
                      style: cairo(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                  if (isStuck) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                          color: AppColors.danger.withOpacity(0.09),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text('STUCK',
                          style: cairo(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: AppColors.danger)),
                    ),
                  ],
                ]),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: cairo(
                          fontSize: 13, color: AppColors.textSecondary)),
                ],
                const SizedBox(height: 2),
                Text(
                    dateTime(DateTime.fromMillisecondsSinceEpoch(
                        entry.createdAt)),
                    style:
                        cairo(fontSize: 12, color: AppColors.textMuted)),
                if (entry.lastError != null) ...[
                  const SizedBox(height: 4),
                  Text('Error: ${entry.lastError}',
                      style: cairo(
                          fontSize: 12,
                          color: AppColors.danger,
                          fontWeight: FontWeight.w500)),
                ],
                if (isStuck)
                  Text(
                      'Failed ${entry.retryCount}× — tap Retry',
                      style: cairo(
                          fontSize: 12, color: AppColors.danger))
                else if (entry.retryCount > 0)
                  Text('${entry.retryCount} failed attempt(s)',
                      style: cairo(
                          fontSize: 12, color: AppColors.warning)),
              ])),

          // Actions
          Row(mainAxisSize: MainAxisSize.min, children: [
            if (onRetry != null)
              GestureDetector(
                onTap: onRetry,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.07),
                      borderRadius: BorderRadius.circular(6)),
                  child: Text('Retry',
                      style: cairo(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            const SizedBox(width: 6),
            GestureDetector(
              onTap: () => _confirmDiscard(context),
              child: Container(
                width: 32, height: 32,
                decoration: BoxDecoration(
                    color: AppColors.danger.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(6)),
                alignment: Alignment.center,
                child: const Icon(Icons.delete_outline_rounded,
                    size: 16, color: AppColors.danger),
              ),
            ),
          ]),
        ]),
      ),
    );
  }

  void _showOrderDetails(
      BuildContext context, Map<String, dynamic> payload) {
    try {
      final orderAction = PendingOrder.fromJson(payload);
      final subtotal = orderAction.items
          .fold<int>(0, (s, i) => s + i.lineTotal);
      final discountAmount = _calcDiscount(
          orderAction.discountType, orderAction.discountValue, subtotal);
      final total = subtotal - discountAmount;

      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8),
        builder: (_) => Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: AppRadius.sheetRadius),
          child: Column(children: [
            // Handle
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Center(
                  child: Container(
                      width: 36, height: 4,
                      decoration: BoxDecoration(
                          color: AppColors.border,
                          borderRadius: BorderRadius.circular(2)))),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 8, 14),
              child: Row(children: [
                Text('Pending Order',
                    style:
                        cairo(fontSize: 17, fontWeight: FontWeight.w700)),
                const Spacer(),
                IconButton(
                    icon: const Icon(Icons.close_rounded, size: 20),
                    onPressed: () => Navigator.pop(context)),
              ]),
            ),
            Container(height: 1, color: AppColors.border),
            // Items
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: orderAction.items.length,
                separatorBuilder: (_, __) => const Divider(
                    height: 1, color: AppColors.borderLight),
                itemBuilder: (_, i) {
                  final item = orderAction.items[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 26, height: 26,
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
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(item.itemName,
                                    style: cairo(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14)),
                                if (item.sizeLabel != null)
                                  Text(item.sizeLabel!,
                                      style: cairo(
                                          fontSize: 12,
                                          color:
                                              AppColors.textSecondary)),
                              ]),
                        ),
                        Text(egp(item.lineTotal),
                            style: cairo(
                                fontWeight: FontWeight.w700,
                                fontSize: 14)),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Totals
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(color: AppColors.border))),
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal',
                          style: cairo(
                              fontSize: 14,
                              color: AppColors.textSecondary)),
                      Text(egp(subtotal),
                          style: cairo(
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                    ]),
                if (discountAmount > 0) ...[
                  const SizedBox(height: 6),
                  Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Discount',
                            style: cairo(
                                fontSize: 14,
                                color: AppColors.success)),
                        Text('- ${egp(discountAmount)}',
                            style: cairo(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.success)),
                      ]),
                ],
                const SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total',
                          style: cairo(
                              fontSize: 17,
                              fontWeight: FontWeight.w800)),
                      Text(egp(total),
                          style: cairo(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary)),
                    ]),
              ]),
            ),
          ]),
        ),
      );
    } catch (_) {}
  }

  int _calcDiscount(String? type, int? val, int subtotal) {
    if (type == null || (val ?? 0) == 0) return 0;
    if (type == 'percentage') return (subtotal * val! / 100).round();
    return val!.clamp(0, subtotal);
  }

  String _subtitle() {
    try {
      final p = entry.payloadMap;
      final typeEnum =
          PendingActionType.values.asNameMap()[entry.type];
      switch (typeEnum) {
        case PendingActionType.order:
          final itemsList = p['items'] as List? ?? [];
          final items = itemsList
              .map((i) =>
                  CartItem.fromStorageJson(i as Map<String, dynamic>))
              .toList();
          final subtotal =
              items.fold<int>(0, (s, i) => s + i.lineTotal);
          final discountType = p['discount_type'] as String?;
          final discountVal = p['discount_value'] as int?;
          final discountAmt =
              _calcDiscount(discountType, discountVal, subtotal);
          final total = subtotal - discountAmt;
          return '${items.length} item(s) · ${egp(total)}';
        case PendingActionType.shiftOpen:
          return 'Opening cash: ${egp((p['opening_cash'] as int?) ?? 0)}';
        case PendingActionType.shiftClose:
          return 'Closing cash: ${egp((p['closing_cash'] as int?) ?? 0)}';
        case PendingActionType.voidOrder:
          return 'Reason: ${((p['reason'] as String?) ?? '').replaceAll('_', ' ')}';
        case PendingActionType.cashMovement:
          final amt = (p['amount'] as int?) ?? 0;
          return '${amt > 0 ? 'Cash In' : 'Cash Out'}: ${egp(amt.abs())}';
        default:
          return '';
      }
    } catch (_) {
      return '';
    }
  }

  void _confirmDiscard(BuildContext context) => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.sm)),
          title:
              Text('Discard?', style: cairo(fontWeight: FontWeight.w800)),
          content: Text(
              'This action will be permanently removed from the queue.',
              style: cairo(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.5)),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text('Cancel',
                    style: cairo(color: AppColors.textSecondary))),
            TextButton(
              onPressed: () {
                HapticFeedback.mediumImpact();
                Navigator.pop(ctx);
                onDiscard();
              },
              child: Text('Discard',
                  style: cairo(
                      color: AppColors.danger,
                      fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      );
}
