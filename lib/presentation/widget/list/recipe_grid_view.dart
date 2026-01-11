import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/data/model/recipe.dart';
import 'package:recipe_finder_app/presentation/common/recipe_grid_card.dart';

class RecipeGridView extends StatelessWidget {
  final List<Recipe> recipes;

  const RecipeGridView({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: const ValueKey('grid'),
      padding: REdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
      ),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return RecipeGridCard(recipe: recipes[index]);
      },
    );
  }
}
