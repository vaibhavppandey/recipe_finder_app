import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_finder_app/core/const/str.dart';
import 'package:recipe_finder_app/presentation/bloc/fav_recipe/fav_recipe_bloc.dart';

import '../../test_helpers/mocks.dart';
import '../../test_helpers/test_data.dart';

void main() {
  late FavRecipeBloc bloc;
  late MockRecipeRepo mockRepo;

  setUp(() {
    mockRepo = MockRecipeRepo();
    bloc = FavRecipeBloc(mockRepo);
  });

  tearDown(() {
    bloc.close();
  });

  setUpAll(() {
    registerFallbackValue(sampleRecipe);
  });

  group('FavRecipeBloc -', () {
    group('LoadFavoritesEvent', () {
      blocTest<FavRecipeBloc, FavRecipeState>(
        'emits [Loading, Loaded] when favorites are loaded successfully',
        build: () {
          when(
            () => mockRepo.getAllFavorites(),
          ).thenReturn([sampleRecipe, sampleRecipe2]);
          return bloc;
        },
        act: (bloc) => bloc.add(LoadFavoritesEvent()),
        expect: () => [
          FavRecipeLoading(),
          FavRecipeLoaded([sampleRecipe, sampleRecipe2]),
        ],
        verify: (_) {
          verify(() => mockRepo.getAllFavorites()).called(1);
        },
      );
    });

    group('ToggleFavoriteEvent', () {
      blocTest<FavRecipeBloc, FavRecipeState>(
        'toggles favorite status and reloads list',
        build: () {
          when(() => mockRepo.toggleFavorite(any())).thenReturn(null);
          when(() => mockRepo.getAllFavorites()).thenReturn([sampleRecipe]);
          return bloc;
        },
        act: (bloc) => bloc.add(ToggleFavoriteEvent(sampleRecipe)),
        expect: () => [
          FavRecipeLoading(),
          FavRecipeLoaded([sampleRecipe]),
        ],
        verify: (_) {
          verify(() => mockRepo.toggleFavorite(sampleRecipe)).called(1);
          verify(() => mockRepo.getAllFavorites()).called(1);
        },
      );

      blocTest<FavRecipeBloc, FavRecipeState>(
        'emits Error when toggle fails',
        build: () {
          when(
            () => mockRepo.toggleFavorite(any()),
          ).thenThrow(Exception('Toggle failed'));
          return bloc;
        },
        act: (bloc) => bloc.add(ToggleFavoriteEvent(sampleRecipe)),
        expect: () => [
          FavRecipeError(
            StringConst.failedToToggleFavorite('Exception: Toggle failed'),
          ),
        ],
      );
    });

    group('State Transitions', () {
      blocTest<FavRecipeBloc, FavRecipeState>(
        'maintains state sequence through multiple operations',
        build: () {
          when(
            () => mockRepo.getAllFavorites(),
          ).thenReturn([sampleRecipe, sampleRecipe2]);
          when(() => mockRepo.removeFromFavorites('52771')).thenAnswer((_) {
            when(() => mockRepo.getAllFavorites()).thenReturn([sampleRecipe2]);
          });
          return bloc;
        },
        act: (bloc) {
          bloc.add(LoadFavoritesEvent());
          bloc.add(const RemoveFromFavoritesEvent('52771'));
        },
        skip: 2, // Skip the first load states since the mock changes behavior
        expect: () => [
          FavRecipeLoading(),
          FavRecipeLoaded([sampleRecipe2]),
        ],
      );
    });
  });
}
