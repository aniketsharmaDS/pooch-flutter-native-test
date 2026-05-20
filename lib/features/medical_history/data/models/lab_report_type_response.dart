class LabReportTypeResponse {
  const LabReportTypeResponse({
    required this.code,
    required this.name,
    required this.species,
  });

  final String code;
  final String name;
  final String species;

  factory LabReportTypeResponse.fromMap(Map<String, dynamic> map) {
    return LabReportTypeResponse(
      code: (map['code'] ?? '').toString(),
      name: (map['name'] ?? '').toString(),
      species: (map['species'] ?? '').toString().toUpperCase(),
    );
  }
}
