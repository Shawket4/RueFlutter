import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/api/client.dart';
import 'package:sufrix_pos/core/api/delivery_api.dart';
import 'package:sufrix_pos/core/models/delivery_settings.dart';

class MockDio extends Mock implements Dio {}

class MockDioClient extends Mock implements DioClient {}

void main() {
  late MockDioClient mockDioClient;
  late MockDio mockDio;
  late DeliveryApi api;

  final settingsJson = <String, dynamic>{
    'branch_id': 'b1',
    'in_mall_enabled': true,
    'outside_enabled': false,
    'in_mall_override': 'auto',
    'outside_override': 'closed',
    'in_mall_fee': 1500,
    'prep_time_minutes': 20,
  };

  setUp(() {
    mockDioClient = MockDioClient();
    mockDio = MockDio();
    when(() => mockDioClient.dio).thenReturn(mockDio);
    api = DeliveryApi(mockDioClient);
  });

  group('DeliveryApi — channel accepting', () {
    test('getSettings GETs /delivery/settings with branch_id and parses', () async {
      when(() => mockDio.get('/delivery/settings',
              queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/delivery/settings'),
                data: settingsJson,
                statusCode: 200,
              ));

      final s = await api.getSettings('b1');
      expect(s.inMallEnabled, true);
      expect(s.outsideEnabled, false);
      expect(s.inMallOverride, 'auto');
      expect(s.outsideOverride, 'closed');

      final captured = verify(() => mockDio.get('/delivery/settings',
          queryParameters: captureAny(named: 'queryParameters'))).captured;
      expect((captured[0] as Map)['branch_id'], 'b1');
    });

    test('setAccepting POSTs branch_id/channel/mode and adopts the result',
        () async {
      when(() => mockDio.post('/delivery/accepting', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/delivery/accepting'),
                data: {...settingsJson, 'in_mall_override': 'closed'},
                statusCode: 200,
              ));

      final s = await api.setAccepting('b1', channel: 'in_mall', mode: 'closed');
      expect(s.inMallOverride, 'closed');

      final data = verify(() => mockDio.post('/delivery/accepting',
          data: captureAny(named: 'data'))).captured[0] as Map<String, dynamic>;
      expect(data['branch_id'], 'b1');
      expect(data['channel'], 'in_mall');
      expect(data['mode'], 'closed'); // not 'override' — Dart reserved word
    });
  });

  group('DeliverySettings model', () {
    test('helpers: enabledFor / overrideFor / anyEnabled', () {
      final s = DeliverySettings.fromJson(settingsJson);
      expect(s.enabledFor('in_mall'), true);
      expect(s.enabledFor('outside'), false);
      expect(s.overrideFor('in_mall'), 'auto');
      expect(s.overrideFor('outside'), 'closed');
      expect(s.anyEnabled, true);
    });

    test('tolerant defaults for a sparse payload', () {
      final s = DeliverySettings.fromJson({'branch_id': 'b1'});
      expect(s.inMallEnabled, false);
      expect(s.inMallOverride, 'auto');
      expect(s.anyEnabled, false);
    });
  });
}
