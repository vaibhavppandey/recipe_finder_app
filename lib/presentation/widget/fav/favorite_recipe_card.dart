import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/core/const/str.dart';
import 'package:recipe_finder_app/core/theme/colors.dart';
import 'package:recipe_finder_app/data/model/recipe.dart';
import 'package:recipe_finder_app/presentation/page/recipe_detail.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class FavoriteRecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onRemove;

  const FavoriteRecipeCard({
    super.key,
    required this.recipe,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: REdgeInsets.only(bottom: 12),
      child: Dismissible(
        key: Key(recipe.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          // padding: REdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: colorScheme.error,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(Icons.delete, color: colorScheme.onError, size: 32.sp),
        ),
        confirmDismiss: (direction) async {
          return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(StringConst.removeFromFavorites),
              content: Text(StringConst.confirmRemoveFavorite(recipe.meal)),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text(StringConst.cancel),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text(StringConst.remove),
                ),
              ],
            ),
          );
        },
        onDismissed: (direction) {
          onRemove();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(StringConst.removedFromFavorites(recipe.meal)),
              duration: const Duration(seconds: 2),
            ),
          );
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailPage(recipeId: recipe.id),
                ),
              );
            },
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CachedNetworkImage(
                    imageUrl: recipe.mealThumb,
                    width: 120.w,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer(
                      duration: const Duration(seconds: 2),
                      interval: const Duration(seconds: 1),
                      color: RFColors.greyOutline,
                      colorOpacity: 0.3,
                      child: Container(color: Colors.grey[300]),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.restaurant,
                        size: 40.sp,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: REdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            recipe.meal,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          6.verticalSpace,
                          Row(
                            children: [
                              Icon(
                                Icons.category_outlined,
                                size: 14.sp,
                                color: colorScheme.secondary,
                              ),
                              4.horizontalSpace,
                              Expanded(
                                child: Text(
                                  recipe.category,
                                  style: textTheme.bodySmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          4.verticalSpace,
                          Row(
                            children: [
                              Icon(
                                Icons.public,
                                size: 14.sp,
                                color: colorScheme.secondary,
                              ),
                              4.horizontalSpace,
                              Expanded(
                                child: Text(
                                  recipe.area,
                                  style: textTheme.bodySmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          if (recipe.tags.isNotEmpty) ...[
                            4.verticalSpace,
                            Row(
                              children: [
                                Icon(
                                  Icons.local_offer_outlined,
                                  size: 14.sp,
                                  color: colorScheme.tertiary,
                                ),
                                4.horizontalSpace,
                                Expanded(
                                  child: Text(
                                    recipe.tags,
                                    style: textTheme.bodySmall?.copyWith(
                                      color: colorScheme.tertiary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
