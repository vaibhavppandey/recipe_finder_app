part of 'recipe_list_bloc.dart';

abstract class RecipeListState extends Equatable {
  final List<Category> categories;
  final List<Area> areas;
  final bool isGridView;

  const RecipeListState({
    this.categories = const [],
    this.areas = const [],
    this.isGridView = true,
  });

  @override
  List<Object?> get props => [categories, areas, isGridView];
}

class RecipeListInitial extends RecipeListState {
  const RecipeListInitial();
}

class RecipeListLoading extends RecipeListState {
  const RecipeListLoading({super.categories, super.areas, super.isGridView});
}

class RecipeListLoaded extends RecipeListState {
  final List<Recipe> recipes;
  final String? selectedCategory;
  final String? selectedArea;
  final SortOption sortOption;
  final int activeFilterCount;

  const RecipeListLoaded({
    required this.recipes,
    this.selectedCategory,
    this.selectedArea,
    this.sortOption = SortOption.nameAsc,
    this.activeFilterCount = 0,
    super.isGridView,
  });

  @override
  List<Object?> get props => [
    recipes,
    selectedCategory,
    selectedArea,
    sortOption,
    activeFilterCount,
    ...super.props,
  ];
}

class RecipeListEmpty extends RecipeListState {
  final String message;
  const RecipeListEmpty(
    this.message, {
    super.categories,
    super.areas,
    super.isGridView,
  });

  @override
  List<Object?> get props => [message, ...super.props];
}

class RecipeListError extends RecipeListState {
  final String message;
  const RecipeListError(
    this.message, {
    super.categories,
    super.areas,
    super.isGridView,
  });

  @override
  List<Object?> get props => [message, ...super.props];
}
