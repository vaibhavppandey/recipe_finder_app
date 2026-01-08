class Area {
  final String str;

  const Area({
    required this.str,
  });

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      str: json['strArea'] as String, // key in API is "strArea"
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'strArea': str,
    };
  }
}
