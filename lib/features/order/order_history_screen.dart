import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/api/shift_api.dart';
import '../../core/l10n/l10n.dart';
import '../../core/models/order.dart';
import '../../core/models/shift_report.dart';
import '../../core/providers/order_history_notifier.dart';
import '../../core/providers/payment_method_notifier.dart';
import '../../core/providers/shift_notifier.dart';
import '../../core/repositories/order_repository.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatting.dart';
import '../../shared/widgets/app_top_bar.dart';
import '../../shared/widgets/empty_state.dart';
import '../../shared/widgets/offline_banner.dart';
import '../../shared/widgets/refresh_button.dart';
import '../../shared/widgets/status_chip.dart';
import '../../shared/widgets/surface_card.dart';
import '../../shared/widgets/sync_status_chip.dart';
import 'helpers/payment_helpers.dart';
import 'void_order_sheet.dart';
import 'widgets/order_ingredients_sheet.dart';
import 'widgets/receipt_preview_sheet.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  SORT + FILTER
// ─────────────────────────────────────────────────────────────────────────────

enum _Col { number, payment, time, teller, amount }

enum _SyncFilter { all, synced, pending, voided }

extension on _SyncFilter {
  String label(AppLocalizations s) => switch (this) {
        _SyncFilter.all => s.orderFilterAll,
        _SyncFilter.synced => s.orderFilterSynced,
        _SyncFilter.pending => s.commonPendingSync,
        _SyncFilter.voided => s.commonVoided,
      };

  IconData get icon => switch (this) {
        _SyncFilter.all => Icons.list_alt_rounded,
        _SyncFilter.synced => Icons.cloud_done_rounded,
        _SyncFilter.pending => Icons.cloud_upload_rounded,
        _SyncFilter.voided => Icons.cancel_outlined,
      };

  ChipTone get activeTone => switch (this) {
        _SyncFilter.all => ChipTone.accent,
        _SyncFilter.synced => ChipTone.success,
        _SyncFilter.pending => ChipTone.warning,
        _SyncFilter.voided => ChipTone.danger,
      };
}

/// Below this body width the table collapses into cards.
const double _kTableBreakpoint = 680;

/// How many orders the list renders at once. The full shift is always held in
/// memory (so offline + not-yet-synced orders stay visible and the stats/filter
/// counts cover everything) — this only caps how many rows paint, with a
/// "show more" footer to reveal the next chunk.
const int _kOrderPageSize = 20;

// ─────────────────────────────────────────────────────────────────────────────
//  EPHEMERAL VIEW STATE — sort · filter · row expansion · shift report
//
//  autoDispose: pinned by the screen (see build), so it lives exactly as long
//  as the screen and resets when it is closed — same as the old State fields.
// ─────────────────────────────────────────────────────────────────────────────

@immutable
class _ViewState {
  final _Col sortCol;
  final bool sortAsc;
  final _SyncFilter filter;
  final String? expandedId;
  final Order? expandedOrder;
  final bool loadingDetail;
  final ShiftReport? report;
  final int visibleLimit;

  const _ViewState({
    this.sortCol = _Col.number,
    this.sortAsc = false,
    this.filter = _SyncFilter.all,
    this.expandedId,
    this.expandedOrder,
    this.loadingDetail = false,
    this.report,
    this.visibleLimit = _kOrderPageSize,
  });

  _ViewState copyWith({
    _Col? sortCol,
    bool? sortAsc,
    _SyncFilter? filter,
    String? expandedId,
    Order? expandedOrder,
    bool? loadingDetail,
    ShiftReport? report,
    int? visibleLimit,
    bool clearExpansion = false,
  }) =>
      _ViewState(
        sortCol: sortCol ?? this.sortCol,
        sortAsc: sortAsc ?? this.sortAsc,
        filter: filter ?? this.filter,
        expandedId: clearExpansion ? null : (expandedId ?? this.expandedId),
        expandedOrder:
            clearExpansion ? null : (expandedOrder ?? this.expandedOrder),
        loadingDetail: loadingDetail ?? this.loadingDetail,
        report: report ?? this.report,
        visibleLimit: visibleLimit ?? this.visibleLimit,
      );
}

class _ViewNotifier extends AutoDisposeNotifier<_ViewState> {
  bool _disposed = false;

  @override
  _ViewState build() {
    ref.onDispose(() => _disposed = true);
    return const _ViewState();
  }

  void setReport(ShiftReport report) => state = state.copyWith(report: report);

  void onSort(_Col col) {
    // Changing the order re-examines the list from the top.
    if (state.sortCol == col) {
      state = state.copyWith(
          sortAsc: !state.sortAsc, visibleLimit: _kOrderPageSize);
    } else {
      state = state.copyWith(
          sortCol: col,
          sortAsc: col == _Col.number,
          visibleLimit: _kOrderPageSize);
    }
  }

  void setFilter(_SyncFilter f) =>
      state = state.copyWith(filter: f, visibleLimit: _kOrderPageSize);

  void showMore() =>
      state = state.copyWith(visibleLimit: state.visibleLimit + _kOrderPageSize);

  /// Mirrors a void into the history list and the expanded panel.
  void onVoided(Order voided) {
    ref.read(orderHistoryProvider.notifier).updateOrder(voided);
    if (state.expandedId == voided.id) {
      state = state.copyWith(expandedOrder: voided);
    }
  }

  Future<void> toggleExpand(Order order) async {
    if (state.expandedId == order.id) {
      state = state.copyWith(clearExpansion: true);
      return;
    }
    state = state.copyWith(
        expandedId: order.id, expandedOrder: order, loadingDetail: false);

    if (order.items.isEmpty) {
      state = state.copyWith(loadingDetail: true);
      try {
        final full =
            await ref.read(orderRepositoryProvider).getOrder(order.id);
        if (_disposed || state.expandedId != order.id) return;
        ref.read(orderHistoryProvider.notifier).updateOrder(full);
        state = state.copyWith(expandedOrder: full, loadingDetail: false);
      } catch (_) {
        if (!_disposed) state = state.copyWith(loadingDetail: false);
      }
    }
  }
}

final _viewProvider =
    NotifierProvider.autoDispose<_ViewNotifier, _ViewState>(_ViewNotifier.new);

// ── Pure helpers shared by the list widgets ──────────────────────────────────

List<Order> _sorted(List<Order> orders, _Col sortCol, bool sortAsc) {
  final list = List<Order>.of(orders);
  list.sort((a, b) {
    int cmp;
    switch (sortCol) {
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
    return sortAsc ? cmp : -cmp;
  });
  return list;
}

List<Order> _applyFilter(List<Order> orders, _SyncFilter f) => switch (f) {
      _SyncFilter.all => orders,
      _SyncFilter.synced => orders
          .where((o) => o.status != 'voided' && o.status != 'pending_sync')
          .toList(),
      _SyncFilter.pending =>
        orders.where((o) => o.status == 'pending_sync').toList(),
      _SyncFilter.voided =>
        orders.where((o) => o.status == 'voided').toList(),
    };

// ─────────────────────────────────────────────────────────────────────────────
//  SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class OrderHistoryScreen extends ConsumerStatefulWidget {
  const OrderHistoryScreen({super.key});
  @override
  ConsumerState<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends ConsumerState<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final shiftId = ref.read(shiftProvider).shift?.id;
    if (shiftId == null) return;

    try {
      final report = await ref.read(shiftApiProvider).getReport(shiftId);
      if (mounted) ref.read(_viewProvider.notifier).setReport(report);
    } catch (_) {}

    await ref
        .read(orderHistoryProvider.notifier)
        .loadForShift(shiftId, force: true);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = l10n(context);
    // Pin the view state to this screen's lifetime without rebuilding the
    // whole screen on every change — leaf widgets watch the slices they need.
    ref.listen(_viewProvider, (_, __) {});
    final history = ref.watch(orderHistoryProvider);
    final shift = ref.watch(shiftProvider.select((st) => st.shift));
    final methods = ref.watch(paymentMethodProvider.select((p) => p.items));

    final Widget body;
    if (shift == null) {
      body = EmptyState(
        icon: Icons.lock_outline_rounded,
        title: s.shiftNoOpenShift,
        body: s.orderOpenShiftToSell,
      );
    } else if (history.isLoading && history.orders.isEmpty) {
      body = const Center(child: CircularProgressIndicator());
    } else if (history.error != null) {
      body = ErrorState(message: history.error!, onRetry: _load);
    } else if (history.orders.isEmpty) {
      body = EmptyState(
        icon: Icons.receipt_long_rounded,
        title: s.orderNoOrdersYet,
        body: s.orderOrdersAppearHere,
      );
    } else {
      body = _Content(orders: history.orders, methods: methods);
    }

    return Scaffold(
      backgroundColor: t.bg,
      body: Column(children: [
        AppTopBar(
          title: s.orderHistoryTitle,
          subtitle: shift == null ? null : s.orderCurrentShift,
          actions: [
            const SyncStatusChip(),
            const SizedBox(width: AppSpace.sm),
            RefreshButton(
              enabled: shift != null,
              loading: history.isLoading,
              onTap: shift == null
                  ? () {}
                  : () =>
                      ref.read(orderHistoryProvider.notifier).refresh(shift.id),
            ),
          ],
        ),
        Expanded(child: body),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  CONTENT — stats + filter + list. Watches only sort/filter; expansion is
//  watched further down so expanding a row never re-sorts the list.
// ─────────────────────────────────────────────────────────────────────────────

class _Content extends ConsumerWidget {
  final List<Order> orders;
  final List<PaymentMethod> methods;
  const _Content({required this.orders, required this.methods});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = l10n(context);
    final (filter, sortCol, sortAsc, limit) = ref.watch(_viewProvider
        .select((v) => (v.filter, v.sortCol, v.sortAsc, v.visibleLimit)));
    final all = _sorted(_applyFilter(orders, filter), sortCol, sortAsc);
    // Render only the first `limit` rows; the rest reveal via the footer. The
    // full `all` set still drives the stats and filter counts above.
    final visible = all.length > limit ? all.sublist(0, limit) : all;
    final remaining = all.length - visible.length;

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpace.lg, AppSpace.md, AppSpace.lg, 0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const OfflineBanner(),
          _StatsHeader(orders: orders, methods: methods),
          const SizedBox(height: AppSpace.md),
          _FilterRow(orders: orders),
        ]),
      ),
      const SizedBox(height: AppSpace.md),
      Expanded(
        child: visible.isEmpty
            ? EmptyState(
                icon: Icons.filter_alt_off_rounded,
                title: s.orderNothingHere,
                body: s.orderNoFilterMatch(filter.label(s)),
              )
            : LayoutBuilder(builder: (context, constraints) {
                return constraints.maxWidth < _kTableBreakpoint
                    ? _CardList(
                        visible: visible, methods: methods, remaining: remaining)
                    : _OrderTable(
                        visible: visible, methods: methods, remaining: remaining);
              }),
      ),
    ]);
  }
}

class _FilterRow extends ConsumerWidget {
  final List<Order> orders;
  const _FilterRow({required this.orders});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(_viewProvider.select((v) => v.filter));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        for (final f in _SyncFilter.values) ...[
          StatusChip(
            label:
                '${f.label(l10n(context))} · ${_applyFilter(orders, f).length}',
            icon: f.icon,
            tone: filter == f ? f.activeTone : ChipTone.neutral,
            onTap: () => ref.read(_viewProvider.notifier).setFilter(f),
          ),
          const SizedBox(width: AppSpace.sm),
        ],
      ]),
    );
  }
}

// ── Narrow: cards ─────────────────────────────────────────────────────────────

class _CardList extends ConsumerWidget {
  final List<Order> visible;
  final List<PaymentMethod> methods;
  final int remaining;
  const _CardList(
      {required this.visible, required this.methods, required this.remaining});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (expandedId, expandedOrder, loadingDetail) = ref.watch(
        _viewProvider
            .select((v) => (v.expandedId, v.expandedOrder, v.loadingDetail)));
    return ListView.builder(
      padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpace.lg, 0, AppSpace.lg, AppSpace.lg),
      itemCount: visible.length + (remaining > 0 ? 1 : 0),
      itemBuilder: (context, i) {
        if (i >= visible.length) {
          return _ShowMoreFooter(
              remaining: remaining,
              onTap: () => ref.read(_viewProvider.notifier).showMore());
        }
        final o = visible[i];
        final isExp = expandedId == o.id;
        return _OrderCard(
          order: o,
          methods: methods,
          expandedOrder: isExp ? expandedOrder : null,
          isLoadingDetail: isExp && loadingDetail,
          onTap: () => ref.read(_viewProvider.notifier).toggleExpand(o),
          onVoided: ref.read(_viewProvider.notifier).onVoided,
        );
      },
    );
  }
}

// ── Wide: sortable table ──────────────────────────────────────────────────────

class _OrderTable extends ConsumerWidget {
  final List<Order> visible;
  final List<PaymentMethod> methods;
  final int remaining;
  const _OrderTable(
      {required this.visible, required this.methods, required this.remaining});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (expandedId, expandedOrder, loadingDetail) = ref.watch(
        _viewProvider
            .select((v) => (v.expandedId, v.expandedOrder, v.loadingDetail)));
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpace.lg, 0, AppSpace.lg, AppSpace.lg),
      child: SurfaceCard(
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: Column(children: [
          const _TableHeader(),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: visible.length + (remaining > 0 ? 1 : 0),
              itemBuilder: (context, i) {
                if (i >= visible.length) {
                  return _ShowMoreFooter(
                      remaining: remaining,
                      onTap: () =>
                          ref.read(_viewProvider.notifier).showMore());
                }
                final o = visible[i];
                final isExp = expandedId == o.id;
                return _TableRow(
                  order: o,
                  methods: methods,
                  expandedOrder: isExp ? expandedOrder : null,
                  isExpanded: isExp,
                  isLoadingDetail: isExp && loadingDetail,
                  isEven: i.isEven,
                  onTap: () => ref.read(_viewProvider.notifier).toggleExpand(o),
                  onVoided: ref.read(_viewProvider.notifier).onVoided,
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}

/// Footer button revealing the next chunk of orders. Sits at the end of the
/// list; the full order set is already in memory, so this is purely cosmetic.
class _ShowMoreFooter extends StatelessWidget {
  final int remaining;
  final VoidCallback onTap;
  const _ShowMoreFooter({required this.remaining, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppSpace.md, horizontal: AppSpace.lg),
      child: Center(
        child: AnimatedPressScale(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpace.lg, vertical: AppSpace.sm + 2),
            decoration: BoxDecoration(
              color: t.surfaceAlt,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              border: Border.all(color: t.border),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.expand_more_rounded, size: 16, color: t.textSecondary),
              const SizedBox(width: 6),
              Text(
                l10n(context).orderShowMore(remaining),
                style:
                    ui(size: 13, weight: FontWeight.w700, color: t.textSecondary),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  STATS HEADER
// ─────────────────────────────────────────────────────────────────────────────

class _StatsHeader extends ConsumerWidget {
  final List<Order> orders;
  final List<PaymentMethod> methods;

  const _StatsHeader({
    required this.orders,
    required this.methods,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final s = l10n(context);
    final locale = Localizations.localeOf(context).languageCode;
    final report = ref.watch(_viewProvider.select((v) => v.report));

    // If the shift report is available, use its highly accurate payment
    // summary; otherwise fall back to a local calculation.
    final total = report?.netPayments ??
        orders
            .where((o) => o.status != 'voided')
            .fold<int>(0, (s, o) => s + o.totalAmount);
    final orderCount = orders.where((o) => o.status != 'voided').length;

    final methodStats = <({String id, String label, bool isCash, int amount})>[];

    for (final m in methods) {
      int sum = 0;
      if (report != null) {
        sum = report.paymentSummary
            .where((p) => p.paymentMethod == m.wireFormat)
            .fold<int>(0, (s, p) => s + p.total);
      } else {
        sum = orders
            .where((o) =>
                o.status != 'voided' &&
                (o.paymentMethod == m.wireFormat ||
                    o.tipPaymentMethod == m.wireFormat))
            .fold<int>(0, (s, o) {
          final orderAmt = o.paymentMethod == m.wireFormat ? o.totalAmount : 0;
          final tipAmt =
              o.tipPaymentMethod == m.wireFormat ? (o.tipAmount ?? 0) : 0;
          return s + orderAmt + tipAmt;
        });
      }
      methodStats.add(
          (id: m.id, label: m.label(locale), isCash: m.isCash, amount: sum));
    }

    final int mixedSum;
    if (report != null) {
      mixedSum = report.paymentSummary
          .where((p) => p.paymentMethod == 'mixed')
          .fold<int>(0, (s, p) => s + p.total);
    } else {
      mixedSum = orders
          .where((o) => o.status != 'voided' && o.paymentMethod == 'mixed')
          .fold<int>(0, (s, o) => s + o.totalAmount);
    }
    if (mixedSum > 0) {
      methodStats.add(
          (id: 'mixed', label: s.orderMixed, isCash: false, amount: mixedSum));
    }

    ChipTone toneFor(({String id, String label, bool isCash, int amount}) m) =>
        m.id == 'mixed'
            ? ChipTone.warning
            : m.isCash
                ? ChipTone.success
                : ChipTone.info;

    Widget statDivider() => Container(
          width: 1,
          height: 28,
          margin:
              const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.lg),
          color: t.border,
        );

    return SurfaceCard(
      padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpace.lg, vertical: AppSpace.md),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          _Stat(
            label: s.orderStatOrders,
            value: Text('$orderCount',
                style:
                    ui(size: 18, weight: FontWeight.w800, color: t.textPrimary)),
          ),
          statDivider(),
          _Stat(
            label: s.orderTotal,
            value: Text(egp(total),
                style: money(size: 18, weight: FontWeight.w800, color: t.success)),
          ),
          if (methodStats.isNotEmpty) statDivider(),
          for (final m in methodStats) ...[
            StatusChip(
              label:
                  '${m.label} · ${egp(m.amount)} · ${total > 0 ? (m.amount / total * 100).round() : 0}%',
              tone: toneFor(m),
            ),
            const SizedBox(width: AppSpace.sm),
          ],
        ]),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final Widget value;
  const _Stat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: ui(
                size: 11,
                weight: FontWeight.w600,
                color: t.textMuted,
                letterSpacing: 0.4)),
        const SizedBox(height: 2),
        value,
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  TABLE
// ─────────────────────────────────────────────────────────────────────────────

// Column flex/width spec shared between header and rows.
// Layout: [#56] [payment flex3] [time flex2] [teller flex2] [amount 110] [chevron 44]
class _ColSpec {
  static const double numW = 104; // widened to fit order_ref under the #
  static const int payFlex = 3;
  static const int timeFlex = 2;
  static const int tellerFlex = 2;
  static const double amtW = 110;
  static const double chevW = 44;
}

class _TableHeader extends ConsumerWidget {
  const _TableHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final s = l10n(context);
    final (sortCol, sortAsc) =
        ref.watch(_viewProvider.select((v) => (v.sortCol, v.sortAsc)));
    return Container(
      height: 44,
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.lg),
      color: t.surfaceAlt,
      child: Row(children: [
        _cell(context, ref, sortCol, sortAsc, '#', _Col.number,
            width: _ColSpec.numW),
        _cell(context, ref, sortCol, sortAsc, s.orderPaymentMethod,
            _Col.payment, flex: _ColSpec.payFlex),
        _cell(context, ref, sortCol, sortAsc, s.orderColTime, _Col.time,
            flex: _ColSpec.timeFlex),
        _cell(context, ref, sortCol, sortAsc, s.commonTeller, _Col.teller,
            flex: _ColSpec.tellerFlex),
        _cell(context, ref, sortCol, sortAsc, s.orderColAmount, _Col.amount,
            width: _ColSpec.amtW, alignEnd: true),
        const SizedBox(width: _ColSpec.chevW),
      ]),
    );
  }

  Widget _cell(BuildContext context, WidgetRef ref, _Col sortCol, bool sortAsc,
      String label, _Col col,
      {double? width, int? flex, bool alignEnd = false}) {
    final t = context.tokens;
    final active = sortCol == col;
    final color = active ? t.accent : t.textMuted;
    final child = GestureDetector(
      onTap: () => ref.read(_viewProvider.notifier).onSort(col),
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisAlignment:
            alignEnd ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Text(label,
              style: ui(
                  size: 11,
                  weight: FontWeight.w700,
                  color: color,
                  letterSpacing: 0.4)),
          if (active) ...[
            const SizedBox(width: 3),
            Icon(
                sortAsc
                    ? Icons.arrow_upward_rounded
                    : Icons.arrow_downward_rounded,
                size: 11,
                color: color),
          ],
        ],
      ),
    );
    if (width != null) return SizedBox(width: width, child: child);
    return Expanded(flex: flex ?? 1, child: child);
  }
}

class _TableRow extends StatelessWidget {
  final Order order;
  final List<PaymentMethod> methods;
  final Order? expandedOrder;
  final bool isExpanded;
  final bool isLoadingDetail;
  final bool isEven;
  final VoidCallback onTap;
  final void Function(Order) onVoided;

  const _TableRow({
    required this.order,
    required this.methods,
    required this.expandedOrder,
    required this.isExpanded,
    required this.isLoadingDetail,
    required this.isEven,
    required this.onTap,
    required this.onVoided,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final o = order;
    final isVoided = o.status == 'voided';
    final isPending = o.status == 'pending_sync';

    return Column(mainAxisSize: MainAxisSize.min, children: [
      GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          height: 56,
          padding:
              const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.lg),
          color: isExpanded
              ? t.navyBg
              : isEven
                  ? Colors.transparent
                  : t.surfaceAlt,
          child: Opacity(
            opacity: isVoided ? 0.55 : 1.0,
            child: Row(children: [
              // # column (per-shift number + unique order_ref beneath)
              SizedBox(
                width: _ColSpec.numW,
                child: isPending
                    ? Icon(Icons.cloud_upload_outlined,
                        size: 16, color: t.warning)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('#${o.orderNumber}',
                              style: ui(
                                  size: 14,
                                  weight: FontWeight.w700,
                                  color: isVoided ? t.textMuted : t.navy)),
                          if (o.orderRef != null)
                            Text(o.orderRef!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: ui(size: 9, color: t.textMuted)),
                        ],
                      ),
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
                    const SizedBox(width: AppSpace.sm),
                    StatusChip(
                        label: l10n(context).commonVoided,
                        tone: ChipTone.danger),
                  ],
                  if (isPending) ...[
                    const SizedBox(width: AppSpace.sm),
                    StatusChip(
                      label: l10n(context).commonPendingSync,
                      tone: ChipTone.warning,
                      icon: Icons.sync_rounded,
                      onTap: () => context.push('/pending-orders'),
                    ),
                  ],
                  if (o.customerName != null) ...[
                    const SizedBox(width: AppSpace.sm),
                    Flexible(
                      child: Text(o.customerName!,
                          overflow: TextOverflow.ellipsis,
                          style: ui(size: 12, color: t.textMuted)),
                    ),
                  ],
                ]),
              ),
              // Time column
              Expanded(
                flex: _ColSpec.timeFlex,
                child: Text(timeShort(o.createdAt),
                    style: ui(size: 13, color: t.textSecondary)),
              ),
              // Teller column
              Expanded(
                flex: _ColSpec.tellerFlex,
                child: Row(children: [
                  Icon(Icons.person_outline_rounded,
                      size: 13, color: t.textMuted),
                  const SizedBox(width: AppSpace.xs),
                  Flexible(
                    child: Text(o.tellerName,
                        overflow: TextOverflow.ellipsis,
                        style: ui(size: 12, color: t.textSecondary)),
                  ),
                ]),
              ),
              // Amount column
              SizedBox(
                width: _ColSpec.amtW,
                child: Text(egp(o.totalAmount),
                    textAlign: TextAlign.end,
                    style: money(
                      size: 14,
                      weight: FontWeight.w600,
                      color: isVoided ? t.textMuted : t.textPrimary,
                    ).copyWith(
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
                          child: CircularProgressIndicator(strokeWidth: 1.5),
                        ),
                      )
                    : Center(
                        child: AnimatedRotation(
                          duration: const Duration(milliseconds: 180),
                          turns: isExpanded ? 0.5 : 0,
                          child: Icon(Icons.keyboard_arrow_down_rounded,
                              size: 20, color: t.textMuted),
                        ),
                      ),
              ),
            ]),
          ),
        ),
      ),

      // Expanded panel
      if (isExpanded && expandedOrder != null)
        Container(
          width: double.infinity,
          color: t.navyBg,
          padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpace.lg, 0, AppSpace.lg, AppSpace.lg),
          child: SurfaceCard(
            padding: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            child: _OrderDetail(
              order: expandedOrder!,
              methods: methods,
              isLoading: isLoadingDetail,
              onVoided: onVoided,
            ),
          ),
        ),
    ]);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  CARD (narrow layouts)
// ─────────────────────────────────────────────────────────────────────────────

class _OrderCard extends StatelessWidget {
  final Order order;
  final List<PaymentMethod> methods;
  final Order? expandedOrder;
  final bool isLoadingDetail;
  final VoidCallback onTap;
  final void Function(Order) onVoided;

  const _OrderCard({
    required this.order,
    required this.methods,
    required this.expandedOrder,
    required this.isLoadingDetail,
    required this.onTap,
    required this.onVoided,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final o = order;
    final isVoided = o.status == 'voided';
    final isPending = o.status == 'pending_sync';
    final isExpanded = expandedOrder != null;

    return SurfaceCard(
      margin: const EdgeInsets.only(bottom: AppSpace.md),
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      onTap: onTap,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpace.lg, AppSpace.md, AppSpace.lg, AppSpace.md),
          child: Opacity(
            opacity: isVoided ? 0.6 : 1.0,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    if (isPending)
                      Icon(Icons.cloud_upload_outlined,
                          size: 16, color: t.warning)
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('#${o.orderNumber}',
                              style: ui(
                                  size: 14,
                                  weight: FontWeight.w700,
                                  color: isVoided ? t.textMuted : t.navy)),
                          if (o.orderRef != null)
                            Text(o.orderRef!,
                                style: ui(size: 10, color: t.textMuted)),
                        ],
                      ),
                    const SizedBox(width: AppSpace.sm),
                    Flexible(
                      child: _PaymentBadge(
                          method: o.paymentMethod,
                          voided: isVoided,
                          methods: methods),
                    ),
                    if (o.orderType == 'delivery') ...[
                      const SizedBox(width: AppSpace.xs),
                      const StatusChip(
                        label: 'Delivery',
                        tone: ChipTone.info,
                        icon: Icons.local_shipping_outlined,
                      ),
                    ],
                    const Spacer(),
                    Text(egp(o.totalAmount),
                        style: money(
                          size: 15,
                          weight: FontWeight.w700,
                          color: isVoided ? t.textMuted : t.textPrimary,
                        ).copyWith(
                            decoration: isVoided
                                ? TextDecoration.lineThrough
                                : null)),
                    const SizedBox(width: AppSpace.xs),
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 180),
                      turns: isExpanded ? 0.5 : 0,
                      child: Icon(Icons.keyboard_arrow_down_rounded,
                          size: 20, color: t.textMuted),
                    ),
                  ]),
                  const SizedBox(height: AppSpace.xs),
                  Text(
                    '${timeShort(o.createdAt)} · ${o.tellerName}'
                    '${o.customerName != null ? ' · ${o.customerName}' : ''}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: ui(size: 12, color: t.textSecondary),
                  ),
                  if (isVoided || isPending) ...[
                    const SizedBox(height: AppSpace.sm),
                    Row(children: [
                      if (isVoided)
                        StatusChip(
                            label: l10n(context).commonVoided,
                            tone: ChipTone.danger),
                      if (isPending)
                        StatusChip(
                          label: l10n(context).commonPendingSync,
                          tone: ChipTone.warning,
                          icon: Icons.sync_rounded,
                          onTap: () => context.push('/pending-orders'),
                        ),
                    ]),
                  ],
                ]),
          ),
        ),
        if (isExpanded) ...[
          const Divider(height: 1),
          _OrderDetail(
            order: expandedOrder!,
            methods: methods,
            isLoading: isLoadingDetail,
            onVoided: onVoided,
          ),
        ],
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  EXPANDED DETAIL (shared by table + cards)
// ─────────────────────────────────────────────────────────────────────────────

class _OrderDetail extends StatelessWidget {
  final Order order;
  final List<PaymentMethod> methods;
  final bool isLoading;
  final void Function(Order) onVoided;

  const _OrderDetail({
    required this.order,
    required this.methods,
    required this.isLoading,
    required this.onVoided,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = l10n(context);
    final isVoided = order.status == 'voided';
    final isPending = order.status == 'pending_sync';

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // ── Line items ──────────────────────────────────────────────────
      if (isLoading)
        const Padding(
          padding: EdgeInsets.all(AppSpace.xl),
          child: Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        )
      else if (order.items.isEmpty)
        Padding(
          padding: const EdgeInsets.all(AppSpace.lg),
          child: Text(s.orderNoItemDetails,
              style: ui(size: 13, color: t.textMuted)),
        )
      else
        ...List.generate(order.items.length, (i) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            _ItemRow(item: order.items[i], isPending: isPending),
            if (i < order.items.length - 1)
              const Divider(
                  height: 1, indent: AppSpace.lg, endIndent: AppSpace.lg),
          ]);
        }),

      // ── Totals ──────────────────────────────────────────────────────
      Container(
        padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpace.lg, AppSpace.md, AppSpace.lg, AppSpace.md),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: t.borderLight))),
        child: Column(children: [
          _TotalRow(label: s.orderSubtotal, value: egp(order.subtotal)),
          if (order.discountAmount > 0)
            _TotalRow(
                label: s.orderDiscount,
                value: '− ${egp(order.discountAmount)}',
                valueColor: t.success),
          if (order.taxAmount > 0)
            _TotalRow(label: s.orderTax14, value: egp(order.taxAmount)),
          if (order.deliveryFee > 0)
            _TotalRow(label: 'Delivery fee', value: egp(order.deliveryFee)),
          const SizedBox(height: AppSpace.sm),
          Container(
            padding: const EdgeInsets.only(top: AppSpace.sm),
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: t.borderLight))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(s.orderTotal,
                    style: ui(size: 14, weight: FontWeight.w700)),
                Text(egp(order.totalAmount),
                    style: money(
                      size: 18,
                      weight: FontWeight.w800,
                      color: isVoided ? t.textMuted : t.textPrimary,
                    ).copyWith(
                        decoration:
                            isVoided ? TextDecoration.lineThrough : null)),
              ],
            ),
          ),
        ]),
      ),

      // ── Meta + actions ──────────────────────────────────────────────
      Container(
        padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpace.lg, AppSpace.md, AppSpace.lg, AppSpace.md),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: t.borderLight))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Wrap(
            spacing: AppSpace.lg,
            runSpacing: AppSpace.xs,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _Meta(
                  icon: Icons.payments_outlined,
                  text: methodLabel(
                      methods,
                      Localizations.localeOf(context).languageCode,
                      order.paymentMethod)),
              if (order.tellerName.isNotEmpty)
                _Meta(
                    icon: Icons.person_outline_rounded,
                    text: order.tellerName),
              if (isVoided && order.voidReason != null)
                _Meta(
                    icon: Icons.cancel_outlined,
                    text: _voidLabel(s, order.voidReason!),
                    color: t.danger),
            ],
          ),
          const SizedBox(height: AppSpace.md),
          Row(children: [
            const Spacer(),
            _RowAction(
              icon: Icons.print_rounded,
              label: s.commonPrint,
              bg: t.navyBg,
              fg: t.navy,
              onTap: () => ReceiptPreviewSheet.show(context, order),
            ),
            if (!isVoided) ...[
              const SizedBox(width: AppSpace.sm),
              _RowAction(
                icon: Icons.cancel_outlined,
                label: s.orderVoid,
                bg: t.dangerBg,
                fg: t.danger,
                onTap: () => VoidOrderSheet.show(context, order, onVoided),
              ),
            ],
          ]),
        ]),
      ),
    ]);
  }

  static String _voidLabel(AppLocalizations s, String r) {
    if (r.startsWith('other: ')) return r.substring(7);
    return switch (r) {
      'customer_request' => s.orderVoidReasonCustomerRequest,
      'wrong_order' => s.orderVoidReasonWrongOrder,
      'quality_issue' => s.orderVoidReasonQualityIssue,
      'other' => s.orderVoidReasonOther,
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
    final t = context.tokens;

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpace.lg, vertical: AppSpace.md),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Qty bubble
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: t.navyBg,
            borderRadius: BorderRadius.circular(AppRadius.xs),
          ),
          alignment: Alignment.center,
          child: Text('${item.quantity}',
              style: ui(size: 12, weight: FontWeight.w700, color: t.navy)),
        ),
        const SizedBox(width: AppSpace.sm + 2),

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
                  style: ui(size: 13, weight: FontWeight.w600),
                ),
              ),
              if (item.isBundleLine) ...[
                const SizedBox(width: AppSpace.sm),
                _TinyChip(
                    label: l10n(context).orderCombo,
                    fg: t.navy,
                    bg: t.navyBg),
              ],
            ]),

            // Bundle components
            if (item.isBundleLine &&
                (item.bundleComponents?.isNotEmpty ?? false)) ...[
              const SizedBox(height: AppSpace.xs),
              ...(item.bundleComponents ?? const []).map((c) {
                final qty = c.quantity * item.quantity;
                return Padding(
                  padding:
                      const EdgeInsetsDirectional.only(start: 8, bottom: 3),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '– ${normaliseName(c.itemName)}'
                          '${c.sizeLabel != null ? ' · ${normaliseName(c.sizeLabel!)}' : ''}'
                          ' × $qty',
                          style: ui(size: 12, color: t.textSecondary),
                        ),
                        if (c.addons.isNotEmpty) ...[
                          const SizedBox(height: 3),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 10),
                            child: Wrap(
                              spacing: 4,
                              runSpacing: 3,
                              children: c.addons.map((a) {
                                final lt = a.priceModifier * a.quantity;
                                return _TinyChip(
                                  label: a.priceModifier > 0
                                      ? '+ ${normaliseName(a.name)}${a.quantity > 1 ? " ×${a.quantity}" : ""}  ${egp(lt)}'
                                      : '+ ${normaliseName(a.name)}${a.quantity > 1 ? " ×${a.quantity}" : ""}',
                                  fg: t.accent,
                                  bg: t.accentBg,
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                        if (c.optionals.isNotEmpty) ...[
                          const SizedBox(height: 3),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 10),
                            child: Wrap(
                              spacing: 4,
                              runSpacing: 3,
                              children: c.optionals
                                  .map((o) => _TinyChip(
                                        label: o.price > 0
                                            ? '+ ${normaliseName(o.name)}  ${egp(o.price)}'
                                            : '+ ${normaliseName(o.name)}',
                                        fg: t.warning,
                                        bg: t.warningBg,
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
                    return _TinyChip(
                      label: hasPrice
                          ? '${normaliseName(a.addonName)}  +${egp(a.lineTotal)}'
                          : normaliseName(a.addonName),
                      fg: t.accent,
                      bg: t.accentBg,
                    );
                  }).toList(),
                ),
              ],
              // Optionals
              if (item.optionals.isNotEmpty) ...[
                const SizedBox(height: AppSpace.xs),
                Wrap(
                  spacing: 4,
                  runSpacing: 3,
                  children: item.optionals.map((o) {
                    final hasPrice = o.price > 0;
                    return _TinyChip(
                      label: hasPrice
                          ? '${normaliseName(o.fieldName)}  +${egp(o.price)}'
                          : normaliseName(o.fieldName),
                      fg: t.warning,
                      bg: t.warningBg,
                    );
                  }).toList(),
                ),
              ],
            ],

            // Ingredients button
            if (item.deductions.isNotEmpty || isPending) ...[
              const SizedBox(height: 6),
              _TinyChip(
                label: l10n(context).orderIngredients,
                fg: t.navy,
                bg: t.navyBg,
                icon: Icons.science_rounded,
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => OrderIngredientsSheet(item: item),
                ),
              ),
            ],
          ]),
        ),

        const SizedBox(width: AppSpace.sm + 2),
        // Line total
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(egp(item.lineTotal),
              style: money(size: 13, weight: FontWeight.w600)),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SMALL REUSABLE WIDGETS
// ─────────────────────────────────────────────────────────────────────────────

class _PaymentBadge extends StatelessWidget {
  final String method;
  final bool voided;
  final List<PaymentMethod> methods;
  const _PaymentBadge(
      {required this.method, required this.voided, required this.methods});

  /// Server-provided method colors are picked for light dashboards — lift
  /// their lightness in dark mode so labels stay readable.
  static Color _readable(Color c, AppTokens t) {
    if (!t.isDark) return c;
    final hsl = HSLColor.fromColor(c);
    return hsl
        .withLightness((hsl.lightness + 0.25).clamp(0.55, 0.85).toDouble())
        .toColor();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final label = methodLabel(
        methods, Localizations.localeOf(context).languageCode, method);
    final fg = voided ? t.textMuted : _readable(methodColor(methods, method), t);
    final bg = voided ? t.surfaceAlt : fg.withOpacity(0.12);
    return Container(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: ui(size: 11, weight: FontWeight.w700, color: fg)),
    );
  }
}

class _TinyChip extends StatelessWidget {
  final String label;
  final Color fg;
  final Color bg;
  final IconData? icon;
  final VoidCallback? onTap;
  const _TinyChip(
      {required this.label,
      required this.fg,
      required this.bg,
      this.icon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final chip = Container(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (icon != null) ...[
          Icon(icon, size: 11, color: fg),
          const SizedBox(width: 3),
        ],
        Text(label, style: ui(size: 11, weight: FontWeight.w600, color: fg)),
      ]),
    );
    return onTap == null ? chip : AnimatedPressScale(onTap: onTap, child: chip);
  }
}

class _TotalRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  const _TotalRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: ui(size: 13, color: t.textSecondary)),
        Text(value,
            style: money(
                size: 13,
                weight: FontWeight.w600,
                color: valueColor ?? t.textPrimary)),
      ]),
    );
  }
}

class _Meta extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;
  const _Meta({required this.icon, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 13, color: color ?? t.textMuted),
      const SizedBox(width: AppSpace.xs),
      Text(text, style: ui(size: 12, color: color ?? t.textSecondary)),
    ]);
  }
}

class _RowAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bg;
  final Color fg;
  final VoidCallback onTap;
  const _RowAction({
    required this.icon,
    required this.label,
    required this.bg,
    required this.fg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => AnimatedPressScale(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(AppRadius.xs),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, size: 14, color: fg),
            const SizedBox(width: 6),
            Text(label,
                style: ui(size: 13, weight: FontWeight.w700, color: fg)),
          ]),
        ),
      );
}
