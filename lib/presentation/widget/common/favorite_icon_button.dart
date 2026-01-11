import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/core/di/service_locator.dart';
import 'package:recipe_finder_app/data/model/recipe.dart';
import 'package:recipe_finder_app/data/repo/recipe.dart';

class FavoriteIconButton extends StatefulWidget {
  final Recipe recipe;
  final double iconSize;
  final double minWidth;
  final double minHeight;
  final bool withBackground;

  const FavoriteIconButton({
    super.key,
    required this.recipe,
    this.iconSize = 22,
    this.minWidth = 40,
    this.minHeight = 40,
    this.withBackground = false,
  });

  @override
  State<FavoriteIconButton> createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  late RecipeRepo _repo;
  late bool _isFavorite;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _repo = getIt<RecipeRepo>();
    _isFavorite = _repo.isFavorite(widget.recipe.id);
  }

  void _toggleFavorite() {
    _repo.toggleFavorite(widget.recipe);
    setState(() {
      _isFavorite = _repo.isFavorite(widget.recipe.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final iconButton = IconButton(
      icon: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
        size: widget.iconSize.sp,
        color: colorScheme.error,
      ),
      onPressed: _toggleFavorite,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(
        minWidth: widget.minWidth.w,
        minHeight: widget.minHeight.w,
      ),
    );

    final animatedButton = AnimatedScale(
      scale: _isFavorite ? 1.0 : 0.9,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutBack,
      child: widget.withBackground
          ? Opacity(
              opacity: 0.9,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  shape: BoxShape.circle,
                ),
                child: iconButton,
              ),
            )
          : iconButton,
    );

    return animatedButton;
  }
}
