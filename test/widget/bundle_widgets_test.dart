import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sufrix_pos/core/models/bundle.dart';
import 'package:sufrix_pos/core/models/cart.dart';
import 'package:sufrix_pos/core/models/menu.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';
import 'package:sufrix_pos/features/order/widgets/bundle_card.dart';
import 'package:sufrix_pos/features/order/widgets/bundle_cart_row.dart';

Bundle _testBundle() => Bundle(
      id: 'b1',
      orgId: 'o1',
      name: 'Breakfast Combo',
      price: 4500,
      status: BundleStatus.active,
      displayOrder: 1,
      components: const [
        BundleComponent(
          bundleId: 'b1',
          itemId: 'item-1',
          quantity: 1,
          position: 0,
        ),
      ],
    );

Widget _wrap(Widget child, SharedPreferences prefs) => ProviderScope(
      overrides: [
        storageServiceProvider.overrideWithValue(StorageService(prefs)),
      ],
      child: MaterialApp(home: Scaffold(body: child)),
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });

  group('BundleCard', () {
    testWidgets('shows Combo chip and price', (tester) async {
      await tester.pumpWidget(
        _wrap(
          BundleCard(
            bundle: _testBundle(),
            menuItems: const [
              MenuItem(
                id: 'item-1',
                orgId: 'o1',
                name: 'Latte',
                basePrice: 3000,
                isActive: true,
                displayOrder: 0,
              ),
            ],
            inventory: const [],
          ),
          prefs,
        ),
      );

      expect(find.text('Combo'), findsOneWidget);
      expect(find.text('EGP 45'), findsOneWidget);
      expect(find.text('1 items'), findsOneWidget);
    });
  });

  group('BundleCartRow', () {
    testWidgets('lists components under bundle title', (tester) async {
      const cartItem = CartItem(
        bundleId: 'b1',
        bundleComponents: [
          BundleComponentSnapshot(
            itemId: 'item-1',
            itemName: 'Latte',
            quantity: 1,
          ),
          BundleComponentSnapshot(
            itemId: 'item-2',
            itemName: 'Croissant',
            quantity: 1,
          ),
        ],
        itemName: 'Breakfast Combo',
        unitPrice: 4500,
        quantity: 1,
      );

      await tester.pumpWidget(
        _wrap(const BundleCartRow(index: 0, item: cartItem), prefs),
      );

      expect(find.text('Breakfast Combo'), findsOneWidget);
      expect(find.text('Latte × 1'), findsOneWidget);
      expect(find.text('Croissant × 1'), findsOneWidget);
    });
  });
}
