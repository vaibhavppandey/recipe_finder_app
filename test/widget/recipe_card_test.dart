import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_finder_app/data/repo/recipe.dart';
import 'package:recipe_finder_app/presentation/common/recipe_grid_card.dart';

import '../test_helpers/mocks.dart';
import '../test_helpers/test_data.dart';

void main() {
  late MockRecipeRepo mockRepo;
  final getIt = GetIt.instance;

  setUp(() {
    mockRepo = MockRecipeRepo();
    when(() => mockRepo.isFavorite(any())).thenReturn(false);
    when(() => mockRepo.toggleFavorite(any())).thenReturn(null);

    if (!getIt.isRegistered<RecipeRepo>()) {
      getIt.registerSingleton<RecipeRepo>(mockRepo);
    }
  });

  tearDown(() {
    getIt.reset();
  });

  setUpAll(() {
    registerFallbackValue(sampleRecipe);
  });

  group('RecipeGridCard Widget -', () {
    testWidgets('has Hero widget with correct tag', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(
            home: Scaffold(body: RecipeGridCard(recipe: sampleRecipe)),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final heroFinder = find.byType(Hero);
      expect(heroFinder, findsOneWidget);

      final Hero heroWidget = tester.widget(heroFinder);
      expect(heroWidget.tag, 'recipe-52771');
    });
  });
}
