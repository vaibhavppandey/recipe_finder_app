import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/data/model/recipe.dart';

class RecipeGridCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeGridCard({super.key, required this.recipe});

  void _navigateToDetail(BuildContext context) {
    // TODO: Navigate to recipe detail page
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
                    tag: 'recipe-${recipe.id}',
                    child: recipe.mealThumb.isNotEmpty
                        ? Image.network(
                            recipe.mealThumb,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  color: colorScheme.surfaceVariant,
                                  child: Icon(
                                    Icons.restaurant,
                                    size: 60.sp,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                          )
                        : Container(
                            color: colorScheme.surfaceVariant,
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
                    child: _buildFavoriteButton(colorScheme),
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
                      recipe.meal,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      '${recipe.category} • ${recipe.area}',
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

  Widget _buildFavoriteButton(ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface.withOpacity(0.9),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(
          Icons.favorite_border,
          size: 20.sp,
          color: colorScheme.error,
        ),
        onPressed: () {
          // TODO: Add to favorites
        },
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(minWidth: 36.w, minHeight: 36.w),
      ),
    );
  }
}
