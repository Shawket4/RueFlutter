import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sufrix_pos/core/db/app_database.dart';
import 'package:sufrix_pos/core/db/kv_store.dart';
import 'package:sufrix_pos/core/storage/secure_token_store.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';

/// In-memory token store: never call [SecureTokenStore.init] in tests — the
/// real one talks to the platform keychain. Overriding the three members the
/// service uses keeps everything in memory.
class FakeTokenStore extends SecureTokenStore {
  String? _t;
  @override
  String? get token => _t;
  @override
  Future<void> write(String t) async => _t = t;
  @override
  Future<void> clear() async => _t = null;
}

void main() {
  sqfliteFfiInit();

  late Database db;
  late KvStore kv;
  late FakeTokenStore tokens;
  late StorageService storage;

  setUp(() async {
    db = await databaseFactoryFfi.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(singleInstance: false),
    );
    await AppDatabase.createSchema(db);
    kv = KvStore(AppDatabase.forTesting(db));
    await kv.init();
    tokens = FakeTokenStore();
    storage = StorageService(kv, tokens);
  });

  tearDown(() async => db.close());

  group('StorageService', () {
    test('saveToken and token live in the secure store, not the kv table',
        () async {
      await storage.saveToken('token123');
      expect(storage.token, 'token123');
      expect(kv.keys().contains('auth_token'), isFalse,
          reason: 'the JWT must never hit the plaintext kv table');

      await storage.removeToken();
      expect(storage.token, isNull);
    });

    test('saveUser and loadUser', () async {
      final user = {'id': '1', 'name': 'Test User'};
      await storage.saveUser(user);

      expect(storage.loadUser(), user);

      await storage.removeUser();
      expect(storage.loadUser(), isNull);
    });

    test('saveMenu, loadMenu and menuCachedAt', () async {
      final menu = {
        'categories': <dynamic>[],
        'items': <dynamic>[],
      };
      final before = DateTime.now().subtract(const Duration(seconds: 1));
      await storage.saveMenu('org1', menu);

      expect(storage.loadMenu('org1'), menu);
      final cachedAt = storage.menuCachedAt('org1');
      expect(cachedAt, isNotNull);
      expect(cachedAt!.isAfter(before), isTrue);
      expect(storage.menuCachedAt('other_org'), isNull);
    });

    test('corrupt cache entries are dropped instead of throwing', () async {
      await kv.setString('cached_user', 'not-json{{{');
      expect(storage.loadUser(), isNull);
      expect(kv.getString('cached_user'), isNull,
          reason: 'corrupt blob must be deleted so it cannot brick a load');
    });

    test('offline unlock hash and user survive clearAuth', () async {
      await storage.saveOfflineUnlock('John ', 'salt:hash');
      await storage.saveOfflineUser('John ', {'id': 'u1'});
      await storage.saveToken('t');
      await storage.saveUser({'id': 'u1'});

      await storage.clearAuth();

      // Normal auth state is gone…
      expect(storage.token, isNull);
      expect(storage.loadUser(), isNull);
      // …but offline unlock data remains (it exists for offline sign-in),
      // and names are normalised (trim + lowercase).
      expect(storage.offlineUnlockHash('john'), 'salt:hash');
      expect(storage.loadOfflineUser('JOHN'), {'id': 'u1'});
    });

    test('draft and active carts round-trip per scope', () async {
      await storage.saveDraftCarts('scope1', [
        {'id': 'draft1'},
      ]);
      await storage.saveActiveCart('scope1', {'id': 'cart1'});

      expect(storage.loadDraftCarts('scope1'), [
        {'id': 'draft1'},
      ]);
      // Legacy SharedPreferences migration is dead; the compat shim just
      // reads the scoped key.
      expect(storage.loadDraftCartsWithLegacyMigration('scope1'), [
        {'id': 'draft1'},
      ]);
      expect(storage.loadActiveCart('scope1'), {'id': 'cart1'});
      expect(storage.loadDraftCarts('scope2'), isEmpty);

      await storage.clearCartDataForScope('scope1');
      expect(storage.loadDraftCarts('scope1'), isEmpty);
      expect(storage.loadActiveCart('scope1'), isNull);
    });

    test('clearAllCartStorage removes carts for every scope', () async {
      await storage.saveDraftCarts('a', [{'id': 'd1'}]);
      await storage.saveDraftCarts('b', [{'id': 'd2'}]);
      await storage.saveActiveCart('a', {'id': 'c1'});
      await storage.saveUser({'id': 'u1'}); // unrelated key must survive

      await storage.clearAllCartStorage();

      expect(storage.loadDraftCarts('a'), isEmpty);
      expect(storage.loadDraftCarts('b'), isEmpty);
      expect(storage.loadActiveCart('a'), isNull);
      expect(storage.loadUser(), {'id': 'u1'});
    });

    test('writes persist to the kv table', () async {
      await storage.saveBranch('b1', {'id': 'b1', 'name': 'Branch'});
      final rows =
          await db.query('kv', where: 'k = ?', whereArgs: ['branch_b1']);
      expect(rows, hasLength(1));
      expect(storage.loadBranch('b1'), {'id': 'b1', 'name': 'Branch'});
    });
  });
}
