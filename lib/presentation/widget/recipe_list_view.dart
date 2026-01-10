import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/data/model/recipe.dart';
import 'package:recipe_finder_app/presentation/common/recipe_list_card.dart';

class RecipeListView extends StatelessWidget {
  final List<Recipe> recipes;

  const RecipeListView({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const ValueKey('list'),
      padding: REdgeInsets.all(16),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return RecipeListCard(recipe: recipes[index]);
      },
    );
  }
}
