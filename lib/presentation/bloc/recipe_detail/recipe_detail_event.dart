part of 'recipe_detail_bloc.dart';

abstract class RecipeDetailEvent extends Equatable {
  const RecipeDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadRecipeDetailEvent extends RecipeDetailEvent {
  final String recipeId;

  const LoadRecipeDetailEvent(this.recipeId);

  @override
  List<Object?> get props => [recipeId];
}

class ToggleFavoriteEvent extends RecipeDetailEvent {
  final Recipe recipe;

  const ToggleFavoriteEvent(this.recipe);

  @override
  List<Object?> get props => [recipe];
}
