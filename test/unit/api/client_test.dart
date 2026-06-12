import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/api/client.dart';

class MockRequestInterceptorHandler extends Mock implements RequestInterceptorHandler {}
class MockErrorInterceptorHandler extends Mock implements ErrorInterceptorHandler {}

void main() {
  setUpAll(() {
    registerFallbackValue(RequestOptions(path: '/'));
    registerFallbackValue(DioException(requestOptions: RequestOptions(path: '/')));
  });

  group('DioClient & interceptors', () {
    setUp(() {
      setAuthToken(null);
      onUnauthorizedCallback = null;
    });

    test('adds Authorization header if token exists', () async {
      setAuthToken('my-token');
      final client = DioClient();

      final interceptor = client.dio.interceptors.firstWhere((i) => i is InterceptorsWrapper) as InterceptorsWrapper;
      final options = RequestOptions(path: '/test');
      final handler = MockRequestInterceptorHandler();
      
      interceptor.onRequest(options, handler);

      verify(() => handler.next(any(that: isA<RequestOptions>()))).called(1);
      expect(options.headers['Authorization'], 'Bearer my-token');
    });

    test('calls onUnauthorizedCallback on 401', () async {
      final client = DioClient();
      final interceptor = client.dio.interceptors.firstWhere((i) => i is InterceptorsWrapper) as InterceptorsWrapper;
      
      bool cbCalled = false;
      onUnauthorizedCallback = () => cbCalled = true;

      final err = DioException(
        requestOptions: RequestOptions(path: '/'),
        response: Response(requestOptions: RequestOptions(path: '/'), statusCode: 401),
      );

      final handler = MockErrorInterceptorHandler();
      interceptor.onError(err, handler);

      expect(cbCalled, isTrue);
      verify(() => handler.next(err)).called(1);
    });
  });

  group('friendlyError', () {
    test('handles network timeouts', () {
      final err = DioException(
        requestOptions: RequestOptions(path: '/'),
        type: DioExceptionType.connectionTimeout,
      );
      expect(friendlyError(err), 'Request timed out — check your connection');
    });

    test('handles 422 with string detail', () {
      final err = DioException(
        requestOptions: RequestOptions(path: '/'),
        response: Response(
          requestOptions: RequestOptions(path: '/'),
          statusCode: 422,
          data: {'detail': 'Invalid email format'},
        ),
      );
      expect(friendlyError(err), 'Invalid email format');
    });

    test('handles 422 with nested errors map', () {
      final err = DioException(
        requestOptions: RequestOptions(path: '/'),
        response: Response(
          requestOptions: RequestOptions(path: '/'),
          statusCode: 422,
          data: {
            'errors': {
              'email': ['is required', 'must be valid'],
              'pin': 'too short'
            }
          },
        ),
      );
      expect(friendlyError(err), 'email: is required, must be valid\npin: too short');
    });

    test('handles generic 500 without message', () {
      final err = DioException(
        requestOptions: RequestOptions(path: '/'),
        response: Response(requestOptions: RequestOptions(path: '/'), statusCode: 500),
      );
      expect(friendlyError(err), 'Server error — please try again');
    });

    test('handles non-DioException', () {
      expect(friendlyError(Exception('Random error')), 'Something went wrong — please try again');
    });
  });

  group('isNetworkError', () {
    test('returns true for timeouts and connection error', () {
      expect(isNetworkError(DioException(requestOptions: RequestOptions(path: '/'), type: DioExceptionType.connectionError)), isTrue);
      expect(isNetworkError(DioException(requestOptions: RequestOptions(path: '/'), type: DioExceptionType.connectionTimeout)), isTrue);
    });

    test('returns false for 4xx errors', () {
      expect(isNetworkError(DioException(requestOptions: RequestOptions(path: '/'), type: DioExceptionType.badResponse)), isFalse);
    });
  });
}
