import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../core/l10n/l10n.dart';
import '../../core/theme/app_theme.dart';
import 'app_button.dart';

/// The one empty-state pattern: a visual (icon in a soft circle, or a Lottie
/// animation), title, optional body, optional action. Pass [lottieAsset] to
/// animate the visual — the cart and search use this; everywhere else uses the
/// static [icon].
class EmptyState extends StatelessWidget {
  final IconData? icon;

  /// Optional Lottie asset path; when set it renders (looping) in place of the
  /// icon-in-circle. One of [icon] or [lottieAsset] must be provided.
  final String? lottieAsset;
  final double lottieSize;
  final String title;
  final String? body;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    this.icon,
    this.lottieAsset,
    this.lottieSize = 140,
    required this.title,
    this.body,
    this.actionLabel,
    this.onAction,
  }) : assert(icon != null || lottieAsset != null,
            'EmptyState needs an icon or a lottieAsset');

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Padding(
          padding: const EdgeInsets.all(AppSpace.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (lottieAsset != null)
                SizedBox(
                  width: lottieSize,
                  height: lottieSize,
                  child: Lottie.asset(lottieAsset!,
                      fit: BoxFit.contain, repeat: true),
                )
              else
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                      color: t.surfaceAlt, shape: BoxShape.circle),
                  child: Icon(icon, size: 32, color: t.textMuted),
                ),
              const SizedBox(height: AppSpace.lg),
              Text(title,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center),
              if (body != null) ...[
                const SizedBox(height: AppSpace.sm),
                Text(body!,
                    style: ui(size: 13, color: t.textSecondary, height: 1.5),
                    textAlign: TextAlign.center),
              ],
              if (actionLabel != null && onAction != null) ...[
                const SizedBox(height: AppSpace.xl),
                AppButton(label: actionLabel!, onTap: onAction, width: 200),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// The one error-state pattern; offline-aware copy belongs to the caller.
class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  /// Custom retry label; defaults to the localized "Retry".
  final String? retryLabel;

  const ErrorState({
    super.key,
    required this.message,
    this.onRetry,
    this.retryLabel,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Padding(
          padding: const EdgeInsets.all(AppSpace.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration:
                    BoxDecoration(color: t.dangerBg, shape: BoxShape.circle),
                child:
                    Icon(Icons.error_outline_rounded, size: 32, color: t.danger),
              ),
              const SizedBox(height: AppSpace.lg),
              Text(message,
                  style: ui(size: 14, color: t.textSecondary, height: 1.5),
                  textAlign: TextAlign.center),
              if (onRetry != null) ...[
                const SizedBox(height: AppSpace.xl),
                AppButton(
                    label: retryLabel ?? l10n(context).retryAction,
                    onTap: onRetry,
                    variant: BtnVariant.outline,
                    width: 160),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
