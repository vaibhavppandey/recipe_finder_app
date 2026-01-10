import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/core/di/injection.dart';
import 'package:recipe_finder_app/data/model/recipe.dart';
import 'package:recipe_finder_app/presentation/bloc/recipe_detail/recipe_detail_bloc.dart';
import 'package:recipe_finder_app/presentation/widget/detail/fullscreen_image_view.dart';
import 'package:recipe_finder_app/presentation/widget/detail/recipe_header.dart';
import 'package:recipe_finder_app/presentation/widget/detail/recipe_image_header.dart';
import 'package:recipe_finder_app/presentation/widget/detail/recipe_ingredients.dart';
import 'package:recipe_finder_app/presentation/widget/detail/recipe_instructions.dart';
import 'package:recipe_finder_app/presentation/widget/detail/recipe_youtube_player.dart';

class RecipeDetailPage extends StatelessWidget {
  final String recipeId;

  const RecipeDetailPage({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<RecipeDetailBloc>()..add(LoadRecipeDetailEvent(recipeId)),
      child: const _RecipeDetailView(),
    );
  }
}

class _RecipeDetailView extends StatelessWidget {
  const _RecipeDetailView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RecipeDetailBloc, RecipeDetailState>(
        builder: (context, state) {
          return switch (state) {
            RecipeDetailLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            RecipeDetailLoaded() => _buildDetailContent(context, state),
            RecipeDetailError() => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64.sp, color: Colors.red),
                  16.verticalSpace,
                  Text(state.message),
                ],
              ),
            ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }

  Widget _buildDetailContent(BuildContext context, RecipeDetailLoaded state) {
    final recipe = state.recipe;

    return CustomScrollView(
      slivers: [
        RecipeImageHeader(
          recipe: recipe,
          isFavorite: state.isFavorite,
          onFavoritePressed: () =>
              context.read<RecipeDetailBloc>().add(ToggleFavoriteEvent(recipe)),
          onImageTap: () => _showFullscreenImage(context, recipe),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: REdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RecipeHeader(recipe: recipe),
                24.verticalSpace,
                RecipeIngredients(recipe: recipe),
                24.verticalSpace,
                RecipeInstructions(instructions: recipe.instructions),
                if (recipe.youtube.isNotEmpty) ...[
                  24.verticalSpace,
                  RecipeYoutubePlayer(youtubeUrl: recipe.youtube),
                ],
                24.verticalSpace,
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showFullscreenImage(BuildContext context, Recipe recipe) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => FullscreenImageView(recipe: recipe)),
    );
  }
}
