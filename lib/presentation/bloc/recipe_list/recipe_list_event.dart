part of 'recipe_list_bloc.dart';

@immutable
sealed class RecipeListEvent {}

final class SearchRecipesEvent extends RecipeListEvent {
  final String query;

  SearchRecipesEvent(this.query);
}

final class GetRecipeByIdEvent extends RecipeListEvent {
  final String recipeId;

  GetRecipeByIdEvent(this.recipeId);
}
