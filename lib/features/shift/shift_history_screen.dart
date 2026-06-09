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

class ShiftHistoryScreen extends ConsumerStatefulWidget {
  const ShiftHistoryScreen({super.key});
  @override
  ConsumerState<ShiftHistoryScreen> createState() => _ShiftHistoryScreenState();
}

class _ShiftHistoryScreenState extends ConsumerState<ShiftHistoryScreen> {
  List<Shift> _shifts  = [];
  bool        _loading = true;
  String?     _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final branchId = ref.read(authProvider).user?.branchId;
    if (branchId == null) {
      setState(() { _loading = false; _error = 'No branch assigned'; });
      return;
    }
    setState(() { _loading = true; _error = null; });
    try {
      final local = ref.read(shiftRepositoryProvider).loadShiftsLocal(branchId);
      if (local != null && local.isNotEmpty && mounted) {
        setState(() { _shifts = local; _loading = false; });
      }
      final fresh = await ref.read(shiftRepositoryProvider).fetchShiftsFresh(branchId);
      if (mounted) setState(() { _shifts = fresh; _loading = false; });
    } catch (e) {
      if (mounted) setState(() { _error = _shifts.isEmpty ? e.toString() : null; _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        // ── Top Bar ────────────────────────────────────────────────────────
        Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(14, MediaQuery.of(context).padding.top + 8, 14, 10),
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
                child: const Icon(Icons.arrow_back_rounded, size: 18, color: AppColors.textPrimary),
              ),
            ),
            const SizedBox(width: 12),
            Text('Past Shifts', style: cairo(fontSize: 17, fontWeight: FontWeight.w700)),
            const Spacer(),
            GestureDetector(
              onTap: _load,
              child: Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                    color: AppColors.bg,
                    borderRadius: BorderRadius.circular(AppRadius.xs),
                    border: Border.all(color: AppColors.border)),
                alignment: Alignment.center,
                child: const Icon(Icons.refresh_rounded, size: 18, color: AppColors.textSecondary),
              ),
            ),
          ]),
        ),
        Container(height: 1, color: AppColors.border),

        // ── Content ────────────────────────────────────────────────────────
        Expanded(
          child: _loading && _shifts.isEmpty
              ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
              : _error != null
                  ? Padding(padding: const EdgeInsets.all(24),
                      child: ErrorBanner(message: _error!, onRetry: _load))
                  : _shifts.isEmpty
                      ? Center(child: Text('No shifts found',
                          style: cairo(fontSize: 15, color: AppColors.textSecondary)))
                      : Container(
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(AppRadius.lg),
                            border: Border.all(color: AppColors.borderLight),
                            boxShadow: AppShadows.card,
                          ),
                          child: Column(children: [
                            // Headers
                            Container(
                              decoration: const BoxDecoration(
                                color: AppColors.bg,
                                borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: Row(children: [
                                SizedBox(width: 48, child: Text('Status', style: cairo(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textSecondary))),
                                Expanded(flex: 2, child: Text('Teller', style: cairo(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textSecondary))),
                                Expanded(flex: 2, child: Text('Time', style: cairo(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textSecondary))),
                                SizedBox(width: 80, child: Text('Declared', textAlign: TextAlign.right, style: cairo(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textSecondary))),
                                const SizedBox(width: 36),
                              ]),
                            ),
                            const Divider(height: 1, color: AppColors.borderLight),

                            // List
                            Expanded(
                              child: ListView.separated(
                                padding: EdgeInsets.zero,
                                itemCount: _shifts.length,
                                separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.borderLight),
                                itemBuilder: (_, i) => _ShiftRow(shift: _shifts[i]),
                              ),
                            ),
                          ]),
                        ),
        ),
      ]),
    );
  }
}

class _ShiftRow extends ConsumerStatefulWidget {
  final Shift shift;
  const _ShiftRow({required this.shift});
  @override
  ConsumerState<_ShiftRow> createState() => _ShiftRowState();
}

class _ShiftRowState extends ConsumerState<_ShiftRow> {
  bool        _expanded      = false;
  bool        _loadingOrders = false;
  bool        _printing      = false;
  List<Order> _orders        = [];
  String?     _ordersError;

  Future<void> _toggleOrders() async {
    if (_orders.isNotEmpty) {
      setState(() => _expanded = !_expanded);
      return;
    }
    setState(() { _loadingOrders = true; _expanded = true; });
    try {
      final local = ref.read(orderRepositoryProvider).loadOrdersLocal(widget.shift.id);
      if (local != null && local.isNotEmpty && mounted) {
        setState(() { _orders = local; _loadingOrders = false; });
      }
      final fresh = await ref.read(orderRepositoryProvider).fetchOrdersFresh(widget.shift.id);
      if (mounted) setState(() { _orders = fresh; _loadingOrders = false; });
    } catch (e) {
      if (mounted) setState(() { _ordersError = _orders.isEmpty ? e.toString() : null; _loadingOrders = false; });
    }
  }

  Future<void> _printReport() async {
    setState(() => _printing = true);
    try {
      final report = await ref.read(shiftRepositoryProvider).getReport(widget.shift.id);
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

  @override
  Widget build(BuildContext context) {
    final s           = widget.shift;
    final statusColor = s.status == 'open'
        ? AppColors.success
        : s.status == 'force_closed'
            ? AppColors.danger
            : AppColors.textSecondary;

    return Container(
      decoration: BoxDecoration(
        color: _expanded ? AppColors.primary.withOpacity(0.04) : Colors.white,
      ),
      child: Column(children: [
        // ── Main Row ───────────────────────────────────────────────────────
        GestureDetector(
          onTap: _toggleOrders,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(children: [
              SizedBox(width: 48, child: Align(alignment: Alignment.centerLeft, child: Container(
                  width: 10, height: 10,
                  decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)))),
              Expanded(flex: 2, child: Text(s.tellerName, style: cairo(fontSize: 14, fontWeight: FontWeight.w600))),
              Expanded(flex: 2, child: Text(dateTime(s.openedAt), style: cairo(fontSize: 13, color: AppColors.textSecondary))),
              SizedBox(width: 80, child: Text(s.closingCashDeclared != null ? egp(s.closingCashDeclared!) : '-',
                  textAlign: TextAlign.right, style: cairo(fontSize: 14, fontWeight: FontWeight.w700))),
              const SizedBox(width: 16),
              Icon(
                  _expanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                  size: 20, color: AppColors.textMuted),
            ]),
          ),
        ),

        // ── Expanded Detail ────────────────────────────────────────────────
        if (_expanded) ...[
          Container(
            width: double.infinity,
            color: AppColors.bg.withOpacity(0.5),
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Meta info
              Row(children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6)),
                    child: Text(s.status.replaceAll('_', ' ').toUpperCase(),
                        style: cairo(fontSize: 10, fontWeight: FontWeight.w800, color: statusColor))),
                const Spacer(),
                if (_printing)
                  const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary))
                else
                  GestureDetector(
                    onTap: _printReport,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppColors.border)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(Icons.print_rounded, size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 6),
                        Text('Print Report', style: cairo(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
                      ]),
                    ),
                  ),
              ]),
              const SizedBox(height: 16),
              
              // Orders section
              Text('Orders in this shift', style: cairo(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 1.1)),
              const SizedBox(height: 8),
              if (_loadingOrders)
                const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 2)))
              else if (_ordersError != null)
                Text(_ordersError!, style: cairo(fontSize: 12, color: AppColors.danger))
              else if (_orders.isEmpty)
                Text('No orders in this shift', style: cairo(fontSize: 13, color: AppColors.textMuted))
              else
                Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.borderLight)),
                  child: Column(children: _orders.map((o) => _PastOrderRow(order: o)).toList()),
                ),
            ]),
          ),
        ],
      ]),
    );
  }
}

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
        final freshList = await ref.read(orderRepositoryProvider).fetchOrdersFresh(widget.order.shiftId);
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
    final o        = widget.order;
    final isVoided = o.status == 'voided';
    final isPending = o.status == 'pending_sync';

    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderLight))),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(children: [
        Container(
            width:  32, height: 32,
            decoration: BoxDecoration(
                color: isVoided ? AppColors.borderLight : AppColors.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: Text(o.orderNumber > 0 ? '#${o.orderNumber}' : '#?',
                style: cairo(fontSize: 11, fontWeight: FontWeight.w700,
                    color: isVoided ? AppColors.textMuted : AppColors.primary))),
        const SizedBox(width: 12),
        Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(timeShort(o.createdAt), style: cairo(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
            if (isPending) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(color: AppColors.warning.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                child: Text('PENDING', style: cairo(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.warning)),
              ),
            ],
          ]),
          if (o.customerName != null && o.customerName!.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(o.customerName!, style: cairo(fontSize: 12, color: AppColors.textMuted)),
          ],
        ])),
        Text(egp(o.totalAmount),
            style: cairo(fontSize: 14, fontWeight: FontWeight.w700,
                color: isVoided ? AppColors.textMuted : AppColors.textPrimary,
                decoration: isVoided ? TextDecoration.lineThrough : null)),
        const SizedBox(width: 12),
          _printing
              ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary))
              : GestureDetector(
                  onTap: _print,
                  child: Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppColors.border)),
                      alignment: Alignment.center,
                      child: const Icon(Icons.print_rounded, size: 14, color: AppColors.textSecondary))),
      ]),
    );
  }
}
