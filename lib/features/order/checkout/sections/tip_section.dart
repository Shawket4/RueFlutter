import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatting.dart';
import '../../../../core/models/payment_method.dart';
import '../../widgets/shared_widgets.dart';

class TipSection extends StatelessWidget {
  final TextEditingController tipCtrl;
  final String tipPaymentMethod;
  final int? parsedTip;
  final void Function(String) onMethodChanged;
  final VoidCallback onAmountChanged;
  final List<PaymentMethod> methods;

  const TipSection({
    super.key,
    required this.tipCtrl,
    required this.tipPaymentMethod,
    required this.parsedTip,
    required this.onMethodChanged,
    required this.onAmountChanged,
    required this.methods,
  });

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.bg,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
              color: parsedTip != null
                  ? AppColors.primary.withOpacity(0.3)
                  : AppColors.border),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Icon(Icons.volunteer_activism_rounded,
                size: 14, color: AppColors.textMuted),
            const SizedBox(width: 6),
            const FieldLabel('TIP (OPTIONAL)'),
            const Spacer(),
            if (parsedTip != null)
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                child: Container(
                  key: ValueKey(parsedTip),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(egp(parsedTip!),
                      style: cairo(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.success)),
                ),
              ),
          ]),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: methods.where((m) => m.wireFormat != 'mixed').map((method) {
              final sel = tipPaymentMethod == method.wireFormat;
              final color = method.color;
              return GestureDetector(
                onTap: () => onMethodChanged(method.wireFormat),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 140),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
                  decoration: BoxDecoration(
                    color: sel ? color : Colors.white,
                    borderRadius: BorderRadius.circular(AppRadius.xs),
                    border: Border.all(
                        color: sel ? color : AppColors.border,
                        width: sel ? 1.5 : 1),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    if (sel) ...[
                      const Icon(Icons.check_rounded,
                          size: 11, color: Colors.white),
                      const SizedBox(width: 4)
                    ],
                    Text(method.label('en'),
                        style: cairo(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color:
                                sel ? Colors.white : AppColors.textSecondary)),
                  ]),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: tipCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => onAmountChanged(),
            style: cairo(fontSize: 22, fontWeight: FontWeight.w700),
            decoration: InputDecoration(
              prefixText: 'EGP  ',
              prefixStyle: cairo(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500),
              hintText: '0',
              hintStyle: cairo(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.border),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              isDense: true,
            ),
          ),
        ]),
      );
}
