class SymptomTypeResponse {
  const SymptomTypeResponse({
    required this.code,
    required this.name,
    required this.species,
  });

  final String code;
  final String name;
  final String species;

  factory SymptomTypeResponse.fromMap(Map<String, dynamic> map) {
    return SymptomTypeResponse(
      code: (map['code'] ?? '').toString(),
      name: (map['name'] ?? '').toString(),
      species: (map['species'] ?? '').toString().toUpperCase(),
    );
  }
}
