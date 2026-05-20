import 'package:poochcare/features/user_profile/data/models/save_house_details_response.dart';
import 'package:poochcare/features/user_profile/domain/models/save_house_details.dart';

class SaveHouseDetailsMapper {
  const SaveHouseDetailsMapper._();

  static SaveHouseDetails toDomain(SaveHouseDetailsResponse response) {
    final ParentGroupResponse? parentGroup = response.parentGroup;

    return SaveHouseDetails(
      parentGroup: parentGroup == null
          ? null
          : ParentGroup(
              id: parentGroup.id,
              houseName: parentGroup.houseName,
              parentName: parentGroup.parentName,
              createdBy: parentGroup.createdBy,
              createdAt: parentGroup.createdAt,
              updatedAt: parentGroup.updatedAt,
              deletedAt: parentGroup.deletedAt,
              createdByLegacy: parentGroup.createdByLegacy,
            ),
      onboardingCompleted: response.onboardingCompleted,
    );
  }
}
