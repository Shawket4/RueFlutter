import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/api/auth_api.dart';
import 'package:sufrix_pos/core/api/client.dart';

class MockDio extends Mock implements Dio {}
class MockDioClient extends Mock implements DioClient {}

void main() {
  late MockDioClient mockDioClient;
  late MockDio mockDio;
  late AuthApi authApi;

  setUp(() {
    mockDioClient = MockDioClient();
    mockDio = MockDio();
    when(() => mockDioClient.dio).thenReturn(mockDio);
    authApi = AuthApi(mockDioClient);
  });

  group('AuthApi', () {
    test('loginWithPin success', () async {
      final mockData = {
        'token': 'my-token',
        'user': {
          'id': 'u1',
          'name': 'Test User',
          'branch_id': 'b1',
        }
      };

      when(() => mockDio.post(
            '/auth/login',
            data: any(named: 'data'),
          )).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: '/auth/login'),
            data: mockData,
            statusCode: 200,
          ));

      final result = await authApi.loginWithPin(
          name: 'Test', pin: '1234', branchId: 'b1');

      expect(result, equals(mockData));
      verify(() => mockDio.post('/auth/login',
          data: {'name': 'Test', 'pin': '1234', 'branch_id': 'b1'})).called(1);
    });

    test('me success', () async {
      final mockData = {
        'user': {
          'id': 'u1',
          'name': 'Test User',
          'branch_id': 'b1',
          'role': 'admin',
          'is_active': true,
        }
      };

      when(() => mockDio.get('/auth/me')).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: '/auth/me'),
            data: mockData,
            statusCode: 200,
          ));

      final user = await authApi.me();
      
      expect(user.id, 'u1');
      expect(user.name, 'Test User');
      expect(user.branchId, 'b1');
      verify(() => mockDio.get('/auth/me')).called(1);
    });
  });
}
