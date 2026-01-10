import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/data/model/recipe.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class RecipeImageHeader extends StatelessWidget {
  final Recipe recipe;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;
  final VoidCallback onImageTap;

  const RecipeImageHeader({
    super.key,
    required this.recipe,
    required this.isFavorite,
    required this.onFavoritePressed,
    required this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SliverAppBar(
      expandedHeight: 300.h,
      pinned: true,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        background: GestureDetector(
          onTap: onImageTap,
          child: Hero(
            tag: 'recipe-${recipe.id}',
            child: CachedNetworkImage(
              imageUrl: recipe.mealThumb,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer(
                color: Colors.white,
                child: Container(color: colorScheme.surfaceContainerHighest),
              ),
              errorWidget: (context, url, error) => Container(
                color: colorScheme.surfaceContainerHighest,
                child: Icon(
                  Icons.restaurant,
                  size: 80.sp,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ),
      ),
      actions: [
        Container(
          margin: REdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: colorScheme.surface.withOpacity(0.9),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: colorScheme.error,
            ),
            onPressed: onFavoritePressed,
          ),
        ),
      ],
    );
  }
}
