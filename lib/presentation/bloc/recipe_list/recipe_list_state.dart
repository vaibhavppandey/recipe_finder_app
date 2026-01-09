part of 'recipe_list_bloc.dart';

@immutable
sealed class RecipeListState {}

final class RecipeListInitial extends RecipeListState {}

final class RecipeListLoading extends RecipeListState {}

final class RecipeListSuccess extends RecipeListState {
  final List<Recipe> recipes;

  RecipeListSuccess(this.recipes);
}

final class RecipeListError extends RecipeListState {
  final String message;

  RecipeListError(this.message);
}

final class RecipeDetailLoading extends RecipeListState {}

final class RecipeDetailSuccess extends RecipeListState {
  final Recipe recipe;

  RecipeDetailSuccess(this.recipe);
}

final class RecipeDetailError extends RecipeListState {
  final String message;

  RecipeDetailError(this.message);
}
