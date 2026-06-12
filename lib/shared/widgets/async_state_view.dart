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
    if (isLoading && isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (error != null && isEmpty) {
      final isOffline = !ConnectivityService.instance.isOnline;
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isOffline ? Icons.wifi_off_rounded : Icons.error_outline_rounded,
                size: 48,
                color: AppColors.textMuted,
              ),
              const SizedBox(height: 16),
              Text(
                isOffline
                    ? l10n(context).commonOffline
                    : l10n(context).commonSomethingWentWrong,
                style: cairo(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                error!,
                style: cairo(fontSize: 14, color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: Text(l10n(context).retryAction,
                    style: cairo(fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.sm)),
                ),
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
            Icon(emptyIcon, size: 48, color: AppColors.textMuted),
            const SizedBox(height: 16),
            Text(
              emptyMessage ?? l10n(context).commonNoDataAvailable,
              style: cairo(fontSize: 16, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    }

    return builder(context);
  }
}
