import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/db/outbox_dao.dart';
import '../../core/l10n/l10n.dart';
import '../../core/models/pending_action.dart';
import '../../core/providers/auth_notifier.dart';
import '../../core/services/connectivity_service.dart';
import '../../core/services/offline_queue.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatting.dart';
import '../../core/utils/responsive.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_top_bar.dart';
import '../../shared/widgets/confirm_sheet.dart';
import '../../shared/widgets/empty_state.dart';
import '../../shared/widgets/responsive_sheet.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/status_chip.dart';
import '../../shared/widgets/surface_card.dart';

// ═════════════════════════════════════════════════════════════════════════════
//  SYNC CENTER — the shell's "Sync" tab (route /pending-orders).
//
//  Surfaces the offline outbox: what's queued, what's syncing, what's stuck,
//  what's waiting on a prerequisite, and what belongs to another session.
// ═════════════════════════════════════════════════════════════════════════════

class PendingOrdersScreen extends ConsumerWidget {
  const PendingOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = l10n(context);
    final queue = ref.watch(offlineQueueProvider);
    final isOnline = ref.watch(isOnlineProvider);
    final currentUserId = ref.watch(authProvider.select((a) => a.user?.id));

    // ── Partition entries ──────────────────────────────────────────────────
    final mine = <OutboxEntry>[];
    final others = <OutboxEntry>[];
    for (final e in queue.entries) {
      final isMine =
          e.userId == null || currentUserId == null || e.userId == currentUserId;
      (isMine ? mine : others).add(e);
    }
    final stuck = mine.where((e) => e.status == 'dead').toList();
    final active = mine.where((e) => e.status != 'dead').toList();

    final allSynced = queue.entries.isEmpty;
    final paused = queue.authPaused && queue.entries.isNotEmpty;

    final subtitle = allSynced
        ? s.allSynced
        : paused
            ? s.syncPausedSubtitle
            : !isOnline
                ? s.syncOfflineQueued(queue.totalCount)
                : queue.isSyncing
                    ? s.syncSyncing
                    : queue.totalCount == 0 && queue.hasStuck
                        ? s.syncNeedAttention(queue.stuckCount)
                        : s.syncWaitingCount(queue.totalCount);

    Future<void> syncNow() =>
        ref.read(offlineQueueProvider.notifier).syncAll();

    final hPad = context.responsive(phone: AppSpace.lg, tablet: AppSpace.xl);

    return Scaffold(
      backgroundColor: context.tokens.bg,
      appBar: AppTopBar(title: s.syncCenterTitle, subtitle: subtitle),
      body: RefreshIndicator(
        onRefresh: syncNow,
        child: LayoutBuilder(builder: (context, constraints) {
          if (allSynced) {
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: constraints.maxHeight,
                  child: EmptyState(
                    icon: Icons.cloud_done_rounded,
                    title: s.allSynced,
                    body: s.syncAllSyncedBody,
                  ),
                ),
              ],
            );
          }

          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: hPad, vertical: AppSpace.lg),
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 760),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _SyncSummaryCard(
                        queue: queue,
                        isOnline: isOnline,
                        paused: paused,
                        onSyncNow: syncNow,
                      ),
                      const SizedBox(height: AppSpace.md),
                      _TypeBreakdown(queue: queue),
                      if (stuck.isNotEmpty) ...[
                        SectionHeader(title: s.syncNeedsAttentionHeader),
                        _EntryGroupCard(
                          entries: stuck,
                          allEntries: queue.entries,
                        ),
                      ],
                      if (active.isNotEmpty) ...[
                        SectionHeader(title: s.syncWaitingHeader),
                        _EntryGroupCard(
                          entries: active,
                          allEntries: queue.entries,
                        ),
                      ],
                      if (others.isNotEmpty) ...[
                        const SizedBox(height: AppSpace.lg),
                        _OtherSessionGroup(
                          entries: others,
                          allEntries: queue.entries,
                        ),
                      ],
                      const SizedBox(height: AppSpace.xxl),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SUMMARY CARD — one glanceable state: paused / offline / syncing / waiting.
// ─────────────────────────────────────────────────────────────────────────────

class _SyncSummaryCard extends StatelessWidget {
  final OfflineQueueState queue;
  final bool isOnline;
  final bool paused;
  final Future<void> Function() onSyncNow;

  const _SyncSummaryCard({
    required this.queue,
    required this.isOnline,
    required this.paused,
    required this.onSyncNow,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = l10n(context);
    final count = queue.totalCount;

    final (IconData icon, Color fg, Color bg, String title, String body) =
        switch ((paused, isOnline, queue.isSyncing)) {
      (true, _, _) => (
          Icons.lock_clock_rounded,
          t.warning,
          t.warningBg,
          s.syncPausedTitle,
          s.syncPausedBody(count),
        ),
      (false, false, _) => (
          Icons.wifi_off_rounded,
          t.warning,
          t.warningBg,
          s.commonOffline,
          s.syncOfflineBody(count),
        ),
      (false, true, true) => (
          Icons.sync_rounded,
          t.navy,
          t.navyBg,
          s.syncSyncing,
          s.syncSyncingBody(count),
        ),
      (false, true, false) when count == 0 && queue.hasStuck => (
          Icons.error_outline_rounded,
          t.danger,
          t.dangerBg,
          s.syncStuckTitle(queue.stuckCount),
          s.syncStuckBody,
        ),
      (false, true, false) => (
          Icons.schedule_rounded,
          t.accent,
          t.accentBg,
          s.syncWaitingTitle,
          s.syncWaitingBody(count),
        ),
    };

    final showSyncNow = !paused;

    return SurfaceCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
            child: queue.isSyncing && !paused
                ? _Spinning(child: Icon(icon, size: 20, color: fg))
                : Icon(icon, size: 20, color: fg),
          ),
          const SizedBox(width: AppSpace.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: ui(size: 15, weight: FontWeight.w700, color: fg)),
                const SizedBox(height: 2),
                Text(body,
                    style: ui(size: 13, color: t.textSecondary, height: 1.45)),
              ],
            ),
          ),
        ]),
        if (showSyncNow) ...[
          const SizedBox(height: AppSpace.lg),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: AppButton(
              label: s.syncNow,
              icon: Icons.sync_rounded,
              width: 160,
              height: 44,
              loading: queue.isSyncing,
              onTap: isOnline ? onSyncNow : null,
            ),
          ),
        ],
      ]),
    );
  }
}

class _Spinning extends StatefulWidget {
  final Widget child;
  const _Spinning({required this.child});

  @override
  State<_Spinning> createState() => _SpinningState();
}

class _SpinningState extends State<_Spinning>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1200))
    ..repeat();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      RotationTransition(turns: _ctrl, child: widget.child);
}

// ─────────────────────────────────────────────────────────────────────────────
//  TYPE BREAKDOWN CHIPS
// ─────────────────────────────────────────────────────────────────────────────

class _TypeBreakdown extends StatelessWidget {
  final OfflineQueueState queue;
  const _TypeBreakdown({required this.queue});

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    final chips = <Widget>[
      if (queue.orderCount > 0)
        StatusChip(
            label: s.commonOrdersCount(queue.orderCount),
            tone: ChipTone.success,
            icon: Icons.receipt_long_rounded),
      if (queue.shiftOpenCount > 0)
        StatusChip(
            label: s.syncShiftOpenChip(queue.shiftOpenCount),
            tone: ChipTone.info,
            icon: Icons.play_arrow_rounded),
      if (queue.shiftCloseCount > 0)
        StatusChip(
            label: s.syncShiftCloseChip(queue.shiftCloseCount),
            tone: ChipTone.warning,
            icon: Icons.lock_outline_rounded),
      if (queue.voidCount > 0)
        StatusChip(
            label: s.syncVoidsChip(queue.voidCount),
            tone: ChipTone.danger,
            icon: Icons.cancel_outlined),
      if (queue.cashCount > 0)
        StatusChip(
            label: s.syncCashChip(queue.cashCount),
            tone: ChipTone.neutral,
            icon: Icons.payments_outlined),
      if (queue.hasStuck)
        StatusChip(
            label: s.syncStuckChip(queue.stuckCount),
            tone: ChipTone.danger,
            icon: Icons.error_outline_rounded),
    ];
    if (chips.isEmpty) return const SizedBox.shrink();
    return Wrap(spacing: AppSpace.sm, runSpacing: AppSpace.sm, children: chips);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  ENTRY GROUPS
// ─────────────────────────────────────────────────────────────────────────────

class _EntryGroupCard extends ConsumerWidget {
  final List<OutboxEntry> entries;
  final List<OutboxEntry> allEntries;

  const _EntryGroupCard({required this.entries, required this.allEntries});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    return SurfaceCard(
      padding: EdgeInsets.zero,
      child: Column(children: [
        for (final (i, entry) in entries.indexed) ...[
          if (i > 0) Divider(height: 1, color: t.borderLight),
          _EntryRow(entry: entry, allEntries: allEntries),
        ],
      ]),
    );
  }
}

/// Whether the "from another session" group is expanded. autoDispose:
/// collapses again once the screen is closed.
final _otherSessionExpandedProvider =
    StateProvider.autoDispose<bool>((_) => false);

/// Collapsed group for entries enqueued under a different account. The queue
/// only drains entries belonging to the signed-in user, so these wait for
/// their owner to sign in on this device.
class _OtherSessionGroup extends ConsumerWidget {
  final List<OutboxEntry> entries;
  final List<OutboxEntry> allEntries;

  const _OtherSessionGroup({required this.entries, required this.allEntries});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final s = l10n(context);
    final n = entries.length;
    final expanded = ref.watch(_otherSessionExpandedProvider);

    return SurfaceCard(
      padding: EdgeInsets.zero,
      child: Column(children: [
        AnimatedPressScale(
          scaleDown: 0.99,
          onTap: () => ref
              .read(_otherSessionExpandedProvider.notifier)
              .update((v) => !v),
          child: Padding(
            padding: const EdgeInsets.all(AppSpace.lg),
            child: Row(children: [
              Container(
                width: 38,
                height: 38,
                decoration:
                    BoxDecoration(color: t.navyBg, shape: BoxShape.circle),
                child: Icon(Icons.person_outline_rounded,
                    size: 18, color: t.navy),
              ),
              const SizedBox(width: AppSpace.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.syncFromAnotherSession,
                        style: ui(size: 14, weight: FontWeight.w600,
                            color: t.textPrimary)),
                    const SizedBox(height: 2),
                    Text(s.syncOtherSessionBody(n),
                        style: ui(size: 12, color: t.textSecondary)),
                  ],
                ),
              ),
              Icon(
                  expanded
                      ? Icons.expand_less_rounded
                      : Icons.expand_more_rounded,
                  size: 20,
                  color: t.textMuted),
            ]),
          ),
        ),
        if (expanded) ...[
          Divider(height: 1, color: t.borderLight),
          for (final (i, entry) in entries.indexed) ...[
            if (i > 0) Divider(height: 1, color: t.borderLight),
            _EntryRow(entry: entry, allEntries: allEntries),
          ],
        ],
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  ENTRY ROW
// ─────────────────────────────────────────────────────────────────────────────

class _EntryRow extends ConsumerWidget {
  final OutboxEntry entry;
  final List<OutboxEntry> allEntries;

  const _EntryRow({required this.entry, required this.allEntries});

  bool get _isStuck => entry.status == 'dead';
  bool get _isInFlight => entry.status == 'in_flight';
  bool get _isOrder => entry.type == PendingActionType.order.name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final s = l10n(context);
    final meta = _typeMeta(s, entry.type);
    final (toneBg, toneFg) = _toneColors(t, _isStuck ? ChipTone.danger : meta.tone);

    final payload = _safePayload();
    final title = _title(s, payload, meta.label);
    final detail = _detailLine(s, payload);
    final orderTotal = _isOrder && payload != null ? _orderTotal(payload) : null;
    final dependency = _dependencyNote(s);

    return AnimatedPressScale(
      scaleDown: 0.99,
      onTap: _isOrder && payload != null
          ? () => _showOrderDetails(context, payload)
          : null,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpace.lg, AppSpace.md, AppSpace.md, AppSpace.md),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                  color: toneBg,
                  borderRadius: BorderRadius.circular(AppRadius.xs)),
              alignment: Alignment.center,
              child: Icon(_isStuck ? Icons.error_outline_rounded : meta.icon,
                  size: 18, color: toneFg),
            ),
            const SizedBox(width: AppSpace.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Expanded(
                      child: Text(title,
                          style: ui(size: 14, weight: FontWeight.w600,
                              color: t.textPrimary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ),
                    if (_isInFlight)
                      StatusChip(
                          label: s.syncSyncingChip,
                          tone: ChipTone.info,
                          icon: Icons.sync_rounded,
                          spinning: true),
                  ]),
                  const SizedBox(height: 2),
                  Text(
                      [
                        if (detail.isNotEmpty) detail,
                        _relTime(s, entry.createdAt),
                      ].join(' · '),
                      style: ui(size: 12, color: t.textSecondary)),
                  if (dependency != null) ...[
                    const SizedBox(height: AppSpace.xs),
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.hourglass_top_rounded,
                          size: 12, color: t.textMuted),
                      const SizedBox(width: AppSpace.xs),
                      Flexible(
                        child: Text(dependency,
                            style: ui(size: 11.5, color: t.textMuted)),
                      ),
                    ]),
                  ],
                  if (!_isStuck && entry.retryCount > 0) ...[
                    const SizedBox(height: AppSpace.xs),
                    Text(s.syncFailedAttempts(entry.retryCount),
                        style: ui(size: 11.5, color: t.warning)),
                  ],
                  if (_isStuck) ...[
                    const SizedBox(height: AppSpace.xs),
                    Text(entry.lastError ?? s.syncStoppedAfterFailures,
                        style: ui(size: 12, weight: FontWeight.w600,
                            color: t.danger, height: 1.4)),
                  ],
                ],
              ),
            ),
            if (orderTotal != null) ...[
              const SizedBox(width: AppSpace.sm),
              Text(egp(orderTotal),
                  style: money(size: 14, color: t.textPrimary)),
            ],
            if (!_isStuck)
              IconButton(
                onPressed: () => _confirmDiscard(context, ref),
                tooltip: s.discardAction,
                icon: Icon(Icons.delete_outline_rounded,
                    size: 18, color: t.textMuted),
                visualDensity: VisualDensity.compact,
              ),
          ]),
          if (_isStuck)
            Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 50, top: AppSpace.sm),
              child: Row(children: [
                StatusChip(
                  label: s.retryAction,
                  tone: ChipTone.info,
                  icon: Icons.refresh_rounded,
                  onTap: () => ref
                      .read(offlineQueueProvider.notifier)
                      .resetRetry(entry.localId),
                ),
                const SizedBox(width: AppSpace.sm),
                StatusChip(
                  label: s.discardAction,
                  tone: ChipTone.danger,
                  icon: Icons.delete_outline_rounded,
                  onTap: () => _confirmDiscard(context, ref),
                ),
              ]),
            ),
        ]),
      ),
    );
  }

  // ── Actions ───────────────────────────────────────────────────────────────

  Future<void> _confirmDiscard(BuildContext context, WidgetRef ref) async {
    final s = l10n(context);
    final meta = _typeMeta(s, entry.type);
    final confirmed = await ConfirmSheet.show(
      context,
      title: s.syncDiscardConfirmTitle(meta.label.toLowerCase()),
      body: s.syncDiscardConfirmBody,
      confirmLabel: s.discardAction,
      destructive: true,
      icon: Icons.delete_outline_rounded,
    );
    if (!confirmed) return;
    HapticFeedback.mediumImpact();
    await ref.read(offlineQueueProvider.notifier).discard(entry.localId);
  }

  // ── Derived display data ──────────────────────────────────────────────────

  Map<String, dynamic>? _safePayload() {
    try {
      return entry.payloadMap;
    } catch (_) {
      return null;
    }
  }

  String _title(
      AppLocalizations s, Map<String, dynamic>? payload, String typeLabel) {
    if (_isOrder) {
      final name = (payload?['customer_name'] as String?)?.trim();
      return (name == null || name.isEmpty) ? s.syncWalkIn : name;
    }
    return typeLabel;
  }

  String _detailLine(AppLocalizations s, Map<String, dynamic>? p) {
    if (p == null) return '';
    try {
      switch (PendingActionType.values.asNameMap()[entry.type]) {
        case PendingActionType.order:
          final n = (p['items'] as List?)?.length ?? 0;
          return s.commonItemsCount(n);
        case PendingActionType.shiftOpen:
          return s.syncOpeningCashDetail(egp((p['opening_cash'] as int?) ?? 0));
        case PendingActionType.shiftClose:
          return s.syncClosingCashDetail(egp((p['closing_cash'] as int?) ?? 0));
        case PendingActionType.voidOrder:
          final reason =
              ((p['reason'] as String?) ?? '').replaceAll('_', ' ').trim();
          return reason.isEmpty ? s.orderVoid : s.syncReason(reason);
        case PendingActionType.cashMovement:
          final amt = (p['amount'] as int?) ?? 0;
          return '${amt >= 0 ? s.cashIn : s.cashOut} ${egp(amt.abs())}';
        default:
          return '';
      }
    } catch (_) {
      return '';
    }
  }

  /// "Waiting for: <type>" when this entry's prerequisite is still in the
  /// queue; shift closes additionally wait for every order/void.
  String? _dependencyNote(AppLocalizations s) {
    if (_isStuck) return null;
    if (entry.dependsOn != null) {
      for (final other in allEntries) {
        if (other.localId == entry.dependsOn) {
          return s.syncWaitingFor(_typeMeta(s, other.type).label);
        }
      }
    }
    if (entry.type == PendingActionType.shiftClose.name) {
      final hasLiveSales = allEntries.any((e) =>
          e.localId != entry.localId &&
          (e.type == PendingActionType.order.name ||
              e.type == PendingActionType.voidOrder.name) &&
          (e.status == 'pending' || e.status == 'in_flight'));
      if (hasLiveSales) return s.syncAfterAllOrders;
    }
    return null;
  }

  // ── Order details sheet ───────────────────────────────────────────────────

  void _showOrderDetails(BuildContext context, Map<String, dynamic> payload) {
    try {
      final order = PendingOrder.fromJson(payload);
      ResponsiveSheet.show(
        context: context,
        builder: (_) => _PendingOrderSheet(order: order),
      );
    } catch (_) {/* malformed payload — nothing to show */}
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  PENDING ORDER DETAILS SHEET
// ─────────────────────────────────────────────────────────────────────────────

class _PendingOrderSheet extends StatelessWidget {
  final PendingOrder order;
  const _PendingOrderSheet({required this.order});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final subtotal = order.items.fold<int>(0, (s, i) => s + i.lineTotal);
    final discount =
        _calcDiscount(order.discountType, order.discountValue, subtotal);
    final total = subtotal - discount;
    final customer = (order.customerName ?? '').trim();
    final bottomPad = MediaQuery.viewPaddingOf(context).bottom;

    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.8),
      child: Container(
        decoration: BoxDecoration(
            color: t.surfaceRaised, borderRadius: AppRadius.sheetRadius),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.only(top: AppSpace.md),
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                  color: t.border, borderRadius: BorderRadius.circular(2)),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpace.xl, AppSpace.md, AppSpace.sm, AppSpace.md),
            child: Row(children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n(context).syncPendingOrder,
                        style: Theme.of(context).textTheme.titleLarge),
                    if (customer.isNotEmpty)
                      Text(customer,
                          style: ui(size: 12, color: t.textSecondary)),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.close_rounded, size: 20, color: t.textPrimary),
                onPressed: () => Navigator.pop(context),
              ),
            ]),
          ),
          Divider(height: 1, color: t.border),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(AppSpace.lg),
              itemCount: order.items.length,
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: t.borderLight),
              itemBuilder: (_, i) {
                final item = order.items[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpace.sm + 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                            color: t.navyBg,
                            borderRadius: BorderRadius.circular(6)),
                        alignment: Alignment.center,
                        child: Text('${item.quantity}',
                            style: ui(size: 12, weight: FontWeight.w700,
                                color: t.navy)),
                      ),
                      const SizedBox(width: AppSpace.sm + 2),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.itemName,
                                style: ui(size: 14, weight: FontWeight.w600,
                                    color: t.textPrimary)),
                            if (item.sizeLabel != null)
                              Text(item.sizeLabel!,
                                  style:
                                      ui(size: 12, color: t.textSecondary)),
                          ],
                        ),
                      ),
                      Text(egp(item.lineTotal),
                          style: money(size: 14, color: t.textPrimary)),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(
                AppSpace.xl, AppSpace.md, AppSpace.xl, AppSpace.xl + bottomPad),
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: t.border))),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(l10n(context).orderSubtotal,
                    style: ui(size: 14, color: t.textSecondary)),
                Text(egp(subtotal),
                    style: money(size: 14, weight: FontWeight.w600,
                        color: t.textPrimary)),
              ]),
              if (discount > 0) ...[
                const SizedBox(height: AppSpace.xs + 2),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(l10n(context).orderDiscount,
                          style: ui(size: 14, color: t.success)),
                      Text('- ${egp(discount)}',
                          style: money(size: 14, weight: FontWeight.w600,
                              color: t.success)),
                    ]),
              ],
              const SizedBox(height: AppSpace.sm + 2),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(l10n(context).orderTotal,
                    style: ui(size: 16, weight: FontWeight.w700,
                        color: t.textPrimary)),
                Text(egp(total),
                    style: money(size: 17, weight: FontWeight.w800,
                        color: t.accent)),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  HELPERS
// ─────────────────────────────────────────────────────────────────────────────

typedef _TypeMeta = ({IconData icon, String label, ChipTone tone});

_TypeMeta _typeMeta(AppLocalizations s, String type) =>
    switch (PendingActionType.values.asNameMap()[type]) {
      PendingActionType.shiftOpen => (
          icon: Icons.play_arrow_rounded,
          label: s.shiftOpen,
          tone: ChipTone.info
        ),
      PendingActionType.order => (
          icon: Icons.receipt_long_rounded,
          label: s.syncTypeOrder,
          tone: ChipTone.success
        ),
      PendingActionType.shiftClose => (
          icon: Icons.lock_outline_rounded,
          label: s.shiftClose,
          tone: ChipTone.warning
        ),
      PendingActionType.voidOrder => (
          icon: Icons.cancel_outlined,
          label: s.syncTypeVoidOrder,
          tone: ChipTone.danger
        ),
      PendingActionType.cashMovement => (
          icon: Icons.payments_outlined,
          label: s.syncTypeCashMovement,
          tone: ChipTone.success
        ),
      null => (
          icon: Icons.help_outline_rounded,
          label: s.syncTypeUnknown,
          tone: ChipTone.neutral
        ),
    };

(Color, Color) _toneColors(AppTokens t, ChipTone tone) => switch (tone) {
      ChipTone.neutral => (t.surfaceAlt, t.textSecondary),
      ChipTone.accent => (t.accentBg, t.accent),
      ChipTone.success => (t.successBg, t.success),
      ChipTone.danger => (t.dangerBg, t.danger),
      ChipTone.warning => (t.warningBg, t.warning),
      ChipTone.info => (t.navyBg, t.navy),
    };

/// Sum of `line_total` across the order payload's items; null when the
/// payload doesn't carry a usable items list.
int? _orderTotal(Map<String, dynamic> payload) {
  try {
    final items = payload['items'] as List?;
    if (items == null || items.isEmpty) return null;
    var sum = 0;
    for (final item in items) {
      final lt = (item as Map)['line_total'];
      if (lt is int) {
        sum += lt;
      } else if (lt is num) {
        sum += lt.round();
      }
    }
    return sum;
  } catch (_) {
    return null;
  }
}

int _calcDiscount(String? type, int? value, int subtotal) {
  if (type == null || (value ?? 0) == 0) return 0;
  if (type == 'percentage') return (subtotal * value! / 100).round();
  return value!.clamp(0, subtotal);
}

String _relTime(AppLocalizations s, int epochMs) {
  final dt = DateTime.fromMillisecondsSinceEpoch(epochMs);
  final diff = DateTime.now().difference(dt);
  if (diff.inMinutes < 1) return s.syncJustNow;
  if (diff.inMinutes < 60) return s.syncMinutesAgo(diff.inMinutes);
  if (diff.inHours < 24) return s.syncHoursAgo(diff.inHours);
  if (diff.inDays < 7) return s.syncDaysAgo(diff.inDays);
  return dateShort(dt);
}
