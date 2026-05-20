class DiagnosisTypeResponse {
  const DiagnosisTypeResponse({
    required this.code,
    required this.name,
    required this.species,
  });

  final String code;
  final String name;
  final String species;

  factory DiagnosisTypeResponse.fromMap(Map<String, dynamic> map) {
    return DiagnosisTypeResponse(
      code: (map['code'] ?? '').toString(),
      name: (map['name'] ?? '').toString(),
      species: (map['species'] ?? '').toString().toUpperCase(),
    );
  }
}
