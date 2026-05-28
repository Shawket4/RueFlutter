import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPrefs;
  late StorageService storage;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    storage = StorageService(mockPrefs);
    
    when(() => mockPrefs.getString(any())).thenReturn(null);
    when(() => mockPrefs.setString(any(), any())).thenAnswer((_) async => true);
    when(() => mockPrefs.remove(any())).thenAnswer((_) async => true);
  });

  group('StorageService', () {
    test('saveToken and getToken', () async {
      when(() => mockPrefs.getString('auth_token')).thenReturn('token123');
      await storage.saveToken('token123');
      expect(storage.token, 'token123');
      
      when(() => mockPrefs.getString('auth_token')).thenReturn(null);
      await storage.removeToken();
      expect(storage.token, isNull);
    });

    test('saveUser and loadUser', () async {
      final user = {'id': '1', 'name': 'Test User'};
      when(() => mockPrefs.getString('cached_user')).thenReturn('{"id":"1","name":"Test User"}');
      await storage.saveUser(user);
      
      final loaded = storage.loadUser();
      expect(loaded, user);

      when(() => mockPrefs.getString('cached_user')).thenReturn(null);
      await storage.removeUser();
      expect(storage.loadUser(), isNull);
    });

    test('saveMenu and loadMenu', () async {
      final menu = {'categories': []};
      when(() => mockPrefs.getString('menu_v2_org1')).thenReturn('{"categories":[]}');
      when(() => mockPrefs.getString('menu_cached_at_org1')).thenReturn(DateTime.now().toIso8601String());
      await storage.saveMenu('org1', menu);
      
      expect(storage.loadMenu('org1'), menu);
      expect(storage.menuCachedAt('org1'), isNotNull);
    });

    test('draft carts migration', () async {
      when(() => mockPrefs.getString('draft_carts_v1_scope1')).thenReturn(null);
      when(() => mockPrefs.getString('draft_carts_v1')).thenReturn('[{"id":"draft1"}]');

      final drafts = storage.loadDraftCartsWithLegacyMigration('scope1');
      expect(drafts.length, 1);
      expect(drafts[0]['id'], 'draft1');

      verify(() => mockPrefs.remove('draft_carts_v1')).called(1);
      verify(() => mockPrefs.setString('draft_carts_v1_scope1', any())).called(1);
    });

    test('clearAuth removes token and user', () async {
      await storage.clearAuth();
      verify(() => mockPrefs.remove('auth_token')).called(1);
      verify(() => mockPrefs.remove('cached_user')).called(1);
    });
  });
}
