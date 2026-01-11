import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_finder_app/data/model/recipe.dart';
import 'package:recipe_finder_app/data/repo/recipe.dart';

part 'fav_recipe_event.dart';
part 'fav_recipe_state.dart';

class FavRecipeBloc extends Bloc<FavRecipeEvent, FavRecipeState> {
  final RecipeRepo repo;

  FavRecipeBloc(this.repo) : super(FavRecipeInitial()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<RemoveFromFavoritesEvent>(_onRemoveFromFavorites);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  Future<void> _onLoadFavorites(
    LoadFavoritesEvent event,
    Emitter<FavRecipeState> emit,
  ) async {
    try {
      emit(FavRecipeLoading());

      final favorites = repo.getAllFavorites();

      if (favorites.isEmpty) {
        emit(const FavRecipeEmpty('No favorite recipes yet'));
      } else {
        emit(FavRecipeLoaded(favorites));
      }
    } catch (e) {
      emit(FavRecipeError('Failed to load favorites: ${e.toString()}'));
    }
  }

  Future<void> _onRemoveFromFavorites(
    RemoveFromFavoritesEvent event,
    Emitter<FavRecipeState> emit,
  ) async {
    try {
      repo.removeFromFavorites(event.recipeId);
      add(LoadFavoritesEvent());
    } catch (e) {
      emit(FavRecipeError('Failed to remove favorite: ${e.toString()}'));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<FavRecipeState> emit,
  ) async {
    try {
      repo.toggleFavorite(event.recipe);
      add(LoadFavoritesEvent());
    } catch (e) {
      emit(FavRecipeError('Failed to toggle favorite: ${e.toString()}'));
    }
  }
}
