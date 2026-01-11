class StringConst {
  // app title
  static const String recipes = 'Recipe Finder';

  // searing
  static const String searchRecipes = 'Search recipes...';
  static const String searchToGetStarted = 'Search for recipes to get started!';
  static const String noRecipesFound = 'No relevant recipes found';

  // filtering & sorting
  static const String filtersAndSort = 'Filters & Sort';
  static const String sortBy = 'Sort By';
  static const String sortAZ = 'A-Z';
  static const String sortZA = 'Z-A';
  static const String category = 'Category';
  static const String cuisineArea = 'Cuisine Area';
  static const String clearAll = 'Clear All';
  static const String apply = 'Apply';

  // detailed
  static const String ingredients = 'Ingredients';
  static const String instructions = 'Instructions';
  static const String videoTutorial = 'Video Tutorial';

  // favs
  static const String favorites = 'Favorites';
  static const String noFavoritesYet = 'No favorite recipes yet';
  static const String startAddingFavorites =
      'Tap the heart icon to save recipes';
  static const String browseRecipes = 'Browse Recipes';
  static const String removeFromFavorites = 'Remove from favorites';

  // tooltip
  static const String filterRecipes = 'Filter recipes';
  static const String listView = 'List view';
  static const String gridView = 'Grid view';

  // error state
  static const String error = 'Error';
  static const String retry = 'Retry';

  // dialog
  static const String cancel = 'Cancel';
  static const String remove = 'Remove';
  static String confirmRemoveFavorite(String recipeName) =>
      'Remove "$recipeName" from favorites?';
  static String removedFromFavorites(String recipeName) =>
      '$recipeName removed from favorites';

  // error messages
  static const String recipeNotFound = 'Recipe not found';
  static String failedToLoadRecipe(String error) =>
      'Unable to load this recipe. Please try again.';
  static String failedToToggleFavorite(String error) =>
      'Unable to update favorites. Please try again.';
  static String failedToLoadFavorites(String error) =>
      'Unable to load your favorites. Please try again.';
  static String failedToRemoveFavorite(String error) =>
      'Unable to remove from favorites. Please try again.';
}
