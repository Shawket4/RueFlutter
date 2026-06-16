import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/haptics.dart';

enum BtnVariant { primary, danger, outline, ghost }

class AppButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final bool loading;
  final BtnVariant variant;
  final double? width;
  final IconData? icon;
  final double height;

  const AppButton({
    super.key,
    required this.label,
    this.onTap,
    this.loading = false,
    this.variant = BtnVariant.primary,
    this.width,
    this.icon,
    this.height = 50,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _scale = Tween<double>(begin: 1.0, end: 0.975)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  bool get _enabled => !widget.loading && widget.onTap != null;

  Color _bg(AppTokens t) => switch (widget.variant) {
        BtnVariant.primary => t.accent,
        BtnVariant.danger => t.danger,
        BtnVariant.outline => Colors.transparent,
        BtnVariant.ghost => Colors.transparent,
      };

  Color _fg(AppTokens t) => switch (widget.variant) {
        BtnVariant.primary => t.textOnAccent,
        BtnVariant.danger => Colors.white,
        BtnVariant.outline => t.accent,
        BtnVariant.ghost => t.textSecondary,
      };

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final hasBorder = widget.variant == BtnVariant.outline;
    final bg = _bg(t);
    final fg = _fg(t);

    return GestureDetector(
      onTapDown: (_) {
        if (_enabled) _ctrl.forward();
      },
      onTapUp: (_) {
        if (_enabled) {
          _ctrl.reverse();
          widget.variant == BtnVariant.danger
              ? Haptics.impact()
              : Haptics.tap();
          widget.onTap!();
        }
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              color: _enabled ? bg : bg.withOpacity(0.45),
              borderRadius: BorderRadius.circular(AppRadius.sm),
              border: hasBorder
                  ? Border.all(
                      color: _enabled ? t.accent : t.border, width: 1.5)
                  : null,
            ),
            alignment: Alignment.center,
            child: widget.loading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child:
                        CircularProgressIndicator(strokeWidth: 2.5, color: fg))
                : Row(mainAxisSize: MainAxisSize.min, children: [
                    if (widget.icon != null) ...[
                      Icon(widget.icon, size: 17, color: fg),
                      const SizedBox(width: AppSpace.sm),
                    ],
                    Text(widget.label,
                        style:
                            ui(size: 14, weight: FontWeight.w700, color: fg)),
                  ]),
          ),
        ),
      ),
    );
  }
}
