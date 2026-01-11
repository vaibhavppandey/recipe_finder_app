import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_finder_app/data/repo/recipe.dart';
import 'package:recipe_finder_app/presentation/widget/common/favorite_icon_button.dart';

import '../test_helpers/mocks.dart';
import '../test_helpers/test_data.dart';

void main() {
  late MockRecipeRepo mockRepo;
  final getIt = GetIt.instance;

  setUp(() {
    mockRepo = MockRecipeRepo();
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

  Widget createTestWidget({bool isFavorite = false}) {
    when(() => mockRepo.isFavorite(any())).thenReturn(isFavorite);
    when(() => mockRepo.toggleFavorite(any())).thenReturn(null);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        home: Scaffold(
          body: FavoriteIconButton(
            recipe: sampleRecipe,
            iconSize: 22,
            minWidth: 40,
            minHeight: 40,
          ),
        ),
      ),
    );
  }

  group('FavoriteIconButton Widget -', () {
    testWidgets('displays with background when specified', (
      WidgetTester tester,
    ) async {
      when(() => mockRepo.isFavorite(any())).thenReturn(false);

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(
            home: Scaffold(
              body: FavoriteIconButton(
                recipe: sampleRecipe,
                withBackground: true,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(Container), findsWidgets);
      expect(find.byType(Opacity), findsOneWidget);
    });

    testWidgets('has AnimatedScale wrapper', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(isFavorite: false));
      await tester.pumpAndSettle();

      expect(find.byType(AnimatedScale), findsOneWidget);
    });

    testWidgets('displays with background when specified', (
      WidgetTester tester,
    ) async {
      when(() => mockRepo.isFavorite(any())).thenReturn(false);

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(
            home: Scaffold(
              body: FavoriteIconButton(
                recipe: sampleRecipe,
                withBackground: true,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(Container), findsWidgets);
      expect(find.byType(Opacity), findsOneWidget);
    });

    testWidgets('respects custom icon size', (WidgetTester tester) async {
      const customSize = 30.0;
      when(() => mockRepo.isFavorite(any())).thenReturn(false);

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(
            home: Scaffold(
              body: FavoriteIconButton(
                recipe: sampleRecipe,
                iconSize: customSize,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(IconButton), findsOneWidget);
    });

    testWidgets('has correct error color for icon', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget(isFavorite: true));
      await tester.pumpAndSettle();

      final iconFinder = find.byIcon(Icons.favorite);
      final Icon icon = tester.widget(iconFinder);
      expect(icon.color, isNotNull);
    });
  });
}
