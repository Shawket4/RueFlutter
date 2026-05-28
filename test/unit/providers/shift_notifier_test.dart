import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/models/shift.dart';
import 'package:sufrix_pos/core/models/user.dart';
import 'package:sufrix_pos/core/providers/auth_notifier.dart';
import 'package:sufrix_pos/core/providers/shift_notifier.dart';
import 'package:sufrix_pos/core/repositories/shift_repository.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';

class MockShiftRepository extends Mock implements ShiftRepository {}
class MockStorageService extends Mock implements StorageService {}
class FakeAuthNotifier extends Notifier<AuthState> implements AuthNotifier {
  @override
  AuthState build() => const AuthState();
  
  @override Future<String?> login({required String name, required String pin}) async => null;
  @override Future<void> logout() async {}
  @override Future<bool> canLogout() async => true;
  @override void clearError() {}
  @override Future<void> init() async {}
  @override void setError(String err) {}
}

void main() {
  late MockShiftRepository mockRepo;
  late MockStorageService mockStorage;
  late ProviderContainer container;

  setUp(() {
    mockRepo = MockShiftRepository();
    mockStorage = MockStorageService();
    
    // Register fallbacks
    registerFallbackValue(const []);

    container = ProviderContainer(overrides: [
      shiftRepositoryProvider.overrideWithValue(mockRepo),
      storageServiceProvider.overrideWithValue(mockStorage),
      authProvider.overrideWith(() => FakeAuthNotifier()),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  group('ShiftNotifier', () {
    test('load fetches current shift successfully', () async {
      final shift = Shift(
        id: 's1', branchId: 'b1', tellerId: 't1', tellerName: 'Teller',
        status: 'open', openingCash: 100, openedAt: DateTime.now(),
      );
      
      when(() => mockRepo.currentShift('b1')).thenAnswer(
        (_) async => ShiftPreFill(openShift: shift, suggestedOpeningCash: 100, hasOpenShift: true)
      );
      
      final notifier = container.read(shiftProvider.notifier);
      await notifier.load('b1');

      final state = container.read(shiftProvider);
      expect(state.isLoading, false);
      expect(state.shift?.id, 's1');
      expect(state.suggestedOpeningCash, 100);
      expect(state.fromCache, false);
    });

    test('load falls back to cache on error', () async {
      when(() => mockRepo.currentShift('b1')).thenThrow(Exception('Error'));
      
      final cachedShift = Shift(
        id: 's2', branchId: 'b1', tellerId: 't1', tellerName: 'Teller',
        status: 'open', openingCash: 100, openedAt: DateTime.now(),
      );
      when(() => mockStorage.loadShift('b1')).thenReturn(cachedShift.toJson());

      final notifier = container.read(shiftProvider.notifier);
      await notifier.load('b1');

      final state = container.read(shiftProvider);
      expect(state.isLoading, false);
      expect(state.shift?.id, 's2');
      expect(state.fromCache, true);
    });

    test('updateShiftSynced updates state to synced', () {
      final notifier = container.read(shiftProvider.notifier);
      final shift = Shift(
        id: 's3', branchId: 'b1', tellerId: 't1', tellerName: 'Teller',
        status: 'open', openingCash: 100, openedAt: DateTime.now(),
      );
      
      notifier.updateShiftSynced(shift);
      
      final state = container.read(shiftProvider);
      expect(state.shift?.id, 's3');
      expect(state.isLocalShift, false);
    });

    test('openShift online succeeds', () async {
      final shift = Shift(
        id: 's4', branchId: 'b1', tellerId: 't1', tellerName: 'Teller',
        status: 'open', openingCash: 200, openedAt: DateTime.now(),
      );
      
      when(() => mockRepo.openShift('b1', 200)).thenAnswer((_) async => shift);
      
      final notifier = container.read(shiftProvider.notifier);
      final result = await notifier.openShift('b1', 200);

      expect(result, true);
      final state = container.read(shiftProvider);
      expect(state.shift?.id, 's4');
      expect(state.isLocalShift, false);
    });

    test('openShift online handles errors', () async {
      when(() => mockRepo.openShift('b1', 200)).thenThrow(Exception('Backend Error'));
      
      final notifier = container.read(shiftProvider.notifier);
      final result = await notifier.openShift('b1', 200);

      expect(result, false);
      final state = container.read(shiftProvider);
      expect(state.error, contains('went wrong'));
    });

    test('closeShift succeeds', () async {
      final shift = Shift(
        id: 's5', branchId: 'b1', tellerId: 't1', tellerName: 'Teller',
        status: 'open', openingCash: 200, openedAt: DateTime.now(),
      );
      
      // Load the shift first
      final notifier = container.read(shiftProvider.notifier);
      notifier.updateShiftSynced(shift);

      when(() => mockRepo.closeShift(
        's5', branchId: 'b1', closingCash: 300, note: null, inventoryCounts: []
      )).thenAnswer((_) async => shift);
      when(() => mockStorage.removeShift('b1')).thenAnswer((_) async {});
      when(() => mockStorage.clearCartDataForScope(any())).thenAnswer((_) async {});

      final result = await notifier.closeShift(branchId: 'b1', closingCash: 300, inventoryCounts: []);

      expect(result, true);
      final state = container.read(shiftProvider);
      expect(state.shift, isNull);
    });

    test('closeShift fails if no shift open', () async {
      final notifier = container.read(shiftProvider.notifier);
      final result = await notifier.closeShift(branchId: 'b1', closingCash: 300, inventoryCounts: []);

      expect(result, false);
    });

    test('loadSystemCash updates state', () async {
      final shift = Shift(
        id: 's6', branchId: 'b1', tellerId: 't1', tellerName: 'Teller',
        status: 'open', openingCash: 200, openedAt: DateTime.now(),
      );
      
      final notifier = container.read(shiftProvider.notifier);
      notifier.updateShiftSynced(shift);

      when(() => mockRepo.getSystemCash('s6', 200)).thenAnswer((_) async => 500);

      await notifier.loadSystemCash();

      final state = container.read(shiftProvider);
      expect(state.systemCash, 500);
      expect(state.systemCashLoading, false);
    });

    test('loadInventory updates state', () async {
      when(() => mockRepo.getInventory('b1')).thenAnswer((_) async => []);

      final notifier = container.read(shiftProvider.notifier);
      await notifier.loadInventory('b1');

      final state = container.read(shiftProvider);
      expect(state.inventory, isEmpty);
    });
  });
}
