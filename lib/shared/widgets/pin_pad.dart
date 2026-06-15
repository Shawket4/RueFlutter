import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';

/// PIN entry: progress dots + a 3×4 numeric keypad.
///
/// Token-aware (light/dark), RTL-safe (symmetric layout, auto-mirrored
/// backspace icon) with comfortable tap targets and tactile press feedback.
class PinPad extends StatelessWidget {
  final String pin;
  final int maxLength;
  final void Function(String) onDigit;
  final VoidCallback onBackspace;

  const PinPad({
    super.key,
    required this.pin,
    required this.maxLength,
    required this.onDigit,
    required this.onBackspace,
  });

  static const _rows = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    ['', '0', '⌫'],
  ];

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final keySize = context.responsive(phone: 64, tablet: 76);

    return Column(mainAxisSize: MainAxisSize.min, children: [
      // ── Progress dots ──────────────────────────────────────────────────
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(maxLength, (i) {
          final filled = i < pin.length;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutBack,
            margin: const EdgeInsets.symmetric(horizontal: AppSpace.sm),
            width: filled ? 14 : 12,
            height: filled ? 14 : 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: filled ? t.accent : Colors.transparent,
              border: Border.all(
                color: filled ? t.accent : t.border,
                width: 2,
              ),
              // Keep the shadow present in both states with a constant blur
              // and animate only its color. easeOutBack overshoots above 1.0,
              // so lerping the blur toward an absent shadow would dip it below
              // zero and trip the "shadow blur must be non-negative" assert.
              boxShadow: [
                BoxShadow(
                  color: filled ? t.accent.withOpacity(0.3) : Colors.transparent,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          );
        }),
      ),
      const SizedBox(height: AppSpace.xxl),

      // ── Keypad ─────────────────────────────────────────────────────────
      ..._rows.map((row) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpace.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: row.map((k) {
                if (k.isEmpty) {
                  // Spacer cell matching key + horizontal padding.
                  return SizedBox(width: keySize + 14, height: keySize);
                }
                final isBack = k == '⌫';
                return _Key(
                  size: keySize,
                  onTap: () {
                    isBack ? onBackspace() : onDigit(k);
                  },
                  child: isBack
                      ? Icon(Icons.backspace_outlined,
                          size: 22, color: t.textSecondary)
                      : Text(
                          k,
                          style: ui(
                            size: 22,
                            weight: FontWeight.w600,
                            color: t.textPrimary,
                          ),
                        ),
                );
              }).toList(),
            ),
          )),
    ]);
  }
}

class _Key extends StatelessWidget {
  final double size;
  final VoidCallback onTap;
  final Widget child;

  const _Key({required this.size, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: AnimatedPressScale(
        scaleDown: 0.92,
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: t.surface,
            border: Border.all(color: t.border, width: 1.5),
            boxShadow: AppShadows.of(t),
          ),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
