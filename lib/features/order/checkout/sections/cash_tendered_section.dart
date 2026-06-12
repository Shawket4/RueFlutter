import 'package:flutter/material.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatting.dart';
import '../../../../shared/widgets/amount_field.dart';

/// Cash-tendered input with quick-tender chips (Exact / 50 / 100 / 200) and a
/// live change-due readout.
///
/// Keystroke-driven UI is scoped to this widget: the chips and the readout
/// rebuild via a [ListenableBuilder] on the text controllers, so the parent
/// checkout sheet never rebuilds while typing.
class CashTenderedSection extends StatelessWidget {
  final TextEditingController tenderedCtrl;
  final int cartTotal;

  /// A cash tip comes out of the change, so the readout (and the "Exact"
  /// chip) listen to the tip field as well.
  final TextEditingController tipCtrl;
  final bool tipIsCash;

  const CashTenderedSection({
    super.key,
    required this.tenderedCtrl,
    required this.cartTotal,
    required this.tipCtrl,
    required this.tipIsCash,
  });

  int get _cashTip {
    if (!tipIsCash) return 0;
    final tip = AmountField.parsePiastres(tipCtrl.text);
    return (tip != null && tip > 0) ? tip : 0;
  }

  static String _fieldText(int piastres) {
    final v = piastres / 100;
    return v == v.truncateToDouble() ? v.toInt().toString() : v.toStringAsFixed(2);
  }

  void _fill(int piastres) {
    final s = _fieldText(piastres);
    tenderedCtrl.value = TextEditingValue(
      text: s,
      selection: TextSelection.collapsed(offset: s.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AmountField(
            controller: tenderedCtrl,
            label: l10n(context).checkoutCashTendered),
        const SizedBox(height: AppSpace.sm),
        ListenableBuilder(
          listenable: Listenable.merge([tenderedCtrl, tipCtrl]),
          builder: (context, _) {
            final tendered = AmountField.parsePiastres(tenderedCtrl.text);
            final exact = cartTotal + _cashTip;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: AppSpace.sm,
                  runSpacing: AppSpace.sm,
                  children: [
                    _QuickTenderChip(
                      label: l10n(context).checkoutExact,
                      active: tendered != null && tendered == exact,
                      onTap: () => _fill(exact),
                    ),
                    for (final egpValue in const [50, 100, 200])
                      _QuickTenderChip(
                        label: '$egpValue',
                        active: tendered != null && tendered == egpValue * 100,
                        onTap: () => _fill(egpValue * 100),
                      ),
                  ],
                ),
                if (tendered != null && tendered > 0)
                  _ChangeDueRow(
                    change: tendered - cartTotal - _cashTip,
                    tokens: t,
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _QuickTenderChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _QuickTenderChip({
    required this.label,
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
            horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: active ? t.accent : t.surfaceAlt,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(color: active ? t.accent : t.border),
        ),
        child: Text(label,
            style: ui(
                size: 13,
                weight: FontWeight.w700,
                color: active ? t.textOnAccent : t.textSecondary)),
      ),
    );
  }
}

class _ChangeDueRow extends StatelessWidget {
  final int change;
  final AppTokens tokens;

  const _ChangeDueRow({required this.change, required this.tokens});

  @override
  Widget build(BuildContext context) {
    final ok = change >= 0;
    final fg = ok ? tokens.success : tokens.danger;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(top: AppSpace.md),
      padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: ok ? tokens.successBg : tokens.dangerBg,
        borderRadius: BorderRadius.circular(AppRadius.xs),
        border: Border.all(color: fg.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(
              ok
                  ? Icons.check_circle_outline_rounded
                  : Icons.error_outline_rounded,
              size: 16,
              color: fg),
          const SizedBox(width: AppSpace.sm),
          Expanded(
            child: Text(
                ok
                    ? l10n(context).checkoutChangeDue
                    : l10n(context).checkoutShortBy,
                style: ui(size: 13, weight: FontWeight.w600, color: fg)),
          ),
          Text(egp(change.abs()),
              style: money(size: 16, weight: FontWeight.w800, color: fg)),
        ],
      ),
    );
  }
}
