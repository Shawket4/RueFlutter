import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/services/offline_queue.dart';
import '../../core/services/connectivity_service.dart';
import '../../core/theme/app_theme.dart';

class SyncStatusChip extends ConsumerWidget {
  const SyncStatusChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sync = ref.watch(offlineQueueProvider);
    final isOnline = ref.watch(isOnlineProvider);

    if (isOnline && sync.isEmpty) {
      return const SizedBox.shrink();
    }

    if (!isOnline) {
      return GestureDetector(
        onTap: () => context.push('/pending-orders'),
        child: _Chip(
          color: const Color(0xFFFFF3CD),
          textColor: const Color(0xFF856404),
          icon: Icons.wifi_off_rounded,
          text: sync.totalCount > 0 
            ? 'Offline — ${sync.totalCount} queued' 
            : 'Offline',
        ),
      );
    }

    if (sync.hasStuck) {
      return GestureDetector(
        onTap: () => context.push('/pending-orders'),
        child: _Chip(
          color: const Color(0xFFF8D7DA),
          textColor: const Color(0xFF842029),
          icon: Icons.error_outline_rounded,
          text: '${sync.stuckCount} failed',
        ),
      );
    }

    if (sync.isSyncing || sync.totalCount > 0) {
      return GestureDetector(
        onTap: () => context.push('/pending-orders'),
        child: _Chip(
          color: const Color(0xFFCFE2FF),
          textColor: const Color(0xFF084298),
          icon: Icons.sync_rounded,
          text: 'Syncing ${sync.totalCount}…',
          spin: true,
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

class _Chip extends StatefulWidget {
  final Color color;
  final Color textColor;
  final IconData icon;
  final String text;
  final bool spin;

  const _Chip({
    required this.color,
    required this.textColor,
    required this.icon,
    required this.text,
    this.spin = false,
  });

  @override
  State<_Chip> createState() => _ChipState();
}

class _ChipState extends State<_Chip> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  );

  @override
  void initState() {
    super.initState();
    if (widget.spin) _ctrl.repeat();
  }

  @override
  void didUpdateWidget(_Chip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.spin && !oldWidget.spin) {
      _ctrl.repeat();
    } else if (!widget.spin && oldWidget.spin) {
      _ctrl.stop();
      _ctrl.reset();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(AppRadius.xs),
        border: Border.all(color: widget.textColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          RotationTransition(
            turns: _ctrl,
            child: Icon(widget.icon, size: 12, color: widget.textColor),
          ),
          const SizedBox(width: 6),
          Text(
            widget.text,
            style: cairo(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: widget.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
