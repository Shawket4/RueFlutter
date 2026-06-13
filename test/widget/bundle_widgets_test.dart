import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sufrix_pos/core/db/app_database.dart';
import 'package:sufrix_pos/core/l10n/app_localizations.dart';
import 'package:sufrix_pos/core/db/kv_store.dart';
import 'package:sufrix_pos/core/models/bundle.dart';
import 'package:sufrix_pos/core/models/cart.dart';
import 'package:sufrix_pos/core/storage/secure_token_store.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';
import 'package:sufrix_pos/features/order/widgets/bundle_card.dart';
import 'package:sufrix_pos/features/order/widgets/bundle_cart_row.dart';

import '../helpers/model_fixtures.dart';

/// In-memory token store: never call [SecureTokenStore.init] in tests — the
/// real one talks to the platform keychain.
class _FakeTokenStore extends SecureTokenStore {
  String? _t;
  @override
  String? get token => _t;
  @override
  Future<void> write(String t) async => _t = t;
  @override
  Future<void> clear() async => _t = null;
}

Bundle _testBundle() => makeBundle(
      id: 'b1',
      orgId: 'o1',
      name: 'Breakfast Combo',
      price: 4500,
      status: BundleStatus.active,
      displayOrder: 1,
      components: [
        makeBundleComponent(
          bundleId: 'b1',
          itemId: 'item-1',
          quantity: 1,
          position: 0,
        ),
      ],
    );

Widget _wrap(Widget child, StorageService storage) => ProviderScope(
      overrides: [
        storageServiceProvider.overrideWithValue(storage),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: child),
      ),
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();

  late Database db;
  late StorageService storage;

  setUp(() async {
    db = await databaseFactoryFfi.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(singleInstance: false),
    );
    await AppDatabase.createSchema(db);
    final kv = KvStore(AppDatabase.forTesting(db));
    await kv.init();
    storage = StorageService(kv, _FakeTokenStore());
  });

  tearDown(() async => db.close());

  group('BundleCard', () {
    testWidgets('shows Combo chip and price', (tester) async {
      await tester.pumpWidget(
        _wrap(
          BundleCard(
            bundle: _testBundle(),
            menuItems: [
              makeMenuItem(
                id: 'item-1',
                orgId: 'o1',
                name: 'Latte',
                basePrice: 3000,
                displayOrder: 0,
              ),
            ],
          ),
          storage,
        ),
      );

      expect(find.text('Combo'), findsOneWidget);
      expect(find.text('EGP 45'), findsOneWidget);
      expect(find.text('1 item'), findsOneWidget);
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
        _wrap(const BundleCartRow(index: 0, item: cartItem), storage),
      );

      expect(find.text('Breakfast Combo'), findsOneWidget);
      expect(find.text('Latte × 1'), findsOneWidget);
      expect(find.text('Croissant × 1'), findsOneWidget);
    });
  });
}
