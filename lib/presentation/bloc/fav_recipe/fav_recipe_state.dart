part of 'fav_recipe_bloc.dart';

sealed class FavRecipeState extends Equatable {
  const FavRecipeState();

  @override
  List<Object> get props => [];
}

final class FavRecipeInitial extends FavRecipeState {}

final class FavRecipeLoading extends FavRecipeState {}

final class FavRecipeLoaded extends FavRecipeState {
  final List<Recipe> recipes;

  const FavRecipeLoaded(this.recipes);

  @override
  List<Object> get props => [recipes];
}

final class FavRecipeEmpty extends FavRecipeState {
  final String message;

  const FavRecipeEmpty(this.message);

  @override
  List<Object> get props => [message];
}

final class FavRecipeError extends FavRecipeState {
  final String message;

  const FavRecipeError(this.message);

  @override
  List<Object> get props => [message];
}
