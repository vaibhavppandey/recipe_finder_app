import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/presentation/bloc/recipe_list/recipe_list_bloc.dart';

class AreaFilterSection extends StatelessWidget {
  final RecipeListState state;

  const AreaFilterSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RecipeListBloc>();
    final areas = bloc.repo.areas;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cuisine Area',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        12.verticalSpace,
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: areas.map((area) {
            final isSelected =
                state is RecipeListLoaded &&
                (state as RecipeListLoaded).selectedArea == area.str;
            return FilterChip(
              label: Text(area.str),
              selected: isSelected,
              showCheckmark: false,
              onSelected: (selected) {
                context.read<RecipeListBloc>().add(
                  FilterByAreaEvent(selected ? area.str : null),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
