import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/presentation/bloc/recipe_list/recipe_list_bloc.dart';

class CategoryFilterSection extends StatelessWidget {
  final RecipeListState state;

  const CategoryFilterSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RecipeListBloc>();
    final categories = bloc.repo.categories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        12.verticalSpace,
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: categories.map((category) {
            final isSelected =
                state is RecipeListLoaded &&
                (state as RecipeListLoaded).selectedCategory == category.name;
            return FilterChip(
              label: Text(category.name),
              selected: isSelected,
              showCheckmark: false,
              onSelected: (selected) {
                context.read<RecipeListBloc>().add(
                  FilterByCategoryEvent(selected ? category.name : null),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
