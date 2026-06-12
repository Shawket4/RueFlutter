import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/l10n.dart';
import '../../core/models/branch.dart';
import '../../core/models/shift_report.dart';
import '../../core/providers/auth_notifier.dart';
import '../../core/providers/payment_method_notifier.dart';
import '../../core/services/printer_service.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatting.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/responsive_sheet.dart';
import '../../shared/widgets/status_chip.dart';
import '../../shared/widgets/surface_card.dart';
import '../order/helpers/payment_helpers.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  EPHEMERAL STATE — autoDispose provider (resets when the sheet closes).
// ─────────────────────────────────────────────────────────────────────────────

class _PrintState {
  final bool printing;
  final String? printError;
  const _PrintState({this.printing = false, this.printError});
}

final _printProvider =
    NotifierProvider.autoDispose<_PrintController, _PrintState>(
        _PrintController.new);

class _PrintController extends AutoDisposeNotifier<_PrintState> {
  bool _disposed = false;

  @override
  _PrintState build() {
    ref.onDispose(() => _disposed = true);
    return const _PrintState();
  }

  void start() {
    if (_disposed) return;
    state = const _PrintState(printing: true);
  }

  void finish(String? error) {
    if (_disposed) return;
    state = _PrintState(printing: false, printError: error);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Public entry point
// ─────────────────────────────────────────────────────────────────────────────

class ShiftReportPreviewSheet extends ConsumerWidget {
  final ShiftReport report;

  const ShiftReportPreviewSheet({super.key, required this.report});

  /// Show the sheet.  Returns after the user closes it.
  static Future<void> show(BuildContext context, ShiftReport report) =>
      ResponsiveSheet.show(
        context: context,
        builder: (_) => ShiftReportPreviewSheet(report: report),
      );

  // ── Print ────────────────────────────────────────────────────────────────
  Future<void> _print(BuildContext context, WidgetRef ref) async {
    final t = context.tokens;
    final branch = ref.read(authProvider).branch;
    if (branch == null || !branch.hasPrinter) {
      _showSnack(context, l10n(context).commonNoPrinterForBranch,
          color: t.warning);
      return;
    }
    final ctl = ref.read(_printProvider.notifier);
    ctl.start();
    final methods = ref.read(paymentMethodProvider).items;

    final err = await PrinterService.printShiftReport(
      ip: branch.printerIp!,
      port: branch.printerPort ?? 9100,
      brand: branch.printerBrand!,
      report: report,
      paymentMethods: methods,
      branchName: branch.name,
      logoUrl: branch.orgLogoUrl,
    );
    ctl.finish(err);
    if (err == null && context.mounted) {
      _showSnack(context, l10n(context).shiftReportPrinted,
          color: context.tokens.success);
    }
  }

  void _showSnack(BuildContext context, String msg, {required Color color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: color),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────
  String _fmtDt(DateTime dt) {
    final l = dt.toLocal();
    final d = l.day.toString().padLeft(2, '0');
    final mo = l.month.toString().padLeft(2, '0');
    final h = l.hour.toString().padLeft(2, '0');
    final mi = l.minute.toString().padLeft(2, '0');
    return '$d/$mo/${l.year}  $h:$mi';
  }

  // ── Build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final s = l10n(context);
    final locale = Localizations.localeOf(context).languageCode;
    final mq = MediaQuery.of(context);
    final methods = ref.watch(paymentMethodProvider.select((p) => p.items));
    final printState = ref.watch(_printProvider);
    final r = report;
    final isOpen = r.isOpen;
    final openTs = _fmtDt(r.openedAt);
    final closeTs = r.closedAt != null ? _fmtDt(r.closedAt!) : null;

    final branch = ref.watch(authProvider.select((a) => a.branch));
    final hasPrinter = branch?.hasPrinter ?? false;

    return Container(
      constraints: BoxConstraints(maxHeight: mq.size.height * 0.92),
      decoration: BoxDecoration(
        color: t.bg,
        borderRadius: AppRadius.sheetRadius,
      ),
      child: Column(children: [
        // ── Handle + header ────────────────────────────────────────────────
        Container(
          decoration: BoxDecoration(
            color: t.surface,
            borderRadius: AppRadius.sheetRadius,
            border: Border(bottom: BorderSide(color: t.border)),
          ),
          padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 16, 14),
          child: Column(children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: t.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpace.md),
            Row(children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s.shiftReportTitle,
                          style: ui(
                              size: 18,
                              weight: FontWeight.w700,
                              color: t.textPrimary)),
                      const SizedBox(height: 2),
                      Text(r.tellerName,
                          style: ui(size: 13, color: t.textSecondary)),
                    ]),
              ),
              StatusChip(
                label: isOpen ? s.shiftReportOpenChip : s.shiftStatusClosed,
                tone: isOpen ? ChipTone.success : ChipTone.neutral,
              ),
            ]),
          ]),
        ),

        // ── Scrollable body ────────────────────────────────────────────────
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Shift info card ────────────────────────────────────────
                  SurfaceCard(
                    child: Column(children: [
                      _SectionTitle(s.shiftReportDetails),
                      const SizedBox(height: AppSpace.sm),
                      _Row(s.shiftColOpened, openTs),
                      if (closeTs != null) _Row(s.shiftColClosed, closeTs),
                      _Row(s.shiftOpeningCash, egp(r.openingCash),
                          isMoney: true),
                      _Row(s.shiftExpectedCash, egp(r.expectedCash()),
                          isMoney: true),
                      if (r.closingCashDeclared != null) ...[
                        _Row(s.shiftDeclaredCash, egp(r.closingCashDeclared!),
                            isMoney: true, bold: true),
                        Divider(color: t.borderLight, height: 16),
                        _DiscrepancyRow(
                            declared: r.closingCashDeclared!,
                            expected: r.expectedCash()),
                      ],
                    ]),
                  ),
                  const SizedBox(height: AppSpace.md),

                  // ── Payments card ──────────────────────────────────────────
                  SurfaceCard(
                    child: Column(children: [
                      _SectionTitle(s.shiftPaymentBreakdown),
                      const SizedBox(height: AppSpace.sm),
                      if (r.paymentSummary.isEmpty)
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: AppSpace.md),
                          child: Center(
                            child: Text(s.shiftNoPayments,
                                style: ui(size: 13, color: t.textMuted)),
                          ),
                        )
                      else ...[
                        ...r.paymentSummary.map((p) {
                          final pct = r.totalPayments > 0
                              ? p.total / r.totalPayments
                              : 0.0;
                          final color = methodColor(methods, p.paymentMethod);
                          return Padding(
                            padding:
                                const EdgeInsets.only(bottom: AppSpace.sm + 2),
                            child: Column(children: [
                              Row(children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: AppSpace.sm),
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            methodLabel(methods, locale,
                                                p.paymentMethod),
                                            style: ui(
                                                size: 13,
                                                weight: FontWeight.w600,
                                                color: t.textPrimary)),
                                        Text(
                                            s.commonOrdersCount(p.orderCount),
                                            style: ui(
                                                size: 11,
                                                color: t.textMuted)),
                                      ]),
                                ),
                                Text(egp(p.total),
                                    style: money(
                                        size: 14, color: t.textPrimary)),
                              ]),
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: pct.toDouble(),
                                  minHeight: 5,
                                  backgroundColor: t.borderLight,
                                  valueColor: AlwaysStoppedAnimation(color),
                                ),
                              ),
                            ]),
                          );
                        }),
                        Divider(color: t.borderLight, height: 20),
                        _Row(s.shiftTotalPayments, egp(r.totalPayments),
                            isMoney: true, bold: true, large: true),
                        if (r.totalReturns > 0)
                          _Row(s.shiftVoidedOrders, '− ${egp(r.totalReturns)}',
                              isMoney: true, valueColor: t.danger),
                        if (r.totalReturns > 0)
                          _Row(s.shiftNetPayments, egp(r.netPayments),
                              isMoney: true,
                              bold: true,
                              large: true,
                              valueColor: t.success),
                      ],
                    ]),
                  ),
                  const SizedBox(height: AppSpace.md),

                  // ── Cash movements card ────────────────────────────────────
                  SurfaceCard(
                    child: Column(children: [
                      _SectionTitle(s.shiftCashMovementsHeader),
                      const SizedBox(height: AppSpace.sm),
                      if (r.cashMovements.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: AppSpace.sm + 2),
                          child: Center(
                            child: Text(s.shiftNoCashMovements,
                                style: ui(size: 13, color: t.textMuted)),
                          ),
                        )
                      else ...[
                        ...r.cashMovements.map((m) {
                          final isIn = m.isIn;
                          final color = isIn ? t.success : t.danger;
                          final bg = isIn ? t.successBg : t.dangerBg;
                          final sign = isIn ? '+' : '−';
                          final ts = _fmtDt(m.createdAt);
                          return Padding(
                            padding:
                                const EdgeInsets.only(bottom: AppSpace.sm + 2),
                            child: Row(children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: bg,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  isIn
                                      ? Icons.add_rounded
                                      : Icons.remove_rounded,
                                  size: 16,
                                  color: color,
                                ),
                              ),
                              const SizedBox(width: AppSpace.sm + 2),
                              Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(m.note,
                                          style: ui(
                                              size: 13,
                                              color: t.textPrimary)),
                                      Text('${m.movedByName} · $ts',
                                          style: ui(
                                              size: 11, color: t.textMuted)),
                                    ]),
                              ),
                              Text('$sign ${egp(m.amount.abs())}',
                                  style: money(size: 13, color: color)),
                            ]),
                          );
                        }),
                        Divider(color: t.borderLight, height: 20),
                        _Row(s.shiftPayIn, egp(r.cashMovementsIn),
                            isMoney: true, valueColor: t.success),
                        _Row(s.shiftPayOut, egp(r.cashMovementsOut),
                            isMoney: true, valueColor: t.danger),
                      ],
                    ]),
                  ),
                  const SizedBox(height: AppSpace.md),

                  // ── Printed at ─────────────────────────────────────────────
                  Center(
                    child: Text(
                      s.shiftReportGenerated(_fmtDt(r.printedAt)),
                      style: ui(size: 11, color: t.textMuted),
                    ),
                  ),
                  const SizedBox(height: AppSpace.sm),
                ]),
          ),
        ),

        // ── Print button ───────────────────────────────────────────────────
        Container(
          decoration: BoxDecoration(
            color: t.surface,
            border: Border(top: BorderSide(color: t.border)),
          ),
          padding: EdgeInsetsDirectional.fromSTEB(
              16, 12, 16, mq.padding.bottom + 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (printState.printError != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpace.sm + 2),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: t.dangerBg,
                      borderRadius: BorderRadius.circular(AppRadius.xs),
                      border: Border.all(color: t.danger.withOpacity(0.25)),
                    ),
                    child: Row(children: [
                      Icon(Icons.error_outline_rounded,
                          size: 14, color: t.danger),
                      const SizedBox(width: AppSpace.sm),
                      Expanded(
                        child: Text(printState.printError!,
                            style: ui(size: 12, color: t.danger)),
                      ),
                    ]),
                  ),
                ),
              AppButton(
                label: hasPrinter
                    ? (printState.printError != null
                        ? s.commonRetryPrint
                        : s.commonPrintReport)
                    : s.noPrinterConfigured,
                icon: printState.printError != null
                    ? Icons.refresh_rounded
                    : Icons.print_rounded,
                width: double.infinity,
                height: 52,
                loading: printState.printing,
                onTap: hasPrinter && !printState.printing
                    ? () => _print(context, ref)
                    : null,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Small layout helpers (private to this file)
// ─────────────────────────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          text,
          style: ui(
            size: 10,
            weight: FontWeight.w700,
            color: context.tokens.textMuted,
            letterSpacing: 1.2,
          ),
        ),
      );
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;
  final bool large;
  final bool isMoney;
  final Color? valueColor;

  const _Row(this.label, this.value,
      {this.bold = false,
      this.large = false,
      this.isMoney = false,
      this.valueColor});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final color = valueColor ?? t.textPrimary;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpace.xs),
      child: Row(children: [
        Expanded(
          child: Text(label,
              style: ui(size: large ? 14 : 13, color: t.textSecondary)),
        ),
        Text(value,
            style: isMoney
                ? money(
                    size: large ? 15 : 13,
                    weight: bold ? FontWeight.w800 : FontWeight.w600,
                    color: color)
                : ui(
                    size: large ? 15 : 13,
                    weight: bold ? FontWeight.w800 : FontWeight.w600,
                    color: color)),
      ]),
    );
  }
}

/// Explicit drawer-versus-system wording — same rule and colors as the
/// close-shift screen.
class _DiscrepancyRow extends StatelessWidget {
  final int declared;
  final int expected;

  const _DiscrepancyRow({required this.declared, required this.expected});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = l10n(context);
    final diff = declared - expected;
    final (color, bg, icon, label) = diff == 0
        ? (
            t.success,
            t.successBg,
            Icons.check_circle_outline_rounded,
            s.shiftDrawerMatches
          )
        : diff > 0
            ? (
                t.warning,
                t.warningBg,
                Icons.arrow_upward_rounded,
                s.shiftDrawerOver(egp(diff))
              )
            : (
                t.danger,
                t.dangerBg,
                Icons.arrow_downward_rounded,
                s.shiftDrawerShort(egp(diff.abs()))
              );

    return Container(
      width: double.infinity,
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.xs),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(children: [
        Icon(icon, size: 15, color: color),
        const SizedBox(width: AppSpace.sm),
        Text(label,
            style: ui(size: 13, weight: FontWeight.w700, color: color)),
      ]),
    );
  }
}
