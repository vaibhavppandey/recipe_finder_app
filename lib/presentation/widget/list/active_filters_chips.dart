import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/core/const/str.dart';
import 'package:recipe_finder_app/presentation/bloc/recipe_list/recipe_list_bloc.dart';

class ActiveFiltersChips extends StatelessWidget {
  const ActiveFiltersChips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeListBloc, RecipeListState>(
      builder: (context, state) {
        if (state is! RecipeListLoaded) return const SizedBox();

        final hasFilters =
            state.selectedCategory != null || state.selectedArea != null;

        if (!hasFilters) return const SizedBox();

        return Container(
          height: 50.h,
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              if (state.selectedCategory != null)
                Chip(
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.secondaryContainer,
                  deleteIconColor: Theme.of(
                    context,
                  ).colorScheme.onSecondaryContainer,
                  label: Text(state.selectedCategory!),
                  onDeleted: () {
                    context.read<RecipeListBloc>().add(
                      FilterByCategoryEvent(null),
                    );
                  },
                ),
              8.horizontalSpace,
              if (state.selectedArea != null)
                Chip(
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.secondaryContainer,
                  deleteIconColor: Theme.of(
                    context,
                  ).colorScheme.onSecondaryContainer,
                  label: Text(state.selectedArea!),
                  onDeleted: () {
                    context.read<RecipeListBloc>().add(FilterByAreaEvent(null));
                  },
                ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  context.read<RecipeListBloc>().add(ClearFiltersEvent());
                },
                child: const Text(StringConst.clearAll),
              ),
            ],
          ),
        );
      },
    );
  }
}
