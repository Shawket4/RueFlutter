import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/models/order.dart';
import '../../../core/models/branch.dart';
import '../../../core/providers/auth_notifier.dart';
import '../../../core/providers/payment_method_notifier.dart';
import '../../../core/repositories/order_repository.dart';
import '../../../core/services/printer_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import '../../../shared/widgets/animated_icons.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/responsive_sheet.dart';
import '../helpers/payment_helpers.dart';

/// Print progress for one preview sheet. autoDispose.family keyed by order
/// id: state resets when the sheet closes and is never shared across orders.
@immutable
class _PreviewPrintState {
  final bool printing;
  final String? error;

  const _PreviewPrintState({this.printing = false, this.error});
}

class _PreviewPrintNotifier
    extends AutoDisposeFamilyNotifier<_PreviewPrintState, String> {
  @override
  _PreviewPrintState build(String arg) => const _PreviewPrintState();

  void started() => state = const _PreviewPrintState(printing: true);

  void finished(String? error) =>
      state = _PreviewPrintState(printing: false, error: error);
}

final _previewPrintProvider = NotifierProvider.autoDispose
    .family<_PreviewPrintNotifier, _PreviewPrintState, String>(
        _PreviewPrintNotifier.new);

/// 1. MAIN SHEET: Handles modal state, printing logic, and action buttons.
class ReceiptPreviewSheet extends ConsumerStatefulWidget {
  final Order order;

  /// Custom sheet title; defaults to the localized "Receipt Preview".
  final String? title;

  const ReceiptPreviewSheet({
    super.key,
    required this.order,
    this.title,
  });

  static Future<void> show(BuildContext context, Order order,
          {String? title}) =>
      ResponsiveSheet.show(
        context: context,
        builder: (_) => ReceiptPreviewSheet(order: order, title: title),
      );

  @override
  ConsumerState<ReceiptPreviewSheet> createState() => _ReceiptPreviewSheetState();
}

class _ReceiptPreviewSheetState extends ConsumerState<ReceiptPreviewSheet> {
  Future<void> _print(Branch branch) async {
    if (!branch.hasPrinter) {
      _showSnack(l10n(context).commonNoPrinterForBranch,
          color: context.tokens.warning);
      return;
    }

    ref.read(_previewPrintProvider(widget.order.id).notifier).started();

    final methods = ref.read(paymentMethodProvider).items;

    // Delivery orders carry their customer/phone/address only on the detail
    // fetch (the list omits it). Enrich before printing so the reprinted receipt
    // shows the full delivery context, not just the flag + channel.
    Order order = widget.order;
    if (order.orderType == 'delivery' && order.delivery == null) {
      try {
        order = await ref.read(orderRepositoryProvider).getOrder(order.id);
      } catch (_) {
        // Offline / fetch failed — fall back to what we have (flag still prints).
      }
    }

    final err = await PrinterService.print(
      ip: branch.printerIp!,
      port: branch.printerPort ?? 9100,
      brand: branch.printerBrand!,
      order: order,
      paymentMethods: methods,
      branchName: branch.name,
      logoUrl: branch.orgLogoUrl,
    );

    if (mounted) {
      ref.read(_previewPrintProvider(widget.order.id).notifier).finished(err);
      if (err == null) {
        _showSnack(l10n(context).orderReceiptPrintedOk,
            color: context.tokens.success);
      }
    }
  }

  void _showSnack(String msg, {required Color color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final mq = MediaQuery.of(context);
    final methods = ref.watch(paymentMethodProvider.select((p) => p.items));
    final branch = ref.watch(authProvider.select((a) => a.branch));
    final printState = ref.watch(_previewPrintProvider(widget.order.id));
    final hasPrinter = branch?.hasPrinter ?? false;

    return Container(
      constraints: BoxConstraints(maxHeight: mq.size.height * 0.92),
      decoration: BoxDecoration(
        color: t.bg,
        borderRadius: AppRadius.sheetRadius,
      ),
      child: Column(
        children: [
          _buildHeader(context, t),

          // Pure UI component for the receipt visual
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpace.xl, vertical: AppSpace.lg),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: ThermalReceiptCard(
                      order: widget.order, branch: branch, methods: methods),
                ),
              ),
            ),
          ),

          _buildActionFooter(mq, t, branch, hasPrinter, printState),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppTokens t) {
    return Container(
      decoration: BoxDecoration(
        color: t.surfaceRaised,
        borderRadius: AppRadius.sheetRadius,
        border: Border(bottom: BorderSide(color: t.border)),
      ),
      padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 16, 14),
      child: Column(
        children: [
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: t.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.title ?? l10n(context).orderReceiptPreview,
                  style: ui(
                      size: 17, weight: FontWeight.w700, color: t.textPrimary),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close_rounded, color: t.textSecondary),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionFooter(MediaQueryData mq, AppTokens t, Branch? branch,
      bool hasPrinter, _PreviewPrintState printState) {
    return Container(
      decoration: BoxDecoration(
        color: t.surfaceRaised,
        border: Border(top: BorderSide(color: t.border)),
      ),
      padding: EdgeInsetsDirectional.fromSTEB(
          20, AppSpace.lg, 20, mq.padding.bottom + AppSpace.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (printState.error != null && !printState.printing)
            _buildErrorBanner(t, printState.error!),
          if (printState.printing)
            _buildPrintingBanner(t)
          else
            AppButton(
              label: hasPrinter
                  ? (printState.error != null
                      ? l10n(context).commonRetryPrint
                      : l10n(context).printReceipt)
                  : l10n(context).noPrinterConfigured,
              icon: printState.error != null
                  ? Icons.refresh_rounded
                  : Icons.print_rounded,
              width: double.infinity,
              height: 52,
              onTap:
                  (hasPrinter && branch != null) ? () => _print(branch) : null,
            ),
        ],
      ),
    );
  }

  /// Print-in-progress banner — the receipt feeds out of the printer while the
  /// job runs (matches the post-checkout receipt sheet).
  Widget _buildPrintingBanner(AppTokens t) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        color: t.navyBg,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      alignment: Alignment.center,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          width: 22,
          height: 22,
          child: LoopingIcon(
            duration: const Duration(milliseconds: 1500),
            builder: (_, a) => CustomPaint(
                size: const Size(22, 22),
                painter:
                    PrinterPainter(t: a, color: t.navy, paperFill: t.surface)),
          ),
        ),
        const SizedBox(width: 10),
        Text(l10n(context).orderPrintingReceipt,
            style: ui(size: 13, weight: FontWeight.w600, color: t.navy)),
      ]),
    );
  }

  Widget _buildErrorBanner(AppTokens t, String error) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpace.md),
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: t.dangerBg,
          borderRadius: BorderRadius.circular(AppRadius.xs),
          border: Border.all(color: t.danger.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline_rounded, size: 16, color: t.danger),
            const SizedBox(width: AppSpace.sm),
            Expanded(
              child: Text(
                error,
                style: ui(size: 12, color: t.danger),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 2. THERMAL RECEIPT VISUAL: Pure UI component, strictly isolated from
/// external state logic.
///
/// The card is intentionally brightness-invariant: it previews a physical
/// white thermal receipt, so it keeps white paper + light-theme "ink" in
/// both app themes (hence [AppTokens.light] instead of `context.tokens`).
class ThermalReceiptCard extends StatelessWidget {
  static const AppTokens _ink = AppTokens.light;

  final Order order;
  final Branch? branch;
  final List<PaymentMethod> methods;

  const ThermalReceiptCard({
    super.key,
    required this.order,
    this.branch,
    required this.methods,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = l10n(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // paper
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: t.border),
        boxShadow: AppShadows.of(t),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildLogoAndBranch(),
          const SizedBox(height: AppSpace.md),
          const _DottedLine(),
          const SizedBox(height: AppSpace.md),
          _buildOrderDetails(context, s),
          const SizedBox(height: AppSpace.md),
          const _DottedLine(),
          const SizedBox(height: AppSpace.md),
          _buildItemsList(s),
          const SizedBox(height: AppSpace.sm),
          const _DottedLine(),
          const SizedBox(height: AppSpace.md),
          _buildSummary(s),
          const SizedBox(height: AppSpace.lg),
          const _DottedLine(),
          const SizedBox(height: 14),
          Text(
            s.receiptThankYou,
            textAlign: TextAlign.center,
            style: ui(size: 11, color: _ink.textMuted),
          ),
          const SizedBox(height: AppSpace.xl),
        ],
      ),
    );
  }

  Widget _buildLogoAndBranch() {
    final hasLogo =
        branch?.orgLogoUrl != null && branch!.orgLogoUrl!.isNotEmpty;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: AppSpace.xl, bottom: AppSpace.sm),
          child: hasLogo
              ? Image(
                  image: CachedNetworkImageProvider(branch!.orgLogoUrl!),
                  width: 72,
                  height: 72,
                  errorBuilder: (_, __, ___) => _buildPlaceholderLogo(),
                )
              : _buildPlaceholderLogo(),
        ),
        Text(
          branch?.name ?? 'Sufrix POS',
          textAlign: TextAlign.center,
          style:
              ui(size: 15, weight: FontWeight.w700, color: _ink.textPrimary),
        ),
      ],
    );
  }

  Widget _buildPlaceholderLogo() {
    return Image.asset(
      'assets/IconForeground.png',
      width: 72,
      height: 72,
    );
  }

  Widget _buildOrderDetails(BuildContext context, AppLocalizations s) {
    final locale = Localizations.localeOf(context).languageCode;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (order.isVoided) ...[
            Container(
              margin: const EdgeInsets.only(bottom: AppSpace.sm),
              padding: const EdgeInsets.symmetric(vertical: AppSpace.xs),
              decoration: BoxDecoration(
                color: _ink.dangerBg,
                border: Border.all(color: _ink.danger.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: Text(
                s.receiptVoidedStamp,
                style: ui(
                    size: 14,
                    weight: FontWeight.w800,
                    color: _ink.danger,
                    letterSpacing: 1.5),
              ),
            ),
          ],
          _ReceiptInfoRow(
            label: s.receiptOrderLabel,
            value: order.orderNumber == 0 ? s.receiptDraft : '#${order.orderNumber}',
          ),
          if (order.orderRef != null) ...[
            const SizedBox(height: AppSpace.xs),
            _ReceiptInfoRow(label: 'Ref', value: order.orderRef!),
          ],
          const SizedBox(height: AppSpace.xs),
          _ReceiptInfoRow(label: s.receiptDate, value: dateTime(order.createdAt)),
          if (order.tellerName.isNotEmpty) ...[
            const SizedBox(height: AppSpace.xs),
            _ReceiptInfoRow(label: s.commonTeller, value: order.tellerName),
          ],
          if (order.customerName != null) ...[
            const SizedBox(height: AppSpace.xs),
            _ReceiptInfoRow(label: s.orderReceiptCustomer, value: order.customerName!),
          ],
          const SizedBox(height: AppSpace.xs),
          _ReceiptInfoRow(
              label: s.orderPaymentMethod,
              value: methodLabel(methods, locale, order.paymentMethod)),
        ],
      ),
    );
  }

  Widget _buildItemsList(AppLocalizations s) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.receiptItems,
            style: ui(
              size: 10,
              weight: FontWeight.w800,
              color: _ink.textMuted,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: AppSpace.sm),
          if (order.items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpace.sm),
              child: Text(
                s.receiptNoItems,
                style: ui(size: 12, color: _ink.textSecondary),
              ),
            )
          else
            ...order.items.map((item) => ReceiptItemRow(item: item)),
        ],
      ),
    );
  }

  Widget _buildSummary(AppLocalizations s) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.lg),
      child: Column(
        children: [
          _ReceiptAmountRow(label: s.orderSubtotal, value: egp(order.subtotal)),
          if (order.discountAmount > 0) ...[
            const SizedBox(height: AppSpace.xs),
            _ReceiptAmountRow(
              label: s.orderDiscount,
              value: '- ${egp(order.discountAmount)}',
              valueColor: _ink.success,
            ),
          ],
          if (order.taxAmount > 0) ...[
            const SizedBox(height: AppSpace.xs),
            _ReceiptAmountRow(label: s.orderTax14, value: egp(order.taxAmount)),
          ],
          const SizedBox(height: AppSpace.sm),
          Row(
            children: [
              Expanded(
                child: Text(
                  s.orderTotal.toUpperCase(),
                  style: ui(
                      size: 15,
                      weight: FontWeight.w800,
                      color: _ink.textPrimary),
                ),
              ),
              Text(
                egp(order.totalAmount),
                style: money(
                    size: 17, weight: FontWeight.w800, color: _ink.navy),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 3. ITEM ROW COMPONENT: Eliminates deep nesting from the mapping function.
class ReceiptItemRow extends StatelessWidget {
  static const AppTokens _ink = AppTokens.light;

  // Statically typed on purpose: members like isBundleLine are EXTENSIONS on
  // the generated wire model now — dynamic dispatch can't see extensions and
  // throws NoSuchMethodError at runtime.
  final OrderItem item;

  const ReceiptItemRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final bool isBundle = item.isBundleLine;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpace.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${item.quantity}x ',
                style:
                    ui(size: 13, weight: FontWeight.w700, color: _ink.navy),
              ),
              Expanded(
                child: Text(
                  item.itemName +
                      (item.sizeLabel != null
                          ? ' · ${normaliseName(item.sizeLabel!)}'
                          : ''),
                  style: ui(
                      size: 13,
                      weight: FontWeight.w600,
                      color: _ink.textPrimary),
                ),
              ),
              const SizedBox(width: AppSpace.sm),
              Text(
                egp(item.lineTotal),
                style: money(
                    size: 13, weight: FontWeight.w700, color: _ink.textPrimary),
              ),
            ],
          ),
          if (isBundle && (item.bundleComponents?.isNotEmpty ?? false))
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 20, top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (item.bundleComponents ?? const []).map<Widget>((c) {
                  final qty = c.quantity * item.quantity;
                  final sizePart = c.sizeLabel != null
                      ? ' · ${normaliseName(c.sizeLabel!)}'
                      : '';
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '– ${normaliseName(c.itemName)}$sizePart × $qty',
                          style: ui(
                              size: 11,
                              weight: FontWeight.w600,
                              color: _ink.textSecondary),
                        ),
                        if (c.addons.isNotEmpty)
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 12, top: 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: c.addons.map<Widget>((a) {
                                final linePrice = a.priceModifier * a.quantity;
                                return Text(
                                  '+ ${normaliseName(a.name)}${a.quantity > 1 ? " ×${a.quantity}" : ""}${linePrice > 0 ? " (${egp(linePrice)})" : ""}',
                                  style: ui(size: 10, color: _ink.navy),
                                );
                              }).toList(),
                            ),
                          ),
                        if (c.optionals.isNotEmpty)
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 12, top: 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: c.optionals.map<Widget>((o) {
                                return Text(
                                  '• ${normaliseName(o.name)}${o.price > 0 ? " (${egp(o.price)})" : ""}',
                                  style: ui(size: 10, color: _ink.warning),
                                );
                              }).toList(),
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            )
          else ...[
            if (item.addons.isNotEmpty)
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 20, top: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: item.addons
                      .map<Widget>((a) => Text(
                            '+ ${normaliseName(a.addonName)} (${egp(a.lineTotal)})',
                            style: ui(size: 11, color: _ink.textMuted),
                          ))
                      .toList(),
                ),
              ),
            if (item.optionals.isNotEmpty)
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 20, top: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: item.optionals
                      .map<Widget>((o) => Text(
                            '• ${normaliseName(o.fieldName)} (${egp(o.price)})',
                            style: ui(size: 11, color: _ink.textMuted),
                          ))
                      .toList(),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

// ── REUSABLE HELPERS ──────────────────────────────────────────────────────────

class _ReceiptInfoRow extends StatelessWidget {
  static const AppTokens _ink = AppTokens.light;

  final String label;
  final String value;

  const _ReceiptInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: ui(
                size: 12, weight: FontWeight.w500, color: _ink.textSecondary),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: ui(
                size: 12, weight: FontWeight.w700, color: _ink.textPrimary),
          ),
        ),
      ],
    );
  }
}

class _ReceiptAmountRow extends StatelessWidget {
  static const AppTokens _ink = AppTokens.light;

  final String label;
  final String value;
  final Color? valueColor;

  const _ReceiptAmountRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: ui(
                size: 12, weight: FontWeight.w500, color: _ink.textSecondary),
          ),
        ),
        Text(
          value,
          style: money(
            size: 13,
            weight: FontWeight.w600,
            color: valueColor ?? _ink.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _DottedLine extends StatelessWidget {
  const _DottedLine();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.lg),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.constrainWidth();
          const dashWidth = 4.0;
          const dashSpace = 4.0;
          final count = (width / (dashWidth + dashSpace)).floor();

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(count, (_) {
              return SizedBox(
                width: dashWidth,
                height: 1,
                child: DecoratedBox(
                  // Paper "ink" — intentionally theme-invariant.
                  decoration: BoxDecoration(color: AppTokens.light.border),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
