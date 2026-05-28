import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/api/auth_api.dart';
import 'package:sufrix_pos/core/api/client.dart';
import 'package:sufrix_pos/core/models/user.dart';
import 'package:sufrix_pos/core/repositories/auth_repository.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';

class MockAuthApi extends Mock implements AuthApi {}
class MockStorageService extends Mock implements StorageService {}

void main() {
  late MockAuthApi mockApi;
  late MockStorageService mockStorage;
  late ProviderContainer container;

  setUp(() {
    mockApi = MockAuthApi();
    mockStorage = MockStorageService();
    
    // Default mock setup for storage token
    when(() => mockStorage.token).thenReturn(null);

    container = ProviderContainer(overrides: [
      authApiProvider.overrideWithValue(mockApi),
      storageServiceProvider.overrideWithValue(mockStorage),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  group('AuthRepository', () {
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
        id: 'u1', name: 'User 1', role: 'admin', 
        isActive: true,
      );
      when(() => mockApi.me()).thenAnswer((_) async => user);
      when(() => mockStorage.saveUser(any())).thenAnswer((_) async {});

      final repo = container.read(authRepositoryProvider);
      final result = await repo.restoreSession();

      expect(result, isNotNull);
      expect(result!.token, 'token_123');
      expect(result.user.id, 'u1');
      verify(() => mockStorage.saveUser(any())).called(1);
    });

    test('restoreSession falls back to cache on network error', () async {
      when(() => mockStorage.token).thenReturn('token_123');
      
      // Throw a DioException of type connectionError
      final reqOpts = RequestOptions(path: '/');
      when(() => mockApi.me()).thenThrow(DioException(requestOptions: reqOpts, type: DioExceptionType.connectionError));
      
      final cachedUser = User(
        id: 'u2', name: 'Cached User', role: 'admin', 
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
        id: 'u3', name: 'User 3', role: 'admin', 
        isActive: true,
      );
      
      when(() => mockApi.loginWithPin(name: 'User 3', pin: '1234'))
          .thenAnswer((_) async => {'token': 'new_token', 'user': user.toJson()});
      
      when(() => mockStorage.saveToken('new_token')).thenAnswer((_) async {});
      when(() => mockStorage.saveUser(any())).thenAnswer((_) async {});

      final repo = container.read(authRepositoryProvider);
      final result = await repo.login(name: 'User 3', pin: '1234');

      expect(result.token, 'new_token');
      expect(result.user.id, 'u3');
      verify(() => mockStorage.saveToken('new_token')).called(1);
      verify(() => mockStorage.saveUser(any())).called(1);
    });

    test('logout clears auth', () async {
      when(() => mockStorage.clearAuth()).thenAnswer((_) async {});
      final repo = container.read(authRepositoryProvider);
      await repo.logout();
      verify(() => mockStorage.clearAuth()).called(1);
    });
  });
}
