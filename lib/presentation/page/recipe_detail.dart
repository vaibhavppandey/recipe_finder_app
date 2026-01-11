import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/data/model/recipe.dart';
import 'package:recipe_finder_app/presentation/bloc/recipe_detail/recipe_detail_bloc.dart';
import 'package:recipe_finder_app/presentation/widget/detail/fullscreen_image_view.dart';
import 'package:recipe_finder_app/presentation/widget/detail/recipe_header.dart';
import 'package:recipe_finder_app/presentation/widget/detail/recipe_image_header.dart';
import 'package:recipe_finder_app/presentation/widget/detail/recipe_ingredients.dart';
import 'package:recipe_finder_app/presentation/widget/detail/recipe_instructions.dart';
import 'package:recipe_finder_app/presentation/widget/detail/recipe_youtube_player.dart';
import 'package:recipe_finder_app/presentation/widget/shimmer/recipe_detail_shimmer.dart';

class RecipeDetailPage extends StatefulWidget {
  final String recipeId;

  const RecipeDetailPage({super.key, required this.recipeId});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  bool _isImageNavigationInProgress = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<RecipeDetailBloc>().add(
        LoadRecipeDetailEvent(widget.recipeId),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: BlocBuilder<RecipeDetailBloc, RecipeDetailState>(
          builder: (context, state) {
            return switch (state) {
              RecipeDetailInitial() => const RecipeDetailShimmer(),
              RecipeDetailLoading() => const RecipeDetailShimmer(),
              RecipeDetailLoaded() => _buildDetailContent(context, state),
              RecipeDetailError() => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64.sp, color: Colors.red),
                    16.verticalSpace,
                    Text(state.message, textAlign: TextAlign.center),
                    24.verticalSpace,
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<RecipeDetailBloc>().add(
                          LoadRecipeDetailEvent(widget.recipeId),
                        );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
              _ => const RecipeDetailShimmer(),
            };
          },
        ),
      ),
    );
  }

  Widget _buildDetailContent(BuildContext context, RecipeDetailLoaded state) {
    final recipe = state.recipe;

    return CustomScrollView(
      slivers: [
        RecipeImageHeader(
          recipe: recipe,
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
    if (_isImageNavigationInProgress) return;

    _isImageNavigationInProgress = true;

    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (_) => FullscreenImageView(recipe: recipe),
          ),
        )
        .then((_) {
          // Reset the flag when navigation completes
          _isImageNavigationInProgress = false;
        });
  }
}
