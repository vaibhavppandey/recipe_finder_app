part of 'fav_recipe_bloc.dart';

sealed class FavRecipeEvent extends Equatable {
  const FavRecipeEvent();

  @override
  List<Object> get props => [];
}

final class LoadFavoritesEvent extends FavRecipeEvent {}

final class RemoveFromFavoritesEvent extends FavRecipeEvent {
  final String recipeId;

  const RemoveFromFavoritesEvent(this.recipeId);

  @override
  List<Object> get props => [recipeId];
}

final class ToggleFavoriteEvent extends FavRecipeEvent {
  final Recipe recipe;

  const ToggleFavoriteEvent(this.recipe);

  @override
  List<Object> get props => [recipe];
}
