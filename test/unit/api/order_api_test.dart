import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/api/client.dart';
import 'package:sufrix_pos/core/api/order_api.dart';
import 'package:sufrix_pos/core/models/order.dart';

class MockDio extends Mock implements Dio {}
class MockDioClient extends Mock implements DioClient {}

void main() {
  late MockDioClient mockDioClient;
  late MockDio mockDio;
  late OrderApi orderApi;

  final mockOrderJson = {
    'id': 'o1',
    'branch_id': 'b1',
    'shift_id': 's1',
    'teller_id': 'u1',
    'teller_name': 'Test User',
    'order_number': 123,
    'status': 'completed',
    'payment_method': 'cash',
    'subtotal': 1000,
    'discount_type': null,
    'discount_value': 0,
    'discount_amount': 0,
    'tax_amount': 0,
    'total_amount': 1000,
    'amount_tendered': 1000,
    'change_given': 0,
    'tip_amount': 0,
    'tip_payment_method': null,
    'discount_id': null,
    'customer_name': 'John Doe',
    'notes': 'Test Note',
    'void_reason': null,
    'created_at': '2023-01-01T12:00:00.000Z',
    'items': []
  };

  setUp(() {
    mockDioClient = MockDioClient();
    mockDio = MockDio();
    when(() => mockDioClient.dio).thenReturn(mockDio);
    orderApi = OrderApi(mockDioClient);
    
    registerFallbackValue(RequestOptions(path: '/'));
  });

  group('OrderApi', () {
    test('create posts correct data and returns Order', () async {
      when(() => mockDio.post(
            '/orders',
            data: any(named: 'data'),
            options: any(named: 'options'),
          )).thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/orders'),
                data: mockOrderJson,
                statusCode: 201,
              ));

      final order = await orderApi.create(
        branchId: 'b1',
        shiftId: 's1',
        paymentMethod: 'cash',
        items: [],
        customerName: 'John Doe',
        amountTendered: 1000,
        idempotencyKey: 'idemp123',
      );

      expect(order.id, 'o1');
      expect(order.orderNumber, 123);
      expect(order.status, 'completed');
      expect(order.customerName, 'John Doe');
      
      final captured = verify(() => mockDio.post(
            '/orders',
            data: captureAny(named: 'data'),
            options: captureAny(named: 'options'),
          )).captured;
          
      final data = captured[0] as Map<String, dynamic>;
      final options = captured[1] as Options;
      
      expect(data['branch_id'], 'b1');
      expect(data['shift_id'], 's1');
      expect(data['payment_method'], 'cash');
      expect(options.headers?['Idempotency-Key'], 'idemp123');
    });

    test('list paginates correctly and returns list of Orders', () async {
      // include_items: orders come back with embedded line items so the
      // offline cache is complete without per-order detail fetches.
      when(() => mockDio.get('/orders', queryParameters: {
            'per_page': 500,
            'include_items': true,
            'shift_id': 's1',
            'page': 1,
          })).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: '/orders'),
            data: {
              'data': [mockOrderJson],
              'total_pages': 1,
            },
            statusCode: 200,
          ));

      final orders = await orderApi.list(shiftId: 's1');
      expect(orders.length, 1);
      expect(orders[0].id, 'o1');
    });

    test('get returns single Order', () async {
      when(() => mockDio.get('/orders/o1'))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/orders/o1'),
                data: mockOrderJson,
                statusCode: 200,
              ));

      final order = await orderApi.get('o1');
      expect(order.id, 'o1');
    });

    test('voidOrder posts reason and returns updated Order', () async {
      final voidedJson = Map<String, dynamic>.from(mockOrderJson)
        ..['status'] = 'voided'
        ..['void_reason'] = 'Customer requested';

      when(() => mockDio.post(
            '/orders/o1/void',
            data: any(named: 'data'),
          )).thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/orders/o1/void'),
                data: voidedJson,
                statusCode: 200,
              ));

      final order = await orderApi.voidOrder('o1', reason: 'Customer requested', restoreInventory: true);
      
      expect(order.isVoided, true);
      expect(order.voidReason, 'Customer requested');
      
      final captured = verify(() => mockDio.post('/orders/o1/void', data: captureAny(named: 'data'))).captured;
      final data = captured[0] as Map<String, dynamic>;
      expect(data['reason'], 'Customer requested');
      expect(data['restore_inventory'], true);
    });
  });
}
