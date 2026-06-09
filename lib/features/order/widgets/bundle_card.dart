import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/bundle.dart';
import '../../../core/models/inventory.dart';
import '../../../core/models/menu.dart';
import 'bundle_detail_sheet.dart';
import '../../../core/services/menu_image_cache.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import '../helpers/category_style.dart';
import 'menu_card.dart';
class BundleCard extends ConsumerStatefulWidget {
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

  @override
  ConsumerState<BundleCard> createState() => _BundleCardState();
}

class _BundleCardState extends ConsumerState<BundleCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pressCtrl;
  late final Animation<double> _pressAnim;

  @override
  void initState() {
    super.initState();
    _pressCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _pressAnim = Tween<double>(begin: 1, end: 0.96)
        .animate(CurvedAnimation(parent: _pressCtrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _pressCtrl.dispose();
    super.dispose();
  }

  void _onTap() {
    if (!widget.enabled) {
      final reason = widget.disabledReason;
      if (reason != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(bundleOutOfStockHint(reason),
                style: cairo(fontSize: 13)),
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
      bundle: widget.bundle,
      menuItems: widget.menuItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bundle = widget.bundle;
    final style = CatStyle.of(bundle.name);
    final imageUrl = bundle.previewImageUrl(widget.menuItems);
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;
    final savings = bundle.savingsVsComponents(widget.menuItems);
    final compCount = bundle.components.length;
    final opacity = widget.enabled ? 1.0 : 0.45;

    return Opacity(
      opacity: opacity,
      child: GestureDetector(
        onTapDown: widget.enabled ? (_) => _pressCtrl.forward() : null,
        onTapUp: widget.enabled
            ? (_) async {
                await _pressCtrl.reverse();
                if (mounted) _onTap();
              }
            : null,
        onTapCancel: widget.enabled ? () => _pressCtrl.reverse() : null,
        onTap: widget.enabled ? null : _onTap,
        child: ScaleTransition(
          scale: _pressAnim,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                    color: style.accent.withOpacity(0.1),
                    blurRadius: 14,
                    offset: const Offset(0, 4)),
                BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 3,
                    offset: const Offset(0, 1)),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: Column(children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (hasImage)
                        MenuImage(
                          url: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: const ImageSkeleton(),
                          errorWidget:
                              _BundlePlaceholder(bundle: bundle, style: style),
                        )
                      else
                        _BundlePlaceholder(bundle: bundle, style: style),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(AppRadius.xs),
                          ),
                          child: Text(comboLabel(),
                              style: cairo(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white)),
                        ),
                      ),
                      if (savings > 0)
                        Positioned(
                          bottom: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.92),
                              borderRadius:
                                  BorderRadius.circular(AppRadius.xs),
                            ),
                            child: Text(bundleSaveLabel(savings),
                                style: cairo(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white)),
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  color: AppColors.primary.withOpacity(0.04),
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 9),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.layers_outlined,
                            size: 14, color: AppColors.primary),
                        const SizedBox(width: 6),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(normaliseName(bundle.name),
                                style: cairo(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    height: 1.25),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis),
                            if (compCount > 0)
                              Text(bundleItemCountLabel(compCount),
                                  style: cairo(
                                      fontSize: 9,
                                      color: AppColors.textMuted)),
                          ],
                        )),
                        const SizedBox(width: 6),
                        Text(egp(bundle.price),
                            style: cairo(
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                color: AppColors.primary)),
                      ]),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class _BundlePlaceholder extends StatelessWidget {
  final Bundle bundle;
  final CatStyle style;

  const _BundlePlaceholder({required this.bundle, required this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.06),
            style.accent.withOpacity(0.12),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(Icons.layers_rounded,
            size: 40, color: AppColors.primary.withOpacity(0.35)),
      ),
    );
  }
}
