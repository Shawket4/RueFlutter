import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// Legacy card wrapper. Prefer [SurfaceCard] for new code — this remains
/// token-aware so any lingering callers stay consistent.
class CardContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double radius;
  final bool elevated;

  const CardContainer({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.radius = AppRadius.md,
    this.elevated = false,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(AppSpace.xl),
      decoration: BoxDecoration(
        color: color ?? t.surface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: t.border),
        boxShadow: elevated ? AppShadows.raised(t) : AppShadows.of(t),
      ),
      child: child,
    );
  }
}
