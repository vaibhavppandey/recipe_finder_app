part of 'recipe_list_bloc.dart';

abstract class RecipeListEvent extends Equatable {
  const RecipeListEvent();

  @override
  List<Object?> get props => [];
}

class LoadInitialDataEvent extends RecipeListEvent {
  const LoadInitialDataEvent();
}

class SearchRecipesEvent extends RecipeListEvent {
  final String query;
  const SearchRecipesEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterByCategoryEvent extends RecipeListEvent {
  final String? category;
  const FilterByCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}

class FilterByAreaEvent extends RecipeListEvent {
  final String? area;
  const FilterByAreaEvent(this.area);

  @override
  List<Object?> get props => [area];
}

class ClearFiltersEvent extends RecipeListEvent {
  const ClearFiltersEvent();
}

class SortRecipesEvent extends RecipeListEvent {
  final SortOption sortOption;
  const SortRecipesEvent(this.sortOption);

  @override
  List<Object?> get props => [sortOption];
}

class ToggleViewModeEvent extends RecipeListEvent {
  const ToggleViewModeEvent();
}

class RefreshSearchEvent extends RecipeListEvent {
  const RefreshSearchEvent();
}
