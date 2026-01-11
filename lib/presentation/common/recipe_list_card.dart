import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/core/di/injection.dart';
import 'package:recipe_finder_app/data/model/recipe.dart';
import 'package:recipe_finder_app/data/repo/recipe.dart';
import 'package:recipe_finder_app/presentation/page/recipe_detail.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class RecipeListCard extends StatefulWidget {
  final Recipe recipe;

  const RecipeListCard({super.key, required this.recipe});

  @override
  State<RecipeListCard> createState() => _RecipeListCardState();
}

class _RecipeListCardState extends State<RecipeListCard> {
  late final RecipeRepo _repo;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _repo = getIt<RecipeRepo>();
    _isFavorite = _repo.isFavorite(widget.recipe.id);
  }

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
      margin: EdgeInsets.only(bottom: 12.h),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: colorScheme.outlineVariant, width: 1.w),
      ),
      child: InkWell(
        onTap: () => _navigateToDetail(context),
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: REdgeInsets.all(12),
          child: Row(
            children: [
              Hero(
                tag: 'recipe-${widget.recipe.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: widget.recipe.mealThumb.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: widget.recipe.mealThumb,
                          width: 100.w,
                          height: 100.w,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer(
                            color: Colors.white,
                            child: Container(
                              width: 100.w,
                              height: 100.w,
                              color: colorScheme.surfaceContainerHighest,
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 100.w,
                            height: 100.w,
                            color: colorScheme.surfaceContainerHighest,
                            child: Icon(
                              Icons.restaurant,
                              size: 40.sp,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        )
                      : Container(
                          width: 100.w,
                          height: 100.w,
                          color: colorScheme.surfaceContainerHighest,
                          child: Icon(
                            Icons.restaurant,
                            size: 40.sp,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.recipe.meal,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    8.verticalSpace,
                    Row(
                      children: [
                        Icon(
                          Icons.category_outlined,
                          size: 16.sp,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            widget.recipe.category,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                    4.verticalSpace,
                    Row(
                      children: [
                        Icon(
                          Icons.public,
                          size: 16.sp,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            widget.recipe.area,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              8.horizontalSpace,
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildFavoriteButton(colorScheme),
                  20.verticalSpace,
                  Icon(
                    Icons.chevron_right,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteButton(ColorScheme colorScheme) {
    return IconButton(
      icon: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
        size: 22.sp,
        color: colorScheme.error,
      ),
      onPressed: () {
        _repo.toggleFavorite(widget.recipe);
        setState(() {
          _isFavorite = _repo.isFavorite(widget.recipe.id);
        });
      },
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(minWidth: 40.w, minHeight: 40.w),
    );
  }
}
