import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/models/order.dart';
import '../../../core/models/branch.dart';
import '../../../core/providers/auth_notifier.dart';
import '../../../core/providers/payment_method_notifier.dart';
import '../../../core/services/printer_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import '../helpers/payment_helpers.dart';
import '../../../core/providers/payment_method_notifier.dart';

/// 1. MAIN SHEET: Handles modal state, printing logic, and action buttons.
class ReceiptPreviewSheet extends ConsumerStatefulWidget {
  final Order order;
  final String title;

  const ReceiptPreviewSheet({
    super.key,
    required this.order,
    this.title = 'Receipt Preview',
  });

  static Future<void> show(BuildContext context, Order order, {String title = 'Receipt Preview'}) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => ReceiptPreviewSheet(order: order, title: title),
      );

  @override
  ConsumerState<ReceiptPreviewSheet> createState() => _ReceiptPreviewSheetState();
}

class _ReceiptPreviewSheetState extends ConsumerState<ReceiptPreviewSheet> {
  bool _printing = false;
  String? _printError;

  Future<void> _print(Branch branch) async {
    if (!branch.hasPrinter) {
      _showSnack('No printer configured for this branch', color: AppColors.warning);
      return;
    }

    setState(() {
      _printing = true;
      _printError = null;
    });

    final methods = ref.read(paymentMethodProvider).items;

    final err = await PrinterService.print(
      ip: branch.printerIp!,
      port: branch.printerPort,
      brand: branch.printerBrand!,
      order: widget.order,
      paymentMethods: methods,
      branchName: branch.name,
      logoUrl: branch.orgLogoUrl,
    );

    if (mounted) {
      setState(() {
        _printing = false;
        _printError = err;
      });
      if (err == null) {
        _showSnack('Receipt printed successfully', color: AppColors.success);
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
    final mq = MediaQuery.of(context);
    final methods = ref.watch(paymentMethodProvider).items;
    final branch = ref.watch(authProvider).branch;
    final hasPrinter = branch?.hasPrinter ?? false;

    return Container(
      constraints: BoxConstraints(maxHeight: mq.size.height * 0.92),
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: AppRadius.sheetRadius,
      ),
      child: Column(
        children: [
          _buildHeader(context),
          
          // Pure UI component for the receipt visual
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: ThermalReceiptCard(order: widget.order, branch: branch, methods: methods),
                ),
              ),
            ),
          ),
          
          _buildActionFooter(mq, branch, hasPrinter),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.sheetRadius,
        border: const Border(bottom: BorderSide(color: AppColors.border)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 16, 14),
      child: Column(
        children: [
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: cairo(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionFooter(MediaQueryData mq, Branch? branch, bool hasPrinter) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      padding: EdgeInsets.fromLTRB(20, 16, 20, mq.padding.bottom + 16),
      child: _printing
          ? const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: CircularProgressIndicator(strokeWidth: 2.5, color: AppColors.primary),
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_printError != null) _buildErrorBanner(),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: (hasPrinter && branch != null) ? () => _print(branch) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: hasPrinter ? AppColors.primary : AppColors.border,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _printError != null ? Icons.refresh_rounded : Icons.print_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          hasPrinter
                              ? (_printError != null ? 'Retry Print' : 'Print Receipt')
                              : 'No Printer Configured',
                          style: cairo(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildErrorBanner() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.danger.withOpacity(0.07),
          borderRadius: BorderRadius.circular(AppRadius.xs),
          border: Border.all(color: AppColors.danger.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline_rounded, size: 16, color: AppColors.danger),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _printError!,
                style: cairo(fontSize: 12, color: AppColors.danger),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 2. THERMAL RECEIPT VISUAL: Pure UI component, strictly isolated from external state logic.
class ThermalReceiptCard extends StatelessWidget {
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildLogoAndBranch(),
          const SizedBox(height: 12),
          const _DottedLine(),
          const SizedBox(height: 12),
          _buildOrderDetails(),
          const SizedBox(height: 12),
          const _DottedLine(),
          const SizedBox(height: 12),
          _buildItemsList(),
          const SizedBox(height: 8),
          const _DottedLine(),
          const SizedBox(height: 12),
          _buildSummary(),
          const SizedBox(height: 20),
          const _DottedLine(),
          const SizedBox(height: 14),
          Text(
            'Thank you for visiting!',
            textAlign: TextAlign.center,
            style: cairo(fontSize: 11, fontStyle: FontStyle.italic, color: AppColors.textMuted),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildLogoAndBranch() {
    final hasLogo = branch?.orgLogoUrl != null && branch!.orgLogoUrl!.isNotEmpty;
    
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 8),
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
          style: cairo(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
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

  Widget _buildOrderDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (order.isVoided) ...[
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.danger.withOpacity(0.1),
                border: Border.all(color: AppColors.danger.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: Text(
                '*** VOIDED ***',
                style: cairo(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.danger, letterSpacing: 1.5),
              ),
            ),
          ],
          _ReceiptInfoRow(
            label: 'Order #',
            value: order.orderNumber == 0 ? 'DRAFT' : '#${order.orderNumber}',
          ),
          const SizedBox(height: 4),
          _ReceiptInfoRow(label: 'Date', value: dateTime(order.createdAt)),
          if (order.tellerName.isNotEmpty) ...[
            const SizedBox(height: 4),
            _ReceiptInfoRow(label: 'Teller', value: order.tellerName),
          ],
          if (order.customerName != null) ...[
            const SizedBox(height: 4),
            _ReceiptInfoRow(label: 'Customer', value: order.customerName!),
          ],
          const SizedBox(height: 4),
          _ReceiptInfoRow(label: 'Payment', value: methodLabel(methods, 'en', order.paymentMethod)),
        ],
      ),
    );
  }

  Widget _buildItemsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ITEMS',
            style: cairo(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: AppColors.textMuted,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          if (order.items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'No items in cart',
                style: cairo(fontSize: 12, fontStyle: FontStyle.italic, color: AppColors.textSecondary),
              ),
            )
          else
            ...order.items.map((item) => ReceiptItemRow(item: item)),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _ReceiptAmountRow(label: 'Subtotal', value: egp(order.subtotal)),
          if (order.discountAmount > 0) ...[
            const SizedBox(height: 4),
            _ReceiptAmountRow(
              label: 'Discount',
              value: '- ${egp(order.discountAmount)}',
              valueColor: AppColors.success,
            ),
          ],
          if (order.taxAmount > 0) ...[
            const SizedBox(height: 4),
            _ReceiptAmountRow(label: 'Tax (14%)', value: egp(order.taxAmount)),
          ],
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TOTAL',
                style: cairo(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
              ),
              Text(
                egp(order.totalAmount),
                style: cairo(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.primary),
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
  final dynamic item; // Replace 'dynamic' with your actual OrderItem model type

  const ReceiptItemRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final bool isBundle = item.isBundleLine;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${item.quantity}x ',
                style: cairo(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primary),
              ),
              Expanded(
                child: Text(
                  item.itemName + (item.sizeLabel != null ? ' · ${normaliseName(item.sizeLabel!)}' : ''),
                  style: cairo(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                egp(item.lineTotal),
                style: cairo(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
              ),
            ],
          ),
          if (isBundle && item.bundleComponents.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: item.bundleComponents.map<Widget>((c) {
                  final qty = c.quantity * item.quantity;
                  final sizePart = c.sizeLabel != null ? ' · ${normaliseName(c.sizeLabel!)}' : '';
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '– ${normaliseName(c.itemName)}$sizePart × $qty',
                          style: cairo(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                        ),
                        if (c.addons.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: c.addons.map<Widget>((a) {
                                final linePrice = a.priceModifier * a.quantity;
                                return Text(
                                  '+ ${normaliseName(a.name)}${a.quantity > 1 ? " ×${a.quantity}" : ""}${linePrice > 0 ? " (${egp(linePrice)})" : ""}',
                                  style: cairo(fontSize: 10, color: AppColors.primary),
                                );
                              }).toList(),
                            ),
                          ),
                        if (c.optionals.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: c.optionals.map<Widget>((o) {
                                return Text(
                                  '• ${normaliseName(o.name)}${o.price > 0 ? " (${egp(o.price)})" : ""}',
                                  style: cairo(fontSize: 10, color: AppColors.warning),
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
                padding: const EdgeInsets.only(left: 20, top: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: item.addons.map<Widget>((a) => Text(
                    '+ ${normaliseName(a.addonName)} (${egp(a.lineTotal)})',
                    style: cairo(fontSize: 11, color: AppColors.textMuted),
                  )).toList(),
                ),
              ),
            if (item.optionals.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: item.optionals.map<Widget>((o) => Text(
                    '• ${normaliseName(o.fieldName)} (${egp(o.price)})',
                    style: cairo(fontSize: 11, color: AppColors.textMuted),
                  )).toList(),
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
            style: cairo(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: cairo(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}

class _ReceiptAmountRow extends StatelessWidget {
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: cairo(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
        ),
        Text(
          value,
          style: cairo(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: valueColor ?? AppColors.textPrimary,
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.constrainWidth();
          const dashWidth = 4.0;
          const dashSpace = 4.0;
          final count = (width / (dashWidth + dashSpace)).floor();
          
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(count, (_) {
              return const SizedBox(
                width: dashWidth,
                height: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: AppColors.border),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}