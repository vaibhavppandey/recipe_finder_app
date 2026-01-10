import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/core/di/injection.dart';
import 'package:recipe_finder_app/core/theme/theme.dart';
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
    return ScreenUtilInit(
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
            ],
            child: MaterialApp(
              title: 'Recipe Finder',
              theme: buildAppTheme(context),
              home: const RecipeListPage(),
            ),
          ),
        );
      },
    );
  }
}
