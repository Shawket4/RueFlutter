import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/models/bundle.dart';
import '../../../core/providers/auth_notifier.dart';
import '../../../core/providers/menu_notifier.dart';
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
        maxCrossAxisExtent: 260,
        mainAxisSpacing: AppSpace.sm + 2,
        crossAxisSpacing: AppSpace.sm + 2,
        childAspectRatio: 1 / 0.94,
      ),
      itemCount: count,
      // GridView already wraps each child in a RepaintBoundary.
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
    final categoryId =
        ref.watch(menuProvider.select((m) => m.selectedCategoryId));
    final entries = menu.gridEntriesForCategory(branchId: branchId);

    // Each state carries a distinct key so the AnimatedSwitcher below
    // cross-fades between them — and keying the grid per category gives each
    // category a FRESH GridView, so cells never recycle a previous category's
    // images (the source of the abrupt swap + ghosting on category change).
    // Each state is wrapped so the AnimatedSwitcher has a distinct keyed child
    // to cross-fade. The grid sits in a RepaintBoundary so it composites as ONE
    // cached layer — the fade then just blends two layers (GPU-cheap) instead
    // of repainting every card each frame. Keying it per category also gives a
    // FRESH GridView, so cells never recycle a previous category's images.
    final Widget body;
    if (menu.isLoading) {
      body = RepaintBoundary(
        key: const ValueKey('menu_loading'),
        child: _buildGrid(8, (_, __) => const MenuCardSkeleton()),
      );
    } else if (menu.error != null) {
      body = ErrorState(
        key: const ValueKey('menu_error'),
        message: menu.error!,
        onRetry: () {
          final orgId = ref.read(authProvider).user?.orgId;
          if (orgId != null) {
            ref.read(menuProvider.notifier).load(orgId, force: true);
          }
        },
      );
    } else if (entries.isEmpty) {
      body = EmptyState(
        key: ValueKey('menu_empty_$categoryId'),
        icon: Icons.coffee_outlined,
        title: l10n(context).orderNoItemsCategory,
        body: l10n(context).orderPickAnotherCategory,
      );
    } else {
      body = RepaintBoundary(
        key: ValueKey('menu_grid_$categoryId'),
        child: _buildGrid(entries.length, (_, i) {
          final e = entries[i];
          switch (e.kind) {
            case MenuGridEntryKind.item:
              return MenuCard(item: e.item!);
            case MenuGridEntryKind.bundle:
              return BundleCard(bundle: e.bundle!, menuItems: menu.items);
          }
        }),
      );
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 190),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      child: body,
    );
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

    final itemFound = menu.items
        .where((i) =>
            i.isActive &&
            (i.name.toLowerCase().contains(query) ||
                (i.description?.toLowerCase().contains(query) ?? false)))
        .toList();

    final bundleFound = menu.searchBundles(query, branchId: branchId);

    if (itemFound.isEmpty && bundleFound.isEmpty) {
      return EmptyState(
        lottieAsset: 'assets/lottie/no_results.json',
        lottieSize: 160,
        title: l10n(context).orderNoResultsFor(query),
        body: l10n(context).orderTryShorterName,
      );
    }

    final entries = <MenuGridEntry>[
      ...itemFound.map(MenuGridEntry.item),
      ...bundleFound.map((b) => MenuGridEntry.bundle(b)),
    ];

    return _buildGrid(entries.length, (_, i) {
      final e = entries[i];
      if (e.kind == MenuGridEntryKind.item) {
        return MenuCard(item: e.item!);
      }
      return BundleCard(bundle: e.bundle!, menuItems: menu.items);
    });
  }
}
