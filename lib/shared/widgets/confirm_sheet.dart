import 'package:flutter/material.dart';
import '../../core/l10n/l10n.dart';
import '../../core/theme/app_theme.dart';
import 'app_button.dart';
import 'responsive_sheet.dart';

/// The one confirmation pattern for consequential actions (void, discard,
/// close shift…). Returns true when the user confirms.
class ConfirmSheet extends StatelessWidget {
  final String title;
  final String body;
  final String confirmLabel;

  /// Custom cancel label; defaults to the localized "Cancel".
  final String? cancelLabel;
  final bool destructive;
  final IconData? icon;

  const ConfirmSheet({
    super.key,
    required this.title,
    required this.body,
    required this.confirmLabel,
    this.cancelLabel,
    this.destructive = false,
    this.icon,
  });

  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String body,
    required String confirmLabel,
    String? cancelLabel,
    bool destructive = false,
    IconData? icon,
  }) async {
    final result = await ResponsiveSheet.show<bool>(
      context: context,
      builder: (_) => ConfirmSheet(
        title: title,
        body: body,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        destructive: destructive,
        icon: icon,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final tone = destructive ? t.danger : t.accent;
    final toneBg = destructive ? t.dangerBg : t.accentBg;

    return Container(
      margin: const EdgeInsets.all(AppSpace.md),
      padding: const EdgeInsets.fromLTRB(
          AppSpace.xl, AppSpace.xl, AppSpace.xl, AppSpace.xxl),
      decoration: BoxDecoration(
        color: t.surfaceRaised,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: t.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(color: toneBg, shape: BoxShape.circle),
            child: Icon(
                icon ??
                    (destructive
                        ? Icons.warning_amber_rounded
                        : Icons.help_outline_rounded),
                size: 26,
                color: tone),
          ),
          const SizedBox(height: AppSpace.lg),
          Text(title,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center),
          const SizedBox(height: AppSpace.sm),
          Text(body,
              style: ui(size: 14, color: t.textSecondary, height: 1.5),
              textAlign: TextAlign.center),
          const SizedBox(height: AppSpace.xl),
          Row(children: [
            Expanded(
              child: AppButton(
                label: cancelLabel ?? l10n(context).cancelAction,
                variant: BtnVariant.outline,
                onTap: () => Navigator.pop(context, false),
              ),
            ),
            const SizedBox(width: AppSpace.md),
            Expanded(
              child: AppButton(
                label: confirmLabel,
                variant: destructive ? BtnVariant.danger : BtnVariant.primary,
                onTap: () => Navigator.pop(context, true),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
