import 'package:equatable/equatable.dart';

class UserPet extends Equatable {
  const UserPet({
    required this.id,
    required this.name,
    required this.type,
    required this.breedId,
    required this.gender,
    required this.dob,
    this.size,
    this.weight,
    this.height,
    this.weightUnit,
    this.heightUnit,
    this.bcsScore,
    this.healthInfo,
    this.profilePicture,
    this.breedName,
    required this.canEdit,
    required this.canDelete,
  });

  final String id;
  final String name;
  final String type;
  final String breedId;
  final String gender;
  final String dob;
  final String? size;
  final double? weight;
  final double? height;
  final String? weightUnit;
  final String? heightUnit;
  final int? bcsScore;
  final String? healthInfo;
  final String? profilePicture;
  final String? breedName;

  final bool canEdit;
  final bool canDelete;

  @override
  List<Object?> get props => <Object?>[
    id,
    name,
    type,
    breedId,
    gender,
    dob,
    size,
    weight,
    height,
    weightUnit,
    heightUnit,
    bcsScore,
    healthInfo,
    profilePicture,
    breedName,
    canEdit,
    canDelete,
  ];
}
