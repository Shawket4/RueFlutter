import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/repositories/order_repository.dart';
import '../../core/repositories/shift_repository.dart';
import 'shift_report_preview_sheet.dart';
import '../order/widgets/receipt_preview_sheet.dart';
import '../../core/models/order.dart';
import '../../core/models/shift.dart';
import '../../core/providers/auth_notifier.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatting.dart';
import '../../shared/widgets/error_banner.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class ShiftHistoryScreen extends ConsumerStatefulWidget {
  const ShiftHistoryScreen({super.key});
  @override
  ConsumerState<ShiftHistoryScreen> createState() => _ShiftHistoryScreenState();
}

class _ShiftHistoryScreenState extends ConsumerState<ShiftHistoryScreen> {
  List<Shift> _shifts = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final branchId = ref.read(authProvider).user?.branchId;
    if (branchId == null) {
      setState(() {
        _loading = false;
        _error = 'No branch assigned';
      });
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final local = ref.read(shiftRepositoryProvider).loadShiftsLocal(branchId);
      if (local != null && local.isNotEmpty && mounted) {
        setState(() {
          _shifts = local;
          _loading = false;
        });
      }
      final fresh =
          await ref.read(shiftRepositoryProvider).fetchShiftsFresh(branchId);
      if (mounted)
        setState(() {
          _shifts = fresh;
          _loading = false;
        });
    } catch (e) {
      if (mounted)
        setState(() {
          _error = _shifts.isEmpty ? e.toString() : null;
          _loading = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(children: [
        // ── Top bar ──────────────────────────────────────────────────
        _TopBar(
          paddingTop: top,
          onBack: () => context.pop(),
          onRefresh: _load,
        ),

        // ── Content ──────────────────────────────────────────────────
        Expanded(
          child: _loading && _shifts.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.primary))
              : _error != null
                  ? Padding(
                      padding: const EdgeInsets.all(24),
                      child: ErrorBanner(message: _error!, onRetry: _load),
                    )
                  : _shifts.isEmpty
                      ? Center(
                          child: Text('No shifts found',
                              style: cairo(
                                  fontSize: 15,
                                  color: AppColors.textSecondary)),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(AppRadius.lg),
                              border: Border.all(color: AppColors.borderLight),
                              boxShadow: AppShadows.card,
                            ),
                            child: Column(children: [
                              _TableHeader(),
                              const Divider(
                                  height: 1, color: AppColors.borderLight),
                              Expanded(
                                child: ListView.separated(
                                  padding: EdgeInsets.zero,
                                  itemCount: _shifts.length,
                                  separatorBuilder: (_, __) => const Divider(
                                      height: 1, color: AppColors.borderLight),
                                  itemBuilder: (_, i) =>
                                      _ShiftRow(shift: _shifts[i]),
                                ),
                              ),
                            ]),
                          ),
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
  final VoidCallback onRefresh;
  const _TopBar(
      {required this.paddingTop,
      required this.onBack,
      required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16, paddingTop + 10, 16, 12),
      child: Row(children: [
        _IconBtn(icon: Icons.arrow_back_rounded, onTap: onBack),
        const SizedBox(width: 14),
        Text('Past Shifts',
            style: cairo(fontSize: 18, fontWeight: FontWeight.w700)),
        const Spacer(),
        _IconBtn(icon: Icons.refresh_rounded, onTap: onRefresh),
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
//  TABLE HEADER
// ─────────────────────────────────────────────────────────────────────────────

// Shared column layout — single source of truth for header + rows.
class _Cols {
  static const double statusW = 10 + 16; // dot + right gap
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
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      child: Row(children: [
        SizedBox(width: _Cols.statusW, child: _th('')),
        Expanded(flex: _Cols.tellerF, child: _th('Teller')),
        Expanded(flex: _Cols.openedF, child: _th('Opened')),
        Expanded(flex: _Cols.closedF, child: _th('Closed')),
        SizedBox(
            width: _Cols.declaredW,
            child: _th('Declared cash', alignRight: true)),
        const SizedBox(width: _Cols.chevW),
      ]),
    );
  }

  Widget _th(String label, {bool alignRight = false}) => Align(
        alignment: alignRight ? Alignment.centerRight : Alignment.centerLeft,
        child: Text(label,
            style: cairo(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
                letterSpacing: 0.4)),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
//  SHIFT ROW  (expandable)
// ─────────────────────────────────────────────────────────────────────────────

class _ShiftRow extends ConsumerStatefulWidget {
  final Shift shift;
  const _ShiftRow({required this.shift});
  @override
  ConsumerState<_ShiftRow> createState() => _ShiftRowState();
}

class _ShiftRowState extends ConsumerState<_ShiftRow> {
  bool _expanded = false;
  bool _loadingOrders = false;
  bool _printing = false;
  List<Order> _orders = [];
  String? _ordersError;

  Future<void> _toggleOrders() async {
    if (_orders.isNotEmpty || _expanded) {
      setState(() => _expanded = !_expanded);
      return;
    }
    setState(() {
      _loadingOrders = true;
      _expanded = true;
    });
    try {
      final local =
          ref.read(orderRepositoryProvider).loadOrdersLocal(widget.shift.id);
      if (local != null && local.isNotEmpty && mounted) {
        setState(() {
          _orders = local;
          _loadingOrders = false;
        });
      }
      final fresh = await ref
          .read(orderRepositoryProvider)
          .fetchOrdersFresh(widget.shift.id);
      if (mounted)
        setState(() {
          _orders = fresh;
          _loadingOrders = false;
        });
    } catch (e) {
      if (mounted)
        setState(() {
          _ordersError = _orders.isEmpty ? e.toString() : null;
          _loadingOrders = false;
        });
    }
  }

  Future<void> _printReport() async {
    setState(() => _printing = true);
    try {
      final report =
          await ref.read(shiftRepositoryProvider).getReport(widget.shift.id);
      if (mounted) {
        setState(() => _printing = false);
        await ShiftReportPreviewSheet.show(context, report);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _printing = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to load report: $e'),
            backgroundColor: AppColors.danger));
      }
    }
  }

  Color get _statusColor => switch (widget.shift.status) {
        'open' => AppColors.success,
        'force_closed' => AppColors.danger,
        _ => AppColors.textSecondary,
      };

  String get _statusLabel => switch (widget.shift.status) {
        'open' => 'Open',
        'closed' => 'Closed',
        'force_closed' => 'Force closed',
        _ => widget.shift.status.replaceAll('_', ' '),
      };

  @override
  Widget build(BuildContext context) {
    final s = widget.shift;

    return Column(mainAxisSize: MainAxisSize.min, children: [
      // ── Main row ────────────────────────────────────────────────
      GestureDetector(
        onTap: _toggleOrders,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: _expanded ? AppColors.primary.withOpacity(0.04) : Colors.white,
          child: Row(children: [
            // Status dot
            SizedBox(
              width: _Cols.statusW,
              child: Container(
                width: 8,
                height: 8,
                decoration:
                    BoxDecoration(color: _statusColor, shape: BoxShape.circle),
              ),
            ),
            // Teller
            Expanded(
              flex: _Cols.tellerF,
              child: Text(s.tellerName,
                  style: cairo(fontSize: 14, fontWeight: FontWeight.w600)),
            ),
            // Opened
            Expanded(
              flex: _Cols.openedF,
              child: Text(dateTime(s.openedAt),
                  style: cairo(fontSize: 13, color: AppColors.textSecondary)),
            ),
            // Closed
            Expanded(
              flex: _Cols.closedF,
              child: s.closedAt != null
                  ? Text(dateTime(s.closedAt!),
                      style:
                          cairo(fontSize: 13, color: AppColors.textSecondary))
                  : Text('—',
                      style: cairo(fontSize: 13, color: AppColors.textMuted)),
            ),
            // Declared cash
            SizedBox(
              width: _Cols.declaredW,
              child: Text(
                  s.closingCashDeclared != null
                      ? egp(s.closingCashDeclared!)
                      : '—',
                  textAlign: TextAlign.right,
                  style: cairo(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: s.closingCashDeclared != null
                          ? AppColors.textPrimary
                          : AppColors.textMuted)),
            ),
            // Chevron
            SizedBox(
              width: _Cols.chevW,
              child: Center(
                child: AnimatedRotation(
                  duration: const Duration(milliseconds: 180),
                  turns: _expanded ? 0.5 : 0,
                  child: const Icon(Icons.keyboard_arrow_down_rounded,
                      size: 20, color: AppColors.textMuted),
                ),
              ),
            ),
          ]),
        ),
      ),

      // ── Expanded panel ───────────────────────────────────────────
      if (_expanded)
        Container(
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
                // ── Shift meta ─────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                  child: Row(children: [
                    _StatusPill(_statusLabel, _statusColor),
                    if (s.openingCash > 0) ...[
                      const SizedBox(width: 10),
                      _MetaChip(
                        icon: Icons.account_balance_wallet_outlined,
                        label: 'Opening ${egp(s.openingCash)}',
                      ),
                    ],
                    const Spacer(),
                    // Print report button
                    _printing
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: AppColors.primary))
                        : _ActionBtn(
                            icon: Icons.print_rounded,
                            label: 'Print report',
                            color: AppColors.primary,
                            onTap: _printReport,
                          ),
                  ]),
                ),

                const Divider(height: 1, color: AppColors.borderLight),

                // ── Orders section ────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 10, 14, 4),
                  child: Text('Orders in this shift',
                      style: cairo(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textMuted,
                          letterSpacing: 0.7)),
                ),

                if (_loadingOrders)
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: AppColors.primary),
                      ),
                    ),
                  )
                else if (_ordersError != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 4, 14, 14),
                    child: Text(_ordersError!,
                        style: cairo(fontSize: 12, color: AppColors.danger)),
                  )
                else if (_orders.isEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 4, 14, 14),
                    child: Text('No orders in this shift',
                        style: cairo(fontSize: 13, color: AppColors.textMuted)),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 6, 14, 14),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.bg,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: Column(
                        children: List.generate(_orders.length, (i) {
                          return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _PastOrderRow(order: _orders[i]),
                                if (i < _orders.length - 1)
                                  const Divider(
                                      height: 1,
                                      color: AppColors.borderLight,
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
        ),
    ]);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  PAST ORDER ROW
// ─────────────────────────────────────────────────────────────────────────────

class _PastOrderRow extends ConsumerStatefulWidget {
  final Order order;
  const _PastOrderRow({required this.order});
  @override
  ConsumerState<_PastOrderRow> createState() => _PastOrderRowState();
}

class _PastOrderRowState extends ConsumerState<_PastOrderRow> {
  bool _printing = false;

  Future<void> _print() async {
    setState(() => _printing = true);
    try {
      Order full = widget.order;
      try {
        final freshList = await ref
            .read(orderRepositoryProvider)
            .fetchOrdersFresh(widget.order.shiftId);
        final match = freshList.where((o) => o.id == widget.order.id);
        if (match.isNotEmpty) full = match.first;
      } catch (_) {}
      if (mounted) await ReceiptPreviewSheet.show(context, full);
    } finally {
      if (mounted) setState(() => _printing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final o = widget.order;
    final isVoided = o.status == 'voided';
    final isPending = o.status == 'pending_sync';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      child: Row(children: [
        // Order number bubble
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: isVoided
                ? AppColors.borderLight
                : AppColors.primary.withOpacity(0.07),
            borderRadius: BorderRadius.circular(9),
          ),
          alignment: Alignment.center,
          child: Text(
            o.orderNumber > 0 ? '#${o.orderNumber}' : '#?',
            style: cairo(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isVoided ? AppColors.textMuted : AppColors.primary),
          ),
        ),
        const SizedBox(width: 12),

        // Time + customer
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(timeShort(o.createdAt),
                  style: cairo(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary)),
              if (isVoided) ...[
                const SizedBox(width: 6),
                _StatusPill('Voided', AppColors.danger),
              ],
              if (isPending) ...[
                const SizedBox(width: 6),
                _StatusPill('Pending sync', AppColors.warning),
              ],
            ]),
            if (o.customerName != null && o.customerName!.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(o.customerName!,
                  style: cairo(fontSize: 12, color: AppColors.textMuted)),
            ],
          ]),
        ),

        // Amount
        Text(egp(o.totalAmount),
            style: cairo(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isVoided ? AppColors.textMuted : AppColors.textPrimary,
                decoration: isVoided ? TextDecoration.lineThrough : null)),
        const SizedBox(width: 12),

        // Print button
        _printing
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: AppColors.primary))
            : GestureDetector(
                onTap: _print,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: AppColors.bg,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: AppColors.border)),
                  alignment: Alignment.center,
                  child: const Icon(Icons.print_rounded,
                      size: 14, color: AppColors.textSecondary),
                ),
              ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SMALL WIDGETS
// ─────────────────────────────────────────────────────────────────────────────

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

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _MetaChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.bg,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 13, color: AppColors.textMuted),
          const SizedBox(width: 5),
          Text(label,
              style: cairo(fontSize: 12, color: AppColors.textSecondary)),
        ]),
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
