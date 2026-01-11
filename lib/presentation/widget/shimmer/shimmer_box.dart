import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerBox extends StatelessWidget {
  final double height;
  final double? width;
  final double borderRadius;
  final bool isCircle;
  final ColorScheme colorScheme;

  const ShimmerBox({
    super.key,
    required this.height,
    this.width,
    this.borderRadius = 0,
    this.isCircle = false,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(seconds: 2),
      interval: const Duration(seconds: 1),
      color: Colors.grey[300]!,
      colorOpacity: 0.3,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: isCircle ? null : BorderRadius.circular(borderRadius),
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }
}
