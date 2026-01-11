import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_finder_app/core/const/api.dart';
import 'package:recipe_finder_app/data/source/remote/api.dart';

import '../../test_helpers/mocks.dart';
import '../../test_helpers/test_data.dart';

void main() {
  late MealApiService apiService;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    apiService = MealApiService(dio: mockDio);
  });

  group('MealApiService -', () {
    group('searchMealByName', () {
      test(
        'should return Response with meals when API call is successful',
        () async {
          final responseData = {
            'meals': [sampleRecipeJson],
          };
          when(
            () => mockDio.get(
              ApiConst.byName,
              queryParameters: {ApiConst.search: 'pasta'},
            ),
          ).thenAnswer(
            (_) async => Response(
              data: responseData,
              statusCode: 200,
              requestOptions: RequestOptions(path: ApiConst.byName),
            ),
          );

          final result = await apiService.searchMealByName('pasta');

          expect(result.statusCode, 200);
          expect(result.data, responseData);
          expect(result.data['meals'], isA<List>());
          expect(result.data['meals'].length, 1);
          verify(
            () => mockDio.get(
              ApiConst.byName,
              queryParameters: {ApiConst.search: 'pasta'},
            ),
          ).called(1);
        },
      );

      test('should throw DioException when network error occurs', () async {
        when(
          () => mockDio.get(
            ApiConst.byName,
            queryParameters: {ApiConst.search: 'pasta'},
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ApiConst.byName),
            error: 'Network error',
            type: DioExceptionType.connectionTimeout,
          ),
        );

        expect(
          () => apiService.searchMealByName('pasta'),
          throwsA(isA<DioException>()),
        );
        verify(
          () => mockDio.get(
            ApiConst.byName,
            queryParameters: {ApiConst.search: 'pasta'},
          ),
        ).called(1);
      });
    });

    group('getMealById', () {
      test(
        'should return Response with meal when API call is successful',
        () async {
          final responseData = {
            'meals': [sampleRecipeJson],
          };
          when(
            () => mockDio.get(
              ApiConst.byID,
              queryParameters: {ApiConst.id: '52771'},
            ),
          ).thenAnswer(
            (_) async => Response(
              data: responseData,
              statusCode: 200,
              requestOptions: RequestOptions(path: ApiConst.byID),
            ),
          );

          final result = await apiService.getMealById('52771');

          expect(result.statusCode, 200);
          expect(result.data, responseData);
          expect(result.data['meals'], isA<List>());
          verify(
            () => mockDio.get(
              ApiConst.byID,
              queryParameters: {ApiConst.id: '52771'},
            ),
          ).called(1);
        },
      );

      test('should throw DioException when meal not found', () async {
        when(
          () => mockDio.get(
            ApiConst.byID,
            queryParameters: {ApiConst.id: 'invalid'},
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ApiConst.byID),
            error: 'Not found',
            type: DioExceptionType.badResponse,
          ),
        );

        expect(
          () => apiService.getMealById('invalid'),
          throwsA(isA<DioException>()),
        );
      });
    });

    group('getCategories', () {
      test('should return Response with categories', () async {
        final responseData = {
          'categories': [sampleCategoryJson],
        };
        when(() => mockDio.get(ApiConst.categories)).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: ApiConst.categories),
          ),
        );

        final result = await apiService.getCategories();

        expect(result.statusCode, 200);
        expect(result.data, responseData);
        verify(() => mockDio.get(ApiConst.categories)).called(1);
      });
    });

    group('getAreas', () {
      test('should return Response with areas', () async {
        final responseData = {
          'meals': [sampleAreaJson],
        };
        when(
          () =>
              mockDio.get(ApiConst.list, queryParameters: {ApiConst.a: 'list'}),
        ).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: ApiConst.list),
          ),
        );

        final result = await apiService.getAreas();

        expect(result.statusCode, 200);
        expect(result.data, responseData);
        verify(
          () =>
              mockDio.get(ApiConst.list, queryParameters: {ApiConst.a: 'list'}),
        ).called(1);
      });
    });
  });
}
