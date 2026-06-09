import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatting.dart';
import '../../../../core/models/payment_method.dart';
import '../../../../core/models/cart.dart';
import '../../widgets/shared_widgets.dart';

class SplitPaymentSection extends StatelessWidget {
  final Set<String> activeMethods;
  final Map<String, TextEditingController> splitCtrs;
  final int cartTotal;
  final void Function(String) onToggleMethod;
  final VoidCallback onAmountChanged;
  final int? parsedTip;
  final String tipPaymentMethod;
  final List<PaymentMethod> methods;

  const SplitPaymentSection({
    super.key,
    required this.activeMethods,
    required this.splitCtrs,
    required this.cartTotal,
    required this.onToggleMethod,
    required this.onAmountChanged,
    required this.parsedTip,
    required this.tipPaymentMethod,
    required this.methods,
  });

  List<PaymentSplit> _buildSplits() {
    final splits = <PaymentSplit>[];
    for (final method in activeMethods) {
      final raw = double.tryParse(splitCtrs[method]?.text ?? '');
      if (raw != null && raw > 0) {
        splits.add(PaymentSplit(method: method, amount: (raw * 100).round()));
      }
    }
    return splits;
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FieldLabel('SELECT METHODS USED'),
          const SizedBox(height: 10),
          // Task 4.1: Enum usage
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: methods.where((m) => m.wireFormat != 'mixed').map((method) {
              final color = method.color;
              final active = activeMethods.contains(method.wireFormat);
              return GestureDetector(
                onTap: () => onToggleMethod(method.wireFormat),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                  decoration: BoxDecoration(
                    color: active ? color : AppColors.bg,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border.all(
                        color: active ? color : AppColors.border,
                        width: active ? 1.5 : 1),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(
                        active
                            ? Icons.check_circle_rounded
                            : Icons.radio_button_unchecked_rounded,
                        size: 14,
                        color: active ? Colors.white : color),
                    const SizedBox(width: 6),
                    Text(method.label('en'),
                        style: cairo(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color:
                                active ? Colors.white : AppColors.textPrimary)),
                  ]),
                ),
              );
            }).toList(),
          ),
          if (activeMethods.isNotEmpty) ...[
            const SizedBox(height: 16),
            const FieldLabel('ENTER AMOUNTS'),
            const SizedBox(height: 10),
            ...activeMethods.map((method) {
              final pm = methods.firstWhere((x) => x.wireFormat == method, orElse: () => PaymentMethod.mixed());
              final color = pm.color;
              final ctrl = splitCtrs[method];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                                color: color, shape: BoxShape.circle)),
                        const SizedBox(width: 6),
                        Text(pm.label('en'),
                            style: cairo(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: color)),
                      ]),
                      const SizedBox(height: 6),
                      TextField(
                        controller: ctrl,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onChanged: (_) => onAmountChanged(),
                        style: cairo(fontSize: 20, fontWeight: FontWeight.w700),
                        decoration: InputDecoration(
                          hintText: '0',
                          prefixText: 'EGP  ',
                          prefixStyle: cairo(
                              fontSize: 15,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(AppRadius.sm),
                              borderSide:
                                  BorderSide(color: color.withOpacity(0.3))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(AppRadius.sm),
                              borderSide:
                                  BorderSide(color: color.withOpacity(0.3))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(AppRadius.sm),
                              borderSide:
                                  BorderSide(color: color, width: 2)),
                          filled: true,
                          fillColor: color.withOpacity(0.03),
                        ),
                      ),
                    ]),
              );
            }),

            Builder(builder: (context) {
              final splits = _buildSplits();
              final entered = splits.fold(0, (s, p) => s + p.amount);
              final isCashTip = methods.firstWhere((x) => x.wireFormat == tipPaymentMethod, orElse: () => PaymentMethod.mixed()).isCash;
              final tipOffset =
                  (isCashTip && parsedTip != null) ? parsedTip! : 0;
              final diff = cartTotal - entered - tipOffset;
              final ok = diff == 0;
              return Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: ok
                      ? AppColors.success.withOpacity(0.07)
                      : AppColors.warning.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  border: Border.all(
                      color: ok
                          ? AppColors.success.withOpacity(0.3)
                          : AppColors.warning.withOpacity(0.3)),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Icon(
                            ok
                                ? Icons.check_circle_outline_rounded
                                : Icons.pending_outlined,
                            size: 16,
                            color:
                                ok ? AppColors.success : AppColors.warning),
                        const SizedBox(width: 8),
                        Text(ok ? 'Balanced ✓' : 'Remaining',
                            style: cairo(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: ok
                                    ? AppColors.success
                                    : AppColors.warning)),
                      ]),
                      if (!ok)
                        Text(egp(diff.abs()),
                            style: cairo(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: AppColors.warning)),
                    ]),
              );
            }),
          ],
        ],
      );
}
