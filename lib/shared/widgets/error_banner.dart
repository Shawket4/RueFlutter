import 'package:flutter/material.dart';
import '../../core/l10n/l10n.dart';
import '../../core/theme/app_theme.dart';

class ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorBanner({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        color: t.dangerBg,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: t.danger.withOpacity(0.18)),
      ),
      child: Row(children: [
        Icon(Icons.error_outline_rounded, color: t.danger, size: 17),
        const SizedBox(width: AppSpace.sm),
        Expanded(
            child: Text(message,
                style: ui(size: 13, color: t.danger))),
        if (onRetry != null)
          TextButton(
            onPressed: onRetry,
            style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12)),
            child: Text(l10n(context).retryAction,
                style: ui(size: 13, weight: FontWeight.w700, color: t.accent)),
          ),
      ]),
    );
  }
}
