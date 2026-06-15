import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/l10n.dart';
import '../../core/models/order.dart';
import '../../core/models/payment_method.dart';
import '../../core/models/shift.dart';
import '../../core/providers/auth_notifier.dart';
import '../../core/providers/payment_method_notifier.dart';
import '../../core/repositories/order_repository.dart';
import '../../core/repositories/shift_repository.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatting.dart';
import '../../shared/widgets/animated_icons.dart';
import '../../shared/widgets/app_top_bar.dart';
import '../../shared/widgets/empty_state.dart';
import '../../shared/widgets/refresh_button.dart';
import '../../shared/widgets/status_chip.dart';
import '../../shared/widgets/surface_card.dart';
import '../order/widgets/receipt_preview_sheet.dart';
import 'shift_report_preview_sheet.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  EPHEMERAL STATE — private autoDispose providers (reset when screen unmounts,
//  same lifetime the old State objects had).
// ─────────────────────────────────────────────────────────────────────────────

class _HistoryState {
  final List<Shift> shifts;
  final bool loading;      // first page / refresh in flight
  final bool loadingMore;  // appending a later page
  final bool hasMore;      // server reported further pages
  final int page;          // highest page loaded so far (0 = none)
  final String? error;
  const _HistoryState({
    this.shifts = const [],
    this.loading = true,
    this.loadingMore = false,
    this.hasMore = false,
    this.page = 0,
    this.error,
  });

  _HistoryState copyWith({
    List<Shift>? shifts,
    bool? loading,
    bool? loadingMore,
    bool? hasMore,
    int? page,
    String? error,
    bool clearError = false,
  }) =>
      _HistoryState(
        shifts: shifts ?? this.shifts,
        loading: loading ?? this.loading,
        loadingMore: loadingMore ?? this.loadingMore,
        hasMore: hasMore ?? this.hasMore,
        page: page ?? this.page,
        error: clearError ? null : (error ?? this.error),
      );
}

final _historyProvider =
    NotifierProvider.autoDispose<_HistoryController, _HistoryState>(
        _HistoryController.new);

class _HistoryController extends AutoDisposeNotifier<_HistoryState> {
  bool _disposed = false;

  @override
  _HistoryState build() {
    ref.onDispose(() => _disposed = true);
    return const _HistoryState();
  }

  void noBranch(String message) => state =
      state.copyWith(loading: false, loadingMore: false, error: message);

  /// (Re)load from the first page. Paints cached shifts instantly, then
  /// replaces them with the freshest page from the server.
  Future<void> load(String branchId) async {
    state = state.copyWith(loading: true, clearError: true);
    try {
      final repo = ref.read(shiftRepositoryProvider);

      // Instant paint from the last cached page.
      final local = repo.loadShiftsLocal(branchId);
      if (local != null && local.isNotEmpty && !_disposed) {
        state = state.copyWith(shifts: local, loading: false);
      }

      final pageData = await repo.fetchShiftsPage(branchId, page: 1);
      if (_disposed) return;
      await repo.cacheShifts(branchId, pageData.shifts);
      state = _HistoryState(
        shifts: _withLocalOpenShift(branchId, pageData.shifts),
        loading: false,
        hasMore: pageData.hasMore,
        page: 1,
      );
    } catch (e) {
      if (!_disposed) {
        state = state.copyWith(
          loading: false,
          loadingMore: false,
          hasMore: false,
          error: state.shifts.isEmpty ? e.toString() : null,
        );
      }
    }
  }

  /// Append the next page. No-op while already busy or when no more pages.
  Future<void> loadMore(String branchId) async {
    if (_disposed ||
        state.loading ||
        state.loadingMore ||
        !state.hasMore) {
      return;
    }
    state = state.copyWith(loadingMore: true);
    try {
      final next = state.page + 1;
      final pageData = await ref
          .read(shiftRepositoryProvider)
          .fetchShiftsPage(branchId, page: next);
      if (_disposed) return;
      final seen = state.shifts.map((s) => s.id).toSet();
      final merged = [
        ...state.shifts,
        ...pageData.shifts.where((s) => !seen.contains(s.id)),
      ];
      state = state.copyWith(
        shifts: merged,
        loadingMore: false,
        hasMore: pageData.hasMore,
        page: next,
      );
    } catch (_) {
      if (!_disposed) state = state.copyWith(loadingMore: false);
    }
  }

  /// Surface a locally-open shift (e.g. opened while offline, not yet synced)
  /// at the top of the first page so the teller always sees their live shift.
  List<Shift> _withLocalOpenShift(String branchId, List<Shift> serverShifts) {
    final pre = ref.read(shiftRepositoryProvider).loadShiftLocal(branchId);
    final local = (pre != null && pre.hasOpenShift) ? pre.openShift : null;
    if (local == null || serverShifts.any((s) => s.id == local.id)) {
      return serverShifts;
    }
    return [local, ...serverShifts];
  }
}

/// Per-row expansion state, keyed by shift id so it survives row rebuilds but
/// resets when the row leaves the viewport (matching the old State lifetime).
class _RowState {
  final bool expanded;
  final bool loadingOrders;
  final bool printing;
  final List<Order> orders;
  final String? ordersError;
  const _RowState({
    this.expanded = false,
    this.loadingOrders = false,
    this.printing = false,
    this.orders = const [],
    this.ordersError,
  });

  _RowState copyWith({
    bool? expanded,
    bool? loadingOrders,
    bool? printing,
    List<Order>? orders,
  }) =>
      _RowState(
        expanded: expanded ?? this.expanded,
        loadingOrders: loadingOrders ?? this.loadingOrders,
        printing: printing ?? this.printing,
        orders: orders ?? this.orders,
        ordersError: ordersError,
      );
}

final _rowProvider = NotifierProvider.autoDispose
    .family<_RowController, _RowState, String>(_RowController.new);

class _RowController extends AutoDisposeFamilyNotifier<_RowState, String> {
  bool _disposed = false;

  @override
  _RowState build(String arg) {
    ref.onDispose(() => _disposed = true);
    return const _RowState();
  }

  Future<void> toggleOrders() async {
    if (state.orders.isNotEmpty || state.expanded) {
      state = state.copyWith(expanded: !state.expanded);
      return;
    }
    state = state.copyWith(expanded: true, loadingOrders: true);
    try {
      final local = ref.read(orderRepositoryProvider).loadOrdersLocal(arg);
      if (local != null && local.isNotEmpty && !_disposed) {
        state = state.copyWith(orders: local, loadingOrders: false);
      }
      final fresh =
          await ref.read(orderRepositoryProvider).fetchOrdersFresh(arg);
      if (!_disposed) {
        state = state.copyWith(orders: fresh, loadingOrders: false);
      }
    } catch (e) {
      if (!_disposed) {
        state = _RowState(
          expanded: state.expanded,
          printing: state.printing,
          orders: state.orders,
          loadingOrders: false,
          ordersError: state.orders.isEmpty ? e.toString() : null,
        );
      }
    }
  }

  void setPrinting(bool value) {
    if (!_disposed) state = state.copyWith(printing: value);
  }
}

/// Spinner on the per-order print button, keyed by order id.
final _orderPrintingProvider =
    StateProvider.autoDispose.family<bool, String>((ref, orderId) => false);

// ─────────────────────────────────────────────────────────────────────────────
//  SCREEN — lives inside the navigation shell (Shifts tab).
// ─────────────────────────────────────────────────────────────────────────────

class ShiftHistoryScreen extends ConsumerStatefulWidget {
  const ShiftHistoryScreen({super.key});
  @override
  ConsumerState<ShiftHistoryScreen> createState() => _ShiftHistoryScreenState();
}

class _ShiftHistoryScreenState extends ConsumerState<ShiftHistoryScreen> {
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scroll.hasClients) return;
    final pos = _scroll.position;
    if (pos.pixels >= pos.maxScrollExtent - 320) _loadMore();
  }

  void _load() {
    if (!mounted) return;
    final branchId = ref.read(authProvider).user?.branchId;
    if (branchId == null) {
      ref
          .read(_historyProvider.notifier)
          .noBranch(l10n(context).shiftErrorNoBranchAssigned);
      return;
    }
    ref.read(_historyProvider.notifier).load(branchId);
  }

  void _loadMore() {
    if (!mounted) return;
    final branchId = ref.read(authProvider).user?.branchId;
    if (branchId == null) return;
    ref.read(_historyProvider.notifier).loadMore(branchId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        AppTopBar(
          title: l10n(context).shiftHistoryTitle,
          subtitle: l10n(context).shiftHistorySubtitle,
          actions: [
            RefreshButton(
              onTap: _load,
              loading: ref.watch(_historyProvider.select((h) => h.loading)),
            ),
          ],
        ),
        Expanded(child: _buildBody()),
      ]),
    );
  }

  Widget _buildBody() {
    final history = ref.watch(_historyProvider);
    if (history.loading && history.shifts.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (history.error != null) {
      return ErrorState(message: history.error!, onRetry: _load);
    }
    if (history.shifts.isEmpty) {
      return EmptyState(
        icon: Icons.schedule_rounded,
        title: l10n(context).shiftNoShiftsYet,
        body: l10n(context).shiftShiftsAppearHere,
      );
    }
    // Width-driven, not device-class-driven: a landscape phone is wide
    // enough for the table, a split-screen tablet is not.
    return LayoutBuilder(builder: (context, constraints) {
      final compact = constraints.maxWidth < 680;
      return Padding(
        padding: const EdgeInsets.all(AppSpace.lg),
        child: SurfaceCard(
          padding: EdgeInsets.zero,
          radius: AppRadius.lg,
          clipBehavior: Clip.antiAlias,
          child: Column(children: [
            if (!compact) ...[
              const _TableHeader(),
              Divider(height: 1, color: context.tokens.borderLight),
            ],
            Expanded(
              child: ListView.builder(
                controller: _scroll,
                padding: EdgeInsets.zero,
                itemCount: history.shifts.length +
                    (history.hasMore || history.loadingMore ? 1 : 0),
                itemBuilder: (_, i) {
                  if (i >= history.shifts.length) {
                    return const _LoadMoreFooter();
                  }
                  return _ShiftRow(
                      shift: history.shifts[i],
                      isEven: i.isEven,
                      compact: compact);
                },
              ),
            ),
          ]),
        ),
      );
    });
  }
}

/// Spinner pinned to the end of the list while the next page loads (or is about
/// to, once the scroll listener fires).
class _LoadMoreFooter extends StatelessWidget {
  const _LoadMoreFooter();
  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpace.lg),
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
//  TABLE LAYOUT (tablet / desktop)
// ─────────────────────────────────────────────────────────────────────────────

// Shared column layout — single source of truth for header + rows.
class _Cols {
  static const double statusW = 10 + 16; // dot + gap
  static const int tellerF = 2;
  static const int openedF = 2;
  static const int closedF = 2;
  static const double declaredW = 110;
  static const double chevW = 44;
}

class _TableHeader extends StatelessWidget {
  const _TableHeader();

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = l10n(context);

    Widget th(String label, {bool end = false}) => Align(
          alignment:
              end ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
          child: Text(label,
              style: ui(
                  size: 11,
                  weight: FontWeight.w600,
                  color: t.textMuted,
                  letterSpacing: 0.4)),
        );

    return Container(
      height: 42,
      padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.lg),
      color: t.surfaceAlt,
      child: Row(children: [
        SizedBox(width: _Cols.statusW, child: th('')),
        Expanded(flex: _Cols.tellerF, child: th(s.commonTeller)),
        Expanded(flex: _Cols.openedF, child: th(s.shiftColOpened)),
        Expanded(flex: _Cols.closedF, child: th(s.shiftColClosed)),
        SizedBox(
            width: _Cols.declaredW,
            child: th(s.shiftDeclaredCash, end: true)),
        const SizedBox(width: _Cols.chevW),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SHIFT ROW  (expandable — same affordance as order history rows)
// ─────────────────────────────────────────────────────────────────────────────

class _ShiftRow extends ConsumerWidget {
  final Shift shift;
  final bool isEven;

  /// Stacked two-line layout below the table breakpoint (width-driven).
  final bool compact;
  const _ShiftRow(
      {required this.shift, required this.isEven, required this.compact});

  Future<void> _printReport(BuildContext context, WidgetRef ref) async {
    final ctl = ref.read(_rowProvider(shift.id).notifier);
    ctl.setPrinting(true);
    try {
      final report =
          await ref.read(shiftRepositoryProvider).getReport(shift.id);
      ctl.setPrinting(false);
      if (context.mounted) {
        await ShiftReportPreviewSheet.show(context, report);
      }
    } catch (e) {
      ctl.setPrinting(false);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(l10n(context).commonFailedLoadReport('$e')),
            backgroundColor: context.tokens.danger));
      }
    }
  }

  ChipTone get _statusTone => switch (shift.status) {
        'open' => ChipTone.success,
        'force_closed' => ChipTone.danger,
        _ => ChipTone.neutral,
      };

  String _statusLabel(AppLocalizations s) => switch (shift.status) {
        'open' => s.shiftStatusOpen,
        'closed' => s.shiftStatusClosed,
        'force_closed' => s.shiftStatusForceClosed,
        _ => shift.status.replaceAll('_', ' '),
      };

  Color _statusColor(BuildContext context) => switch (shift.status) {
        'open' => context.tokens.success,
        'force_closed' => context.tokens.danger,
        _ => context.tokens.textMuted,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final s = shift;
    final phone = compact;
    final row = ref.watch(_rowProvider(shift.id));

    return Column(mainAxisSize: MainAxisSize.min, children: [
      // ── Main row ────────────────────────────────────────────────
      GestureDetector(
        onTap: () => ref.read(_rowProvider(shift.id).notifier).toggleOrders(),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          height: phone ? 64 : 56,
          padding:
              const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.lg),
          color: row.expanded
              ? t.hoverOverlay
              : isEven
                  ? Colors.transparent
                  : t.surfaceAlt,
          child: phone ? _phoneRow(context, t, s, row) : _tableRow(context, t, s, row),
        ),
      ),

      // ── Expanded panel ───────────────────────────────────────────
      if (row.expanded) _expandedPanel(context, ref, t, s, row),
    ]);
  }

  Widget _statusDot(BuildContext context) => SizedBox(
        width: _Cols.statusW,
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
                color: _statusColor(context), shape: BoxShape.circle),
          ),
        ),
      );

  Widget _chevron(AppTokens t, _RowState row) => SizedBox(
        width: _Cols.chevW,
        child: Center(
          child: AnimatedRotation(
            duration: const Duration(milliseconds: 180),
            turns: row.expanded ? 0.5 : 0,
            child: Icon(Icons.keyboard_arrow_down_rounded,
                size: 20, color: t.textMuted),
          ),
        ),
      );

  Widget _declaredCash(AppTokens t, Shift s) => Text(
        s.closingCashDeclared != null ? egp(s.closingCashDeclared!) : '—',
        textAlign: TextAlign.end,
        style: money(
            size: 14,
            weight: FontWeight.w600,
            color:
                s.closingCashDeclared != null ? t.textPrimary : t.textMuted),
      );

  Widget _tableRow(BuildContext context, AppTokens t, Shift s, _RowState row) =>
      Row(children: [
        _statusDot(context),
        Expanded(
          flex: _Cols.tellerF,
          child: Text(s.tellerName,
              overflow: TextOverflow.ellipsis,
              style: ui(size: 14, weight: FontWeight.w600, color: t.textPrimary)),
        ),
        Expanded(
          flex: _Cols.openedF,
          child: Text(dateTime(s.openedAt),
              style: ui(size: 13, color: t.textSecondary)),
        ),
        Expanded(
          flex: _Cols.closedF,
          child: s.closedAt != null
              ? Text(dateTime(s.closedAt!),
                  style: ui(size: 13, color: t.textSecondary))
              : Text('—', style: ui(size: 13, color: t.textMuted)),
        ),
        SizedBox(width: _Cols.declaredW, child: _declaredCash(t, s)),
        _chevron(t, row),
      ]);

  Widget _phoneRow(BuildContext context, AppTokens t, Shift s, _RowState row) =>
      Row(children: [
        _statusDot(context),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(s.tellerName,
                  overflow: TextOverflow.ellipsis,
                  style: ui(
                      size: 14, weight: FontWeight.w600, color: t.textPrimary)),
              const SizedBox(height: 2),
              Text(
                s.closedAt != null
                    ? '${dateTime(s.openedAt)} → ${dateTime(s.closedAt!)}'
                    : l10n(context).shiftOpenedOn(dateTime(s.openedAt)),
                overflow: TextOverflow.ellipsis,
                style: ui(size: 11, color: t.textSecondary),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpace.sm),
        _declaredCash(t, s),
        _chevron(t, row),
      ]);

  Widget _expandedPanel(BuildContext context, WidgetRef ref, AppTokens t,
          Shift s, _RowState row) =>
      Container(
        color: t.surfaceAlt,
        padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpace.lg, AppSpace.md, AppSpace.lg, AppSpace.md + 2),
        child: SurfaceCard(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Shift meta ─────────────────────────────────
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 14, 12),
                child: Row(children: [
                  StatusChip(
                      label: _statusLabel(l10n(context)), tone: _statusTone),
                  if (s.openingCash > 0) ...[
                    const SizedBox(width: AppSpace.sm + 2),
                    StatusChip(
                      label: l10n(context)
                          .shiftOpeningChip(egp(s.openingCash)),
                      tone: ChipTone.neutral,
                      icon: Icons.account_balance_wallet_outlined,
                    ),
                  ],
                  const Spacer(),
                  StatusChip(
                    label: row.printing
                        ? l10n(context).commonLoading
                        : l10n(context).commonPrintReport,
                    tone: ChipTone.info,
                    icon: row.printing
                        ? Icons.sync_rounded
                        : Icons.print_rounded,
                    spinning: row.printing,
                    onTap:
                        row.printing ? null : () => _printReport(context, ref),
                  ),
                ]),
              ),

              Divider(height: 1, color: t.borderLight),

              // ── Orders section ────────────────────────────
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(14, 10, 14, 4),
                child: Text(l10n(context).shiftOrdersInShift,
                    style: ui(
                        size: 10,
                        weight: FontWeight.w700,
                        color: t.textMuted,
                        letterSpacing: 0.7)),
              ),

              if (row.loadingOrders)
                const Padding(
                  padding: EdgeInsets.all(AppSpace.lg + 4),
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                )
              else if (row.ordersError != null)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(14, 4, 14, 14),
                  child: Text(row.ordersError!,
                      style: ui(size: 12, color: t.danger)),
                )
              else if (row.orders.isEmpty)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(14, 4, 14, 14),
                  child: Text(l10n(context).shiftNoOrdersInShift,
                      style: ui(size: 13, color: t.textMuted)),
                )
              else
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(14, 6, 14, 14),
                  child: Container(
                    decoration: BoxDecoration(
                      color: t.surfaceAlt,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      border: Border.all(color: t.borderLight),
                    ),
                    child: Column(
                      children: List.generate(row.orders.length, (i) {
                        return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _PastOrderRow(order: row.orders[i]),
                              if (i < row.orders.length - 1)
                                Divider(
                                    height: 1,
                                    color: t.borderLight,
                                    indent: 14,
                                    endIndent: 14),
                            ]);
                      }),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
//  PAST ORDER ROW
// ─────────────────────────────────────────────────────────────────────────────

class _PastOrderRow extends ConsumerWidget {
  final Order order;
  const _PastOrderRow({required this.order});

  Future<void> _print(BuildContext context, WidgetRef ref) async {
    ref.read(_orderPrintingProvider(order.id).notifier).state = true;
    try {
      Order full = order;
      if (full.items.isEmpty) {
        try {
          full = await ref.read(orderRepositoryProvider).getOrder(order.id);
        } catch (_) {}
      }
      if (context.mounted) await ReceiptPreviewSheet.show(context, full);
    } finally {
      if (context.mounted) {
        ref.read(_orderPrintingProvider(order.id).notifier).state = false;
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final o = order;
    final isVoided = o.status == 'voided';
    final isPending = o.status == 'pending_sync';
    final printing = ref.watch(_orderPrintingProvider(o.id));

    final methods = ref.watch(paymentMethodProvider.select((s) => s.items));
    final pm =
        methods.where((m) => m.wireFormat == o.paymentMethod).firstOrNull;
    final methodText = pm != null
        ? pm.label(Localizations.localeOf(context).languageCode)
        : o.paymentMethod;

    return Padding(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 11),
      child: Row(children: [
        // Order number bubble
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: isVoided ? t.borderLight : t.navyBg,
            borderRadius: BorderRadius.circular(9),
          ),
          alignment: Alignment.center,
          child: Text(
            o.orderNumber > 0 ? '#${o.orderNumber}' : '#?',
            style: ui(
                size: 11,
                weight: FontWeight.w700,
                color: isVoided ? t.textMuted : t.navy),
          ),
        ),
        const SizedBox(width: AppSpace.md),

        // Time + customer + payment method
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(timeShort(o.createdAt),
                  style: ui(size: 13, color: t.textSecondary)),
              if (isVoided) ...[
                const SizedBox(width: 6),
                StatusChip(
                    label: l10n(context).commonVoided,
                    tone: ChipTone.danger),
              ],
              if (isPending) ...[
                const SizedBox(width: 6),
                StatusChip(
                    label: l10n(context).commonPendingSync,
                    tone: ChipTone.warning),
              ],
            ]),
            if (o.customerName != null && o.customerName!.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(o.customerName!, style: ui(size: 12, color: t.textMuted)),
            ],
            const SizedBox(height: 2),
            Text(methodText,
                style: ui(size: 11, weight: FontWeight.w600, color: t.navy)),
            if (o.orderRef != null) ...[
              const SizedBox(height: 2),
              Text(o.orderRef!, style: ui(size: 10, color: t.textMuted)),
            ],
          ]),
        ),

        // Amount
        Text(egp(o.totalAmount),
            style: money(
              size: 14,
              weight: FontWeight.w600,
              color: isVoided ? t.textMuted : t.textPrimary,
            ).copyWith(
                decoration: isVoided ? TextDecoration.lineThrough : null)),
        const SizedBox(width: AppSpace.md),

        // Print button — while printing, the receipt feeds out of the
        // printer on a gentle loop in place of a plain spinner.
        printing
            ? SizedBox(
                width: 24,
                height: 24,
                child: LoopingIcon(
                  duration: const Duration(milliseconds: 1500),
                  builder: (_, a) => CustomPaint(
                      size: const Size(24, 24),
                      painter: PrinterPainter(
                          t: a, color: t.navy, paperFill: t.surface)),
                ),
              )
            : AnimatedPressScale(
                onTap: () => _print(context, ref),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: t.surfaceAlt,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: t.border)),
                  alignment: Alignment.center,
                  child: Icon(Icons.print_rounded,
                      size: 14, color: t.textSecondary),
                ),
              ),
      ]),
    );
  }
}
