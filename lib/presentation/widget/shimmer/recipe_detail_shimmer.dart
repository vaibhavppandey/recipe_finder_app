import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class RecipeDetailShimmer extends StatelessWidget {
  const RecipeDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Shimmer(
        color: colorScheme.surfaceContainerHighest,
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            // Image Header Shimmer
            SliverAppBar(
              expandedHeight: 300.h,
              pinned: true,
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: colorScheme.surfaceContainerHighest,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: REdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Recipe Header Shimmer
                    _buildShimmerContainer(
                      height: 32.h,
                      width: double.infinity,
                      borderRadius: 8.r,
                      color: colorScheme,
                    ),
                    12.verticalSpace,
                    Row(
                      children: [
                        _buildShimmerContainer(
                          height: 32.h,
                          width: 100.w,
                          borderRadius: 16.r,
                          color: colorScheme,
                        ),
                        12.horizontalSpace,
                        _buildShimmerContainer(
                          height: 32.h,
                          width: 100.w,
                          borderRadius: 16.r,
                          color: colorScheme,
                        ),
                      ],
                    ),
                    24.verticalSpace,

                    // Ingredients Section Shimmer
                    _buildShimmerContainer(
                      height: 24.h,
                      width: 150.w,
                      borderRadius: 8.r,
                      color: colorScheme,
                    ),
                    16.verticalSpace,
                    ...List.generate(
                      6,
                      (index) => Padding(
                        padding: REdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            _buildShimmerContainer(
                              height: 6.h,
                              width: 6.w,
                              isCircle: true,
                              color: colorScheme,
                            ),
                            12.horizontalSpace,
                            Expanded(
                              child: _buildShimmerContainer(
                                height: 16.h,
                                borderRadius: 8.r,
                                color: colorScheme,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    24.verticalSpace,

                    // Instructions Section Shimmer
                    _buildShimmerContainer(
                      height: 24.h,
                      width: 150.w,
                      borderRadius: 8.r,
                      color: colorScheme,
                    ),
                    16.verticalSpace,
                    ...List.generate(
                      4,
                      (index) => Padding(
                        padding: REdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildShimmerContainer(
                              height: 16.h,
                              width: double.infinity,
                              borderRadius: 8.r,
                              color: colorScheme,
                            ),
                            8.verticalSpace,
                            _buildShimmerContainer(
                              height: 16.h,
                              width: 250.w,
                              borderRadius: 8.r,
                              color: colorScheme,
                            ),
                          ],
                        ),
                      ),
                    ),
                    24.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerContainer({
    required double height,
    double? width,
    double borderRadius = 0,
    bool isCircle = false,
    required ColorScheme color,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color.surfaceContainerHighest,
        borderRadius: isCircle ? null : BorderRadius.circular(borderRadius),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      ),
    );
  }
}
