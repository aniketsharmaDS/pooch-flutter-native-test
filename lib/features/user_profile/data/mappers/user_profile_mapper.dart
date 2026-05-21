import 'package:poochcare/features/user_profile/data/models/user_profile_response.dart';
import 'package:poochcare/features/user_profile/domain/models/user_profile.dart';

class UserProfileMapper {
  const UserProfileMapper._();

  static UserProfile toDomain(UserProfileResponse response) {
    final details = response.profile;

    return UserProfile(
      hasBoughtPet: response.hasBoughtPet,
      id: response.id,
      name: response.name,
      email: response.email,
      phone: response.phone,
      primaryIdentifier: response.primaryIdentifier,
      countryCode: response.countryCode,
      country: response.country,
      provider: response.provider,
      providerId: response.providerId,
      isSocialLogin: response.isSocialLogin,
      role: response.role,
      isVerified: response.isVerified,
      isActive: response.isActive,
      isDeleted: response.isDeleted,
      deletedBy: response.deletedBy,
      deletedAt: response.deletedAt,
      deletedAtLegacy: response.deletedAtLegacy,
      deletionReason: response.deletionReason,
      isOnboarded: response.isOnboarded,
      isProfileCompleted: response.isProfileCompleted,
      isPetOnboarded: response.isPetOnboarded,
      points: response.points,
      createdAt: response.createdAt,
      updatedAt: response.updatedAt,
      createdAtLegacy: response.createdAtLegacy,
      updatedAtLegacy: response.updatedAtLegacy,
      profileId: details?.id ?? '',
      profileUserId: details?.userId ?? '',
      profilePicture: details?.profilePicture ?? '',
      dateOfBirth: details?.dateOfBirth ?? '',
      gender: details?.gender ?? '',
      bio: details?.bio ?? '',
      languagePreference: details?.languagePreference ?? '',
      profileCreatedAt: details?.createdAt ?? '',
      profileUpdatedAt: details?.updatedAt ?? '',
      profileUserIdLegacy: details?.userIdLegacy ?? '',
      parentGroups: response.parentGroups.map(_mapParentGroup).toList(),
      invites: response.invites,
    );
  }

  static UserProfileParentGroup _mapParentGroup(ParentGroupResponse response) {
    return UserProfileParentGroup(
      id: response.id,
      userRole: response.userRole,
      isOwner: response.isOwner,
      pets: response.pets.map(_mapParentGroupPet).toList(),
      members: response.members
          .whereType<Map<String, dynamic>>()
          .map(_mapParentGroupMember)
          .toList(),
    );
  }

  static UserProfileParentGroupMember _mapParentGroupMember(
    Map<String, dynamic> member,
  ) {
    return UserProfileParentGroupMember(
      id: _string(member['id']),
      name: _string(member['name']),
      email: _string(member['email']),
      phone: _string(member['phone']),
      role: _string(member['role']),
      joinedAt: _string(member['joinedAt']),
      gender: _string(member['gender']),
      dateOfBirth: _string(member['dateOfBirth']),
      profilePicture: _string(member['profilePicture']),
    );
  }

  static UserProfileParentGroupPet _mapParentGroupPet(
    ParentGroupPetResponse response,
  ) {
    return UserProfileParentGroupPet(
      id: response.id,
      petNumber: response.petNumber,
      parentGroupId: response.parentGroupId,
      userId: response.userId,
      orderItemId: response.orderItemId,
      name: response.name,
      type: response.type,
      gender: response.gender,
      breedId: response.breedId,
      dob: response.dob,
      size: response.size,
      bcsScore: response.bcsScore,
      height: response.height,
      weight: response.weight,
      heightUnit: response.heightUnit,
      weightUnit: response.weightUnit,
      profilePicture: response.profilePicture,
      healthInfo: response.healthInfo,
      createdAtLegacy: response.createdAtLegacy,
      updatedAtLegacy: response.updatedAtLegacy,
      deletedAtLegacy: response.deletedAtLegacy,
      userIdLegacy: response.userIdLegacy,
      parentGroupIdLegacy: response.parentGroupIdLegacy,
      breedInfo: _mapBreedInfo(response.breedInfo),
    );
  }

  static UserProfileBreedInfo? _mapBreedInfo(BreedInfoResponse? response) {
    if (response == null) return null;

    return UserProfileBreedInfo(
      id: response.id,
      breedName: response.breedName,
      petType: response.petType,
      sizeCategory: response.sizeCategory,
    );
  }

  static String _string(dynamic value) =>
      value is String ? value : (value ?? '').toString();
}
