import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/l10n/l10n.dart';
import '../../core/services/offline_queue.dart';
import '../../core/services/connectivity_service.dart';
import 'status_chip.dart';

/// Glanceable sync state. Tapping always lands on the Sync Center.
///
/// States, in priority order:
///   paused (sign-in needed) → offline (+queued) → stuck → syncing/queued → ∅
class SyncStatusChip extends ConsumerWidget {
  const SyncStatusChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = l10n(context);
    final sync = ref.watch(offlineQueueProvider);
    final isOnline = ref.watch(isOnlineProvider);
    void open() => context.pushNamed('pending-orders');

    if (sync.authPaused && !sync.isEmpty) {
      return StatusChip(
        label: s.syncSignInToSync(sync.totalCount),
        tone: ChipTone.warning,
        icon: Icons.lock_clock_rounded,
        onTap: open,
      );
    }

    if (!isOnline) {
      return StatusChip(
        label: sync.totalCount > 0
            ? s.syncOfflineQueued(sync.totalCount)
            : s.commonOffline,
        tone: ChipTone.warning,
        icon: Icons.wifi_off_rounded,
        onTap: open,
      );
    }

    if (sync.hasStuck) {
      return StatusChip(
        label: s.syncNeedAttention(sync.stuckCount),
        tone: ChipTone.danger,
        icon: Icons.error_outline_rounded,
        onTap: open,
      );
    }

    if (sync.isSyncing || sync.totalCount > 0) {
      return StatusChip(
        label: s.syncSyncingCount(sync.totalCount),
        tone: ChipTone.info,
        icon: Icons.sync_rounded,
        spinning: true,
        onTap: open,
      );
    }

    return const SizedBox.shrink();
  }
}
