import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  SECTION LABEL
// ─────────────────────────────────────────────────────────────────────────────
class SectionLabel extends StatelessWidget {
  final String label;
  const SectionLabel(this.label, {super.key});
  @override
  Widget build(BuildContext context) => Text(label.toUpperCase(),
      style: ui(
          size: 10,
          weight: FontWeight.w700,
          color: context.tokens.textSecondary,
          letterSpacing: 0.7));
}

// ─────────────────────────────────────────────────────────────────────────────
//  PILL (tiny badge)
// ─────────────────────────────────────────────────────────────────────────────
class Pill extends StatelessWidget {
  final String text;
  final Color color;
  const Pill(this.text, this.color, {super.key});
  @override
  Widget build(BuildContext context) => Container(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(AppRadius.xs)),
      child: Text(text,
          style: ui(
              size: 9,
              weight: FontWeight.w700,
              color: color,
              letterSpacing: 0.3)));
}

// ─────────────────────────────────────────────────────────────────────────────
//  COUNT BADGE
// ─────────────────────────────────────────────────────────────────────────────
class CountBadge extends StatelessWidget {
  final int count;
  const CountBadge({super.key, required this.count});
  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
            color: t.accentBg,
            borderRadius: BorderRadius.circular(AppRadius.pill)),
        child: Text('$count',
            style: ui(size: 11, weight: FontWeight.w700, color: t.accent)));
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SELECTABLE CHIP
// ─────────────────────────────────────────────────────────────────────────────
class SelectableChip extends StatelessWidget {
  final String label;
  final String? sublabel;
  final bool selected;
  final bool checkbox;
  final bool enabled;
  final VoidCallback onTap;
  final Color? accentColor;
  const SelectableChip({
    super.key,
    required this.label,
    this.sublabel,
    required this.selected,
    required this.checkbox,
    this.enabled = true,
    required this.onTap,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final accent = accentColor ?? t.accent;
    final isDisabled = !enabled && !selected;

    return GestureDetector(
        onTap: isDisabled ? null : onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
              color: selected
                  ? accent.withOpacity(0.14)
                  : isDisabled
                      ? t.surfaceAlt.withOpacity(0.6)
                      : t.surfaceAlt,
              borderRadius: BorderRadius.circular(AppRadius.xs),
              border: Border.all(
                  color: selected
                      ? accent
                      : isDisabled
                          ? t.border.withOpacity(0.5)
                          : t.border,
                  width: selected ? 1.5 : 1)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            if (checkbox) ...[
              Icon(
                  selected
                      ? Icons.check_box_rounded
                      : Icons.check_box_outline_blank_rounded,
                  size: 14,
                  color: selected
                      ? accent
                      : isDisabled
                          ? t.border
                          : t.textMuted),
              const SizedBox(width: 6),
            ],
            Text(label,
                style: ui(
                    size: 13,
                    weight: FontWeight.w600,
                    color: selected
                        ? accent
                        : isDisabled
                            ? t.textMuted
                            : t.textPrimary)),
            if (sublabel != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    color: selected
                        ? accent.withOpacity(0.18)
                        : accent.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(sublabel!,
                    style: money(size: 10, weight: FontWeight.w700, color: accent)),
              ),
            ],
          ]),
        ));
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  QTY BUTTON (± inside footer)
// ─────────────────────────────────────────────────────────────────────────────
class QtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const QtyBtn({super.key, required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: onTap,
      child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: Icon(icon, size: 18, color: context.tokens.textPrimary)));
}

// ─────────────────────────────────────────────────────────────────────────────
//  INLINE BUTTON (small cart row ± buttons)
// ─────────────────────────────────────────────────────────────────────────────
class InlineBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const InlineBtn({super.key, required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return GestureDetector(
        onTap: onTap,
        child: Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
                color: t.surface,
                borderRadius: BorderRadius.circular(AppRadius.xs),
                border: Border.all(color: t.border)),
            alignment: Alignment.center,
            child: Icon(icon, size: 13, color: t.textPrimary)));
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  ICON BUTTON (top bar)
// ─────────────────────────────────────────────────────────────────────────────
class SmallIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const SmallIconBtn({super.key, required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return GestureDetector(
        onTap: onTap,
        child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
                color: t.surfaceAlt,
                borderRadius: BorderRadius.circular(AppRadius.xs),
                border: Border.all(color: t.border)),
            alignment: Alignment.center,
            child: Icon(icon, size: 18, color: t.textPrimary)));
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  FIELD LABEL (checkout forms)
// ─────────────────────────────────────────────────────────────────────────────
class FieldLabel extends StatelessWidget {
  final String text;
  const FieldLabel(this.text, {super.key});
  @override
  Widget build(BuildContext context) => Text(text,
      style: ui(
          size: 10,
          weight: FontWeight.w700,
          color: context.tokens.textMuted,
          letterSpacing: 1.2));
}

// ─────────────────────────────────────────────────────────────────────────────
//  SKELETON HELPERS
// ─────────────────────────────────────────────────────────────────────────────

// Legacy light-theme constants — still consumed by not-yet-migrated sheets.
const skeletonBase = Color(0xFFEEF0F4);
const skeletonHighlight = Color(0xFFE4E7ED);

/// Token-aware skeleton color pair for the current theme.
(Color, Color) skeletonColors(BuildContext context) {
  final t = context.tokens;
  return (t.surfaceAlt, t.borderLight);
}
