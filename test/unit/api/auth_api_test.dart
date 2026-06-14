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

    test('me success surfaces user and tax rate', () async {
      final mockData = {
        'tax_rate': 0.14,
        'currency_code': 'EGP',
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

      final res = await authApi.me();

      expect(res.user.id, 'u1');
      expect(res.user.name, 'Test User');
      expect(res.user.branchId, 'b1');
      expect(res.taxRate, 0.14);
      verify(() => mockDio.get('/auth/me')).called(1);
    });

    test('me defaults tax rate to 0.0 when the field is absent', () async {
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

      final res = await authApi.me();

      expect(res.taxRate, 0.0);
    });
  });
}
