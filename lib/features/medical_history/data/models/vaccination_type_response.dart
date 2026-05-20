class VaccinationTypeResponse {
  const VaccinationTypeResponse({
    this.id = 0,
    this.species = '',
    this.vaccineCode = '',
    this.vaccineName = '',
    this.vaccineNameAr,
    this.isCore = false,
    this.mandatory = false,
    this.lifestyleBased = false,
    this.countrySpecific = false,
    this.minAgeWeeks = 0,
    this.maxAgeWeeks,
    this.repeatType = '',
    this.notes,
  });

  final int id;
  final String species;
  final String vaccineCode;
  final String vaccineName;
  final String? vaccineNameAr;
  final bool isCore;
  final bool mandatory;
  final bool lifestyleBased;
  final bool countrySpecific;
  final int minAgeWeeks;
  final int? maxAgeWeeks;
  final String repeatType;
  final String? notes;

  factory VaccinationTypeResponse.fromMap(Map<String, dynamic> map) {
    bool toBool(dynamic value) => value == true || value == 1;

    return VaccinationTypeResponse(
      id: (map['id'] as num?)?.toInt() ?? 0,
      species: (map['species'] ?? '').toString().toUpperCase(),
      vaccineCode: (map['vaccineCode'] ?? '').toString(),
      vaccineName: (map['vaccineName'] ?? '').toString(),
      vaccineNameAr: map['vaccineNameAr']?.toString(),
      isCore: toBool(map['isCore']),
      mandatory: toBool(map['mandatory']),
      lifestyleBased: toBool(map['lifestyleBased']),
      countrySpecific: toBool(map['countrySpecific']),
      minAgeWeeks: (map['minAgeWeeks'] as num?)?.toInt() ?? 0,
      maxAgeWeeks: (map['maxAgeWeeks'] as num?)?.toInt(),
      repeatType: (map['repeatType'] ?? '').toString(),
      notes: map['notes']?.toString(),
    );
  }
}
