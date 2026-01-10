import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/core/const/str.dart';
import 'package:recipe_finder_app/data/model/recipe.dart';

class RecipeIngredients extends StatelessWidget {
  final Recipe recipe;

  const RecipeIngredients({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ingredients = _getIngredients();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringConst.ingredients,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        12.verticalSpace,
        ...ingredients.map(
          (pair) => Padding(
            padding: REdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Icon(Icons.circle, size: 6.sp),
                12.horizontalSpace,
                Expanded(
                  child: Text(
                    '${pair.$2.trim()} ${pair.$1.trim()}',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<(String, String)> _getIngredients() {
    return [
      (recipe.ingredient1, recipe.measure1),
      (recipe.ingredient2, recipe.measure2),
      (recipe.ingredient3, recipe.measure3),
      (recipe.ingredient4, recipe.measure4),
      (recipe.ingredient5, recipe.measure5),
      (recipe.ingredient6, recipe.measure6),
      (recipe.ingredient7, recipe.measure7),
      (recipe.ingredient8, recipe.measure8),
      (recipe.ingredient9, recipe.measure9),
      (recipe.ingredient10, recipe.measure10),
      (recipe.ingredient11, recipe.measure11),
      (recipe.ingredient12, recipe.measure12),
      (recipe.ingredient13, recipe.measure13),
      (recipe.ingredient14, recipe.measure14),
      (recipe.ingredient15, recipe.measure15),
      (recipe.ingredient16, recipe.measure16),
      (recipe.ingredient17, recipe.measure17),
      (recipe.ingredient18, recipe.measure18),
      (recipe.ingredient19, recipe.measure19),
      (recipe.ingredient20, recipe.measure20),
    ].where((pair) => pair.$1.isNotEmpty && pair.$1.trim().isNotEmpty).toList();
  }
}
