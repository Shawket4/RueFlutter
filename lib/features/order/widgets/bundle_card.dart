import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/models/bundle.dart';
import '../../../core/models/inventory.dart';
import '../../../core/models/menu.dart';
import '../../../core/services/menu_image_cache.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import '../../../shared/widgets/status_chip.dart';
import '../helpers/category_style.dart';
import 'bundle_detail_sheet.dart';
import 'menu_card.dart';

class BundleCard extends ConsumerWidget {
  final Bundle bundle;
  final List<MenuItem> menuItems;
  final List<InventoryItem> inventory;
  final bool enabled;
  final String? disabledReason;

  const BundleCard({
    super.key,
    required this.bundle,
    required this.menuItems,
    required this.inventory,
    this.enabled = true,
    this.disabledReason,
  });

  void _onTap(BuildContext context, WidgetRef ref) {
    if (!enabled) {
      final reason = disabledReason;
      if (reason != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n(context).orderItemOutOfStock(reason)),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      return;
    }
    HapticFeedback.lightImpact();
    BundleDetailSheet.configureAndAdd(
      context,
      ref,
      bundle: bundle,
      menuItems: menuItems,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final s = l10n(context);
    final style =
        CatStyle.of(bundle.name, brightness: Theme.of(context).brightness);
    final imageUrl = bundle.previewImageUrl(menuItems);
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;
    final savings = bundle.savingsVsComponents(menuItems);
    final compCount = bundle.components.length;

    return AnimatedPressScale(
      onTap: () => _onTap(context, ref),
      scaleDown: enabled ? 0.96 : 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: t.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: enabled ? t.navy.withOpacity(0.25) : t.border),
          boxShadow: AppShadows.of(t),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Column(children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Opacity(
                    opacity: enabled ? 1.0 : 0.4,
                    child: hasImage
                        ? MenuImage(
                            url: imageUrl,
                            fit: BoxFit.cover,
                            placeholder: const ImageSkeleton(),
                            errorWidget: _BundlePlaceholder(style: style),
                          )
                        : _BundlePlaceholder(style: style),
                  ),
                  PositionedDirectional(
                    top: 8,
                    end: 8,
                    child: StatusChip(label: s.orderCombo, tone: ChipTone.info),
                  ),
                  if (!enabled)
                    Center(
                      child: StatusChip(
                        label: s.orderOutOfStock,
                        tone: ChipTone.danger,
                        icon: Icons.block_rounded,
                      ),
                    )
                  else if (savings > 0)
                    PositionedDirectional(
                      bottom: 8,
                      start: 8,
                      child: StatusChip(
                          label: s.orderComboSave(egp(savings)),
                          tone: ChipTone.success),
                    ),
                ],
              ),
            ),
            Container(
              color: t.navyBg.withOpacity(0.45),
              padding: const EdgeInsetsDirectional.fromSTEB(10, 8, 10, 9),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.layers_outlined, size: 14, color: t.navy),
                    const SizedBox(width: 6),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(normaliseName(bundle.name),
                            style: ui(
                                size: 12,
                                weight: FontWeight.w600,
                                color: enabled ? t.textPrimary : t.textMuted,
                                height: 1.25),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        if (compCount > 0)
                          Text(s.commonItemsCount(compCount),
                              style: ui(size: 9, color: t.textMuted)),
                      ],
                    )),
                    const SizedBox(width: 6),
                    Text(egp(bundle.price),
                        style: money(
                            size: 11,
                            weight: FontWeight.w700,
                            color: enabled ? t.navy : t.textMuted)),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}

class _BundlePlaceholder extends StatelessWidget {
  final CatStyle style;

  const _BundlePlaceholder({required this.style});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [t.navyBg.withOpacity(0.5), style.bgBottom],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: Center(
        child: Icon(Icons.layers_rounded,
            size: 40, color: t.navy.withOpacity(0.4)),
      ),
    );
  }
}
