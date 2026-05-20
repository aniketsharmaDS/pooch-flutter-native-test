import 'package:poochcare/features/user_profile/data/models/user_profile_model.dart';
import 'package:poochcare/features/user_profile/domain/models/user_pet.dart';

extension UserProfilePetsMapper on UserProfileModel {
  List<UserPet> toPets() {
    final List<UserPet> petsList = <UserPet>[];

    for (final group in parentGroups) {
      final isParent = group.userRole == 'parent';

      for (final pet in group.pets) {
        petsList.add(
          UserPet(
            id: pet.id,
            name: pet.name,
            type: pet.type,
            breedId: pet.breedId,
            gender: pet.gender,
            dob: pet.dob,
            size: pet.size,
            weight: pet.weight > 0 ? pet.weight : null,
            height: pet.height > 0 ? pet.height : null,
            weightUnit: pet.weightUnit.trim().isNotEmpty
                ? pet.weightUnit
                : null,
            heightUnit: pet.heightUnit.trim().isNotEmpty
                ? pet.heightUnit
                : null,
            bcsScore: pet.bcsScore > 0 ? pet.bcsScore : null,
            healthInfo: (pet.healthInfo ?? '').trim().isNotEmpty
                ? pet.healthInfo
                : null,
            profilePicture: pet.profilePicture,
            breedName: pet.breedInfo?.breedName,
            canEdit: isParent || group.userRole == 'co_parent',
            canDelete: isParent && group.isOwner,
          ),
        );
      }
    }

    return petsList;
  }
}
