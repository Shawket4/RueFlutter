import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/models/shift.dart';
import 'package:sufrix_pos/core/providers/auth_notifier.dart';
import 'package:sufrix_pos/core/providers/menu_notifier.dart' show DataFreshness;
import 'package:sufrix_pos/core/providers/shift_notifier.dart';
import 'package:sufrix_pos/core/repositories/shift_repository.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';

import '../../helpers/model_fixtures.dart';

class MockShiftRepository extends Mock implements ShiftRepository {}

class MockStorageService extends Mock implements StorageService {}

/// Overrides build() only: avoids the real AuthNotifier's microtask init()
/// (which would hit the network) while keeping the full interface.
class FakeAuthNotifier extends AuthNotifier {
  @override
  AuthState build() => AuthState(
        isLoading: false,
        user: makeUser(id: 't1', name: 'Teller'),
      );
}

void main() {
  setUpAll(() {
    registerFallbackValue(<Map<String, dynamic>>[]);
  });

  late MockShiftRepository mockRepo;
  late MockStorageService mockStorage;
  late ProviderContainer container;

  setUp(() {
    mockRepo = MockShiftRepository();
    mockStorage = MockStorageService();

    // No local cache by default; ConnectivityService.instance.isOnline
    // defaults to true in tests (init() is never called), so the notifier
    // takes the online paths.
    when(() => mockRepo.loadShiftLocal(any())).thenReturn(null);

    container = ProviderContainer(overrides: [
      shiftRepositoryProvider.overrideWithValue(mockRepo),
      storageServiceProvider.overrideWithValue(mockStorage),
      authProvider.overrideWith(FakeAuthNotifier.new),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  Shift shift(String id, {int openingCash = 100}) => makeShift(
        id: id, branchId: 'b1', tellerId: 't1', tellerName: 'Teller',
        status: 'open', openingCash: openingCash, openedAt: DateTime.now(),
      );

  group('ShiftNotifier', () {
    test('load fetches the current shift successfully', () async {
      when(() => mockRepo.fetchShiftFresh('b1')).thenAnswer((_) async =>
          ShiftPreFill(
              hasOpenShift: true,
              openShift: shift('s1'),
              suggestedOpeningCash: 100));

      final notifier = container.read(shiftProvider.notifier);
      await notifier.load('b1');

      final state = container.read(shiftProvider);
      expect(state.isLoading, false);
      expect(state.shift?.id, 's1');
      expect(state.suggestedOpeningCash, 100);
      expect(state.freshness, DataFreshness.live);
      expect(state.fromCache, false);
    });

    test('load keeps the locally cached shift when the refresh fails',
        () async {
      when(() => mockRepo.loadShiftLocal('b1')).thenReturn(ShiftPreFill(
          hasOpenShift: true, openShift: shift('s2'), suggestedOpeningCash: 0));
      when(() => mockRepo.fetchShiftFresh('b1')).thenThrow(Exception('Error'));

      final notifier = container.read(shiftProvider.notifier);
      await notifier.load('b1');

      final state = container.read(shiftProvider);
      expect(state.isLoading, false);
      expect(state.shift?.id, 's2');
      expect(state.freshness, DataFreshness.offline);
      expect(state.fromCache, true);
      expect(state.error, isNull, reason: 'cached shift is still shown');
    });

    test('updateShiftSynced updates state to synced', () {
      final notifier = container.read(shiftProvider.notifier);

      notifier.updateShiftSynced(shift('s3'));

      final state = container.read(shiftProvider);
      expect(state.shift?.id, 's3');
      expect(state.isLocalShift, false);
    });

    test('openShift online succeeds', () async {
      when(() => mockRepo.openShift('b1', 200))
          .thenAnswer((_) async => shift('s4', openingCash: 200));

      final notifier = container.read(shiftProvider.notifier);
      final result = await notifier.openShift('b1', 200);

      expect(result, true);
      final state = container.read(shiftProvider);
      expect(state.shift?.id, 's4');
      expect(state.isLocalShift, false);
      expect(state.freshness, DataFreshness.live);
    });

    test('openShift online handles errors', () async {
      when(() => mockRepo.openShift('b1', 200))
          .thenThrow(Exception('Backend Error'));

      final notifier = container.read(shiftProvider.notifier);
      final result = await notifier.openShift('b1', 200);

      expect(result, false);
      final state = container.read(shiftProvider);
      expect(state.error, contains('went wrong'));
    });

    test('closeShift succeeds', () async {
      final notifier = container.read(shiftProvider.notifier);
      notifier.updateShiftSynced(shift('s5'));

      when(() => mockRepo.closeShift('s5',
              branchId: 'b1', closingCash: 300, note: null, inventoryCounts: []))
          .thenAnswer((_) async => shift('s5'));
      when(() => mockStorage.removeShift('b1')).thenAnswer((_) async {});
      when(() => mockStorage.clearCartDataForScope(any()))
          .thenAnswer((_) async {});

      final result = await notifier.closeShift(
          branchId: 'b1', closingCash: 300, inventoryCounts: []);

      expect(result, true);
      final state = container.read(shiftProvider);
      expect(state.shift, isNull);
    });

    test('closeShift fails if no shift open', () async {
      final notifier = container.read(shiftProvider.notifier);
      final result = await notifier.closeShift(
          branchId: 'b1', closingCash: 300, inventoryCounts: []);

      expect(result, false);
    });

    test('loadSystemCash updates state', () async {
      final notifier = container.read(shiftProvider.notifier);
      notifier.updateShiftSynced(shift('s6', openingCash: 200));

      when(() => mockRepo.getSystemCash('s6', 200))
          .thenAnswer((_) async => 500);

      await notifier.loadSystemCash();

      final state = container.read(shiftProvider);
      expect(state.systemCash, 500);
      expect(state.systemCashLoading, false);
    });

    test('addLocalCash increments system cash', () {
      final notifier = container.read(shiftProvider.notifier);
      notifier.addLocalCash(150);
      expect(container.read(shiftProvider).systemCash, 150);
    });

  });
}
