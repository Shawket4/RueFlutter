import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

enum SyncBannerVariant { offline, syncing, stuck }

class SyncStatusBanner extends StatelessWidget {
  final SyncBannerVariant variant;
  final String text;

  const SyncStatusBanner({super.key, required this.variant, required this.text});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final (bg, fg, icon, animate) = switch (variant) {
      SyncBannerVariant.offline =>
        (t.warningBg, t.warning, Icons.wifi_off_rounded, false),
      SyncBannerVariant.syncing =>
        (t.navyBg, t.navy, Icons.sync_rounded, true),
      SyncBannerVariant.stuck =>
        (t.warningBg, t.warning, Icons.warning_amber_rounded, false),
    };

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.xs),
        border: Border.all(color: fg.withOpacity(0.3)),
      ),
      child: Row(children: [
        animate
            ? SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(strokeWidth: 2, color: fg))
            : Icon(icon, size: 16, color: fg),
        const SizedBox(width: 10),
        Expanded(
            child: Text(text,
                style: ui(size: 12, weight: FontWeight.w600, color: fg))),
      ]),
    );
  }
}
