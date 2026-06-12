import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/models/menu.dart';
import '../../../core/providers/menu_notifier.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import '../helpers/category_style.dart';

class _CatEntry {
  final String id;
  final String label;
  final IconData icon;
  const _CatEntry({required this.id, required this.label, required this.icon});
}

/// Builds entries from narrow menu slices (categories + bundle flag) so the
/// rail/strip don't rebuild when unrelated menu state (loading, items) moves.
List<_CatEntry> _entries(BuildContext context, WidgetRef ref,
    Brightness brightness) {
  final categories =
      ref.watch(menuProvider.select((m) => m.categories));
  final hasActiveBundles =
      ref.watch(menuProvider.select((m) => m.hasActiveBundles));
  return [
    for (final Category cat in categories)
      _CatEntry(
        id: cat.id,
        label: normaliseName(cat.name),
        icon: CatStyle.of(cat.name, brightness: brightness).icon,
      ),
    if (hasActiveBundles)
      _CatEntry(
        id: kComboCategoryId,
        label: l10n(context).orderCombos,
        icon: Icons.layers_rounded,
      ),
  ];
}

// ─────────────────────────────────────────────────────────────────────────────
//  VERTICAL RAIL — tablet / desktop
// ─────────────────────────────────────────────────────────────────────────────
class CategoryRail extends ConsumerWidget {
  const CategoryRail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final brightness = Theme.of(context).brightness;
    final selectedId =
        ref.watch(menuProvider.select((m) => m.selectedCategoryId));
    final entries = _entries(context, ref, brightness);

    return Container(
      width: 94,
      decoration: BoxDecoration(
        color: t.surface,
        border: BorderDirectional(end: BorderSide(color: t.borderLight)),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: AppSpace.sm),
        itemCount: entries.length,
        itemBuilder: (_, i) {
          final e = entries[i];
          return _RailTile(
            icon: e.icon,
            label: e.label,
            selected: e.id == selectedId,
            onTap: () => ref.read(menuProvider.notifier).selectCategory(e.id),
          );
        },
      ),
    );
  }
}

class _RailTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _RailTile({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return AnimatedPressScale(
      onTap: onTap,
      scaleDown: 0.95,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpace.sm, vertical: 3),
        padding: const EdgeInsetsDirectional.symmetric(
            vertical: AppSpace.md, horizontal: AppSpace.xs),
        decoration: BoxDecoration(
          color: selected ? t.accentBg : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 18, color: selected ? t.accent : t.textMuted),
          const SizedBox(height: 5),
          Text(label,
              style: ui(
                  size: 10,
                  weight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected ? t.accent : t.textSecondary,
                  height: 1.2),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
        ]),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  HORIZONTAL STRIP — phone (no side rail; sits above the grid)
// ─────────────────────────────────────────────────────────────────────────────
class CategoryStrip extends ConsumerWidget {
  const CategoryStrip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final brightness = Theme.of(context).brightness;
    final selectedId =
        ref.watch(menuProvider.select((m) => m.selectedCategoryId));
    final entries = _entries(context, ref, brightness);
    if (entries.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: t.surface,
        border: Border(bottom: BorderSide(color: t.borderLight)),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpace.md, vertical: 7),
        itemCount: entries.length,
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        itemBuilder: (_, i) {
          final e = entries[i];
          final selected = e.id == selectedId;
          return AnimatedPressScale(
            onTap: () => ref.read(menuProvider.notifier).selectCategory(e.id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: selected ? t.accentBg : t.surfaceAlt,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                border: Border.all(
                    color: selected ? t.accent.withOpacity(0.4) : t.border),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(e.icon,
                    size: 14, color: selected ? t.accent : t.textMuted),
                const SizedBox(width: 6),
                Text(e.label,
                    style: ui(
                        size: 12,
                        weight: selected ? FontWeight.w700 : FontWeight.w500,
                        color: selected ? t.accent : t.textSecondary)),
              ]),
            ),
          );
        },
      ),
    );
  }
}
