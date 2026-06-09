import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/menu_notifier.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import '../helpers/category_style.dart';

class CategoryRail extends ConsumerWidget {
  const CategoryRail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menu = ref.watch(menuProvider);
    final showCombos = menu.hasActiveBundles;
    return Container(
      width: 94,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: AppColors.borderLight)),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: menu.categories.length + (showCombos ? 1 : 0),
        itemBuilder: (_, i) {
          if (showCombos && i == menu.categories.length) {
            final sel = menu.selectedCategoryId == kComboCategoryId;
            return _Tile(
              icon: Icons.layers_rounded,
              label: 'Combos',
              selected: sel,
              onTap: () => ref
                  .read(menuProvider.notifier)
                  .selectCategory(kComboCategoryId),
            );
          }
          final cat = menu.categories[i];
          final sel = cat.id == menu.selectedCategoryId;
          return _Tile(
            icon: CatStyle.of(cat.name).icon,
            label: normaliseName(cat.name),
            selected: sel,
            onTap: () =>
                ref.read(menuProvider.notifier).selectCategory(cat.id),
          );
        },
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _Tile({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => AnimatedPressScale(
        onTap: onTap,
        scaleDown: 0.95,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon,
                size: 18,
                color: selected ? Colors.white : AppColors.textMuted),
            const SizedBox(height: 5),
            Text(label,
                style: cairo(
                    fontSize: 10,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: selected ? Colors.white : AppColors.textSecondary,
                    height: 1.2),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
          ]),
        ),
      );
}
