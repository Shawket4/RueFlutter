import 'package:flutter/material.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/models/payment_method.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatting.dart';
import '../../../../shared/widgets/amount_field.dart';
import '../../../../shared/widgets/status_chip.dart';

/// Optional tip: amount + the method the tip was paid with.
///
/// The live tip badge rebuilds via a [ListenableBuilder] on the controller —
/// typing here never rebuilds the parent checkout sheet. Only a tip-method
/// tap calls back up (the parent needs it for validation and drawer math).
class TipSection extends StatelessWidget {
  final TextEditingController tipCtrl;
  final String tipPaymentMethod;
  final ValueChanged<String> onMethodChanged;
  final List<PaymentMethod> methods;

  const TipSection({
    super.key,
    required this.tipCtrl,
    required this.tipPaymentMethod,
    required this.onMethodChanged,
    required this.methods,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      padding: const EdgeInsets.all(AppSpace.lg),
      decoration: BoxDecoration(
        color: t.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: t.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.volunteer_activism_rounded,
                size: 14, color: t.textMuted),
            const SizedBox(width: AppSpace.sm),
            Expanded(
              child: Text(l10n(context).checkoutTipOptional,
                  style: ui(
                      size: 12,
                      weight: FontWeight.w700,
                      color: t.textMuted,
                      letterSpacing: 0.6)),
            ),
            ListenableBuilder(
              listenable: tipCtrl,
              builder: (context, _) {
                final tip = AmountField.parsePiastres(tipCtrl.text);
                if (tip == null || tip <= 0) return const SizedBox.shrink();
                return StatusChip(
                    label: egp(tip),
                    tone: ChipTone.success,
                    icon: Icons.add_rounded);
              },
            ),
          ]),
          const SizedBox(height: AppSpace.md),
          Wrap(
            spacing: AppSpace.sm - 2,
            runSpacing: AppSpace.sm - 2,
            children: methods
                .where((m) => m.wireFormat != 'mixed')
                .map((method) => _TipMethodChip(
                      method: method,
                      selected: tipPaymentMethod == method.wireFormat,
                      onTap: () => onMethodChanged(method.wireFormat),
                    ))
                .toList(),
          ),
          const SizedBox(height: AppSpace.md),
          AmountField(
              controller: tipCtrl, label: l10n(context).checkoutTipAmount),
        ],
      ),
    );
  }
}

class _TipMethodChip extends StatelessWidget {
  final PaymentMethod method;
  final bool selected;
  final VoidCallback onTap;

  const _TipMethodChip({
    required this.method,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return AnimatedPressScale(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 11, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? method.uiColor : t.surface,
          borderRadius: BorderRadius.circular(AppRadius.xs),
          border: Border.all(
              color: selected ? method.uiColor : t.border,
              width: selected ? 1.5 : 1),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (selected) ...[
            // White on the method's own brand color in both themes.
            const Icon(Icons.check_rounded, size: 11, color: Colors.white),
            const SizedBox(width: AppSpace.xs),
          ],
          Text(method.label(Localizations.localeOf(context).languageCode),
              style: ui(
                  size: 12,
                  weight: FontWeight.w600,
                  color: selected ? Colors.white : t.textSecondary)),
        ]),
      ),
    );
  }
}
