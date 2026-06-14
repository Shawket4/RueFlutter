import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/api/branch_api.dart';
import 'package:sufrix_pos/core/api/shift_api.dart';
import 'package:sufrix_pos/core/models/shift.dart';
import 'package:sufrix_pos/core/models/user.dart';
import 'package:sufrix_pos/core/providers/auth_notifier.dart';
import 'package:sufrix_pos/core/repositories/auth_repository.dart';
import 'package:sufrix_pos/core/services/offline_queue.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';

import '../../helpers/model_fixtures.dart';

class MockAuthRepository extends Mock implements AuthRepository {}
class MockBranchApi extends Mock implements BranchApi {}
class MockShiftApi extends Mock implements ShiftApi {}
class MockStorageService extends Mock implements StorageService {}

/// The real notifier's drain path needs the outbox DAO (sqflite); the auth
/// tests only care that pause/resume are invoked, so stub them out.
class FakeOfflineQueueNotifier extends OfflineQueueNotifier {
  @override
  void resumeAfterAuth() {}
  @override
  void pauseForAuth() {}
}

void main() {
  late MockAuthRepository mockAuthRepo;
  late MockBranchApi mockBranchApi;
  late MockShiftApi mockShiftApi;
  late MockStorageService mockStorageService;
  late ProviderContainer container;

  setUp(() {
    mockAuthRepo = MockAuthRepository();
    mockBranchApi = MockBranchApi();
    mockShiftApi = MockShiftApi();
    mockStorageService = MockStorageService();

    container = ProviderContainer(overrides: [
      authRepositoryProvider.overrideWithValue(mockAuthRepo),
      branchApiProvider.overrideWithValue(mockBranchApi),
      shiftApiProvider.overrideWithValue(mockShiftApi),
      storageServiceProvider.overrideWithValue(mockStorageService),
      offlineQueueProvider.overrideWith(FakeOfflineQueueNotifier.new),
    ]);

    when(() => mockAuthRepo.restoreSession()).thenAnswer((_) async => null);
  });

  tearDown(() {
    container.dispose();
  });

  group('AuthNotifier', () {
    test('init restores session if available', () async {
      final user = makeUser(id: 'u1', name: 'John', role: UserRole.orgAdmin, branchId: 'b1');
      when(() => mockAuthRepo.restoreSession())
          .thenAnswer((_) async => (token: 'token', user: user, taxRate: 0.14));

      final branch = makeBranch(id: 'b1', orgId: 'org1', name: 'Branch 1');
      when(() => mockBranchApi.get('b1')).thenAnswer((_) async => branch);
      when(() => mockStorageService.saveBranch('b1', any())).thenAnswer((_) async {});

      when(() => mockShiftApi.current('b1'))
          .thenAnswer((_) async => ShiftPreFill(hasOpenShift: false, suggestedOpeningCash: 1000));

      final notifier = container.read(authProvider.notifier);
      await notifier.init();

      final state = container.read(authProvider);
      expect(state.isLoading, false);
      expect(state.isAuthenticated, true);
      expect(state.user?.id, 'u1');
      expect(state.branch?.id, 'b1');
      expect(state.taxRate, 0.14);
    });

    test('init sets loading false if no session', () async {
      when(() => mockAuthRepo.restoreSession()).thenAnswer((_) async => null);

      final notifier = container.read(authProvider.notifier);
      await notifier.init();

      final state = container.read(authProvider);
      expect(state.isLoading, false);
      expect(state.isAuthenticated, false);
    });

    test('login blocks if another teller has open shift', () async {
      final user = makeUser(id: 'u1', name: 'John', role: UserRole.orgAdmin, branchId: 'b1');
      when(() => mockAuthRepo.login(name: 'John', pin: '1234'))
          .thenAnswer((_) async => (token: 'token', user: user, taxRate: 0.0));

      when(() => mockBranchApi.get('b1')).thenAnswer((_) async => makeBranch(id: 'b1', orgId: 'org1', name: 'Branch 1'));
      when(() => mockStorageService.saveBranch('b1', any())).thenAnswer((_) async {});

      final otherShift = makeShift(
        id: 's1', branchId: 'b1', tellerId: 't2', tellerName: 'Alice', status: 'open', openingCash: 1000, openedAt: DateTime.now(),
      );
      when(() => mockShiftApi.current('b1'))
          .thenAnswer((_) async => ShiftPreFill(hasOpenShift: true, openShift: otherShift, suggestedOpeningCash: 1000));
      
      when(() => mockAuthRepo.logout()).thenAnswer((_) async {});

      final notifier = container.read(authProvider.notifier);
      final error = await notifier.login(name: 'John', pin: '1234');

      expect(error, contains('Alice'));
      final state = container.read(authProvider);
      expect(state.sessionExpiry, SessionExpiry.blockedByOtherShift);
      expect(state.blockedByName, 'Alice');
      expect(state.isAuthenticated, false);
    });

    test('canLogout checks if shift is open', () async {
      final user = makeUser(id: 'u1', name: 'John', role: UserRole.orgAdmin, branchId: 'b1');
      when(() => mockAuthRepo.restoreSession())
          .thenAnswer((_) async => (token: 'token', user: user, taxRate: 0.0));
      when(() => mockBranchApi.get('b1')).thenAnswer((_) async => makeBranch(id: 'b1', orgId: 'org1', name: 'Branch 1'));
      when(() => mockStorageService.saveBranch('b1', any())).thenAnswer((_) async {});

      final openShift = makeShift(
        id: 's1', branchId: 'b1', tellerId: 'u1', tellerName: 'John', status: 'open', openingCash: 1000, openedAt: DateTime.now(),
      );
      when(() => mockShiftApi.current('b1'))
          .thenAnswer((_) async => ShiftPreFill(hasOpenShift: true, openShift: openShift, suggestedOpeningCash: 1000));
      when(() => mockStorageService.saveShift('b1', any())).thenAnswer((_) async {});

      final notifier = container.read(authProvider.notifier);
      await notifier.init(); // logs in John with open shift

      final canLogout = await notifier.canLogout();
      expect(canLogout, false); // cannot logout with open shift
    });

    test('logout clears everything', () async {
      when(() => mockStorageService.clearAllCartStorage()).thenAnswer((_) async {});
      when(() => mockAuthRepo.logout()).thenAnswer((_) async {});

      final notifier = container.read(authProvider.notifier);
      await notifier.logout();

      final state = container.read(authProvider);
      expect(state.isAuthenticated, false);
      expect(state.isLoading, false);
    });
  });
}
