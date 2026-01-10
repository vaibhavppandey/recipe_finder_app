import 'package:hive/hive.dart';
import 'package:recipe_finder_app/core/const/local.dart';
import 'package:recipe_finder_app/data/model/area.dart';
import 'package:recipe_finder_app/data/model/category.dart';
import 'package:recipe_finder_app/data/model/recipe.dart';

class HiveService {
  Future<void> cacheRecipe(Recipe recipe) async {
    final box = Hive.box(LocalConst.cache);
    await box.put(recipe.id, recipe.toJson());
  }

  Future<void> cacheRecipeIfNeeded(Recipe recipe) async {
    final box = Hive.box(LocalConst.cache);
    if (!box.containsKey(recipe.id)) {
      await box.put(recipe.id, recipe.toJson());
    }
  }

  Recipe? getCachedRecipe(String id) {
    final box = Hive.box(LocalConst.cache);
    final data = box.get(id);
    if (data == null) return null;
    return Recipe.fromJson(data as Map<String, dynamic>);
  }

  bool isRecipeCached(String id) {
    final box = Hive.box(LocalConst.cache);
    return box.containsKey(id);
  }

  List<Recipe> getAllCachedRecipes() {
    final box = Hive.box(LocalConst.cache);
    return box.values
        .map((json) => Recipe.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> clearRecipeCache() async {
    final box = Hive.box(LocalConst.cache);
    await box.clear();
  }

  Future<void> addToFavorites(Recipe recipe) async {
    final box = Hive.box(LocalConst.favs);
    await box.put(recipe.id, recipe.toJson());
  }

  Future<void> removeFromFavorites(String recipeId) async {
    final box = Hive.box(LocalConst.favs);
    await box.delete(recipeId);
  }

  bool isFavorite(String recipeId) {
    final box = Hive.box(LocalConst.favs);
    return box.containsKey(recipeId);
  }

  Future<void> toggleFavorite(Recipe recipe) async {
    final isFav = isFavorite(recipe.id);
    if (isFav) {
      await removeFromFavorites(recipe.id);
    } else {
      await addToFavorites(recipe);
    }
  }

  List<Recipe> getAllFavorites() {
    final box = Hive.box(LocalConst.favs);
    return box.values
        .map((json) => Recipe.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> clearFavorites() async {
    final box = Hive.box(LocalConst.favs);
    await box.clear();
  }

  Future<void> cacheCategories(List<Category> categories) async {
    final box = Hive.box(LocalConst.categories);
    final categoryList = categories.map((c) => c.toJson()).toList();
    await box.put(LocalConst.data, categoryList);
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

  Future<void> cacheAreas(List<Area> areas) async {
    final box = Hive.box(LocalConst.areas);
    final areaList = areas.map((a) => a.toJson()).toList();
    await box.put(LocalConst.data, areaList);
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
    await box.clear();
  }

  Future<void> clearAreasCache() async {
    final box = Hive.box(LocalConst.areas);
    await box.clear();
  }

  Future<void> clearData() async {
    await clearRecipeCache();
    await clearFavorites();
    await clearCategoriesCache();
    await clearAreasCache();
  }

  Future<void> closeAll() async {
    final recipeBox = Hive.box(LocalConst.cache);
    final favBox = Hive.box(LocalConst.favs);
    final categoriesBox = Hive.box(LocalConst.categories);
    final areasBox = Hive.box(LocalConst.areas);

    await recipeBox.close();
    await favBox.close();
    await categoriesBox.close();
    await areasBox.close();
  }
}
