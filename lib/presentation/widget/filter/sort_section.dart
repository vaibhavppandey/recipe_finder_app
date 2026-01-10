import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/data/enum/sort_option.dart';
import 'package:recipe_finder_app/presentation/bloc/recipe_list/recipe_list_bloc.dart';

class SortSection extends StatelessWidget {
  final RecipeListState state;

  const SortSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sort By',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        12.verticalSpace,
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            ChoiceChip(
              label: const Text('A-Z'),
              selected:
                  state is RecipeListLoaded &&
                  (state as RecipeListLoaded).sortOption == SortOption.nameAsc,
              onSelected: (selected) {
                if (selected) {
                  context.read<RecipeListBloc>().add(
                    SortRecipesEvent(SortOption.nameAsc),
                  );
                }
              },
            ),
            ChoiceChip(
              label: const Text('Z-A'),
              selected:
                  state is RecipeListLoaded &&
                  (state as RecipeListLoaded).sortOption == SortOption.nameDesc,
              onSelected: (selected) {
                if (selected) {
                  context.read<RecipeListBloc>().add(
                    SortRecipesEvent(SortOption.nameDesc),
                  );
                }
              },
            ),
            ChoiceChip(
              label: const Text('Category A-Z'),
              selected:
                  state is RecipeListLoaded &&
                  (state as RecipeListLoaded).sortOption ==
                      SortOption.categoryAsc,
              onSelected: (selected) {
                if (selected) {
                  context.read<RecipeListBloc>().add(
                    SortRecipesEvent(SortOption.categoryAsc),
                  );
                }
              },
            ),
            ChoiceChip(
              label: const Text('Category Z-A'),
              selected:
                  state is RecipeListLoaded &&
                  (state as RecipeListLoaded).sortOption ==
                      SortOption.categoryDesc,
              onSelected: (selected) {
                if (selected) {
                  context.read<RecipeListBloc>().add(
                    SortRecipesEvent(SortOption.categoryDesc),
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
