import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/api/order_api.dart';
import 'package:sufrix_pos/core/api/shift_api.dart';
import 'package:sufrix_pos/core/models/pending_action.dart';
import 'package:sufrix_pos/core/services/offline_queue.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';

class MockShiftApi extends Mock implements ShiftApi {}
class MockOrderApi extends Mock implements OrderApi {}
class MockStorageService extends Mock implements StorageService {}

void main() {
  late MockShiftApi mockShiftApi;
  late MockOrderApi mockOrderApi;
  late MockStorageService mockStorage;
  late ProviderContainer container;

  setUp(() {
    mockShiftApi = MockShiftApi();
    mockOrderApi = MockOrderApi();
    mockStorage = MockStorageService();
    
    when(() => mockStorage.loadPendingActions()).thenReturn([]);
    when(() => mockStorage.savePendingActions(any())).thenAnswer((_) async {});

    container = ProviderContainer(overrides: [
      shiftApiProvider.overrideWithValue(mockShiftApi),
      orderApiProvider.overrideWithValue(mockOrderApi),
      storageServiceProvider.overrideWithValue(mockStorage),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  group('OfflineQueueNotifier', () {
    test('init loads from storage', () async {
      final action = PendingShiftOpen(
        localId: 'id1', branchId: 'b1', shiftId: 's1',
        openingCash: 100, openedAt: DateTime.now(), createdAt: DateTime.now(),
      );
      when(() => mockStorage.loadPendingActions()).thenReturn([action.toJson()]);
      
      final notifier = container.read(offlineQueueProvider.notifier);
      await notifier.init();

      final state = container.read(offlineQueueProvider);
      expect(state.queue.length, 1);
      expect(state.queue.first.localId, 'id1');
    });

    test('enqueueShiftOpen adds to queue and persists', () async {
      final action = PendingShiftOpen(
        localId: 'id1', branchId: 'b1', shiftId: 's1',
        openingCash: 100, openedAt: DateTime.now(), createdAt: DateTime.now(),
      );

      final notifier = container.read(offlineQueueProvider.notifier);
      await notifier.enqueueShiftOpen(action);

      final state = container.read(offlineQueueProvider);
      expect(state.queue.length, 1);
      verify(() => mockStorage.savePendingActions(any())).called(greaterThanOrEqualTo(1));
    });

    test('discard removes from queue and persists', () async {
      final action = PendingShiftOpen(
        localId: 'id1', branchId: 'b1', shiftId: 's1',
        openingCash: 100, openedAt: DateTime.now(), createdAt: DateTime.now(),
      );
      
      final notifier = container.read(offlineQueueProvider.notifier);
      await notifier.enqueueShiftOpen(action);
      
      expect(container.read(offlineQueueProvider).queue.length, 1);
      
      await notifier.discard('id1');

      final state = container.read(offlineQueueProvider);
      expect(state.queue.isEmpty, true);
      verify(() => mockStorage.savePendingActions(any())).called(greaterThanOrEqualTo(2)); // One for enqueue, one for discard
    });

    test('resetRetry resets retry count and persists', () async {
      var action = PendingShiftOpen(
        localId: 'id1', branchId: 'b1', shiftId: 's1',
        openingCash: 100, openedAt: DateTime.now(), createdAt: DateTime.now(),
      );
      
      // Simulate incremented retry
      action = action.withIncrementedRetry('Error') as PendingShiftOpen;
      
      final notifier = container.read(offlineQueueProvider.notifier);
      await notifier.enqueueShiftOpen(action);
      
      expect(container.read(offlineQueueProvider).queue.first.retryCount, greaterThanOrEqualTo(1));
      
      await notifier.resetRetry('id1');

      final state = container.read(offlineQueueProvider);
      expect(state.queue.first.retryCount, 0);
      expect(state.queue.first.lastError, isNull);
    });
  });
}
