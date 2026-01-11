import 'package:hive/hive.dart';
import 'package:recipe_finder_app/core/const/local.dart';
import 'package:recipe_finder_app/data/model/area.dart';
import 'package:recipe_finder_app/data/model/category.dart';
import 'package:recipe_finder_app/data/model/recipe.dart';

class HiveService {
  void cacheRecipe(Recipe recipe) {
    final box = Hive.box(LocalConst.cache);
    box.put(recipe.id, recipe.toJson());
  }

  void cacheRecipeIfNeeded(Recipe recipe) {
    final box = Hive.box(LocalConst.cache);
    if (!box.containsKey(recipe.id)) {
      box.put(recipe.id, recipe.toJson());
    }
  }

  Recipe? getCachedRecipe(String id) {
    final box = Hive.box(LocalConst.cache);
    final data = box.get(id);
    if (data == null) return null;
    return Recipe.fromJson(Map<String, dynamic>.from(data as Map));
  }

  bool isRecipeCached(String id) {
    final box = Hive.box(LocalConst.cache);
    return box.containsKey(id);
  }

  List<Recipe> getAllCachedRecipes() {
    final box = Hive.box(LocalConst.cache);
    return box.values
        .map((json) => Recipe.fromJson(Map<String, dynamic>.from(json as Map)))
        .toList();
  }

  Future<void> clearRecipeCache() async {
    final box = Hive.box(LocalConst.cache);
    box.clear();
  }

  void addToFavorites(Recipe recipe) {
    final box = Hive.box(LocalConst.favs);
    box.put(recipe.id, recipe.toJson());
  }

  void removeFromFavorites(String recipeId) {
    final box = Hive.box(LocalConst.favs);
    box.delete(recipeId);
  }

  bool isFavorite(String recipeId) {
    final box = Hive.box(LocalConst.favs);
    return box.containsKey(recipeId);
  }

  void toggleFavorite(Recipe recipe) {
    final isFav = isFavorite(recipe.id);
    if (isFav) {
      removeFromFavorites(recipe.id);
    } else {
      addToFavorites(recipe);
    }
  }

  List<Recipe> getAllFavorites() {
    final box = Hive.box(LocalConst.favs);
    return box.values
        .map((json) => Recipe.fromJson(Map<String, dynamic>.from(json as Map)))
        .toList();
  }

  Future<void> clearFavorites() async {
    final box = Hive.box(LocalConst.favs);
    box.clear();
  }

  void cacheCategories(List<Category> categories) {
    final box = Hive.box(LocalConst.categories);
    final categoryList = categories.map((c) => c.toJson()).toList();
    box.put(LocalConst.data, categoryList);
  }

  List<Category>? getCachedCategories() {
    final box = Hive.box(LocalConst.categories);
    final data = box.get(LocalConst.data);
    if (data == null) return null;
    return (data as List)
        .map(
          (json) => Category.fromJson(Map<String, dynamic>.from(json as Map)),
        )
        .toList();
  }

  bool areCategoriesCached() {
    final box = Hive.box(LocalConst.categories);
    return box.containsKey(LocalConst.data);
  }

  void cacheAreas(List<Area> areas) {
    final box = Hive.box(LocalConst.areas);
    final areaList = areas.map((a) => a.toJson()).toList();
    box.put(LocalConst.data, areaList);
  }

  List<Area>? getCachedAreas() {
    final box = Hive.box(LocalConst.areas);
    final data = box.get(LocalConst.data);
    if (data == null) return null;
    return (data as List)
        .map((json) => Area.fromJson(Map<String, dynamic>.from(json as Map)))
        .toList();
  }

  bool areAreasCached() {
    final box = Hive.box(LocalConst.areas);
    return box.containsKey(LocalConst.data);
  }

  Future<void> clearCategoriesCache() async {
    final box = Hive.box(LocalConst.categories);
    box.clear();
  }

  Future<void> clearAreasCache() async {
    final box = Hive.box(LocalConst.areas);
    box.clear();
  }

  Future<void> clearData() async {
    clearRecipeCache();
    clearFavorites();
    clearCategoriesCache();
    clearAreasCache();
  }

  Future<void> closeAll() async {
    final recipeBox = Hive.box(LocalConst.cache);
    final favBox = Hive.box(LocalConst.favs);
    final categoriesBox = Hive.box(LocalConst.categories);
    final areasBox = Hive.box(LocalConst.areas);

    recipeBox.close();
    favBox.close();
    categoriesBox.close();
    areasBox.close();
  }
}
