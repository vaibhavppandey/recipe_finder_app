import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/presentation/bloc/recipe_list/recipe_list_bloc.dart';
import 'package:recipe_finder_app/presentation/widget/filter/area_filter_section.dart';
import 'package:recipe_finder_app/presentation/widget/filter/bottom_sheet_handle.dart';
import 'package:recipe_finder_app/presentation/widget/filter/category_filter_section.dart';
import 'package:recipe_finder_app/presentation/widget/filter/sort_section.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<RecipeListBloc, RecipeListState>(
      builder: (context, state) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                const BottomSheetHandle(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Filters & Sort', style: textTheme.titleLarge),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: REdgeInsets.all(16),
                    children: [
                      SortSection(state: state),
                      24.verticalSpace,
                      CategoryFilterSection(state: state),
                      24.verticalSpace,
                      AreaFilterSection(state: state),
                    ],
                  ),
                ),
                Container(
                  padding: REdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10.r,
                        offset: Offset(0, -2.h),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            context.read<RecipeListBloc>().add(
                              ClearFiltersEvent(),
                            );
                          },
                          child: const Text('Clear All'),
                        ),
                      ),
                      16.horizontalSpace,
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Apply'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
