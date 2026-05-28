import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/api/client.dart';
import 'package:sufrix_pos/core/api/inventory_api.dart';

class MockDio extends Mock implements Dio {}
class MockDioClient extends Mock implements DioClient {}

void main() {
  late MockDioClient mockDioClient;
  late MockDio mockDio;
  late InventoryApi inventoryApi;

  setUp(() {
    mockDioClient = MockDioClient();
    mockDio = MockDio();
    when(() => mockDioClient.dio).thenReturn(mockDio);
    inventoryApi = InventoryApi(mockDioClient);
  });

  group('InventoryApi', () {
    test('items returns inventory items', () async {
      final mockData = [
        {
          'id': 'inv1',
          'ingredient_name': 'Coffee Beans',
          'unit': 'kg',
          'current_stock': 12.5,
        },
        {
          'id': 'inv2',
          'ingredient_name': 'Milk',
          'unit': 'L',
          'current_stock': '4.0', // test string parsing fallback
        }
      ];

      when(() => mockDio.get('/inventory/branches/b1/stock'))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/inventory/branches/b1/stock'),
                data: mockData,
                statusCode: 200,
              ));

      final items = await inventoryApi.items('b1');
      
      expect(items.length, 2);
      
      expect(items[0].id, 'inv1');
      expect(items[0].name, 'Coffee Beans');
      expect(items[0].unit, 'kg');
      expect(items[0].currentStock, 12.5);

      expect(items[1].id, 'inv2');
      expect(items[1].name, 'Milk');
      expect(items[1].unit, 'L');
      expect(items[1].currentStock, 4.0);

      verify(() => mockDio.get('/inventory/branches/b1/stock')).called(1);
    });
  });
}
