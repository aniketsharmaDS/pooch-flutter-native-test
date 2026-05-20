class MedicalHistoryPetResponse {
  const MedicalHistoryPetResponse({
    this.id = '',
    this.name = '',
    this.species = '',
  });

  final String id;
  final String name;
  final String species;

  factory MedicalHistoryPetResponse.fromMap(Map<String, dynamic> map) {
    return MedicalHistoryPetResponse(
      id: (map['id'] ?? '').toString(),
      name: (map['name'] ?? '').toString(),
      species: (map['species'] ?? map['type'] ?? '').toString().toUpperCase(),
    );
  }
}
