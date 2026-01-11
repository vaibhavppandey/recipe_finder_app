class StringConst {
  // App Bar Titles
  static const String recipes = 'Recipe Finder';

  // Search
  static const String searchRecipes = 'Search recipes...';
  static const String searchToGetStarted = 'Search for recipes to get started!';
  static const String noRecipesFound = 'No relevant recipes found';

  // Filters & Sort
  static const String filtersAndSort = 'Filters & Sort';
  static const String sortBy = 'Sort By';
  static const String sortAZ = 'A-Z';
  static const String sortZA = 'Z-A';
  static const String category = 'Category';
  static const String cuisineArea = 'Cuisine Area';
  static const String clearAll = 'Clear All';
  static const String apply = 'Apply';

  // Recipe Detail
  static const String ingredients = 'Ingredients';
  static const String instructions = 'Instructions';
  static const String videoTutorial = 'Video Tutorial';

  // Favorites
  static const String favorites = 'Favorites';
  static const String noFavoritesYet = 'No favorite recipes yet';
  static const String startAddingFavorites =
      'Tap the heart icon to save recipes';
  static const String browseRecipes = 'Browse Recipes';
  static const String removeFromFavorites = 'Remove from favorites';

  // Tooltips
  static const String filterRecipes = 'Filter recipes';
  static const String listView = 'List view';
  static const String gridView = 'Grid view';

  // Error
  static const String error = 'Error';
  static const String retry = 'Retry';

  // Dialog
  static const String cancel = 'Cancel';
  static const String remove = 'Remove';
  static String confirmRemoveFavorite(String recipeName) =>
      'Remove "$recipeName" from favorites?';
  static String removedFromFavorites(String recipeName) =>
      '$recipeName removed from favorites';

  // Bloc Error Messages
  static const String recipeNotFound = 'Recipe not found';
  static String failedToLoadRecipe(String error) =>
      'Failed to load recipe: $error';
  static String failedToToggleFavorite(String error) =>
      'Failed to toggle favorite: $error';
  static String failedToLoadFavorites(String error) =>
      'Failed to load favorites: $error';
  static String failedToRemoveFavorite(String error) =>
      'Failed to remove favorite: $error';
}
