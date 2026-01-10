import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/data/model/recipe.dart';

class RecipeHeader extends StatelessWidget {
  final Recipe recipe;

  const RecipeHeader({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(recipe.meal, style: theme.textTheme.headlineSmall),
        12.verticalSpace,
        Row(
          children: [
            Icon(
              Icons.category_outlined,
              size: 18.sp,
              color: colorScheme.secondary,
            ),
            8.horizontalSpace,
            Text(recipe.category, style: theme.textTheme.bodyLarge),
            16.horizontalSpace,
            Icon(Icons.public, size: 18.sp, color: colorScheme.secondary),
            8.horizontalSpace,
            Text(recipe.area, style: theme.textTheme.bodyLarge),
          ],
        ),
        if (recipe.tags.isNotEmpty) ...[
          16.verticalSpace,
          Wrap(
            spacing: 8.w,
            children: recipe.tags
                .split(',')
                .map((tag) => Chip(label: Text(tag.trim())))
                .toList(),
          ),
        ],
      ],
    );
  }
}
