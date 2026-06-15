import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/api/client.dart';
import 'package:sufrix_pos/core/api/shift_api.dart';
import 'package:sufrix_pos/core/models/shift_report.dart';

class MockDio extends Mock implements Dio {}
class MockDioClient extends Mock implements DioClient {}

void main() {
  late MockDioClient mockDioClient;
  late MockDio mockDio;
  late ShiftApi shiftApi;

  final shiftJson = {
    'id': 's1',
    'branch_id': 'b1',
    'teller_id': 't1',
    'teller_name': 'Teller',
    'status': 'open',
    'opening_cash': 1000,
    'opening_cash_was_edited': false,
    'closing_cash_declared': null,
    'closing_cash_system': null,
    'cash_discrepancy': null,
    'opened_at': '2023-01-01T08:00:00Z',
    'closed_at': null,
  };

  setUp(() {
    mockDioClient = MockDioClient();
    mockDio = MockDio();
    when(() => mockDioClient.dio).thenReturn(mockDio);
    shiftApi = ShiftApi(mockDioClient);
    
    registerFallbackValue(RequestOptions(path: '/'));
  });

  group('ShiftApi', () {
    test('current returns ShiftPreFill', () async {
      when(() => mockDio.get('/shifts/branches/b1/current'))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: ''),
                data: {
                  'has_open_shift': true,
                  'open_shift': shiftJson,
                  'suggested_opening_cash': 1000,
                },
                statusCode: 200,
              ));

      final preFill = await shiftApi.current('b1');
      expect(preFill.hasOpenShift, true);
      expect(preFill.suggestedOpeningCash, 1000);
      expect(preFill.openShift?.id, 's1');
    });

    test('list returns shifts', () async {
      when(() => mockDio.get('/shifts/branches/b1',
              queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: ''),
                // Backend returns a PaginatedShifts envelope.
                data: {
                  'data': [shiftJson],
                  'total': 1,
                  'page': 1,
                  'per_page': 50,
                  'total_pages': 1,
                },
                statusCode: 200,
              ));

      final shifts = await shiftApi.list('b1');
      expect(shifts.shifts.length, 1);
      expect(shifts.shifts[0].id, 's1');
    });

    test('open returns new shift', () async {
      when(() => mockDio.post('/shifts/branches/b1/open', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: ''),
                data: shiftJson,
                statusCode: 201,
              ));

      final shift = await shiftApi.open('b1', 1000);
      expect(shift.id, 's1');
      expect(shift.openingCash, 1000);
    });

    test('openWithId returns new shift', () async {
      when(() => mockDio.post('/shifts/branches/b1/open', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: ''),
                data: shiftJson,
                statusCode: 201,
              ));

      final shift = await shiftApi.openWithId(
        branchId: 'b1',
        shiftId: 's1',
        openingCash: 1000,
        openedAt: DateTime.utc(2023, 1, 1, 8),
      );
      expect(shift.id, 's1');
    });

    test('close returns updated shift', () async {
      final closedJson = Map<String, dynamic>.from(shiftJson)
        ..['status'] = 'closed'
        ..['closing_cash_declared'] = 1500
        ..['closed_at'] = '2023-01-01T16:00:00Z';

      when(() => mockDio.post('/shifts/s1/close', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: ''),
                data: {'shift': closedJson},
                statusCode: 200,
              ));

      final shift = await shiftApi.close(
        's1',
        closingCash: 1500,
        inventoryCounts: [],
      );

      expect(shift.status, 'closed');
      expect(shift.closingCashDeclared, 1500);
    });

    test('getReport returns ShiftReport', () async {
      when(() => mockDio.get('/shifts/s1/report'))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: ''),
                data: {
                  'shift': shiftJson,
                  'payment_summary': [],
                  'cash_movements': [],
                  'total_payments': 0,
                  'net_payments': 0,
                  'cash_movements_in': 0,
                  'cash_movements_out': 0,
                  'cash_movements_net': 0,
                  'voided_amount': 0,
                  'expected_cash': 0,
                  'printed_at': '2023-01-01T16:00:00Z',
                },
                statusCode: 200,
              ));

      final report = await shiftApi.getReport('s1');
      expect(report.shiftId, 's1');
      expect(report.status, 'open');
    });

    test('cashMovementsTotal sums amount correctly', () async {
      when(() => mockDio.get('/shifts/s1/cash-movements'))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: ''),
                data: [
                  {'amount': 100},
                  {'amount': -50},
                ],
                statusCode: 200,
              ));

      final total = await shiftApi.cashMovementsTotal('s1');
      expect(total, 50);
    });

    test('addCashMovement posts data', () async {
      when(() => mockDio.post('/shifts/s1/cash-movements', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: ''),
                data: {},
                statusCode: 201,
              ));

      await shiftApi.addCashMovement('s1', 100, 'Test Note');
      
      final captured = verify(() => mockDio.post('/shifts/s1/cash-movements', data: captureAny(named: 'data'))).captured;
      final data = captured[0] as Map<String, dynamic>;
      expect(data['amount'], 100);
      expect(data['note'], 'Test Note');
    });
  });
}
