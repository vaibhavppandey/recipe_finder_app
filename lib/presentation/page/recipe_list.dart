import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder_app/presentation/bloc/recipe_list/recipe_list_bloc.dart';
import 'package:recipe_finder_app/presentation/widget/active_filters_chips.dart';
import 'package:recipe_finder_app/presentation/widget/filter/filter_bottom_sheet.dart';
import 'package:recipe_finder_app/presentation/widget/recipe_grid_view.dart';
import 'package:recipe_finder_app/presentation/widget/recipe_list_view.dart';
import 'package:recipe_finder_app/presentation/widget/search_bar_widget.dart';
import 'package:recipe_finder_app/presentation/widget/shimmer/recipe_shimmer.dart';

class RecipeListPage extends StatefulWidget {
  const RecipeListPage({super.key});

  @override
  State<RecipeListPage> createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  @override
  void initState() {
    super.initState();
    context.read<RecipeListBloc>().add(LoadInitialDataEvent());
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const FilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
        actions: [
          BlocBuilder<RecipeListBloc, RecipeListState>(
            builder: (context, state) {
              if (state is! RecipeListLoaded) return const SizedBox();

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () => _showFilterBottomSheet(context),
                  ),
                  IconButton(
                    icon: Icon(state.isGridView ? Icons.list : Icons.grid_view),
                    onPressed: () {
                      context.read<RecipeListBloc>().add(ToggleViewModeEvent());
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SearchBarWidget(),
          const ActiveFiltersChips(),
          Expanded(
            child: BlocBuilder<RecipeListBloc, RecipeListState>(
              builder: (context, state) {
                switch (state.runtimeType) {
                  case == RecipeListLoading:
                    return state.isGridView
                        ? const RecipeShimmerGrid()
                        : const RecipeShimmerList();

                  case == RecipeListError:
                    final errorState = state as RecipeListError;
                    return Center(child: Text('Error: ${errorState.message}'));

                  case == RecipeListEmpty:
                    final emptyState = state as RecipeListEmpty;
                    return Center(child: Text(emptyState.message));

                  case == RecipeListLoaded:
                    final loadedState = state as RecipeListLoaded;
                    if (loadedState.recipes.isEmpty) {
                      final hasFilters =
                          loadedState.selectedCategory != null ||
                          loadedState.selectedArea != null;
                      return Center(
                        child: Text(
                          hasFilters
                              ? 'No relevant recipes found!'
                              : 'Search for recipes to get started!',
                        ),
                      );
                    }

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      switchInCurve: Curves.easeInOut,
                      switchOutCurve: Curves.easeInOut,
                      transitionBuilder: (child, animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: loadedState.isGridView
                          ? RecipeGridView(recipes: loadedState.recipes)
                          : RecipeListView(recipes: loadedState.recipes),
                    );

                  default:
                    return const Center(
                      child: Text('Search for recipes to get started!'),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
