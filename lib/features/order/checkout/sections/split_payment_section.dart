import 'package:flutter/material.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/models/payment_method.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatting.dart';
import '../../../../shared/widgets/amount_field.dart';

/// Split payment entry: toggle the methods used, type an amount per method,
/// and watch the live remaining/over indicator converge on zero.
///
/// Amount keystrokes only rebuild the indicator (a [ListenableBuilder] over
/// the active controllers + the tip field) — never the parent sheet. Method
/// toggles call back up because the parent owns the controller map.
class SplitPaymentSection extends StatelessWidget {
  final Set<String> activeMethods;
  final Map<String, TextEditingController> splitCtrs;
  final int cartTotal;
  final void Function(String) onToggleMethod;

  /// A cash tip is taken out of the split target, so the indicator listens
  /// to the tip field too.
  final TextEditingController tipCtrl;
  final bool tipIsCash;
  final List<PaymentMethod> methods;

  const SplitPaymentSection({
    super.key,
    required this.activeMethods,
    required this.splitCtrs,
    required this.cartTotal,
    required this.onToggleMethod,
    required this.tipCtrl,
    required this.tipIsCash,
    required this.methods,
  });

  int get _enteredTotal {
    var sum = 0;
    for (final method in activeMethods) {
      final amount = AmountField.parsePiastres(splitCtrs[method]?.text ?? '');
      if (amount != null && amount > 0) sum += amount;
    }
    return sum;
  }

  int get _cashTip {
    if (!tipIsCash) return 0;
    final tip = AmountField.parsePiastres(tipCtrl.text);
    return (tip != null && tip > 0) ? tip : 0;
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: AppSpace.sm,
          runSpacing: AppSpace.sm,
          children: methods
              .where((m) => m.wireFormat != 'mixed')
              .map((method) => _SplitMethodChip(
                    method: method,
                    active: activeMethods.contains(method.wireFormat),
                    onTap: () => onToggleMethod(method.wireFormat),
                  ))
              .toList(),
        ),
        if (activeMethods.isEmpty)
          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: AppSpace.xs, top: AppSpace.md),
            child: Text(l10n(context).checkoutSelectSplitMethods,
                style: ui(size: 12, color: t.textMuted)),
          )
        else ...[
          const SizedBox(height: AppSpace.lg),
          ...activeMethods.map((method) {
            final pm = methods.firstWhere((x) => x.wireFormat == method,
                orElse: paymentMethodMixed);
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpace.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                            color: pm.uiColor, shape: BoxShape.circle)),
                    const SizedBox(width: AppSpace.sm - 2),
                    Text(
                        pm.label(
                            Localizations.localeOf(context).languageCode),
                        style: ui(
                            size: 12,
                            weight: FontWeight.w700,
                            color: t.textSecondary)),
                  ]),
                  const SizedBox(height: AppSpace.sm - 2),
                  AmountField(controller: splitCtrs[method]!),
                ],
              ),
            );
          }),
          ListenableBuilder(
            listenable: Listenable.merge([
              tipCtrl,
              for (final m in activeMethods)
                if (splitCtrs[m] != null) splitCtrs[m]!,
            ]),
            builder: (context, _) {
              final expected = cartTotal - _cashTip;
              final diff = expected - _enteredTotal;
              return _SplitBalanceRow(diff: diff, tokens: t);
            },
          ),
        ],
      ],
    );
  }
}

class _SplitMethodChip extends StatelessWidget {
  final PaymentMethod method;
  final bool active;
  final VoidCallback onTap;

  const _SplitMethodChip({
    required this.method,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return AnimatedPressScale(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: active ? method.uiColor : t.surfaceAlt,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(
              color: active ? method.uiColor : t.border,
              width: active ? 1.5 : 1),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(
              active
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked_rounded,
              size: 14,
              // White on the method's own brand color in both themes.
              color: active ? Colors.white : method.uiColor),
          const SizedBox(width: AppSpace.sm - 2),
          Text(method.label(Localizations.localeOf(context).languageCode),
              style: ui(
                  size: 13,
                  weight: FontWeight.w600,
                  color: active ? Colors.white : t.textPrimary)),
        ]),
      ),
    );
  }
}

/// Live convergence indicator: "EGP X remaining" → "EGP X over" → balanced.
class _SplitBalanceRow extends StatelessWidget {
  final int diff;
  final AppTokens tokens;

  const _SplitBalanceRow({required this.diff, required this.tokens});

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    final (Color fg, Color bg, IconData icon, String label) = switch (diff) {
      > 0 => (
          tokens.warning,
          tokens.warningBg,
          Icons.pending_outlined,
          s.checkoutRemaining(egp(diff))
        ),
      < 0 => (
          tokens.danger,
          tokens.dangerBg,
          Icons.error_outline_rounded,
          s.checkoutOver(egp(-diff))
        ),
      _ => (
          tokens.success,
          tokens.successBg,
          Icons.check_circle_outline_rounded,
          s.checkoutBalanced
        ),
    };

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: fg.withOpacity(0.3)),
      ),
      child: Row(children: [
        Icon(icon, size: 16, color: fg),
        const SizedBox(width: AppSpace.sm),
        Expanded(
          child: Text(label,
              style: money(size: 14, weight: FontWeight.w700, color: fg)),
        ),
      ]),
    );
  }
}
