import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/api/client.dart';
import 'package:sufrix_pos/core/api/discount_api.dart';

class MockDio extends Mock implements Dio {}
class MockDioClient extends Mock implements DioClient {}

void main() {
  late MockDioClient mockDioClient;
  late MockDio mockDio;
  late DiscountApi discountApi;

  setUp(() {
    mockDioClient = MockDioClient();
    mockDio = MockDio();
    when(() => mockDioClient.dio).thenReturn(mockDio);
    discountApi = DiscountApi(mockDioClient);
  });

  group('DiscountApi', () {
    test('list returns discounts', () async {
      final mockData = [
        {
          'id': 'd1',
          'org_id': 'org1',
          'name': 'Staff Discount',
          'dtype': 'percentage',
          'value': 10,
          'is_active': true,
        },
        {
          'id': 'd2',
          'org_id': 'org1',
          'name': 'Summer Promo',
          'dtype': 'fixed',
          'value': 500,
          'is_active': false,
        }
      ];

      when(() => mockDio.get('/discounts', queryParameters: {'org_id': 'org1'}))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/discounts'),
                data: mockData,
                statusCode: 200,
              ));

      final discounts = await discountApi.list('org1');
      
      expect(discounts.length, 2);
      expect(discounts[0].id, 'd1');
      expect(discounts[0].name, 'Staff Discount');
      expect(discounts[0].label, 'Staff Discount (10%)');

      expect(discounts[1].id, 'd2');
      expect(discounts[1].name, 'Summer Promo');
      expect(discounts[1].label, 'Summer Promo (EGP 5 off)');
      expect(discounts[1].isActive, false);

      verify(() => mockDio.get('/discounts', queryParameters: {'org_id': 'org1'})).called(1);
    });
  });
}
