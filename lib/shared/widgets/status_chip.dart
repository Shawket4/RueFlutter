import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

enum ChipTone { neutral, accent, success, danger, warning, info }

/// Small status pill used for sync states, order states, shift states…
class StatusChip extends StatelessWidget {
  final String label;
  final ChipTone tone;
  final IconData? icon;
  final bool spinning;
  final VoidCallback? onTap;

  const StatusChip({
    super.key,
    required this.label,
    this.tone = ChipTone.neutral,
    this.icon,
    this.spinning = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final (bg, fg) = switch (tone) {
      ChipTone.neutral => (t.surfaceAlt, t.textSecondary),
      ChipTone.accent => (t.accentBg, t.accent),
      ChipTone.success => (t.successBg, t.success),
      ChipTone.danger => (t.dangerBg, t.danger),
      ChipTone.warning => (t.warningBg, t.warning),
      ChipTone.info => (t.navyBg, t.navy),
    };

    final chip = Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: fg.withOpacity(0.25)),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (icon != null) ...[
          spinning ? _Spin(child: Icon(icon, size: 12, color: fg)) : Icon(icon, size: 12, color: fg),
          const SizedBox(width: 5),
        ],
        Text(label, style: ui(size: 11, weight: FontWeight.w700, color: fg)),
      ]),
    );

    return onTap == null ? chip : AnimatedPressScale(onTap: onTap, child: chip);
  }
}

class _Spin extends StatefulWidget {
  final Widget child;
  const _Spin({required this.child});
  @override
  State<_Spin> createState() => _SpinState();
}

class _SpinState extends State<_Spin> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000))
    ..repeat();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      RotationTransition(turns: _ctrl, child: widget.child);
}
