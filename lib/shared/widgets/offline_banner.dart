import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/l10n/l10n.dart';
import '../../core/providers/auth_notifier.dart';
import '../../core/services/connectivity_service.dart';
import '../../core/services/offline_queue.dart';
import '../../core/theme/app_theme.dart';

/// Persistent context banner for degraded states. Shows nothing when all is
/// well. Order of precedence: offline session → offline → auth-paused queue.
class OfflineBanner extends ConsumerWidget {
  final EdgeInsetsGeometry margin;
  const OfflineBanner(
      {super.key, this.margin = const EdgeInsets.only(bottom: 10)});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final s = l10n(context);
    final isOnline = ref.watch(isOnlineProvider);
    final auth = ref.watch(authProvider);
    final queue = ref.watch(offlineQueueProvider);

    final (String? text, IconData icon) = switch ((
      auth.isOfflineSession,
      isOnline,
      queue.authPaused && !queue.isEmpty,
    )) {
      (true, _, _) => (
          s.syncOfflineSessionBanner,
          Icons.lock_clock_rounded
        ),
      (false, false, _) => (
          s.syncOfflineBanner,
          Icons.wifi_off_rounded
        ),
      (false, true, true) => (
          s.syncSessionExpiredBanner(queue.totalCount),
          Icons.lock_clock_rounded
        ),
      _ => (null, Icons.info_outline),
    };

    if (text == null) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: margin,
      padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: t.warningBg,
        borderRadius: BorderRadius.circular(AppRadius.xs),
        border: Border.all(color: t.warning.withOpacity(0.3)),
      ),
      child: Row(children: [
        Icon(icon, size: 16, color: t.warning),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: ui(size: 12, weight: FontWeight.w600, color: t.warning)),
        ),
      ]),
    );
  }
}
