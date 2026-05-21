import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../../../core/models/bundle.dart';
import '../../../core/providers/auth_notifier.dart';
import '../../../core/providers/menu_notifier.dart';
import '../../../core/providers/shift_notifier.dart';
import '../../../core/theme/app_theme.dart';
import 'bundle_card.dart';
import 'menu_card.dart';
import 'shared_widgets.dart';

class MenuGrid extends ConsumerWidget {
  const MenuGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menu = ref.watch(menuProvider);
    final branchId = ref.watch(authProvider).user?.branchId ?? '';
    final inventory = ref.watch(shiftProvider).inventory;
    final entries = menu.gridEntriesForCategory(
      branchId: branchId,
      inventory: inventory,
    );

    if (menu.isLoading) {
      return _grid(8, (_, __) => const MenuCardSkeleton());
    }
    if (menu.error != null) {
      return ErrorState(
        message: menu.error!,
        onRetry: () {
          final orgId = ref.read(authProvider).user?.orgId;
          if (orgId != null) {
            ref.read(menuProvider.notifier).load(orgId, force: true);
          }
        },
      );
    }
    if (entries.isEmpty) {
      return Center(
          child: Text('No items in this category',
              style: cairo(color: AppColors.textMuted)));
    }
    return _grid(entries.length, (_, i) {
      final e = entries[i];
      switch (e.kind) {
        case MenuGridEntryKind.item:
          return MenuCard(item: e.item!);
        case MenuGridEntryKind.bundle:
          return BundleCard(
            bundle: e.bundle!,
            menuItems: menu.items,
            inventory: inventory,
            enabled: e.enabled,
            disabledReason: e.disabledReason,
          );
      }
    });
  }

  Widget _grid(int count, Widget Function(BuildContext, int) builder) =>
      LayoutBuilder(builder: (ctx, constraints) {
        final cols = (constraints.maxWidth / 160).floor().clamp(2, 6);
        final extent = constraints.maxWidth / cols;
        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: extent / (extent * 1.22),
          ),
          itemCount: count,
          itemBuilder: builder,
        );
      });
}

class SearchResults extends ConsumerWidget {
  final String query;
  const SearchResults({required this.query, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menu = ref.watch(menuProvider);
    final branchId = ref.watch(authProvider).user?.branchId ?? '';
    final inventory = ref.watch(shiftProvider).inventory;

    final itemFound = menu.items
        .where((i) =>
            i.isActive &&
            (i.name.toLowerCase().contains(query) ||
                (i.description?.toLowerCase().contains(query) ?? false)))
        .toList();

    final bundleFound = menu.searchBundles(
      query,
      branchId: branchId,
      inventory: inventory,
    );

    if (itemFound.isEmpty && bundleFound.isEmpty) {
      return Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
            width: 160,
            height: 160,
            child: Lottie.asset('assets/lottie/no_results.json',
                fit: BoxFit.contain, repeat: true)),
        const SizedBox(height: 8),
        Text('No results for "$query"',
            style: cairo(fontSize: 14, color: AppColors.textSecondary)),
      ]));
    }

    final entries = <MenuGridEntry>[
      ...itemFound.map(MenuGridEntry.item),
      ...bundleFound.map((b) => MenuGridEntry.bundle(b)),
    ]..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

    return LayoutBuilder(builder: (ctx, constraints) {
      final cols = (constraints.maxWidth / 160).floor().clamp(2, 6);
      final extent = constraints.maxWidth / cols;
      return GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cols,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: extent / (extent * 1.22),
        ),
        itemCount: entries.length,
        itemBuilder: (_, i) {
          final e = entries[i];
          if (e.kind == MenuGridEntryKind.item) {
            return MenuCard(item: e.item!);
          }
          return BundleCard(
            bundle: e.bundle!,
            menuItems: menu.items,
            inventory: inventory,
          );
        },
      );
    });
  }
}
