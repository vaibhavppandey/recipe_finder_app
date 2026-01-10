import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder_app/core/const/str.dart';
import 'package:recipe_finder_app/data/enum/sort_option.dart';
import 'package:recipe_finder_app/data/model/area.dart';
import 'package:recipe_finder_app/data/model/category.dart';
import 'package:recipe_finder_app/data/model/recipe.dart';
import 'package:recipe_finder_app/data/repo/recipe.dart';

part 'recipe_list_event.dart';
part 'recipe_list_state.dart';

class RecipeListBloc extends Bloc<RecipeListEvent, RecipeListState> {
  final RecipeRepo repo;

  RecipeListBloc({required this.repo}) : super(const RecipeListInitial()) {
    on<LoadInitialDataEvent>(_onLoadInitialData);
    on<SearchRecipesEvent>(_onSearchRecipes);
    on<FilterByCategoryEvent>(_onFilterByCategory);
    on<FilterByAreaEvent>(_onFilterByArea);
    on<ClearFiltersEvent>(_onClearFilters);
    on<SortRecipesEvent>(_onSortRecipes);
    on<ToggleViewModeEvent>(_onToggleViewMode);
  }

  Future<void> _onLoadInitialData(
    LoadInitialDataEvent event,
    Emitter<RecipeListState> emit,
  ) async {
    await repo.getCategories();
    await repo.getAreas();
    emit(const RecipeListEmpty(StringConst.searchToGetStarted));
  }

  Future<void> _onSearchRecipes(
    SearchRecipesEvent event,
    Emitter<RecipeListState> emit,
  ) async {
    String? selectedCategory;
    String? selectedArea;

    if (state is RecipeListLoaded) {
      final currentState = state as RecipeListLoaded;
      selectedCategory = currentState.selectedCategory;
      selectedArea = currentState.selectedArea;
    }

    emit(RecipeListLoading(isGridView: state.isGridView));

    try {
      final recipes = await repo.searchMealByName(event.query);
      if (recipes.isEmpty) {
        emit(RecipeListEmpty('No recipes found', isGridView: state.isGridView));
      } else {
        await repo.getCategories();
        await repo.getAreas();
        emit(
          RecipeListLoaded(
            recipes: recipes,
            categories: repo.categories,
            areas: repo.areas,
            selectedCategory: selectedCategory,
            selectedArea: selectedArea,
            isGridView: state.isGridView,
          ),
        );
      }
    } catch (e) {
      emit(RecipeListError(e.toString(), isGridView: state.isGridView));
    }
  }

  void _onFilterByCategory(
    FilterByCategoryEvent event,
    Emitter<RecipeListState> emit,
  ) {
    if (state is RecipeListLoaded) {
      final currentState = state as RecipeListLoaded;
      final filteredRecipes = _applyFilters(
        repo.recipes,
        event.category,
        currentState.selectedArea,
      );
      final filterCount = _calculateFilterCount(
        event.category,
        currentState.selectedArea,
      );

      emit(
        RecipeListLoaded(
          recipes: filteredRecipes,
          categories: currentState.categories,
          areas: currentState.areas,
          selectedCategory: event.category,
          selectedArea: currentState.selectedArea,
          sortOption: currentState.sortOption,
          activeFilterCount: filterCount,
          isGridView: currentState.isGridView,
        ),
      );
    }
  }

  void _onFilterByArea(FilterByAreaEvent event, Emitter<RecipeListState> emit) {
    if (state is RecipeListLoaded) {
      final currentState = state as RecipeListLoaded;
      final filteredRecipes = _applyFilters(
        repo.recipes,
        currentState.selectedCategory,
        event.area,
      );
      final filterCount = _calculateFilterCount(
        currentState.selectedCategory,
        event.area,
      );

      emit(
        RecipeListLoaded(
          recipes: filteredRecipes,
          categories: currentState.categories,
          areas: currentState.areas,
          selectedCategory: currentState.selectedCategory,
          selectedArea: event.area,
          sortOption: currentState.sortOption,
          activeFilterCount: filterCount,
          isGridView: currentState.isGridView,
        ),
      );
    }
  }

  void _onClearFilters(ClearFiltersEvent event, Emitter<RecipeListState> emit) {
    if (state is RecipeListLoaded) {
      final currentState = state as RecipeListLoaded;
      final unfilteredRecipes = repo.recipes;

      emit(
        RecipeListLoaded(
          recipes: unfilteredRecipes,
          categories: currentState.categories,
          areas: currentState.areas,
          selectedCategory: null,
          selectedArea: null,
          sortOption: currentState.sortOption,
          activeFilterCount: 0,
          isGridView: currentState.isGridView,
        ),
      );
    }
  }

  void _onSortRecipes(SortRecipesEvent event, Emitter<RecipeListState> emit) {
    if (state is RecipeListLoaded) {
      final currentState = state as RecipeListLoaded;
      final sortedRecipes = _sortRecipes(
        currentState.recipes,
        event.sortOption,
      );

      emit(
        RecipeListLoaded(
          recipes: sortedRecipes,
          categories: currentState.categories,
          areas: currentState.areas,
          selectedCategory: currentState.selectedCategory,
          selectedArea: currentState.selectedArea,
          sortOption: event.sortOption,
          activeFilterCount: currentState.activeFilterCount,
          isGridView: currentState.isGridView,
        ),
      );
    }
  }

  void _onToggleViewMode(
    ToggleViewModeEvent event,
    Emitter<RecipeListState> emit,
  ) {
    if (state is RecipeListLoaded) {
      final currentState = state as RecipeListLoaded;
      emit(
        RecipeListLoaded(
          recipes: currentState.recipes,
          categories: currentState.categories,
          areas: currentState.areas,
          selectedCategory: currentState.selectedCategory,
          selectedArea: currentState.selectedArea,
          sortOption: currentState.sortOption,
          activeFilterCount: currentState.activeFilterCount,
          isGridView: !currentState.isGridView,
        ),
      );
    }
  }

  int _calculateFilterCount(String? category, String? area) {
    int count = 0;
    if (category != null) count++;
    if (area != null) count++;
    return count;
  }

  List<Recipe> _applyFilters(
    List<Recipe> recipes,
    String? category,
    String? area,
  ) {
    var filtered = recipes;

    if (category != null) {
      filtered = filtered
          .where((recipe) => recipe.category == category)
          .toList();
    }

    if (area != null) {
      filtered = filtered.where((recipe) => recipe.area == area).toList();
    }

    return filtered;
  }

  List<Recipe> _sortRecipes(List<Recipe> recipes, SortOption option) {
    final sorted = List<Recipe>.from(recipes);
    switch (option) {
      case SortOption.nameAsc:
        sorted.sort((a, b) => a.meal.compareTo(b.meal));
        break;
      case SortOption.nameDesc:
        sorted.sort((a, b) => b.meal.compareTo(a.meal));
        break;
    }
    return sorted;
  }
}
