import 'package:equatable/equatable.dart';

class VaccinationType extends Equatable {
  const VaccinationType({
    required this.id,
    required this.species,
    required this.vaccineCode,
    required this.vaccineName,
    this.vaccineNameAr,
    required this.isCore,
    required this.mandatory,
    required this.lifestyleBased,
    required this.countrySpecific,
    required this.minAgeWeeks,
    this.maxAgeWeeks,
    required this.repeatType,
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

  @override
  List<Object?> get props => <Object?>[
    id,
    species,
    vaccineCode,
    vaccineName,
    vaccineNameAr,
    isCore,
    mandatory,
    lifestyleBased,
    countrySpecific,
    minAgeWeeks,
    maxAgeWeeks,
    repeatType,
    notes,
  ];
}
