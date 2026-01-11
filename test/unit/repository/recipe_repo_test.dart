import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_finder_app/data/model/recipe.dart';
import 'package:recipe_finder_app/data/repo/recipe.dart';

import '../../test_helpers/mocks.dart';
import '../../test_helpers/test_data.dart';

void main() {
  late RecipeRepo repository;
  late MockMealApiService mockApi;
  late MockHiveService mockHive;
  late MockLogger mockLogger;

  setUp(() {
    mockApi = MockMealApiService();
    mockHive = MockHiveService();
    mockLogger = MockLogger();
    repository = RecipeRepo(api: mockApi, hive: mockHive, logger: mockLogger);
  });

  group('RecipeRepo -', () {
    group('searchMealByName', () {
      test('should return list of recipes on successful API call', () async {
        final responseData = {
          'meals': [sampleRecipeJson, sampleRecipe2Json],
        };
        when(() => mockApi.searchMealByName('pasta')).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/search'),
          ),
        );

        final result = await repository.searchMealByName('pasta');

        expect(result, isA<List<Recipe>>());
        expect(result.length, 2);
        expect(result[0].meal, 'Spicy Arrabiata Penne');
        expect(result[1].meal, 'Teriyaki Chicken');
        verify(() => mockApi.searchMealByName('pasta')).called(1);
      });

      test('should return empty list when no meals found', () async {
        final responseData = {'meals': null};
        when(() => mockApi.searchMealByName('nonexistent')).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/search'),
          ),
        );

        final result = await repository.searchMealByName('nonexistent');

        expect(result, isEmpty);
        verify(() => mockApi.searchMealByName('nonexistent')).called(1);
      });

      test('should throw Exception when network error occurs', () async {
        when(() => mockApi.searchMealByName('pasta')).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/search'),
            error: 'Network error',
            type: DioExceptionType.connectionTimeout,
          ),
        );
        when(
          () => mockLogger.e(any(), error: any(named: 'error')),
        ).thenReturn(null);

        expect(
          () => repository.searchMealByName('pasta'),
          throwsA(isA<Exception>()),
        );
        verify(() => mockApi.searchMealByName('pasta')).called(1);
        verify(() => mockLogger.e(any(), error: any(named: 'error'))).called(1);
      });

      test('should store recipes in internal list', () async {
        final responseData = {
          'meals': [sampleRecipeJson],
        };
        when(() => mockApi.searchMealByName('pasta')).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/search'),
          ),
        );

        await repository.searchMealByName('pasta');

        expect(repository.recipes.length, 1);
        expect(repository.recipes[0].meal, 'Spicy Arrabiata Penne');
      });
    });
  });
}
