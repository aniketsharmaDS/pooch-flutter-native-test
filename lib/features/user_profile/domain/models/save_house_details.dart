import 'package:equatable/equatable.dart';

class SaveHouseDetails extends Equatable {
  const SaveHouseDetails({
    required this.parentGroup,
    required this.onboardingCompleted,
  });

  final ParentGroup? parentGroup;
  final bool onboardingCompleted;

  @override
  List<Object?> get props => <Object?>[parentGroup, onboardingCompleted];
}

class ParentGroup extends Equatable {
  const ParentGroup({
    required this.id,
    required this.houseName,
    required this.parentName,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.createdByLegacy,
  });

  final String id;
  final String houseName;
  final String parentName;
  final String createdBy;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final String createdByLegacy;

  @override
  List<Object?> get props => <Object?>[
    id,
    houseName,
    parentName,
    createdBy,
    createdAt,
    updatedAt,
    deletedAt,
    createdByLegacy,
  ];
}
