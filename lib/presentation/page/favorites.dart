import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/core/const/str.dart';
import 'package:recipe_finder_app/presentation/bloc/fav_recipe/fav_recipe_bloc.dart';
import 'package:recipe_finder_app/presentation/bloc/recipe_list/recipe_list_bloc.dart';
import 'package:recipe_finder_app/presentation/widget/fav/favorite_recipe_card.dart';
import 'package:recipe_finder_app/presentation/widget/fav/favorites_empty_state.dart';
import 'package:recipe_finder_app/presentation/widget/shimmer/recipe_shimmer.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    context.read<FavRecipeBloc>().add(LoadFavoritesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(StringConst.favorites)),
      body: BlocBuilder<FavRecipeBloc, FavRecipeState>(
        builder: (context, state) {
          return switch (state) {
            FavRecipeLoading() => const RecipeShimmerList(),

            FavRecipeEmpty() => FavoritesEmptyState(message: state.message),

            FavRecipeError() => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${StringConst.error}: ${state.message}',
                    textAlign: TextAlign.center,
                  ),
                  16.verticalSpace,
                  ElevatedButton(
                    onPressed: () {
                      context.read<FavRecipeBloc>().add(LoadFavoritesEvent());
                    },
                    child: const Text(StringConst.retry),
                  ),
                ],
              ),
            ),

            FavRecipeLoaded() =>
              state.recipes.isEmpty
                  ? const FavoritesEmptyState(
                      message: StringConst.noFavoritesYet,
                    )
                  : ListView.builder(
                      padding: REdgeInsets.all(16),
                      itemCount: state.recipes.length,
                      itemBuilder: (context, index) {
                        final recipe = state.recipes[index];
                        return FavoriteRecipeCard(
                          recipe: recipe,
                          onRemove: () {
                            context.read<FavRecipeBloc>().add(
                              RemoveFromFavoritesEvent(recipe.id),
                            );
                            context.read<RecipeListBloc>().add(
                              const RefreshSearchEvent(),
                            );
                          },
                        );
                      },
                    ),

            _ => const FavoritesEmptyState(message: StringConst.noFavoritesYet),
          };
        },
      ),
    );
  }
}
