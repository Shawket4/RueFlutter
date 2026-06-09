import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/menu.dart';
import '../../../core/services/menu_image_cache.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import '../helpers/category_style.dart';
import 'item_detail_sheet.dart';
import 'shared_widgets.dart';

class MenuCard extends ConsumerWidget {
  final MenuItem item;
  const MenuCard({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = CatStyle.of(item.name);
    final hasImage = item.imageUrl != null && item.imageUrl!.isNotEmpty;

    return AnimatedPressScale(
      onTap: () => ItemDetailSheet.show(context, item),
      scaleDown: 0.97,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 2)),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          child: Column(children: [
            Expanded(
              child: hasImage
                  ? MenuImage(
                      url: item.imageUrl!,
                      fit: BoxFit.cover,
                      placeholder: const ImageSkeleton(),
                      errorWidget: MissingItemCard(item: item, style: style),
                    )
                  : MissingItemCard(item: item, style: style),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(10, 7, 10, 8),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 3,
                        height: 22,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                            color: style.accent,
                            borderRadius: BorderRadius.circular(2))),
                    Expanded(
                        child: Text(normaliseName(item.name),
                            style: cairo(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                height: 1.25),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis)),
                    const SizedBox(width: 6),
                    Text(egp(item.basePrice),
                        style: cairo(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textSecondary)),
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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFBFAF7), Color(0xFFEEEBE6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            right: -36,
            bottom: -36,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: style.accent.withOpacity(0.12),
                  width: 2,
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              _monogram,
              style: cairo(
                fontSize: 48,
                fontWeight: FontWeight.w200,
                color: style.accent.withOpacity(0.5),
                letterSpacing: 1.5,
                height: 1,
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.7),
              ),
              child: Icon(
                style.icon,
                size: 11,
                color: style.accent.withOpacity(0.6),
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
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _anim,
        builder: (_, __) {
          final c =
              Color.lerp(skeletonBase, skeletonHighlight, _anim.value)!;
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(color: AppColors.borderLight)),
            child: Column(children: [
              Expanded(
                  child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(AppRadius.sm)),
                      child: Container(color: c))),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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

class ImageSkeleton extends StatefulWidget {
  const ImageSkeleton({super.key});

  @override
  State<ImageSkeleton> createState() => _ImageSkeletonState();
}

class _ImageSkeletonState extends State<ImageSkeleton>
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
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
          color: Color.lerp(skeletonBase, skeletonHighlight, _anim.value)));
}