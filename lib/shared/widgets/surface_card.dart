import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// The single card surface for the app: token-aware (light/dark), border-led
/// with a whisper of shadow. Replaces ad-hoc `Container(decoration: ...)`.
class SurfaceCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final bool raised;
  final Color? color;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Clip clipBehavior;

  const SurfaceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpace.lg),
    this.margin,
    this.radius = AppRadius.md,
    this.raised = false,
    this.color,
    this.onTap,
    this.onLongPress,
    this.clipBehavior = Clip.none,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final card = Container(
      margin: margin,
      padding: padding,
      clipBehavior: clipBehavior,
      decoration: BoxDecoration(
        color: color ?? (raised ? t.surfaceRaised : t.surface),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: t.border),
        boxShadow: raised ? AppShadows.raised(t) : AppShadows.of(t),
      ),
      child: child,
    );
    if (onTap == null && onLongPress == null) return card;
    return AnimatedPressScale(onTap: onTap, onLongPress: onLongPress, child: card);
  }
}
