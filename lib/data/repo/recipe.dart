import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:recipe_finder_app/data/model/area.dart';
import 'package:recipe_finder_app/data/model/category.dart';
import 'package:recipe_finder_app/data/model/recipe.dart';
import 'package:recipe_finder_app/data/source/local/hive.dart';
import 'package:recipe_finder_app/data/source/remote/api.dart';

class RecipeRepo {
  final MealApiService api;
  final HiveService hive;
  final Logger logger;

  List<Recipe> _recipes = [];
  List<Category> _categories = [];
  List<Area> _areas = [];

  RecipeRepo({required this.api, required this.hive, required this.logger});

  List<Recipe> get recipes => _recipes;
  List<Category> get categories => _categories;
  List<Area> get areas => _areas;

  Future<List<Recipe>> searchMealByName(String query) async {
    try {
      final response = await api.searchMealByName(query);
      if (response.statusCode == 200 && response.data != null) {
        final meals = response.data['meals'] as List<dynamic>?;
        if (meals == null || meals.isEmpty) {
          _recipes = [];
          return [];
        }

        final recipes = meals
            .map((meal) => Recipe.fromJson(meal as Map<String, dynamic>))
            .toList();

        _recipes = recipes;

        // don't cache search results, call seperately
        // for (var recipe in recipes) {
        //   hive.cacheRecipeIfNeeded(recipe);
        // }

        return _recipes;
      }
      _recipes = [];
      return [];
    } on DioException catch (e) {
      logger.e('Error searching meals by name: ${e.message}', error: e);
      rethrow;
    } catch (e) {
      logger.e('Unexpected error searching meals by name', error: e);
      rethrow;
    }
  }

  Future<Recipe?> getMealById(String mealId) async {
    try {
      final cached = hive.getCachedRecipe(mealId);
      if (cached != null) {
        logger.d('Returning cached recipe: $mealId');
        return cached;
      }

      final response = await api.getMealById(mealId);
      if (response.statusCode == 200 && response.data != null) {
        final meals = response.data['meals'] as List<dynamic>?;
        if (meals == null || meals.isEmpty) return null;

        final recipe = Recipe.fromJson(meals.first as Map<String, dynamic>);
        hive.cacheRecipe(recipe);
        return recipe;
      }
      return null;
    } on DioException catch (e) {
      logger.e('Error getting meal by id: ${e.message}', error: e);
      rethrow;
    } catch (e) {
      logger.e('Unexpected error getting meal by id', error: e);
      rethrow;
    }
  }

  Future<void> getCategories() async {
    try {
      final cached = hive.getCachedCategories();
      if (cached != null) {
        logger.d('Returning cached categories');
        _categories = cached;
        return;
      }

      final response = await api.getCategories();
      if (response.statusCode == 200 && response.data != null) {
        final categoriesData = response.data['categories'] as List<dynamic>?;
        if (categoriesData == null || categoriesData.isEmpty) {
          _categories = [];
          return;
        }

        final categories = categoriesData
            .map(
              (cat) => Category.fromJson(Map<String, dynamic>.from(cat as Map)),
            )
            .toList();

        // cache & don't call the api again
        hive.cacheCategories(categories);
        _categories = categories;
        return;
      }
      _categories = [];
    } on DioException catch (e) {
      logger.e('Error getting categories: ${e.message}', error: e);
      rethrow;
    } catch (e) {
      logger.e('Unexpected error getting categories', error: e);
      rethrow;
    }
  }

  Future<void> getAreas() async {
    try {
      final cached = hive.getCachedAreas();
      if (cached != null) {
        logger.d('Returning cached areas');
        _areas = cached;
        return;
      }

      final response = await api.getAreas();
      if (response.statusCode == 200 && response.data != null) {
        final areasData = response.data['meals'] as List<dynamic>?;
        if (areasData == null || areasData.isEmpty) {
          _areas = [];
          return;
        }

        final areas = areasData
            .map(
              (area) => Area.fromJson(Map<String, dynamic>.from(area as Map)),
            )
            .toList();

        hive.cacheAreas(areas);
        _areas = areas;
        return;
      }
      _areas = [];
    } on DioException catch (e) {
      logger.e('Error getting areas: ${e.message}', error: e);
      rethrow;
    } catch (e) {
      logger.e('Unexpected error getting areas', error: e);
      rethrow;
    }
  }

  void addToFavorites(Recipe recipe) {
    try {
      hive.addToFavorites(recipe);
      logger.d('Added recipe ${recipe.id} to favorites');
    } catch (e) {
      logger.e('Error adding to favorites', error: e);
      rethrow;
    }
  }

  void removeFromFavorites(String recipeId) {
    try {
      hive.removeFromFavorites(recipeId);
      logger.d('Removed recipe $recipeId from favorites');
    } catch (e) {
      logger.e('Error removing from favorites', error: e);
      rethrow;
    }
  }

  bool isFavorite(String recipeId) {
    return hive.isFavorite(recipeId);
  }

  void toggleFavorite(Recipe recipe) {
    try {
      hive.toggleFavorite(recipe);
      logger.d('Toggled favorite for recipe ${recipe.id}');
    } catch (e) {
      logger.e('Error toggling favorite', error: e);
      rethrow;
    }
  }

  List<Recipe> getAllFavorites() {
    return hive.getAllFavorites();
  }

  List<Recipe> getAllCachedRecipes() {
    return hive.getAllCachedRecipes();
  }
}
