import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/api/auth_api.dart';
import 'package:sufrix_pos/core/api/branch_api.dart';
import 'package:sufrix_pos/core/models/user.dart';
import 'package:sufrix_pos/core/repositories/auth_repository.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';
import '../../helpers/model_fixtures.dart';

class MockAuthApi extends Mock implements AuthApi {}
class MockBranchApi extends Mock implements BranchApi {}
class MockStorageService extends Mock implements StorageService {}

void main() {
  late MockAuthApi mockApi;
  late MockBranchApi mockBranchApi;
  late MockStorageService mockStorage;
  late ProviderContainer container;

  setUp(() {
    mockApi = MockAuthApi();
    mockBranchApi = MockBranchApi();
    mockStorage = MockStorageService();

    // Default mock setup for storage token
    when(() => mockStorage.token).thenReturn(null);

    container = ProviderContainer(overrides: [
      authApiProvider.overrideWithValue(mockApi),
      branchApiProvider.overrideWithValue(mockBranchApi),
      storageServiceProvider.overrideWithValue(mockStorage),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  group('AuthRepository', () {
    test('setupDevice lists branches with the manager\'s org_id', () async {
      // Regression: GET /branches requires org_id as a query parameter —
      // calling it without one made first-time setup fail with "missing
      // org_id".
      final manager = makeUser(role: UserRole.orgAdmin, orgId: 'org-1');
      when(() => mockApi.loginWithEmailPassword(
              email: 'm@x.com', password: 'pw'))
          .thenAnswer((_) async => {'token': 'mgr-token', 'user': manager.toJson()});
      final branch = makeBranch();
      when(() => mockBranchApi.list(orgId: 'org-1'))
          .thenAnswer((_) async => [branch]);

      final repo = container.read(authRepositoryProvider);
      final branches = await repo.setupDevice(email: 'm@x.com', password: 'pw');

      expect(branches, [branch]);
      verify(() => mockBranchApi.list(orgId: 'org-1')).called(1);
    });

    test('setupDevice rejects accounts without an organization', () async {
      final superAdmin =
          makeUser(role: UserRole.superAdmin, orgId: null);
      when(() => mockApi.loginWithEmailPassword(
              email: 's@x.com', password: 'pw'))
          .thenAnswer((_) async => {'token': 't', 'user': superAdmin.toJson()});

      final repo = container.read(authRepositoryProvider);
      expect(() => repo.setupDevice(email: 's@x.com', password: 'pw'),
          throwsA(isA<DeviceSetupError>()));
    });

    test('storedToken returns token from storage', () {
      when(() => mockStorage.token).thenReturn('token_123');
      final repo = container.read(authRepositoryProvider);
      expect(repo.storedToken, 'token_123');
    });

    test('restoreSession returns null if no token', () async {
      when(() => mockStorage.token).thenReturn(null);
      final repo = container.read(authRepositoryProvider);
      final result = await repo.restoreSession();
      expect(result, isNull);
    });

    test('restoreSession fetches user and saves to storage on success', () async {
      when(() => mockStorage.token).thenReturn('token_123');
      
      final user = User(
        id: 'u1', name: 'User 1', role: UserRole.orgAdmin,
        isActive: true,
      );
      when(() => mockApi.me())
          .thenAnswer((_) async => (user: user, taxRate: 0.14));
      when(() => mockStorage.saveUser(any())).thenAnswer((_) async {});

      final repo = container.read(authRepositoryProvider);
      final result = await repo.restoreSession();

      expect(result, isNotNull);
      expect(result!.token, 'token_123');
      expect(result.user.id, 'u1');
      expect(result.taxRate, 0.14);
      verify(() => mockStorage.saveUser(any())).called(1);
    });

    test('restoreSession falls back to cache on network error', () async {
      when(() => mockStorage.token).thenReturn('token_123');
      
      // Throw a DioException of type connectionError
      final reqOpts = RequestOptions(path: '/');
      when(() => mockApi.me()).thenThrow(DioException(requestOptions: reqOpts, type: DioExceptionType.connectionError));
      
      final cachedUser = User(
        id: 'u2', name: 'Cached User', role: UserRole.orgAdmin,
        isActive: true,
      );
      when(() => mockStorage.loadUser()).thenReturn(cachedUser.toJson());

      final repo = container.read(authRepositoryProvider);
      final result = await repo.restoreSession();

      expect(result, isNotNull);
      expect(result!.token, 'token_123');
      expect(result.user.id, 'u2');
    });

    test('restoreSession clears auth on 401 or non-network error', () async {
      when(() => mockStorage.token).thenReturn('token_123');
      
      final reqOpts = RequestOptions(path: '/');
      final response = Response(requestOptions: reqOpts, statusCode: 401);
      when(() => mockApi.me()).thenThrow(DioException(requestOptions: reqOpts, response: response, type: DioExceptionType.badResponse));
      
      when(() => mockStorage.clearAuth()).thenAnswer((_) async {});

      final repo = container.read(authRepositoryProvider);
      final result = await repo.restoreSession();

      expect(result, isNull);
      verify(() => mockStorage.clearAuth()).called(1);
    });

    test('login saves token and user to storage and returns data', () async {
      final user = User(
        id: 'u3', name: 'User 3', role: UserRole.orgAdmin,
        isActive: true,
      );
      
      when(() => mockStorage.deviceBranchId).thenReturn('b1');
      when(() => mockApi.loginWithPin(
              name: 'User 3', pin: '1234', branchId: 'b1'))
          .thenAnswer((_) async =>
              {'token': 'new_token', 'tax_rate': 0.14, 'user': user.toJson()});

      when(() => mockStorage.saveToken('new_token')).thenAnswer((_) async {});
      when(() => mockStorage.saveUser(any())).thenAnswer((_) async {});
      when(() => mockStorage.saveOfflineUnlock(any(), any()))
          .thenAnswer((_) async {});
      when(() => mockStorage.saveOfflineUser(any(), any()))
          .thenAnswer((_) async {});

      final repo = container.read(authRepositoryProvider);
      final result = await repo.login(name: 'User 3', pin: '1234');

      expect(result.token, 'new_token');
      expect(result.user.id, 'u3');
      expect(result.taxRate, 0.14);
      verify(() => mockStorage.saveToken('new_token')).called(1);
      verify(() => mockStorage.saveUser(any())).called(1);
      // Login must also persist the offline unlock credentials (salted PIN
      // hash + user snapshot) so the teller can get back in while offline.
      verify(() => mockStorage.saveOfflineUnlock('User 3', any())).called(1);
      verify(() => mockStorage.saveOfflineUser('User 3', any())).called(1);
    });

    test('login maps 403 to BranchAccessError with the server message', () async {
      when(() => mockStorage.deviceBranchId).thenReturn('b1');
      final reqOpts = RequestOptions(path: '/auth/login');
      when(() => mockApi.loginWithPin(name: 'User 5', pin: '1234', branchId: 'b1'))
          .thenThrow(DioException(
            requestOptions: reqOpts,
            response: Response(
              requestOptions: reqOpts,
              statusCode: 403,
              data: {'error': 'Your account is not assigned to this branch.'},
            ),
            type: DioExceptionType.badResponse,
          ));

      final repo = container.read(authRepositoryProvider);
      await expectLater(
        () => repo.login(name: 'User 5', pin: '1234'),
        throwsA(isA<BranchAccessError>().having(
            (e) => e.message, 'message', contains('not assigned to this branch'))),
      );
    });

    test('login maps 401 to WrongCredentialsError', () async {
      when(() => mockStorage.deviceBranchId).thenReturn('b1');
      final reqOpts = RequestOptions(path: '/auth/login');
      when(() => mockApi.loginWithPin(name: 'User 6', pin: '0000', branchId: 'b1'))
          .thenThrow(DioException(
            requestOptions: reqOpts,
            response: Response(requestOptions: reqOpts, statusCode: 401),
            type: DioExceptionType.badResponse,
          ));

      final repo = container.read(authRepositoryProvider);
      await expectLater(
        () => repo.login(name: 'User 6', pin: '0000'),
        throwsA(isA<WrongCredentialsError>()),
      );
    });

    test('verifyOfflineUnlock accepts the hash written by login', () async {
      final user =
          User(id: 'u4', name: 'User 4', role: UserRole.teller, isActive: true);

      when(() => mockStorage.deviceBranchId).thenReturn('b1');
      when(() => mockApi.loginWithPin(
              name: 'User 4', pin: '9876', branchId: 'b1'))
          .thenAnswer((_) async => {'token': 't', 'user': user.toJson()});
      when(() => mockStorage.saveToken(any())).thenAnswer((_) async {});
      when(() => mockStorage.saveUser(any())).thenAnswer((_) async {});
      when(() => mockStorage.saveOfflineUnlock(any(), any()))
          .thenAnswer((_) async {});
      when(() => mockStorage.saveOfflineUser(any(), any()))
          .thenAnswer((_) async {});

      final repo = container.read(authRepositoryProvider);
      await repo.login(name: 'User 4', pin: '9876');

      final savedHash = verify(
              () => mockStorage.saveOfflineUnlock('User 4', captureAny()))
          .captured
          .single as String;

      when(() => mockStorage.offlineUnlockHash('User 4')).thenReturn(savedHash);
      when(() => mockStorage.loadOfflineUser('User 4'))
          .thenReturn(user.toJson());

      final unlocked = repo.verifyOfflineUnlock(name: 'User 4', pin: '9876');
      expect(unlocked?.id, 'u4');

      final wrongPin = repo.verifyOfflineUnlock(name: 'User 4', pin: '0000');
      expect(wrongPin, isNull);
    });

    test('logout clears auth', () async {
      when(() => mockStorage.clearAuth()).thenAnswer((_) async {});
      final repo = container.read(authRepositoryProvider);
      await repo.logout();
      verify(() => mockStorage.clearAuth()).called(1);
    });
  });
}
