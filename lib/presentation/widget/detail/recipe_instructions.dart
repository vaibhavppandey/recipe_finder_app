import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/core/const/str.dart';

class RecipeInstructions extends StatelessWidget {
  final String instructions;

  const RecipeInstructions({super.key, required this.instructions});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (instructions.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    final steps = instructions.split('\n').where((step) {
      final trimmedStep = step.trim();
      return trimmedStep.isNotEmpty && !RegExp(r'^\d+$').hasMatch(trimmedStep);
    }).toList();

    if (steps.isEmpty) {
      return const SizedBox.shrink();
    }

    int stepNumber = 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringConst.instructions,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        12.verticalSpace,
        ...steps.map((stepText) {
          var step = stepText.trim();

          step = step
              .replaceFirst(
                RegExp(r'^step\s+\d+[:\s]*', caseSensitive: false),
                '',
              )
              .replaceFirst(RegExp(r'^\d+\.\s*'), '');

          if (step.isEmpty) {
            return const SizedBox.shrink();
          }

          return Padding(
            padding: REdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$stepNumber',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                12.horizontalSpace,
                Expanded(child: Text(step, style: theme.textTheme.bodyMedium)),
              ],
            ),
          );
        }),
      ],
    );
  }
}
