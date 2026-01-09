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
  String? _selectedCategory;
  String? _selectedArea;

  RecipeRepo({required this.api, required this.hive, required this.logger});

  List<Recipe> get recipes => _getFilteredRecipes();

  String? get selectedCategory => _selectedCategory;
  String? get selectedArea => _selectedArea;

  List<Recipe> _getFilteredRecipes() {
    var filtered = _recipes;

    if (_selectedCategory != null) {
      filtered = filtered
          .where((recipe) => recipe.category == _selectedCategory)
          .toList();
    }

    if (_selectedArea != null) {
      filtered = filtered
          .where((recipe) => recipe.area == _selectedArea)
          .toList();
    }

    return filtered;
  }

  void setCategory(String? category) {
    _selectedCategory = category;
  }

  void setArea(String? area) {
    _selectedArea = area;
  }

  void clearFilters() {
    _selectedCategory = null;
    _selectedArea = null;
  }

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

        for (var recipe in recipes) {
          await hive.cacheRecipeIfNeeded(recipe);
        }

        return _getFilteredRecipes();
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
        await hive.cacheRecipe(recipe);
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

  Future<List<Category>> getCategories() async {
    try {
      final cached = hive.getCachedCategories();
      if (cached != null) {
        logger.d('Returning cached categories');
        return cached;
      }

      final response = await api.getCategories();
      if (response.statusCode == 200 && response.data != null) {
        final categoriesData = response.data['categories'] as List<dynamic>?;
        if (categoriesData == null || categoriesData.isEmpty) return [];

        final categories = categoriesData
            .map((cat) => Category.fromJson(cat as Map<String, dynamic>))
            .toList();

        await hive.cacheCategories(categories);
        return categories;
      }
      return [];
    } on DioException catch (e) {
      logger.e('Error getting categories: ${e.message}', error: e);
      rethrow;
    } catch (e) {
      logger.e('Unexpected error getting categories', error: e);
      rethrow;
    }
  }

  Future<List<Area>> getAreas() async {
    try {
      final cached = hive.getCachedAreas();
      if (cached != null) {
        logger.d('Returning cached areas');
        return cached;
      }

      final response = await api.getAreas();
      if (response.statusCode == 200 && response.data != null) {
        final areasData = response.data['meals'] as List<dynamic>?;
        if (areasData == null || areasData.isEmpty) return [];

        final areas = areasData
            .map((area) => Area.fromJson(area as Map<String, dynamic>))
            .toList();

        await hive.cacheAreas(areas);
        return areas;
      }
      return [];
    } on DioException catch (e) {
      logger.e('Error getting areas: ${e.message}', error: e);
      rethrow;
    } catch (e) {
      logger.e('Unexpected error getting areas', error: e);
      rethrow;
    }
  }

  Future<void> addToFavorites(Recipe recipe) async {
    try {
      await hive.addToFavorites(recipe);
      logger.d('Added recipe ${recipe.id} to favorites');
    } catch (e) {
      logger.e('Error adding to favorites', error: e);
      rethrow;
    }
  }

  Future<void> removeFromFavorites(String recipeId) async {
    try {
      await hive.removeFromFavorites(recipeId);
      logger.d('Removed recipe $recipeId from favorites');
    } catch (e) {
      logger.e('Error removing from favorites', error: e);
      rethrow;
    }
  }

  bool isFavorite(String recipeId) {
    return hive.isFavorite(recipeId);
  }

  Future<void> toggleFavorite(Recipe recipe) async {
    try {
      await hive.toggleFavorite(recipe);
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
