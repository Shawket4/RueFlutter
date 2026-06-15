import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/models/branch.dart';
import '../../../core/models/order.dart';
import '../../../core/providers/auth_notifier.dart';
import '../../../core/services/printer_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import '../../../shared/widgets/animated_icons.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/responsive_sheet.dart';
import '../../../shared/widgets/status_chip.dart';
import '../../../shared/widgets/surface_card.dart';
import '../helpers/payment_helpers.dart';
import '../../../core/providers/payment_method_notifier.dart';

/// Print progress for one receipt sheet. autoDispose.family keyed by order
/// id: state resets when the sheet closes and is never shared across orders.
@immutable
class _PrintState {
  final bool printing;
  final String? error;

  /// Presentation only: lets the UI tell "printed fine" apart from
  /// "never attempted" (e.g. no printer configured).
  final bool attempted;

  const _PrintState({this.printing = false, this.error, this.attempted = false});
}

class _PrintStateNotifier extends AutoDisposeFamilyNotifier<_PrintState, String> {
  @override
  _PrintState build(String arg) => const _PrintState();

  void started() =>
      state = const _PrintState(printing: true, attempted: true);

  void finished(String? error) =>
      state = _PrintState(printing: false, error: error, attempted: true);
}

final _printStateProvider = NotifierProvider.autoDispose
    .family<_PrintStateNotifier, _PrintState, String>(_PrintStateNotifier.new);

class ReceiptSheet extends ConsumerStatefulWidget {
  final Order order;
  final int total;
  final int? changeGiven;
  const ReceiptSheet(
      {super.key, required this.order, required this.total, this.changeGiven});

  static Future<void> show(BuildContext ctx,
          {required Order order, required int total, int? changeGiven}) =>
      ResponsiveSheet.show(
          context: ctx,
          builder: (_) => ReceiptSheet(
              order: order, total: total, changeGiven: changeGiven));

  @override
  ConsumerState<ReceiptSheet> createState() => _ReceiptSheetState();
}

class _ReceiptSheetState extends ConsumerState<ReceiptSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _print();
    });
  }

  Future<void> _print() async {
    final branch = ref.read(authProvider).branch;
    final methods = ref.read(paymentMethodProvider).items;
    if (branch == null || !branch.hasPrinter) return;
    ref.read(_printStateProvider(widget.order.id).notifier).started();
    final err = await PrinterService.print(
        ip: branch.printerIp!,
        port: branch.printerPort ?? 9100,
        brand: branch.printerBrand!,
        order: widget.order,
        paymentMethods: methods,
        branchName: branch.name,
        kickDrawer: isCashMethod(methods, widget.order.paymentMethod));
    if (mounted) {
      ref.read(_printStateProvider(widget.order.id).notifier).finished(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = l10n(context);
    final locale = Localizations.localeOf(context).languageCode;
    final o = widget.order;
    final methods = ref.watch(paymentMethodProvider.select((p) => p.items));
    final branch = ref.watch(authProvider.select((a) => a.branch));
    final printState = ref.watch(_printStateProvider(o.id));
    final hasPrinter = branch != null && branch.hasPrinter;
    final isQueued = o.status == 'pending_sync';

    return Container(
      decoration: BoxDecoration(
          color: t.surfaceRaised, borderRadius: AppRadius.sheetRadius),
      padding: EdgeInsetsDirectional.fromSTEB(AppSpace.xl, 14, AppSpace.xl,
          MediaQuery.of(context).padding.bottom + AppSpace.xl),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Center(
              child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                      color: t.border,
                      borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: AppSpace.lg),
          SuccessCheckIcon(size: 88, color: t.success),
          const SizedBox(height: AppSpace.sm),
          Text(s.orderPlaced,
              style:
                  ui(size: 22, weight: FontWeight.w800, color: t.textPrimary)),
          const SizedBox(height: AppSpace.xs),
          if (isQueued || o.orderNumber <= 0)
            StatusChip(
                label: s.orderQueuedSyncs,
                tone: ChipTone.warning,
                icon: Icons.cloud_upload_outlined)
          else ...[
            Text(s.orderNumber(o.orderNumber),
                style: ui(size: 15, color: t.textSecondary)),
            if (o.orderRef != null)
              Text(o.orderRef!,
                  style: ui(size: 12, color: t.textMuted)),
          ],
          const SizedBox(height: AppSpace.lg),

          SurfaceCard(
            padding: const EdgeInsets.all(AppSpace.lg),
            child: Column(children: [
              _ReceiptRow(
                  label: s.orderPaymentMethod,
                  value: methodLabel(methods, locale, o.paymentMethod)),
              if (o.tipAmount != null && o.tipAmount! > 0)
                _ReceiptRow(
                    label: s.orderReceiptTip,
                    value:
                        '${egp(o.tipAmount!)}${o.tipPaymentMethod != null ? " · ${methodLabel(methods, locale, o.tipPaymentMethod!)}" : ""}',
                    valueColor: t.success,
                    isMoney: true),
              if (o.customerName != null && o.customerName!.isNotEmpty)
                _ReceiptRow(label: s.orderReceiptCustomer, value: o.customerName!),
              _ReceiptRow(
                  label: s.orderTotal,
                  value: egp(o.totalAmount),
                  emphasized: true,
                  isMoney: true),
              _ReceiptRow(label: s.orderReceiptTime, value: timeShort(o.createdAt)),
              if (widget.changeGiven != null && widget.changeGiven! > 0)
                _ReceiptRow(
                    label: s.orderChangeGiven,
                    value: egp(widget.changeGiven!),
                    valueColor: t.success,
                    isMoney: true),
            ]),
          ),
          const SizedBox(height: AppSpace.lg),

          _PrintStatus(
            hasPrinter: hasPrinter,
            printing: printState.printing,
            error: printState.error,
            printed: printState.attempted &&
                !printState.printing &&
                printState.error == null,
            onPrint: _print,
          ),
          const SizedBox(height: AppSpace.lg),

          AppButton(
              label: s.orderNewOrder,
              width: double.infinity,
              height: 54,
              icon: Icons.add_rounded,
              onTap: () => Navigator.pop(context)),
        ]),
      ),
    );
  }
}

/// One block, four clear states: no printer / printing / printed / failed.
class _PrintStatus extends StatelessWidget {
  final bool hasPrinter;
  final bool printing;
  final String? error;
  final bool printed;
  final VoidCallback onPrint;

  const _PrintStatus({
    required this.hasPrinter,
    required this.printing,
    required this.error,
    required this.printed,
    required this.onPrint,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = l10n(context);

    if (!hasPrinter) {
      return StatusChip(
          label: s.noPrinterConfigured,
          tone: ChipTone.neutral,
          icon: Icons.print_disabled_rounded);
    }

    if (printing) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpace.lg, vertical: AppSpace.md),
        decoration: BoxDecoration(
          color: t.navyBg,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: 22,
            height: 22,
            child: LoopingIcon(
              duration: const Duration(milliseconds: 1500),
              builder: (_, a) => CustomPaint(
                  size: const Size(22, 22),
                  painter: PrinterPainter(
                      t: a, color: t.navy, paperFill: t.surface)),
            ),
          ),
          const SizedBox(width: 10),
          Text(s.orderPrintingReceipt,
              style: ui(size: 13, weight: FontWeight.w600, color: t.navy)),
        ]),
      );
    }

    if (error != null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpace.lg),
        decoration: BoxDecoration(
          color: t.dangerBg,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: t.danger.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(Icons.print_disabled_rounded, size: 16, color: t.danger),
              const SizedBox(width: AppSpace.sm),
              Expanded(
                child: Text(s.orderReceiptFailed,
                    style: ui(
                        size: 14, weight: FontWeight.w700, color: t.danger)),
              ),
            ]),
            const SizedBox(height: AppSpace.xs),
            Text(error!, style: ui(size: 12, color: t.danger, height: 1.4)),
            const SizedBox(height: AppSpace.md),
            AppButton(
              label: s.commonRetryPrint,
              variant: BtnVariant.danger,
              height: 42,
              width: double.infinity,
              icon: Icons.refresh_rounded,
              onTap: onPrint,
            ),
          ],
        ),
      );
    }

    if (printed) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpace.lg, vertical: AppSpace.md),
        decoration: BoxDecoration(
          color: t.successBg,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Row(children: [
          Icon(Icons.check_circle_rounded, size: 16, color: t.success),
          const SizedBox(width: AppSpace.sm),
          Expanded(
            child: Text(s.orderReceiptPrinted,
                style:
                    ui(size: 13, weight: FontWeight.w600, color: t.success)),
          ),
          StatusChip(
              label: s.orderReprint,
              tone: ChipTone.success,
              icon: Icons.print_rounded,
              onTap: onPrint),
        ]),
      );
    }

    // Printer exists but no attempt was made yet (defensive fallback).
    return StatusChip(
        label: s.printReceipt,
        tone: ChipTone.info,
        icon: Icons.print_rounded,
        onTap: onPrint);
  }
}

class _ReceiptRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool emphasized;
  final bool isMoney;

  const _ReceiptRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.emphasized = false,
    this.isMoney = false,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final valueStyle = isMoney
        ? money(
            size: emphasized ? 15 : 13,
            weight: emphasized ? FontWeight.w800 : FontWeight.w600,
            color: valueColor ?? t.textPrimary)
        : ui(
            size: 13,
            weight: emphasized ? FontWeight.w800 : FontWeight.w600,
            color: valueColor ?? t.textPrimary);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(children: [
        Expanded(
            child: Text(label, style: ui(size: 13, color: t.textSecondary))),
        Text(value, style: valueStyle),
      ]),
    );
  }
}
