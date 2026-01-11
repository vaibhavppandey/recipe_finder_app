import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_finder_app/core/const/str.dart';
import 'package:recipe_finder_app/data/enum/sort_option.dart';
import 'package:recipe_finder_app/data/model/area.dart';
import 'package:recipe_finder_app/data/model/category.dart';
import 'package:recipe_finder_app/data/model/recipe.dart';
import 'package:recipe_finder_app/presentation/bloc/recipe_list/recipe_list_bloc.dart';

import '../../test_helpers/mocks.dart';
import '../../test_helpers/test_data.dart';

void main() {
  late RecipeListBloc bloc;
  late MockRecipeRepo mockRepo;

  setUp(() {
    mockRepo = MockRecipeRepo();
    bloc = RecipeListBloc(repo: mockRepo);
  });

  tearDown(() {
    bloc.close();
  });

  group('RecipeListBloc -', () {
    group('SearchRecipesEvent', () {
      blocTest<RecipeListBloc, RecipeListState>(
        'emits [Loading, Loaded] when search is successful',
        build: () {
          when(
            () => mockRepo.searchMealByName('pasta'),
          ).thenAnswer((_) async => [sampleRecipe]);
          when(() => mockRepo.getCategories()).thenAnswer((_) async => {});
          when(() => mockRepo.getAreas()).thenAnswer((_) async => {});
          when(() => mockRepo.categories).thenReturn([]);
          when(() => mockRepo.areas).thenReturn([]);
          return bloc;
        },
        act: (bloc) => bloc.add(const SearchRecipesEvent('pasta')),
        expect: () => [
          const RecipeListLoading(isGridView: true, lastSearchQuery: 'pasta'),
          RecipeListLoaded(
            recipes: [sampleRecipe],
            categories: const [],
            areas: const [],
            isGridView: true,
            lastSearchQuery: 'pasta',
          ),
        ],
        verify: (_) {
          verify(() => mockRepo.searchMealByName('pasta')).called(1);
          verify(() => mockRepo.getCategories()).called(1);
          verify(() => mockRepo.getAreas()).called(1);
        },
      );

      blocTest<RecipeListBloc, RecipeListState>(
        'emits [Loading, Error] when repository throws exception',
        build: () {
          when(
            () => mockRepo.searchMealByName('error'),
          ).thenThrow(Exception('Network error'));
          return bloc;
        },
        act: (bloc) => bloc.add(const SearchRecipesEvent('error')),
        expect: () => [
          const RecipeListLoading(isGridView: true, lastSearchQuery: 'error'),
          const RecipeListError(
            'Exception: Network error',
            isGridView: true,
            lastSearchQuery: 'error',
          ),
        ],
      );

      blocTest<RecipeListBloc, RecipeListState>(
        'preserves filters when searching',
        build: () {
          when(
            () => mockRepo.searchMealByName(any()),
          ).thenAnswer((_) async => [sampleRecipe]);
          when(() => mockRepo.getCategories()).thenAnswer((_) async => {});
          when(() => mockRepo.getAreas()).thenAnswer((_) async => {});
          when(() => mockRepo.categories).thenReturn([]);
          when(() => mockRepo.areas).thenReturn([]);
          return bloc;
        },
        seed: () => RecipeListLoaded(
          recipes: [sampleRecipe],
          selectedCategory: 'Vegetarian',
          selectedArea: 'Italian',
        ),
        act: (bloc) => bloc.add(const SearchRecipesEvent('pasta')),
        verify: (bloc) {
          final state = bloc.state as RecipeListLoaded;
          expect(state.selectedCategory, 'Vegetarian');
          expect(state.selectedArea, 'Italian');
        },
      );
    });

    group('FilterByCategoryEvent', () {
      final vegetarianRecipe = Recipe.fromJson(sampleRecipeJson);
      final chickenRecipe = Recipe.fromJson(sampleRecipe2Json);
      final allRecipes = [vegetarianRecipe, chickenRecipe];
      final categories = [
        Category(id: '1', name: 'Vegetarian', thumb: ''),
        Category(id: '2', name: 'Chicken', thumb: ''),
      ];

      blocTest<RecipeListBloc, RecipeListState>(
        'filters recipes by selected category correctly',
        build: () {
          when(() => mockRepo.recipes).thenReturn(allRecipes);
          return bloc;
        },
        seed: () =>
            RecipeListLoaded(recipes: allRecipes, categories: categories),
        act: (bloc) => bloc.add(const FilterByCategoryEvent('Vegetarian')),
        verify: (bloc) {
          final state = bloc.state as RecipeListLoaded;
          expect(state.selectedCategory, 'Vegetarian');
          expect(state.recipes.length, 1);
          expect(state.recipes[0].category, 'Vegetarian');
        },
      );

      blocTest<RecipeListBloc, RecipeListState>(
        'clears category filter when null is passed',
        build: () {
          when(() => mockRepo.recipes).thenReturn(allRecipes);
          return bloc;
        },
        seed: () => RecipeListLoaded(
          recipes: [vegetarianRecipe],
          categories: categories,
          selectedCategory: 'Vegetarian',
          activeFilterCount: 1,
        ),
        act: (bloc) => bloc.add(const FilterByCategoryEvent(null)),
        verify: (bloc) {
          final state = bloc.state as RecipeListLoaded;
          expect(state.selectedCategory, isNull);
          expect(state.recipes.length, 2); // Should show all recipes
          expect(state.activeFilterCount, 0);
        },
      );
    });

    group('FilterByAreaEvent', () {
      final italianRecipe = Recipe.fromJson(sampleRecipeJson);
      final japaneseRecipe = Recipe.fromJson(sampleRecipe2Json);
      final allRecipes = [italianRecipe, japaneseRecipe];
      final areas = [const Area(str: 'Italian'), const Area(str: 'Japanese')];

      blocTest<RecipeListBloc, RecipeListState>(
        'filters recipes by selected area correctly',
        build: () {
          when(() => mockRepo.recipes).thenReturn(allRecipes);
          return bloc;
        },
        seed: () => RecipeListLoaded(recipes: allRecipes, areas: areas),
        act: (bloc) => bloc.add(const FilterByAreaEvent('Italian')),
        verify: (bloc) {
          final state = bloc.state as RecipeListLoaded;
          expect(state.selectedArea, 'Italian');
          expect(state.recipes.length, 1);
          expect(state.recipes[0].area, 'Italian');
        },
      );
    });

    group('ClearFiltersEvent', () {
      blocTest<RecipeListBloc, RecipeListState>(
        'clears all filters and resets activeFilterCount',
        build: () {
          when(() => mockRepo.recipes).thenReturn([sampleRecipe]);
          return bloc;
        },
        seed: () => RecipeListLoaded(
          recipes: [sampleRecipe],
          selectedCategory: 'Vegetarian',
          selectedArea: 'Italian',
          activeFilterCount: 2,
        ),
        act: (bloc) => bloc.add(const ClearFiltersEvent()),
        verify: (bloc) {
          final state = bloc.state as RecipeListLoaded;
          expect(state.selectedCategory, isNull);
          expect(state.selectedArea, isNull);
          expect(state.activeFilterCount, 0);
        },
      );
    });

    group('SortRecipesEvent', () {
      final recipeA = Recipe.fromJson({
        ...sampleRecipeJson,
        'strMeal': 'Apple Pie',
      });
      final recipeZ = Recipe.fromJson({
        ...sampleRecipe2Json,
        'strMeal': 'Zebra Cake',
      });

      blocTest<RecipeListBloc, RecipeListState>(
        'sorts recipes by name A-Z',
        build: () => bloc,
        seed: () => RecipeListLoaded(recipes: [recipeZ, recipeA]),
        act: (bloc) => bloc.add(const SortRecipesEvent(SortOption.nameAsc)),
        verify: (bloc) {
          final state = bloc.state as RecipeListLoaded;
          expect(state.sortOption, SortOption.nameAsc);
          expect(state.recipes[0].meal, 'Apple Pie');
          expect(state.recipes[1].meal, 'Zebra Cake');
        },
      );

      blocTest<RecipeListBloc, RecipeListState>(
        'sorts recipes by name Z-A',
        build: () => bloc,
        seed: () => RecipeListLoaded(recipes: [recipeA, recipeZ]),
        act: (bloc) => bloc.add(const SortRecipesEvent(SortOption.nameDesc)),
        verify: (bloc) {
          final state = bloc.state as RecipeListLoaded;
          expect(state.sortOption, SortOption.nameDesc);
          expect(state.recipes[0].meal, 'Zebra Cake');
          expect(state.recipes[1].meal, 'Apple Pie');
        },
      );
    });

    group('LoadInitialDataEvent', () {
      blocTest<RecipeListBloc, RecipeListState>(
        'loads categories and areas then emits empty state',
        build: () {
          when(() => mockRepo.getCategories()).thenAnswer((_) async => {});
          when(() => mockRepo.getAreas()).thenAnswer((_) async => {});
          return bloc;
        },
        act: (bloc) => bloc.add(const LoadInitialDataEvent()),
        expect: () => [const RecipeListEmpty(StringConst.searchToGetStarted)],
        verify: (_) {
          verify(() => mockRepo.getCategories()).called(1);
          verify(() => mockRepo.getAreas()).called(1);
        },
      );
    });

    group('RefreshSearchEvent', () {
      blocTest<RecipeListBloc, RecipeListState>(
        'triggers new search with last query',
        build: () {
          when(
            () => mockRepo.searchMealByName('pasta'),
          ).thenAnswer((_) async => [sampleRecipe]);
          when(() => mockRepo.getCategories()).thenAnswer((_) async => {});
          when(() => mockRepo.getAreas()).thenAnswer((_) async => {});
          when(() => mockRepo.categories).thenReturn([]);
          when(() => mockRepo.areas).thenReturn([]);
          return bloc;
        },
        seed: () => const RecipeListEmpty('test', lastSearchQuery: 'pasta'),
        act: (bloc) => bloc.add(const RefreshSearchEvent()),
        expect: () => [
          const RecipeListLoading(isGridView: true, lastSearchQuery: 'pasta'),
          RecipeListLoaded(
            recipes: [sampleRecipe],
            categories: const [],
            areas: const [],
            lastSearchQuery: 'pasta',
          ),
        ],
      );
    });
  });
}
