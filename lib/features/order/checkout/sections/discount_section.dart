import 'package:flutter/material.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/models/discount.dart';
import '../../../../core/theme/app_theme.dart';

/// Discount picker chips. Selection state lives in the parent (it affects the
/// cart total); tapping the selected chip clears it — same toggle behavior
/// as before.
class DiscountSection extends StatelessWidget {
  final List<Discount> discounts;
  final Discount? selected;
  final void Function(Discount?) onSelect;

  const DiscountSection({
    super.key,
    required this.discounts,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: AppSpace.sm,
        runSpacing: AppSpace.sm,
        children: [
          _DiscountChip(
            label: l10n(context).checkoutNoDiscount,
            selected: selected == null,
            onTap: () => onSelect(null),
          ),
          ...discounts.map((d) => _DiscountChip(
                label: d.label,
                selected: selected?.id == d.id,
                onTap: () => onSelect(selected?.id == d.id ? null : d),
              )),
        ],
      );
}

class _DiscountChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _DiscountChip({
    required this.label,
    required this.selected,
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
            horizontal: AppSpace.md, vertical: AppSpace.sm),
        decoration: BoxDecoration(
          color: selected ? t.accent : t.surfaceAlt,
          borderRadius: BorderRadius.circular(AppRadius.xs),
          border: Border.all(
              color: selected ? t.accent : t.border,
              width: selected ? 1.5 : 1),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (selected) ...[
            Icon(Icons.check_rounded, size: 13, color: t.textOnAccent),
            const SizedBox(width: AppSpace.xs),
          ],
          Text(label,
              style: ui(
                  size: 13,
                  weight: FontWeight.w600,
                  color: selected ? t.textOnAccent : t.textPrimary)),
        ]),
      ),
    );
  }
}
