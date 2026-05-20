import 'package:poochcare/features/user_profile/data/models/get_parent_groups_response.dart';
import 'package:poochcare/features/user_profile/domain/models/user_profile.dart';

class GetParentGroupsMapper {
  const GetParentGroupsMapper._();

  static List<UserProfileParentGroup> toDomain(
    GetParentGroupsResponse response,
  ) {
    return response.parentGroups.map(_mapParentGroup).toList();
  }

  static UserProfileParentGroup _mapParentGroup(ParentGroupResponse response) {
    return UserProfileParentGroup(
      id: response.id,
      name: response.name,
      userRole: response.userRole,
      isOwner: response.isOwner,
      pets: response.pets.map(_mapParentGroupPet).toList(),
      members: response.members.map(_mapMember).toList(),
    );
  }

  static UserProfileParentGroupMember _mapMember(
    ParentGroupMemberResponse response,
  ) {
    return UserProfileParentGroupMember(
      id: response.id,
      name: response.name,
      email: response.email,
      phone: response.phone,
      role: response.role,
      joinedAt: response.joinedAt,
      gender: response.gender,
      dateOfBirth: response.dateOfBirth,
      profilePicture: response.profilePicture,
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

  static UserProfileBreedInfo? _mapBreedInfo(
    ParentGroupBreedInfoResponse? response,
  ) {
    if (response == null) return null;

    return UserProfileBreedInfo(
      id: response.id,
      breedName: response.breedName,
      petType: response.petType,
      sizeCategory: response.sizeCategory,
    );
  }
}
