class Category {
  final String id;
  final String name;
  final String thumb;

  Category({
    required this.id,
    required this.name,
    required this.thumb,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['idCategory'] as String,
      name: json['strCategory'] as String,
      thumb: json['strCategoryThumb'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCategory': id,
      'strCategory': name,
      'strCategoryThumb': thumb,
    };
  }

  @override
  String toString() {
    return 'Category(id: $id, name: $name, thumb: $thumb)';
  }
}

class CategoryResponse {
  final List<Category> categories;

  CategoryResponse({required this.categories});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      categories: (json['categories'] as List)
          .map((item) => Category.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categories': categories.map((cat) => cat.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'CategoryResponse(categories: $categories)';
  }
}
