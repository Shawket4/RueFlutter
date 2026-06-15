import 'package:flutter/material.dart';
import '../../../core/models/menu.dart';
import '../../../core/services/menu_image_cache.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import '../helpers/category_style.dart';
import 'item_detail_sheet.dart';
import 'shared_widgets.dart';

/// Stateless on purpose — the card renders purely from [item]; no provider
/// state is read here, so grid rebuilds don't pay the Consumer overhead.
class MenuCard extends StatelessWidget {
  final MenuItem item;
  const MenuCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final locale = Localizations.localeOf(context).languageCode;
    final style =
        CatStyle.of(item.name, brightness: Theme.of(context).brightness);
    final hasImage = isLoadableImageUrl(item.imageUrl);

    return AnimatedPressScale(
      onTap: () => ItemDetailSheet.show(context, item),
      scaleDown: 0.97,
      child: Container(
        decoration: BoxDecoration(
          color: t.surface,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: t.borderLight),
          boxShadow: AppShadows.of(t),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          child: Column(children: [
            Expanded(
              child: hasImage
                  ? MenuImage(
                      url: item.imageUrl!,
                      fit: BoxFit.cover,
                      // Avatar as the placeholder too: a slow/dead image host
                      // shows the monogram immediately instead of a blank grey
                      // shimmer, and the photo only replaces it if it loads.
                      placeholder: MissingItemCard(item: item, style: style),
                      errorWidget: MissingItemCard(item: item, style: style),
                    )
                  : MissingItemCard(item: item, style: style),
            ),
            Container(
              color: t.surface,
              padding: const EdgeInsetsDirectional.fromSTEB(10, 7, 10, 8),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 3,
                        height: 22,
                        margin: const EdgeInsetsDirectional.only(end: 8),
                        decoration: BoxDecoration(
                            color: style.accent,
                            borderRadius: BorderRadius.circular(2))),
                    Expanded(
                        child: Text(item.localizedName(locale),
                            style: ui(
                                size: 12,
                                weight: FontWeight.w600,
                                color: t.textPrimary,
                                height: 1.25),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis)),
                    const SizedBox(width: 6),
                    Text(egp(item.basePrice),
                        style: money(
                            size: 11,
                            weight: FontWeight.w700,
                            color: t.textSecondary)),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}

class MissingItemCard extends StatelessWidget {
  final MenuItem item;
  final CatStyle style;
  const MissingItemCard({
    super.key,
    required this.item,
    required this.style,
  });

  String get _monogram {
    final cleaned = normaliseName(item.name).trim();
    if (cleaned.isEmpty) return '?';
    final words =
        cleaned.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
    if (words.length >= 2) {
      return (words[0][0] + words[1][0]).toUpperCase();
    }
    final w = words.first;
    return w.substring(0, w.length.clamp(1, 2)).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [style.bgTop, style.bgBottom],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          PositionedDirectional(
            end: -36,
            bottom: -36,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: style.accent.withOpacity(0.15),
                  width: 2,
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              _monogram,
              style: ui(
                size: 48,
                weight: FontWeight.w200,
                color: style.iconColor.withOpacity(0.55),
                height: 1,
                letterSpacing: 1.5,
              ),
            ),
          ),
          PositionedDirectional(
            top: 10,
            start: 10,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: t.surface.withOpacity(0.7),
              ),
              child: Icon(
                style.icon,
                size: 11,
                color: style.iconColor.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuCardSkeleton extends StatefulWidget {
  const MenuCardSkeleton({super.key});
  @override
  State<MenuCardSkeleton> createState() => _MenuCardSkeletonState();
}

class _MenuCardSkeletonState extends State<MenuCardSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1100))
      ..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final (base, highlight) = skeletonColors(context);
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) {
        final c = Color.lerp(base, highlight, _anim.value)!;
        return Container(
          decoration: BoxDecoration(
              color: t.surface,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              border: Border.all(color: t.borderLight)),
          child: Column(children: [
            Expanded(
                child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(AppRadius.sm)),
                    child: Container(color: c))),
            Padding(
              padding:
                  const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 10),
              child: Row(children: [
                Expanded(
                    child: Container(
                        height: 10,
                        decoration: BoxDecoration(
                            color: c,
                            borderRadius: BorderRadius.circular(4)))),
                const SizedBox(width: 12),
                Container(
                    width: 40,
                    height: 10,
                    decoration: BoxDecoration(
                        color: c, borderRadius: BorderRadius.circular(4))),
              ]),
            ),
          ]),
        );
      },
    );
  }
}
