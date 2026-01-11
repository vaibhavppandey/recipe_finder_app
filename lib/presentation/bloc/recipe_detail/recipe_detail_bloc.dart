import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder_app/core/const/str.dart';
import 'package:recipe_finder_app/data/model/recipe.dart';
import 'package:recipe_finder_app/data/repo/recipe.dart';

part 'recipe_detail_event.dart';
part 'recipe_detail_state.dart';

class RecipeDetailBloc extends Bloc<RecipeDetailEvent, RecipeDetailState> {
  final RecipeRepo repo;

  RecipeDetailBloc({required this.repo}) : super(const RecipeDetailInitial()) {
    on<LoadRecipeDetailEvent>(_onLoadRecipeDetail);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  Future<void> _onLoadRecipeDetail(
    LoadRecipeDetailEvent event,
    Emitter<RecipeDetailState> emit,
  ) async {
    emit(const RecipeDetailLoading());

    try {
      // Ensure shimmer is visible for at least a short duration
      await Future.delayed(const Duration(milliseconds: 500));

      repo.logger.d('API call for meal ID: ${event.recipeId}');
      final recipe = await repo.getMealById(event.recipeId);

      if (recipe == null) {
        emit(const RecipeDetailError(StringConst.recipeNotFound));
        return;
      }

      final isFavorite = repo.hive.isFavorite(recipe.id);
      emit(RecipeDetailLoaded(recipe: recipe, isFavorite: isFavorite));
    } catch (e) {
      emit(RecipeDetailError(StringConst.failedToLoadRecipe(e.toString())));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<RecipeDetailState> emit,
  ) async {
    if (state is! RecipeDetailLoaded) return;

    final currentState = state as RecipeDetailLoaded;

    try {
      repo.hive.toggleFavorite(event.recipe);
      final isFavorite = repo.hive.isFavorite(event.recipe.id);

      emit(
        RecipeDetailLoaded(recipe: currentState.recipe, isFavorite: isFavorite),
      );
    } catch (e) {
      emit(RecipeDetailError(StringConst.failedToToggleFavorite(e.toString())));
    }
  }
}
