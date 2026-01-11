import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/data/model/recipe.dart';
import 'package:recipe_finder_app/presentation/page/recipe_detail.dart';
import 'package:recipe_finder_app/presentation/widget/common/favorite_icon_button.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class RecipeGridCard extends StatefulWidget {
  final Recipe recipe;

  const RecipeGridCard({super.key, required this.recipe});

  @override
  State<RecipeGridCard> createState() => _RecipeGridCardState();
}

class _RecipeGridCardState extends State<RecipeGridCard> {
  void _navigateToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RecipeDetailPage(recipeId: widget.recipe.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: colorScheme.outlineVariant, width: 1.w),
      ),
      child: InkWell(
        onTap: () => _navigateToDetail(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'recipe-${widget.recipe.id}',
                    child: widget.recipe.mealThumb.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: widget.recipe.mealThumb,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer(
                              duration: const Duration(seconds: 2),
                              interval: const Duration(seconds: 1),
                              color: Colors.grey[300]!,
                              colorOpacity: 0.3,
                              child: Container(color: Colors.grey[300]),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: colorScheme.surfaceContainerHighest,
                              child: Icon(
                                Icons.restaurant,
                                size: 60.sp,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          )
                        : Container(
                            color: colorScheme.surfaceContainerHighest,
                            child: Icon(
                              Icons.restaurant,
                              size: 60.sp,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                  ),
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: FavoriteIconButton(
                      recipe: widget.recipe,
                      iconSize: 20,
                      minWidth: 36,
                      minHeight: 36,
                      withBackground: true,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: REdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.recipe.meal,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      '${widget.recipe.category} • ${widget.recipe.area}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
