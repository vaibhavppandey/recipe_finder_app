import 'package:dio/dio.dart';
import 'package:recipe_finder_app/core/const/api.dart';

class MealApiService {
  final Dio dio;

  MealApiService({required this.dio});

  Future<Response> searchMealByName(String query) async {
    return await dio.get(
      ApiConst.byName,
      queryParameters: {ApiConst.search: query},
    );
  }

  Future<Response> getMealById(String mealId) async {
    return await dio.get(ApiConst.byID, queryParameters: {ApiConst.id: mealId});
  }

  Future<Response> getCategories() async {
    return await dio.get(ApiConst.list, queryParameters: {ApiConst.c: 'list'});
  }

  Future<Response> getAreas() async {
    return await dio.get(ApiConst.list, queryParameters: {ApiConst.a: 'list'});
  }
}
