import 'package:flutter/material.dart';
import '../../core/l10n/l10n.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/connectivity_service.dart';

class AsyncStateView<T> extends StatelessWidget {
  final bool isLoading;
  final String? error;
  final bool isEmpty;
  final Widget Function(BuildContext) builder;
  final VoidCallback onRetry;

  /// Custom empty message; defaults to the localized "No data available".
  final String? emptyMessage;
  final IconData emptyIcon;

  const AsyncStateView({
    super.key,
    required this.isLoading,
    this.error,
    required this.isEmpty,
    required this.builder,
    required this.onRetry,
    this.emptyMessage,
    this.emptyIcon = Icons.inbox_rounded,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;

    if (isLoading && isEmpty) {
      return Center(
        child: CircularProgressIndicator(color: t.accent),
      );
    }

    if (error != null && isEmpty) {
      final isOffline = !ConnectivityService.instance.isOnline;
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpace.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isOffline ? Icons.wifi_off_rounded : Icons.error_outline_rounded,
                size: 48,
                color: t.textMuted,
              ),
              const SizedBox(height: AppSpace.lg),
              Text(
                isOffline
                    ? l10n(context).commonOffline
                    : l10n(context).commonSomethingWentWrong,
                style: ui(size: 18, weight: FontWeight.w700, color: t.textPrimary),
              ),
              const SizedBox(height: AppSpace.sm),
              Text(
                error!,
                style: ui(size: 14, color: t.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpace.xl),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: Text(l10n(context).retryAction),
              ),
            ],
          ),
        ),
      );
    }

    if (isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(emptyIcon, size: 48, color: t.textMuted),
            const SizedBox(height: AppSpace.lg),
            Text(
              emptyMessage ?? l10n(context).commonNoDataAvailable,
              style: ui(size: 16, color: t.textSecondary, weight: FontWeight.w600),
            ),
          ],
        ),
      );
    }

    return builder(context);
  }
}
