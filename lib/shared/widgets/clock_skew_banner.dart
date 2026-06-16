import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/l10n.dart';
import '../../core/providers/clock_provider.dart';
import '../../core/theme/app_theme.dart';

/// Warns the cashier when this device's clock is meaningfully wrong vs the
/// server. Timestamps are still corrected automatically (online = server time;
/// offline work is re-based to a fresh offset at sync), but a badly-set clock is
/// worth fixing so future OFFLINE work stays accurate. Shows nothing when the
/// clock is fine.
class ClockSkewBanner extends ConsumerWidget {
  final EdgeInsetsGeometry margin;
  const ClockSkewBanner(
      {super.key, this.margin = const EdgeInsets.only(bottom: 10)});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final s = l10n(context);
    final skew = ref.watch(clockSkewProvider).valueOrNull ?? Duration.zero;

    if (skew < kClockSkewWarnThreshold) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: margin,
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: t.warningBg,
        borderRadius: BorderRadius.circular(AppRadius.xs),
        border: Border.all(color: t.warning.withOpacity(0.3)),
      ),
      child: Row(children: [
        Icon(Icons.schedule_rounded, size: 16, color: t.warning),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            s.clockSkewWarning(skew.inMinutes),
            style: ui(size: 12, weight: FontWeight.w600, color: t.warning),
          ),
        ),
      ]),
    );
  }
}
