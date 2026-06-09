import 'package:flutter/material.dart';
import '../../../../core/models/discount.dart';
import '../../../../core/theme/app_theme.dart';

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
        spacing: 8,
        runSpacing: 8,
        children: [
          _chip('None', null, selected == null, AppColors.primary),
          ...discounts.map((d) =>
              _chip(d.label, d, selected?.id == d.id, AppColors.success)),
        ],
      );

  Widget _chip(String label, Discount? d, bool sel, Color color) =>
      GestureDetector(
        onTap: () => onSelect(sel ? null : d),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: sel ? color : AppColors.bg,
            borderRadius: BorderRadius.circular(AppRadius.xs),
            border: Border.all(
                color: sel ? color : AppColors.border, width: sel ? 1.5 : 1),
          ),
          child: Text(label,
              style: cairo(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: sel ? Colors.white : AppColors.textPrimary)),
        ),
      );
}
