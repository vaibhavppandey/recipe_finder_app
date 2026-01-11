import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/core/di/service_locator.dart';
import 'package:recipe_finder_app/core/theme/theme.dart';
import 'package:recipe_finder_app/presentation/bloc/fav_recipe/fav_recipe_bloc.dart';
import 'package:recipe_finder_app/presentation/bloc/recipe_detail/recipe_detail_bloc.dart';
import 'package:recipe_finder_app/presentation/bloc/recipe_list/recipe_list_bloc.dart';
import 'package:recipe_finder_app/presentation/page/recipe_list.dart';

class RecipeFinderApp extends StatefulWidget {
  const RecipeFinderApp({super.key});

  @override
  State<RecipeFinderApp> createState() => _RecipeFinderAppState();
}

class _RecipeFinderAppState extends State<RecipeFinderApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit( // responsiveness ftw
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return KeyboardVisibilityProvider(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<RecipeListBloc>(
                create: (context) => getIt<RecipeListBloc>(),
              ),
              BlocProvider<RecipeDetailBloc>(
                create: (context) => getIt<RecipeDetailBloc>(),
              ),
              BlocProvider<FavRecipeBloc>(
                create: (context) => getIt<FavRecipeBloc>(),
              ),
            ],
            child: MaterialApp(
              title: 'Recipe Finder App',
              theme: buildAppTheme(context),
              home: const RecipeListPage(),
            ),
          ),
        );
      },
    );
  }
}
