import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class LabelValue extends StatelessWidget {
  final String label, value;
  final Color? valueColor;
  final bool bold;

  const LabelValue(this.label, this.value,
      {super.key, this.valueColor, this.bold = false});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: ui(size: 13, color: t.textSecondary)),
          Text(value,
              style: money(
                  size: 13,
                  weight: bold ? FontWeight.w800 : FontWeight.w600,
                  color: valueColor ?? t.textPrimary)),
        ],
      ),
    );
  }
}
