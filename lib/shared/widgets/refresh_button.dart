import 'package:flutter/material.dart';

import '../../core/l10n/l10n.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/haptics.dart';

/// Compact labelled refresh control: a spinning icon + "Refresh".
///
/// The icon turns one full rotation on every tap (tactile feedback) and keeps
/// turning for as long as [loading] is true, finishing the current rotation
/// cleanly when loading ends so it never stops mid-spin.
class RefreshButton extends StatefulWidget {
  final VoidCallback onTap;
  final bool loading;
  final bool enabled;

  const RefreshButton({
    super.key,
    required this.onTap,
    this.loading = false,
    this.enabled = true,
  });

  @override
  State<RefreshButton> createState() => _RefreshButtonState();
}

class _RefreshButtonState extends State<RefreshButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 650),
  );

  @override
  void initState() {
    super.initState();
    if (widget.loading) _spin();
  }

  @override
  void didUpdateWidget(RefreshButton old) {
    super.didUpdateWidget(old);
    if (widget.loading && !_c.isAnimating) _spin();
  }

  /// One full turn; loops itself while still loading, else rests upright.
  void _spin() {
    _c.forward(from: 0).whenComplete(() {
      if (!mounted) return;
      if (widget.loading) {
        _spin();
      } else {
        _c.value = 0;
      }
    });
  }

  void _onTap() {
    if (!widget.enabled) return;
    Haptics.selection();
    widget.onTap();
    if (!_c.isAnimating) _spin();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final fg = widget.enabled ? t.textPrimary : t.textMuted;

    return AnimatedPressScale(
      scaleDown: 0.96,
      onTap: _onTap,
      child: Container(
        height: 36,
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: t.surfaceAlt,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(color: t.border),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          RotationTransition(
            turns: _c,
            child: Icon(Icons.refresh_rounded, size: 17, color: fg),
          ),
          const SizedBox(width: 6),
          Text(l10n(context).commonRefresh,
              style: ui(size: 13, weight: FontWeight.w600, color: fg)),
        ]),
      ),
    );
  }
}
