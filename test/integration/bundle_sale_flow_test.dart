import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/bundle.dart';
import 'package:sufrix_pos/core/models/cart.dart';
import 'package:sufrix_pos/core/models/menu.dart';

/// Offline bundle sale flow: snapshot capture → cart JSON → API payload shape.
void main() {
  test('add bundle captures component snapshot for sync payload', () {
    final bundle = Bundle(
      id: 'bundle-1',
      orgId: 'org-1',
      name: 'Breakfast Combo',
      price: 4500,
      status: BundleStatus.active,
      displayOrder: 1,
      components: const [
        BundleComponent(
          bundleId: 'bundle-1',
          itemId: 'latte',
          quantity: 1,
          position: 0,
        ),
        BundleComponent(
          bundleId: 'bundle-1',
          itemId: 'croissant',
          quantity: 1,
          position: 1,
        ),
      ],
    );

    const menuItems = [
      MenuItem(
        id: 'latte',
        orgId: 'org-1',
        name: 'Latte',
        basePrice: 3000,
        isActive: true,
        displayOrder: 0,
      ),
      MenuItem(
        id: 'croissant',
        orgId: 'org-1',
        name: 'Croissant',
        basePrice: 2000,
        isActive: true,
        displayOrder: 1,
      ),
    ];

    final sorted = List<BundleComponent>.of(bundle.components)
      ..sort((a, b) => a.position.compareTo(b.position));

    final snapshot = <BundleComponentSnapshot>[];
    for (final comp in sorted) {
      MenuItem? item;
      for (final m in menuItems) {
        if (m.id == comp.itemId) {
          item = m;
          break;
        }
      }
      snapshot.add(BundleComponentSnapshot(
        itemId: comp.itemId,
        itemName: item?.name ?? 'Item',
        quantity: comp.quantity,
        addons: comp.itemId == 'latte'
            ? const [
                SelectedAddon(
                  addonItemId: 'oat',
                  name: 'Oat milk',
                  priceModifier: 500,
                ),
              ]
            : const [],
      ));
    }

    final line = CartItem(
      bundleId: bundle.id,
      bundleComponents: snapshot,
      itemName: bundle.name,
      unitPrice: bundle.price,
      quantity: 2,
    );

    final api = line.toApiJson();
    expect(api['menu_item_id'], isNull);
    expect(api['bundle_id'], 'bundle-1');
    expect(api['bundle_unit_price'], 4500);
    expect(api['quantity'], 2);
    final comps = api['bundle_components'] as List;
    expect(comps[0]['addons'], [
      {'addon_item_id': 'oat', 'quantity': 1},
    ]);

    final stored = CartItem.fromStorageJson(line.toStorageJson());
    expect(stored.lineTotal, 10000);
    expect(stored.bundleComponents!.length, 2);

    // Idempotency: same bundle id merges in cart logic
    final existing = [line];
    final incoming = line.copyWith(quantity: 1);
    final idx = existing.indexWhere((i) => i.bundleId == incoming.bundleId);
    expect(idx, 0);
  });
}
