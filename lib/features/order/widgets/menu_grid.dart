import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/models/bundle.dart';
import '../../../core/providers/auth_notifier.dart';
import '../../../core/providers/menu_notifier.dart';
import '../../../core/providers/shift_notifier.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/empty_state.dart';
import 'bundle_card.dart';
import 'menu_card.dart';

/// Width-driven grid: cells target ~190dp and the column count falls out of
/// the ACTUAL available width — a phone rotated to landscape gets 4 columns,
/// a split-screen tablet gets fewer, etc. (Keying columns off device class
/// gave landscape phones two giant cards.)
Widget _buildGrid(int count, Widget Function(BuildContext, int) builder) =>
    GridView.builder(
      padding: const EdgeInsets.all(AppSpace.md),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: AppSpace.sm + 2,
        crossAxisSpacing: AppSpace.sm + 2,
        childAspectRatio: 1 / 1.22,
      ),
      itemCount: count,
      itemBuilder: builder,
    );

class MenuGrid extends ConsumerWidget {
  const MenuGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menu = ref.watch(menuProvider);
    // select(): the grid must NOT rebuild when unrelated auth/shift state
    // changes (e.g. systemCash refresh after every checkout).
    final branchId =
        ref.watch(authProvider.select((s) => s.user?.branchId ?? ''));
    final inventory = ref.watch(shiftProvider.select((s) => s.inventory));
    final entries = menu.gridEntriesForCategory(
      branchId: branchId,
      inventory: inventory,
    );

    if (menu.isLoading) {
      return _buildGrid(8, (_, __) => const MenuCardSkeleton());
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
      return EmptyState(
        icon: Icons.coffee_outlined,
        title: l10n(context).orderNoItemsCategory,
        body: l10n(context).orderPickAnotherCategory,
      );
    }
    return _buildGrid(entries.length, (_, i) {
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
}

class SearchResults extends ConsumerWidget {
  final String query;
  const SearchResults({required this.query, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menu = ref.watch(menuProvider);
    final branchId =
        ref.watch(authProvider.select((s) => s.user?.branchId ?? ''));
    final inventory = ref.watch(shiftProvider.select((s) => s.inventory));

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
      return EmptyState(
        icon: Icons.search_off_rounded,
        title: l10n(context).orderNoResultsFor(query),
        body: l10n(context).orderTryShorterName,
      );
    }

    final entries = <MenuGridEntry>[
      ...itemFound.map(MenuGridEntry.item),
      ...bundleFound.map((b) => MenuGridEntry.bundle(b)),
    ]..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

    return _buildGrid(entries.length, (_, i) {
      final e = entries[i];
      if (e.kind == MenuGridEntryKind.item) {
        return MenuCard(item: e.item!);
      }
      return BundleCard(
        bundle: e.bundle!,
        menuItems: menu.items,
        inventory: inventory,
      );
    });
  }
}
