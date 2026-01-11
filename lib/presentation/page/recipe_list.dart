import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/core/const/str.dart';
import 'package:recipe_finder_app/presentation/bloc/recipe_list/recipe_list_bloc.dart';
import 'package:recipe_finder_app/presentation/page/favorites.dart';
import 'package:recipe_finder_app/presentation/widget/list/active_filters_chips.dart';
import 'package:recipe_finder_app/presentation/widget/filter/filter_bottom_sheet.dart';
import 'package:recipe_finder_app/presentation/widget/list/recipe_grid_view.dart';
import 'package:recipe_finder_app/presentation/widget/list/recipe_list_view.dart';
import 'package:recipe_finder_app/presentation/widget/list/search_bar_widget.dart';
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
        title: const Text(StringConst.recipes),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            tooltip: StringConst.favorites,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritesPage()),
              );
            },
          ),
          BlocBuilder<RecipeListBloc, RecipeListState>(
            builder: (context, state) {
              if (state is! RecipeListLoaded && state is! RecipeListEmpty) {
                return const SizedBox();
              }
              if (state is RecipeListEmpty) return const SizedBox();

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    tooltip: StringConst.filterRecipes,
                    onPressed: () => _showFilterBottomSheet(context),
                  ),
                  IconButton(
                    icon: Icon(state.isGridView ? Icons.list : Icons.grid_view),
                    tooltip: state.isGridView
                        ? StringConst.listView
                        : StringConst.gridView,
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
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64.sp,
                            color: Colors.red,
                          ),
                          16.verticalSpace,
                          Text(
                            '${StringConst.error}: ${errorState.message}',
                            textAlign: TextAlign.center,
                          ),
                          24.verticalSpace,
                          ElevatedButton.icon(
                            onPressed: () {
                              context.read<RecipeListBloc>().add(
                                LoadInitialDataEvent(),
                              );
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text('Try Again'),
                          ),
                        ],
                      ),
                    );

                  case == RecipeListEmpty:
                    final emptyState = state as RecipeListEmpty;
                    return KeyboardVisibilityBuilder(
                      builder: (context, isKeyboardVisible) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (!isKeyboardVisible) ...[
                                Opacity(
                                  opacity: 0.5,
                                  child: Icon(
                                    emptyState.message ==
                                            StringConst.searchToGetStarted
                                        ? Icons.restaurant_menu
                                        : Icons.search_off,
                                    size: 80.sp,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                  ),
                                ),
                                24.verticalSpace,
                              ],
                              Text(
                                emptyState.message,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    );

                  case == RecipeListLoaded:
                    final loadedState = state as RecipeListLoaded;
                    if (loadedState.recipes.isEmpty) {
                      final hasFilters =
                          loadedState.selectedCategory != null ||
                          loadedState.selectedArea != null;
                      return KeyboardVisibilityBuilder(
                        builder: (context, isKeyboardVisible) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (!isKeyboardVisible) ...[
                                  Opacity(
                                    opacity: 0.5,
                                    child: Icon(
                                      hasFilters
                                          ? Icons.search_off
                                          : Icons.restaurant_menu,
                                      size: 80.sp,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                    ),
                                  ),
                                  24.verticalSpace,
                                ],
                                Text(
                                  hasFilters
                                      ? StringConst.noRecipesFound
                                      : StringConst.searchToGetStarted,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
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
                    return KeyboardVisibilityBuilder(
                      builder: (context, isKeyboardVisible) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (!isKeyboardVisible) ...[
                                Opacity(
                                  opacity: 0.5,
                                  child: Icon(
                                    Icons.restaurant_menu,
                                    size: 80.sp,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                  ),
                                ),
                                24.verticalSpace,
                              ],
                              const Text(
                                StringConst.searchToGetStarted,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
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
