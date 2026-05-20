import 'package:equatable/equatable.dart';

class Pet extends Equatable {
  const Pet({
    this.profilePicture,
    this.bcsScore,
    required this.name,
    required this.type,
    required this.breedId,
    required this.gender,
    required this.dob,
    required this.size,
    required this.weight,
    required this.height,
    required this.heightUnit,
    required this.weightUnit,
    this.healthInfo,
  });

  final String? profilePicture;
  final int? bcsScore;
  final String name;
  final String type;
  final String breedId;
  final String gender;
  final String dob;
  final String size;
  final double weight;
  final double height;
  final String heightUnit;
  final String weightUnit;
  final String? healthInfo;

  @override
  List<Object?> get props => <Object?>[
    profilePicture,
    bcsScore,
    name,
    type,
    breedId,
    gender,
    dob,
    size,
    weight,
    height,
    heightUnit,
    weightUnit,
    healthInfo,
  ];
}
