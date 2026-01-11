import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_finder_app/data/model/recipe.dart';

import '../../test_helpers/test_data.dart';

void main() {
  group('Recipe Model -', () {
    group('fromJson', () {
      test('should handle all 20 ingredients and measures correctly', () {
        final recipe = Recipe.fromJson(sampleRecipeJson);

        expect(recipe.ingredient1, 'penne rigate');
        expect(recipe.ingredient2, 'olive oil');
        expect(recipe.ingredient3, 'garlic');
        expect(recipe.ingredient8, 'Parmigiano-Reggiano');

        expect(recipe.ingredient9, '');
        expect(recipe.ingredient20, '');

        expect(recipe.measure1, '1 pound');
        expect(recipe.measure2, '1/4 cup');
        expect(recipe.measure9, '');
      });

      test('should handle null values as empty strings', () {
        final jsonWithNulls = Map<String, dynamic>.from(sampleRecipeJson);
        jsonWithNulls['strDrinkAlternate'] = null;
        jsonWithNulls['strTags'] = null;
        jsonWithNulls['strSource'] = null;

        final recipe = Recipe.fromJson(jsonWithNulls);

        expect(recipe.mealAlternate, isEmpty);
        expect(recipe.tags, isEmpty);
        expect(recipe.source, isEmpty);
      });
    });

    group('toJson', () {
      test(
        'should produce JSON that can be parsed back to identical Recipe',
        () {
          final originalRecipe = Recipe.fromJson(sampleRecipeJson);

          final json = originalRecipe.toJson();
          final parsedRecipe = Recipe.fromJson(json);

          expect(parsedRecipe.id, originalRecipe.id);
          expect(parsedRecipe.meal, originalRecipe.meal);
          expect(parsedRecipe.category, originalRecipe.category);
          expect(parsedRecipe.area, originalRecipe.area);
          expect(parsedRecipe.instructions, originalRecipe.instructions);
          expect(parsedRecipe.mealThumb, originalRecipe.mealThumb);
          expect(parsedRecipe.ingredient1, originalRecipe.ingredient1);
          expect(parsedRecipe.measure1, originalRecipe.measure1);
        },
      );

      test('should preserve all 20 ingredients and measures in JSON', () {
        final recipe = Recipe.fromJson(sampleRecipeJson);

        final json = recipe.toJson();

        expect(json['strIngredient1'], 'penne rigate');
        expect(json['strIngredient8'], 'Parmigiano-Reggiano');
        expect(json['strIngredient9'], '');
        expect(json['strMeasure1'], '1 pound');
        expect(json['strMeasure8'], 'spinkling');
      });
    });

    group('Serialization Round-Trip', () {
      test('should maintain data integrity through multiple conversions', () {
        final original = Recipe.fromJson(sampleRecipeJson);

        final json1 = original.toJson();
        final recipe1 = Recipe.fromJson(json1);
        final json2 = recipe1.toJson();
        final recipe2 = Recipe.fromJson(json2);

        expect(recipe2.id, original.id);
        expect(recipe2.meal, original.meal);
        expect(recipe2.category, original.category);
        expect(recipe2.instructions, original.instructions);
      });
    });
  });
}
