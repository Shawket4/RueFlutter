import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/api/client.dart';
import 'package:sufrix_pos/core/api/menu_api.dart';
import 'package:sufrix_pos/core/models/bundle.dart';

class MockDio extends Mock implements Dio {}
class MockDioClient extends Mock implements DioClient {}

void main() {
  late MockDioClient mockDioClient;
  late MockDio mockDio;
  late MenuApi menuApi;

  setUp(() {
    mockDioClient = MockDioClient();
    mockDio = MockDio();
    when(() => mockDioClient.dio).thenReturn(mockDio);
    menuApi = MenuApi(mockDioClient);
  });

  group('MenuApi', () {
    test('categories returns list', () async {
      when(() => mockDio.get('/categories', queryParameters: {'org_id': 'org1'}))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/categories'),
                data: [
                  {
                    'id': 'c1',
                    'org_id': 'org1',
                    'name': 'Drinks',
                    'name_translations': <String, dynamic>{},
                    'icon': 'local_cafe',
                    'display_order': 1,
                    'is_active': true,
                    'created_at': '2023-01-01T00:00:00Z',
                    'updated_at': '2023-01-01T00:00:00Z',
                  }
                ],
                statusCode: 200,
              ));

      final cats = await menuApi.categories('org1');
      expect(cats.length, 1);
      expect(cats[0].id, 'c1');
    });

    test('items returns list', () async {
      when(() => mockDio.get('/menu-items', queryParameters: {'org_id': 'org1', 'full': 'true'}))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/menu-items'),
                data: [
                  {
                    'id': 'm1',
                    'org_id': 'org1',
                    'name': 'Espresso',
                    'name_translations': <String, dynamic>{},
                    'description_translations': <String, dynamic>{},
                    'category_id': 'c1',
                    'base_price': 2000,
                    'is_active': true,
                    'display_order': 1,
                    'sizes': <Object>[],
                    'addon_slots': <Object>[],
                    'optional_fields': <Object>[],
                    'recipes': <Object>[],
                    'created_at': '2023-01-01T00:00:00Z',
                    'updated_at': '2023-01-01T00:00:00Z',
                  }
                ],
                statusCode: 200,
              ));

      final items = await menuApi.items('org1');
      expect(items.length, 1);
      expect(items[0].id, 'm1');
      expect(items[0].basePrice, 2000);
    });

    test('item returns single item', () async {
      when(() => mockDio.get('/menu-items/m1'))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/menu-items/m1'),
                data: {
                  'id': 'm1',
                  'org_id': 'org1',
                  'name': 'Espresso',
                  'name_translations': <String, dynamic>{},
                  'description_translations': <String, dynamic>{},
                  'category_id': 'c1',
                  'base_price': 2000,
                  'is_active': true,
                  'display_order': 1,
                  'sizes': <Object>[],
                  'addon_slots': <Object>[],
                  'optional_fields': <Object>[],
                  'recipes': <Object>[],
                  'created_at': '2023-01-01T00:00:00Z',
                  'updated_at': '2023-01-01T00:00:00Z',
                },
                statusCode: 200,
              ));

      final item = await menuApi.item('m1');
      expect(item.id, 'm1');
    });

    test('addonItems returns list', () async {
      when(() => mockDio.get('/addon-items', queryParameters: {'org_id': 'org1'}))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/addon-items'),
                data: [
                  {
                    'id': 'a1',
                    'org_id': 'org1',
                    'name': 'Extra Shot',
                    'name_translations': <String, dynamic>{},
                    'addon_type': 'coffee',
                    'default_price': 500,
                    'is_active': true,
                    'display_order': 1,
                    'created_at': '2023-01-01T00:00:00Z',
                    'updated_at': '2023-01-01T00:00:00Z',
                  }
                ],
                statusCode: 200,
              ));

      final addons = await menuApi.addonItems('org1');
      expect(addons.length, 1);
      expect(addons[0].id, 'a1');
      expect(addons[0].defaultPrice, 500);
    });

    test('bundles returns list filtering inactive', () async {
      when(() => mockDio.get('/bundles', queryParameters: {'org_id': 'org1'}))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/bundles'),
                data: {
                  'data': [
                    {
                      'id': 'b1',
                      'org_id': 'org1',
                      'name': 'Breakfast Combo',
                      'name_translations': <String, dynamic>{},
                      'description_translations': <String, dynamic>{},
                      'price': 5000,
                      'status': 'active',
                      'branch_ids': <Object>[],
                      'components': [],
                      'computed_cost': 0,
                      'display_order': 1,
                      'created_at': '2023-01-01T00:00:00Z',
                      'updated_at': '2023-01-01T00:00:00Z',
                    },
                    {
                      'id': 'b2',
                      'org_id': 'org1',
                      'name': 'Lunch Combo',
                      'name_translations': <String, dynamic>{},
                      'description_translations': <String, dynamic>{},
                      'price': 8000,
                      'status': 'draft',
                      'branch_ids': <Object>[],
                      'components': [],
                      'computed_cost': 0,
                      'display_order': 2,
                      'created_at': '2023-01-01T00:00:00Z',
                      'updated_at': '2023-01-01T00:00:00Z',
                    }
                  ]
                },
                statusCode: 200,
              ));

      final bundles = await menuApi.bundles('org1');
      expect(bundles.length, 1);
      expect(bundles[0].id, 'b1');
      expect(bundles[0].status, BundleStatus.active);
    });
  });
}
