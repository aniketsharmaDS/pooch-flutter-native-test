class TipsGuideCategory {
  final String id;
  final String name;

  TipsGuideCategory({required this.id, required this.name});

  factory TipsGuideCategory.fromJson(Map<String, dynamic> json) {
    return TipsGuideCategory(
      id: json['id'].toString(),
      name: json['name'].toString(),
    );
  }
}
