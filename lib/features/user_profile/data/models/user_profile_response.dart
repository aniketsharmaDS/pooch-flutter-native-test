import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'user_profile_response.mapper.dart';

@MappableClass()
class UserProfileResponse with UserProfileResponseMappable {
  const UserProfileResponse({
    this.id = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.primaryIdentifier = '',
    this.countryCode = '',
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
    this.hasBoughtPet = false,
    this.points = 0,
    this.createdAt = '',
    this.updatedAt = '',
    this.createdAtLegacy = '',
    this.updatedAtLegacy = '',
    this.profile,
    this.parentGroups = const <ParentGroupResponse>[],
    this.invites = const <dynamic>[],
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String name;

  @MappableField(hook: SafeStringHook())
  final String email;

  @MappableField(hook: SafeStringHook())
  final String phone;

  @MappableField(hook: SafeStringHook())
  final String primaryIdentifier;

  @MappableField(hook: SafeStringHook())
  final String countryCode;

  @MappableField(hook: SafeStringHook())
  final String country;

  @MappableField(hook: SafeStringHook())
  final String provider;

  @MappableField(hook: SafeStringHook())
  final String providerId;

  @MappableField(hook: SafeBoolHook())
  final bool isSocialLogin;

  @MappableField(hook: SafeStringHook())
  final String role;

  @MappableField(hook: SafeBoolHook())
  final bool isVerified;

  @MappableField(hook: SafeBoolHook())
  final bool isActive;

  @MappableField(hook: SafeBoolHook())
  final bool isDeleted;

  @MappableField(hook: SafeStringHook())
  final String deletedBy;

  @MappableField(hook: SafeStringHook())
  final String deletedAt;

  @MappableField(key: 'deleted_at', hook: SafeStringHook())
  final String deletedAtLegacy;

  @MappableField(hook: SafeStringHook())
  final String deletionReason;

  @MappableField(hook: SafeBoolHook())
  final bool isOnboarded;

  @MappableField(hook: SafeBoolHook())
  final bool isProfileCompleted;

  @MappableField(hook: SafeBoolHook())
  final bool isPetOnboarded;

  @MappableField(hook: SafeBoolHook())
  final bool hasBoughtPet;

  @MappableField(hook: SafeIntHook())
  final int points;

  @MappableField(key: 'createdAt', hook: SafeStringHook())
  final String createdAt;

  @MappableField(key: 'updatedAt', hook: SafeStringHook())
  final String updatedAt;

  @MappableField(key: 'created_at', hook: SafeStringHook())
  final String createdAtLegacy;

  @MappableField(key: 'updated_at', hook: SafeStringHook())
  final String updatedAtLegacy;

  final UserProfileDetailsResponse? profile;

  final List<ParentGroupResponse> parentGroups;

  final List<dynamic> invites;
}

@MappableClass()
class UserProfileDetailsResponse with UserProfileDetailsResponseMappable {
  const UserProfileDetailsResponse({
    this.id = '',
    this.userId = '',
    this.profilePicture = '',
    this.dateOfBirth = '',
    this.gender = '',
    this.bio = '',
    this.languagePreference = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.userIdLegacy = '',
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String userId;

  @MappableField(hook: SafeStringHook())
  final String profilePicture;

  @MappableField(hook: SafeStringHook())
  final String dateOfBirth;

  @MappableField(hook: SafeStringHook())
  final String gender;

  @MappableField(hook: SafeStringHook())
  final String bio;

  @MappableField(hook: SafeStringHook())
  final String languagePreference;

  @MappableField(key: 'createdAt', hook: SafeStringHook())
  final String createdAt;

  @MappableField(key: 'updatedAt', hook: SafeStringHook())
  final String updatedAt;

  @MappableField(key: 'user_id', hook: SafeStringHook())
  final String userIdLegacy;
}

@MappableClass()
class ParentGroupResponse with ParentGroupResponseMappable {
  const ParentGroupResponse({
    this.id = '',
    this.userRole = '',
    this.isOwner = false,
    this.pets = const <ParentGroupPetResponse>[],
    this.members = const <dynamic>[],
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String userRole;

  @MappableField(hook: SafeBoolHook())
  final bool isOwner;

  final List<ParentGroupPetResponse> pets;

  final List<dynamic> members;
}

@MappableClass()
class ParentGroupPetResponse with ParentGroupPetResponseMappable {
  const ParentGroupPetResponse({
    this.id = '',
    this.petNumber = '',
    this.parentGroupId = '',
    this.userId = '',
    this.orderItemId = '',
    this.name = '',
    this.type = '',
    this.gender = '',
    this.breedId = '',
    this.dob = '',
    this.size = '',
    this.bcsScore = 0,
    this.height = 0,
    this.weight = 0,
    this.heightUnit = '',
    this.weightUnit = '',
    this.profilePicture = '',
    this.healthInfo = '',
    this.createdAtLegacy = '',
    this.updatedAtLegacy = '',
    this.deletedAtLegacy = '',
    this.userIdLegacy = '',
    this.parentGroupIdLegacy = '',
    this.breedInfo,
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String petNumber;

  @MappableField(hook: SafeStringHook())
  final String parentGroupId;

  @MappableField(hook: SafeStringHook())
  final String userId;

  @MappableField(hook: SafeStringHook())
  final String orderItemId;

  @MappableField(hook: SafeStringHook())
  final String name;

  @MappableField(hook: SafeStringHook())
  final String type;

  @MappableField(hook: SafeStringHook())
  final String gender;

  @MappableField(hook: SafeStringHook())
  final String breedId;

  @MappableField(hook: SafeStringHook())
  final String dob;

  @MappableField(hook: SafeStringHook())
  final String size;

  @MappableField(hook: SafeIntHook())
  final int bcsScore;

  @MappableField(hook: SafeDoubleHook())
  final double height;

  @MappableField(hook: SafeDoubleHook())
  final double weight;

  @MappableField(hook: SafeStringHook())
  final String heightUnit;

  @MappableField(hook: SafeStringHook())
  final String weightUnit;

  @MappableField(hook: SafeStringHook())
  final String profilePicture;

  @MappableField(hook: SafeStringHook())
  final String healthInfo;

  @MappableField(key: 'created_at', hook: SafeStringHook())
  final String createdAtLegacy;

  @MappableField(key: 'updated_at', hook: SafeStringHook())
  final String updatedAtLegacy;

  @MappableField(key: 'deleted_at', hook: SafeStringHook())
  final String deletedAtLegacy;

  @MappableField(key: 'user_id', hook: SafeStringHook())
  final String userIdLegacy;

  @MappableField(key: 'parent_group_id', hook: SafeStringHook())
  final String parentGroupIdLegacy;

  final BreedInfoResponse? breedInfo;
}

@MappableClass()
class BreedInfoResponse with BreedInfoResponseMappable {
  const BreedInfoResponse({
    this.id = '',
    this.breedName = '',
    this.petType = '',
    this.sizeCategory = '',
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String breedName;

  @MappableField(hook: SafeStringHook())
  final String petType;

  @MappableField(hook: SafeStringHook())
  final String sizeCategory;
}
