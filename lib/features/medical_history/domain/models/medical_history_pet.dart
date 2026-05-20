import 'package:equatable/equatable.dart';

class MedicalHistoryPet extends Equatable {
  const MedicalHistoryPet({
    required this.id,
    required this.name,
    required this.species,
  });

  final String id;
  final String name;
  final String species;

  @override
  List<Object?> get props => <Object?>[id, name, species];
}
