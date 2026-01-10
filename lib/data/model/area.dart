class Area {
  final String str;

  const Area({required this.str});

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(str: json['strArea'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'strArea': str};
  }

  @override
  String toString() {
    return 'Area(str: $str)';
  }
}
