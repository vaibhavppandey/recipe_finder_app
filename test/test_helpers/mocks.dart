import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_finder_app/data/repo/recipe.dart';
import 'package:recipe_finder_app/data/source/local/hive.dart';
import 'package:recipe_finder_app/data/source/remote/api.dart';

// Mock classes for testing
class MockDio extends Mock implements Dio {}

class MockHiveService extends Mock implements HiveService {}

class MockRecipeRepo extends Mock implements RecipeRepo {}

class MockMealApiService extends Mock implements MealApiService {}

class MockLogger extends Mock implements Logger {}

class MockBox extends Mock implements Box {}

class MockResponse extends Mock implements Response {}
