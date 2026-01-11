import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/core/const/str.dart';

class FavoritesEmptyState extends StatelessWidget {
  final String message;

  const FavoritesEmptyState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: 0.5,
            child: Icon(
              Icons.favorite_border,
              size: 80.sp,
              color: colorScheme.secondary,
            ),
          ),
          24.verticalSpace,
          Text(
            message,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          24.verticalSpace,
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(StringConst.browseRecipes),
          ),
        ],
      ),
    );
  }
}
