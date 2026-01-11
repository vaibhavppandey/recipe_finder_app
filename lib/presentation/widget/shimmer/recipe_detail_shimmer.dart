import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:recipe_finder_app/presentation/widget/shimmer/shimmer_box.dart';

class RecipeDetailShimmer extends StatelessWidget {
  const RecipeDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
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
                background: Shimmer(
                  duration: const Duration(seconds: 2),
                  interval: const Duration(seconds: 1),
                  color: Colors.grey[300]!,
                  colorOpacity: 0.3,
                  child: Container(color: Colors.grey[300]),
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
                    ShimmerBox(
                      height: 32.h,
                      width: double.infinity,
                      borderRadius: 8.r,
                      colorScheme: colorScheme,
                    ),
                    12.verticalSpace,
                    Row(
                      children: [
                        ShimmerBox(
                          height: 32.h,
                          width: 100.w,
                          borderRadius: 16.r,
                          colorScheme: colorScheme,
                        ),
                        12.horizontalSpace,
                        ShimmerBox(
                          height: 32.h,
                          width: 100.w,
                          borderRadius: 16.r,
                          colorScheme: colorScheme,
                        ),
                      ],
                    ),
                    24.verticalSpace,

                    // Ingredients Section Shimmer
                    ShimmerBox(
                      height: 24.h,
                      width: 150.w,
                      borderRadius: 8.r,
                      colorScheme: colorScheme,
                    ),
                    16.verticalSpace,
                    ...List.generate(
                      6,
                      (index) => Padding(
                        padding: REdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            ShimmerBox(
                              height: 6.h,
                              width: 6.w,
                              isCircle: true,
                              colorScheme: colorScheme,
                            ),
                            12.horizontalSpace,
                            Expanded(
                              child: ShimmerBox(
                                height: 16.h,
                                borderRadius: 8.r,
                                colorScheme: colorScheme,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    24.verticalSpace,

                    // Instructions Section Shimmer
                    ShimmerBox(
                      height: 24.h,
                      width: 150.w,
                      borderRadius: 8.r,
                      colorScheme: colorScheme,
                    ),
                    16.verticalSpace,
                    ...List.generate(
                      4,
                      (index) => Padding(
                        padding: REdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerBox(
                              height: 16.h,
                              width: double.infinity,
                              borderRadius: 8.r,
                              colorScheme: colorScheme,
                            ),
                            8.verticalSpace,
                            ShimmerBox(
                              height: 16.h,
                              width: 250.w,
                              borderRadius: 8.r,
                              colorScheme: colorScheme,
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
}
