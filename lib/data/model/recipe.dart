class Recipe {
  final String id;
  final String meal;
  final String mealAlternate;
  final String category;
  final String area;
  final String instructions;
  final String mealThumb;
  final String tags;
  final String youtube;
  final String source;
  final String imageSource;
  final String creativeCommonsConfirmed;
  final String dateModified;

  // Ingredients 1–20
  final String ingredient1;
  final String ingredient2;
  final String ingredient3;
  final String ingredient4;
  final String ingredient5;
  final String ingredient6;
  final String ingredient7;
  final String ingredient8;
  final String ingredient9;
  final String ingredient10;
  final String ingredient11;
  final String ingredient12;
  final String ingredient13;
  final String ingredient14;
  final String ingredient15;
  final String ingredient16;
  final String ingredient17;
  final String ingredient18;
  final String ingredient19;
  final String ingredient20;

  // Measures 1–20
  final String measure1;
  final String measure2;
  final String measure3;
  final String measure4;
  final String measure5;
  final String measure6;
  final String measure7;
  final String measure8;
  final String measure9;
  final String measure10;
  final String measure11;
  final String measure12;
  final String measure13;
  final String measure14;
  final String measure15;
  final String measure16;
  final String measure17;
  final String measure18;
  final String measure19;
  final String measure20;

  const Recipe({
    required this.id,
    required this.meal,
    required this.mealAlternate,
    required this.category,
    required this.area,
    required this.instructions,
    required this.mealThumb,
    required this.tags,
    required this.youtube,
    required this.source,
    required this.imageSource,
    required this.creativeCommonsConfirmed,
    required this.dateModified,
    required this.ingredient1,
    required this.ingredient2,
    required this.ingredient3,
    required this.ingredient4,
    required this.ingredient5,
    required this.ingredient6,
    required this.ingredient7,
    required this.ingredient8,
    required this.ingredient9,
    required this.ingredient10,
    required this.ingredient11,
    required this.ingredient12,
    required this.ingredient13,
    required this.ingredient14,
    required this.ingredient15,
    required this.ingredient16,
    required this.ingredient17,
    required this.ingredient18,
    required this.ingredient19,
    required this.ingredient20,
    required this.measure1,
    required this.measure2,
    required this.measure3,
    required this.measure4,
    required this.measure5,
    required this.measure6,
    required this.measure7,
    required this.measure8,
    required this.measure9,
    required this.measure10,
    required this.measure11,
    required this.measure12,
    required this.measure13,
    required this.measure14,
    required this.measure15,
    required this.measure16,
    required this.measure17,
    required this.measure18,
    required this.measure19,
    required this.measure20,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    String _s(String key) => (json[key] as String?) ?? '';

    return Recipe(
      id: _s('idMeal'),
      meal: _s('strMeal'),
      mealAlternate: _s('strMealAlternate'),
      category: _s('strCategory'),
      area: _s('strArea'),
      instructions: _s('strInstructions'),
      mealThumb: _s('strMealThumb'),
      tags: _s('strTags'),
      youtube: _s('strYoutube'),
      source: _s('strSource'),
      imageSource: _s('strImageSource'),
      creativeCommonsConfirmed: _s('strCreativeCommonsConfirmed'),
      dateModified: _s('dateModified'),
      ingredient1: _s('strIngredient1'),
      ingredient2: _s('strIngredient2'),
      ingredient3: _s('strIngredient3'),
      ingredient4: _s('strIngredient4'),
      ingredient5: _s('strIngredient5'),
      ingredient6: _s('strIngredient6'),
      ingredient7: _s('strIngredient7'),
      ingredient8: _s('strIngredient8'),
      ingredient9: _s('strIngredient9'),
      ingredient10: _s('strIngredient10'),
      ingredient11: _s('strIngredient11'),
      ingredient12: _s('strIngredient12'),
      ingredient13: _s('strIngredient13'),
      ingredient14: _s('strIngredient14'),
      ingredient15: _s('strIngredient15'),
      ingredient16: _s('strIngredient16'),
      ingredient17: _s('strIngredient17'),
      ingredient18: _s('strIngredient18'),
      ingredient19: _s('strIngredient19'),
      ingredient20: _s('strIngredient20'),
      measure1: _s('strMeasure1'),
      measure2: _s('strMeasure2'),
      measure3: _s('strMeasure3'),
      measure4: _s('strMeasure4'),
      measure5: _s('strMeasure5'),
      measure6: _s('strMeasure6'),
      measure7: _s('strMeasure7'),
      measure8: _s('strMeasure8'),
      measure9: _s('strMeasure9'),
      measure10: _s('strMeasure10'),
      measure11: _s('strMeasure11'),
      measure12: _s('strMeasure12'),
      measure13: _s('strMeasure13'),
      measure14: _s('strMeasure14'),
      measure15: _s('strMeasure15'),
      measure16: _s('strMeasure16'),
      measure17: _s('strMeasure17'),
      measure18: _s('strMeasure18'),
      measure19: _s('strMeasure19'),
      measure20: _s('strMeasure20'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMeal': id,
      'strMeal': meal,
      'strMealAlternate': mealAlternate,
      'strCategory': category,
      'strArea': area,
      'strInstructions': instructions,
      'strMealThumb': mealThumb,
      'strTags': tags,
      'strYoutube': youtube,
      'strSource': source,
      'strImageSource': imageSource,
      'strCreativeCommonsConfirmed': creativeCommonsConfirmed,
      'dateModified': dateModified,
      'strIngredient1': ingredient1,
      'strIngredient2': ingredient2,
      'strIngredient3': ingredient3,
      'strIngredient4': ingredient4,
      'strIngredient5': ingredient5,
      'strIngredient6': ingredient6,
      'strIngredient7': ingredient7,
      'strIngredient8': ingredient8,
      'strIngredient9': ingredient9,
      'strIngredient10': ingredient10,
      'strIngredient11': ingredient11,
      'strIngredient12': ingredient12,
      'strIngredient13': ingredient13,
      'strIngredient14': ingredient14,
      'strIngredient15': ingredient15,
      'strIngredient16': ingredient16,
      'strIngredient17': ingredient17,
      'strIngredient18': ingredient18,
      'strIngredient19': ingredient19,
      'strIngredient20': ingredient20,
      'strMeasure1': measure1,
      'strMeasure2': measure2,
      'strMeasure3': measure3,
      'strMeasure4': measure4,
      'strMeasure5': measure5,
      'strMeasure6': measure6,
      'strMeasure7': measure7,
      'strMeasure8': measure8,
      'strMeasure9': measure9,
      'strMeasure10': measure10,
      'strMeasure11': measure11,
      'strMeasure12': measure12,
      'strMeasure13': measure13,
      'strMeasure14': measure14,
      'strMeasure15': measure15,
      'strMeasure16': measure16,
      'strMeasure17': measure17,
      'strMeasure18': measure18,
      'strMeasure19': measure19,
      'strMeasure20': measure20,
    };
  }

  Recipe copyWith({
    String? id,
    String? meal,
    String? mealAlternate,
    String? category,
    String? area,
    String? instructions,
    String? mealThumb,
    String? tags,
    String? youtube,
    String? source,
    String? imageSource,
    String? creativeCommonsConfirmed,
    String? dateModified,
    String? ingredient1,
    String? ingredient2,
    String? ingredient3,
    String? ingredient4,
    String? ingredient5,
    String? ingredient6,
    String? ingredient7,
    String? ingredient8,
    String? ingredient9,
    String? ingredient10,
    String? ingredient11,
    String? ingredient12,
    String? ingredient13,
    String? ingredient14,
    String? ingredient15,
    String? ingredient16,
    String? ingredient17,
    String? ingredient18,
    String? ingredient19,
    String? ingredient20,
    String? measure1,
    String? measure2,
    String? measure3,
    String? measure4,
    String? measure5,
    String? measure6,
    String? measure7,
    String? measure8,
    String? measure9,
    String? measure10,
    String? measure11,
    String? measure12,
    String? measure13,
    String? measure14,
    String? measure15,
    String? measure16,
    String? measure17,
    String? measure18,
    String? measure19,
    String? measure20,
  }) {
    return Recipe(
      id: id ?? this.id,
      meal: meal ?? this.meal,
      mealAlternate: mealAlternate ?? this.mealAlternate,
      category: category ?? this.category,
      area: area ?? this.area,
      instructions: instructions ?? this.instructions,
      mealThumb: mealThumb ?? this.mealThumb,
      tags: tags ?? this.tags,
      youtube: youtube ?? this.youtube,
      source: source ?? this.source,
      imageSource: imageSource ?? this.imageSource,
      creativeCommonsConfirmed:
          creativeCommonsConfirmed ?? this.creativeCommonsConfirmed,
      dateModified: dateModified ?? this.dateModified,
      ingredient1: ingredient1 ?? this.ingredient1,
      ingredient2: ingredient2 ?? this.ingredient2,
      ingredient3: ingredient3 ?? this.ingredient3,
      ingredient4: ingredient4 ?? this.ingredient4,
      ingredient5: ingredient5 ?? this.ingredient5,
      ingredient6: ingredient6 ?? this.ingredient6,
      ingredient7: ingredient7 ?? this.ingredient7,
      ingredient8: ingredient8 ?? this.ingredient8,
      ingredient9: ingredient9 ?? this.ingredient9,
      ingredient10: ingredient10 ?? this.ingredient10,
      ingredient11: ingredient11 ?? this.ingredient11,
      ingredient12: ingredient12 ?? this.ingredient12,
      ingredient13: ingredient13 ?? this.ingredient13,
      ingredient14: ingredient14 ?? this.ingredient14,
      ingredient15: ingredient15 ?? this.ingredient15,
      ingredient16: ingredient16 ?? this.ingredient16,
      ingredient17: ingredient17 ?? this.ingredient17,
      ingredient18: ingredient18 ?? this.ingredient18,
      ingredient19: ingredient19 ?? this.ingredient19,
      ingredient20: ingredient20 ?? this.ingredient20,
      measure1: measure1 ?? this.measure1,
      measure2: measure2 ?? this.measure2,
      measure3: measure3 ?? this.measure3,
      measure4: measure4 ?? this.measure4,
      measure5: measure5 ?? this.measure5,
      measure6: measure6 ?? this.measure6,
      measure7: measure7 ?? this.measure7,
      measure8: measure8 ?? this.measure8,
      measure9: measure9 ?? this.measure9,
      measure10: measure10 ?? this.measure10,
      measure11: measure11 ?? this.measure11,
      measure12: measure12 ?? this.measure12,
      measure13: measure13 ?? this.measure13,
      measure14: measure14 ?? this.measure14,
      measure15: measure15 ?? this.measure15,
      measure16: measure16 ?? this.measure16,
      measure17: measure17 ?? this.measure17,
      measure18: measure18 ?? this.measure18,
      measure19: measure19 ?? this.measure19,
      measure20: measure20 ?? this.measure20,
    );
  }

  @override
  String toString() {
    return 'Recipe(id: $id, meal: $meal, category: $category, area: $area)';
  }
}
