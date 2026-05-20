import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.primaryIdentifier = '',
    required this.countryCode,
    this.country = '',
    this.provider = '',
    this.providerId = '',
    this.isSocialLogin = false,
    this.role = '',
    this.isVerified = false,
    this.isActive = false,
    this.isDeleted = false,
    this.deletedBy = '',
    this.deletedAt = '',
    this.deletedAtLegacy = '',
    this.deletionReason = '',
    this.isOnboarded = false,
    this.isProfileCompleted = false,
    this.isPetOnboarded = false,
    this.points = 0,
    this.createdAt = '',
    this.updatedAt = '',
    this.createdAtLegacy = '',
    this.updatedAtLegacy = '',
    this.profileId = '',
    this.profileUserId = '',
    required this.profilePicture,
    required this.dateOfBirth,
    required this.gender,
    this.bio = '',
    this.languagePreference = '',
    this.profileCreatedAt = '',
    this.profileUpdatedAt = '',
    this.profileUserIdLegacy = '',
    this.parentGroups = const <UserProfileParentGroup>[],
    this.invites = const <dynamic>[],
  });

  final String id;
  final String name;
  final String email;
  final String phone;
  final String primaryIdentifier;
  final String countryCode;
  final String country;
  final String provider;
  final String providerId;
  final bool isSocialLogin;
  final String role;
  final bool isVerified;
  final bool isActive;
  final bool isDeleted;
  final String deletedBy;
  final String deletedAt;
  final String deletedAtLegacy;
  final String deletionReason;
  final bool isOnboarded;
  final bool isProfileCompleted;
  final bool isPetOnboarded;
  final int points;
  final String createdAt;
  final String updatedAt;
  final String createdAtLegacy;
  final String updatedAtLegacy;
  final String profileId;
  final String profileUserId;
  final String profilePicture;
  final String dateOfBirth;
  final String gender;
  final String bio;
  final String languagePreference;
  final String profileCreatedAt;
  final String profileUpdatedAt;
  final String profileUserIdLegacy;
  final List<UserProfileParentGroup> parentGroups;
  final List<dynamic> invites;

  @override
  List<Object?> get props => <Object?>[
    id,
    name,
    email,
    phone,
    primaryIdentifier,
    countryCode,
    country,
    provider,
    providerId,
    isSocialLogin,
    role,
    isVerified,
    isActive,
    isDeleted,
    deletedBy,
    deletedAt,
    deletedAtLegacy,
    deletionReason,
    isOnboarded,
    isProfileCompleted,
    isPetOnboarded,
    points,
    createdAt,
    updatedAt,
    createdAtLegacy,
    updatedAtLegacy,
    profileId,
    profileUserId,
    profilePicture,
    dateOfBirth,
    gender,
    bio,
    languagePreference,
    profileCreatedAt,
    profileUpdatedAt,
    profileUserIdLegacy,
    parentGroups,
    invites,
  ];
}

class UserProfileParentGroup extends Equatable {
  const UserProfileParentGroup({
    required this.id,
    this.name = '',
    required this.userRole,
    required this.isOwner,
    required this.pets,
    required this.members,
  });

  final String id;
  final String name;
  final String userRole;
  final bool isOwner;
  final List<UserProfileParentGroupPet> pets;
  final List<UserProfileParentGroupMember> members;

  @override
  List<Object?> get props => <Object?>[
    id,
    name,
    userRole,
    isOwner,
    pets,
    members,
  ];
}

class UserProfileParentGroupMember extends Equatable {
  const UserProfileParentGroupMember({
    this.id = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.role = '',
    this.joinedAt = '',
    this.gender = '',
    this.dateOfBirth = '',
    this.profilePicture = '',
  });

  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String joinedAt;
  final String gender;
  final String dateOfBirth;
  final String profilePicture;

  @override
  List<Object?> get props => <Object?>[
    id,
    name,
    email,
    phone,
    role,
    joinedAt,
    gender,
    dateOfBirth,
    profilePicture,
  ];
}

class UserProfileParentGroupPet extends Equatable {
  const UserProfileParentGroupPet({
    required this.id,
    required this.petNumber,
    required this.parentGroupId,
    required this.userId,
    required this.orderItemId,
    required this.name,
    required this.type,
    required this.gender,
    required this.breedId,
    required this.dob,
    required this.size,
    required this.bcsScore,
    required this.height,
    required this.weight,
    required this.heightUnit,
    required this.weightUnit,
    required this.profilePicture,
    required this.healthInfo,
    required this.createdAtLegacy,
    required this.updatedAtLegacy,
    required this.deletedAtLegacy,
    required this.userIdLegacy,
    required this.parentGroupIdLegacy,
    required this.breedInfo,
  });

  final String id;
  final String petNumber;
  final String parentGroupId;
  final String userId;
  final String orderItemId;
  final String name;
  final String type;
  final String gender;
  final String breedId;
  final String dob;
  final String size;
  final int bcsScore;
  final double height;
  final double weight;
  final String heightUnit;
  final String weightUnit;
  final String profilePicture;
  final String healthInfo;
  final String createdAtLegacy;
  final String updatedAtLegacy;
  final String deletedAtLegacy;
  final String userIdLegacy;
  final String parentGroupIdLegacy;
  final UserProfileBreedInfo? breedInfo;

  @override
  List<Object?> get props => <Object?>[
    id,
    petNumber,
    parentGroupId,
    userId,
    orderItemId,
    name,
    type,
    gender,
    breedId,
    dob,
    size,
    bcsScore,
    height,
    weight,
    heightUnit,
    weightUnit,
    profilePicture,
    healthInfo,
    createdAtLegacy,
    updatedAtLegacy,
    deletedAtLegacy,
    userIdLegacy,
    parentGroupIdLegacy,
    breedInfo,
  ];
}

class UserProfileBreedInfo extends Equatable {
  const UserProfileBreedInfo({
    required this.id,
    required this.breedName,
    required this.petType,
    required this.sizeCategory,
  });

  final String id;
  final String breedName;
  final String petType;
  final String sizeCategory;

  @override
  List<Object?> get props => <Object?>[id, breedName, petType, sizeCategory];
}
