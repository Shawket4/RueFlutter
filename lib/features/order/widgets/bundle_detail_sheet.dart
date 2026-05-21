import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/bundle.dart';
import '../../../core/models/cart.dart';
import '../../../core/models/menu.dart';
import '../../../core/providers/cart_notifier.dart';
import '../../../core/providers/menu_notifier.dart';
import '../../../core/utils/formatting.dart';
import '../../../shared/widgets/responsive_sheet.dart';
import 'item_detail_sheet.dart';

bool componentNeedsConfiguration(
  MenuItem item,
  Map<String, List<AddonItem>> addonsByType,
) {
  if (item.sizes.length > 1) return true;
  if (item.optionalFields.any((f) => f.isActive)) return true;
  if (item.addonSlots.isNotEmpty) return true;

  final slotted = item.addonSlots.map((s) => s.addonType).toSet();
  const globalTypes = ['milk_type', 'coffee_type', 'extra'];
  for (final t in globalTypes) {
    if (!slotted.contains(t) &&
        (addonsByType[t] ?? []).any((a) => a.isActive)) {
      return true;
    }
  }
  return false;
}

MenuItem? _menuItemById(List<MenuItem> items, String id) {
  for (final m in items) {
    if (m.id == id) return m;
  }
  return null;
}

class BundleDetailSheet extends ConsumerWidget {
  final Bundle bundle;
  final List<MenuItem> menuItems;

  const BundleDetailSheet({
    super.key,
    required this.bundle,
    required this.menuItems,
  });

  static Future<void> show(
    BuildContext context, {
    required Bundle bundle,
    required List<MenuItem> menuItems,
  }) =>
      ResponsiveSheet.show(
        context: context,
        builder: (_) => BundleDetailSheet(
          bundle: bundle,
          menuItems: menuItems,
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SizedBox.shrink();
  }

  static Future<void> configureAndAdd(
    BuildContext context,
    WidgetRef ref, {
    required Bundle bundle,
    required List<MenuItem> menuItems,
  }) async {
    final addonsByType = ref.read(menuProvider).addonsByType;
    final sorted = List<BundleComponent>.of(bundle.components)
      ..sort((a, b) => a.position.compareTo(b.position));

    final snapshots = <BundleComponentSnapshot>[];

    for (var i = 0; i < sorted.length; i++) {
      final comp = sorted[i];
      final item = _menuItemById(menuItems, comp.itemId);
      if (item == null) {
        snapshots.add(BundleComponentSnapshot(
          itemId: comp.itemId,
          itemName: 'Item',
          quantity: comp.quantity,
        ));
        continue;
      }

      final defaultSize =
          item.sizes.isNotEmpty ? item.sizes.first.label : null;

      if (componentNeedsConfiguration(item, addonsByType)) {
        final config = await ItemDetailSheet.showForConfiguration(
          context,
          item: item,
          title: '${normaliseName(item.name)} (${normaliseName(bundle.name)})',
        );
        if (config == null || !context.mounted) return;

        snapshots.add(BundleComponentSnapshot(
          itemId: comp.itemId,
          itemName: item.name,
          quantity: comp.quantity,
          sizeLabel: config.sizeLabel ?? defaultSize,
          addons: config.addons,
          optionals: config.optionals,
        ));
      } else {
        snapshots.add(BundleComponentSnapshot(
          itemId: comp.itemId,
          itemName: item.name,
          quantity: comp.quantity,
          sizeLabel: defaultSize,
        ));
      }
    }

    if (!context.mounted) return;
    ref.read(cartProvider.notifier).addBundle(bundle, snapshots);
  }
}
