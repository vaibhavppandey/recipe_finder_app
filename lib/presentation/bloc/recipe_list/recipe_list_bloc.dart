import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:recipe_finder_app/data/model/recipe.dart';
import 'package:recipe_finder_app/data/repo/recipe.dart';

part 'recipe_list_event.dart';
part 'recipe_list_state.dart';

class RecipeListBloc extends Bloc<RecipeListEvent, RecipeListState> {
  final RecipeRepo repo;

  RecipeListBloc({required this.repo}) : super(RecipeListInitial()) {
    on<SearchRecipesEvent>(_onSearchRecipes);
    on<GetRecipeByIdEvent>(_onGetRecipeById);
  }

  Future<void> _onSearchRecipes(
    SearchRecipesEvent event,
    Emitter<RecipeListState> emit,
  ) async {
    emit(RecipeListLoading());
    try {
      final recipes = await repo.searchMealByName(event.query);
      emit(RecipeListSuccess(recipes));
    } catch (e) {
      emit(RecipeListError(e.toString()));
    }
  }

  Future<void> _onGetRecipeById(
    GetRecipeByIdEvent event,
    Emitter<RecipeListState> emit,
  ) async {
    emit(RecipeDetailLoading());
    try {
      final recipe = await repo.getMealById(event.recipeId);
      if (recipe != null) {
        emit(RecipeDetailSuccess(recipe));
      } else {
        emit(RecipeDetailError('Recipe not found'));
      }
    } catch (e) {
      emit(RecipeDetailError(e.toString()));
    }
  }
}
