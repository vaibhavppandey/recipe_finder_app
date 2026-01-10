import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/data/model/recipe.dart';
import 'package:widget_zoom/widget_zoom.dart';

class FullscreenImageView extends StatelessWidget {
  final Recipe recipe;

  const FullscreenImageView({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          Center(
            child: WidgetZoom(
              heroAnimationTag: 'recipe-${recipe.id}',
              zoomWidget: CachedNetworkImage(
                imageUrl: recipe.mealThumb,
                fit: BoxFit.contain,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, color: colorScheme.error),
              ),
            ),
          ),
          SafeArea(
            child: Positioned(
              top: 16.h,
              right: 16.w,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: colorScheme.onSurface,
                  size: 32.sp,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
