import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// Uppercase-feel section label with optional trailing widget.
class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  const SectionHeader({
    super.key,
    required this.title,
    this.trailing,
    this.padding = const EdgeInsetsDirectional.only(
        start: AppSpace.xs, bottom: AppSpace.sm, top: AppSpace.lg),
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: padding,
      child: Row(children: [
        Expanded(
          child: Text(title,
              style: ui(
                  size: 12,
                  weight: FontWeight.w700,
                  color: t.textMuted,
                  letterSpacing: 0.6)),
        ),
        if (trailing != null) trailing!,
      ]),
    );
  }
}
