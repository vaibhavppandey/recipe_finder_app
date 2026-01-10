part of 'recipe_detail_bloc.dart';

abstract class RecipeDetailState extends Equatable {
  const RecipeDetailState();

  @override
  List<Object?> get props => [];
}

class RecipeDetailInitial extends RecipeDetailState {
  const RecipeDetailInitial();
}

class RecipeDetailLoading extends RecipeDetailState {
  const RecipeDetailLoading();
}

class RecipeDetailLoaded extends RecipeDetailState {
  final Recipe recipe;
  final bool isFavorite;

  const RecipeDetailLoaded({required this.recipe, required this.isFavorite});

  @override
  List<Object?> get props => [recipe, isFavorite];
}

class RecipeDetailError extends RecipeDetailState {
  final String message;

  const RecipeDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
