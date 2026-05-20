class ProductFilters {
  final List<String> petTypes;
  final List<String> genders;
  final List<String> sizes;
  final List<String> lifeStages;
  final List<String> energyLevels;
  final List<String> groomingNeeds;
  final List<String> temperaments;
  final List<String> subcategories;
  final List<String> allergies;

  ProductFilters({
    required this.petTypes,
    required this.genders,
    required this.sizes,
    required this.lifeStages,
    required this.energyLevels,
    required this.groomingNeeds,
    required this.temperaments,
    required this.subcategories,
    required this.allergies,
  });

  factory ProductFilters.fromJson(Map<String, dynamic> json) {
    List<String> map(dynamic v) =>
        (v as List?)?.map((e) => e.toString()).toList() ?? [];

    return ProductFilters(
      petTypes: map(json['petTypes']),
      genders: map(json['genders']),
      sizes: map(json['sizes']),
      lifeStages: map(json['lifeStages']),
      energyLevels: map(json['energyLevels']),
      groomingNeeds: map(json['groomingNeeds']),
      temperaments: map(json['temperaments']),
      subcategories: map(json['subcategories']),
      allergies: map(json['allergies']),
    );
  }
}
