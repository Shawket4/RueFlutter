import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/api/branch_api.dart';
import 'package:sufrix_pos/core/api/client.dart';
import 'package:sufrix_pos/core/models/branch.dart';

class MockDio extends Mock implements Dio {}
class MockDioClient extends Mock implements DioClient {}

void main() {
  late MockDioClient mockDioClient;
  late MockDio mockDio;
  late BranchApi branchApi;

  setUp(() {
    mockDioClient = MockDioClient();
    mockDio = MockDio();
    when(() => mockDioClient.dio).thenReturn(mockDio);
    branchApi = BranchApi(mockDioClient);
  });

  group('BranchApi', () {
    test('get success', () async {
      final mockData = {
        'id': 'b1',
        'org_id': 'org1',
        'name': 'Main Branch',
        'address': '123 Test St',
        'phone': '555-0123',
        'printer_brand': 'star',
        'printer_ip': '192.168.1.100',
        'printer_port': 9100,
        'is_active': true,
        'org_logo_url': 'http://example.com/logo.png',
        'timezone': 'Africa/Cairo',
        'created_at': '2023-01-01T00:00:00Z',
        'updated_at': '2023-01-01T00:00:00Z',
      };

      when(() => mockDio.get('/branches/b1')).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: '/branches/b1'),
            data: mockData,
            statusCode: 200,
          ));

      final branch = await branchApi.get('b1');
      
      expect(branch.id, 'b1');
      expect(branch.orgId, 'org1');
      expect(branch.name, 'Main Branch');
      expect(branch.address, '123 Test St');
      expect(branch.phone, '555-0123');
      expect(branch.printerBrand, PrinterBrand.star);
      expect(branch.printerIp, '192.168.1.100');
      expect(branch.printerPort, 9100);
      expect(branch.isActive, true);
      expect(branch.orgLogoUrl, 'http://example.com/logo.png');
      expect(branch.hasPrinter, true);

      verify(() => mockDio.get('/branches/b1')).called(1);
    });
  });
}
