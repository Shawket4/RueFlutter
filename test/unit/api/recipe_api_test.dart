import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/api/client.dart';
import 'package:sufrix_pos/core/api/recipe_api.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';

class MockDio extends Mock implements Dio {}
class MockDioClient extends Mock implements DioClient {}
class MockStorageService extends Mock implements StorageService {}

void main() {
  late MockDioClient mockDioClient;
  late MockDio mockDio;
  late MockStorageService mockStorageService;
  late RecipeApi recipeApi;

  setUp(() {
    mockDioClient = MockDioClient();
    mockDio = MockDio();
    mockStorageService = MockStorageService();
    when(() => mockDioClient.dio).thenReturn(mockDio);
    recipeApi = RecipeApi(mockDioClient, mockStorageService);
    
    registerFallbackValue(RequestOptions(path: '/'));
  });

  group('RecipeApi', () {
    test('preview calls network and saves to storage on success', () async {
      final mockData = [
        {
          'ingredient_name': 'Coffee Beans',
          'unit': 'g',
          'quantity': 18.0,
          'source': 'drink_recipe',
          'category': 'coffee_bean',
        }
      ];

      when(() => mockDio.post(
            '/orders/preview-recipe',
            data: any(named: 'data'),
          )).thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/orders/preview-recipe'),
                data: mockData,
                statusCode: 200,
              ));

      when(() => mockStorageService.saveRecipe(any(), any()))
          .thenAnswer((_) async {});

      final ingredients = await recipeApi.preview(
        menuItemId: 'm1',
        addons: [],
        optionals: [],
      );

      expect(ingredients.length, 1);
      expect(ingredients[0].name, 'Coffee Beans');
      expect(ingredients[0].quantity, 18.0);
      expect(ingredients[0].isBase, true);

      verify(() => mockStorageService.saveRecipe(any(), mockData)).called(1);
    });

    test('preview falls back to cache on network error', () async {
      when(() => mockDio.post('/orders/preview-recipe', data: any(named: 'data')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '/orders/preview-recipe')));

      final cachedData = [
        {
          'ingredient_name': 'Milk',
          'unit': 'ml',
          'quantity': 200.0,
          'source': 'addon',
          'category': 'general',
        }
      ];

      when(() => mockStorageService.loadRecipe(any())).thenReturn(cachedData);

      final ingredients = await recipeApi.preview(
        menuItemId: 'm1',
        addons: [],
        optionals: [],
      );

      expect(ingredients.length, 1);
      expect(ingredients[0].name, 'Milk');
      expect(ingredients[0].isAddon, true);

      verify(() => mockStorageService.loadRecipe(any())).called(1);
    });
  });
}
