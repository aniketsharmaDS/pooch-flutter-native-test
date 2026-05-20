class GetParentGroupsResponse {
  const GetParentGroupsResponse({
    this.parentGroups = const <ParentGroupResponse>[],
  });

  final List<ParentGroupResponse> parentGroups;

  factory GetParentGroupsResponse.fromMap(Map<String, dynamic> map) {
    final parentGroupsRaw = map['parentGroups'];
    final List<ParentGroupResponse> parentGroups =
        parentGroupsRaw is List<dynamic>
        ? parentGroupsRaw
              .whereType<Map<String, dynamic>>()
              .map(ParentGroupResponse.fromMap)
              .toList()
        : const <ParentGroupResponse>[];

    return GetParentGroupsResponse(parentGroups: parentGroups);
  }
}

class ParentGroupResponse {
  const ParentGroupResponse({
    this.id = '',
    this.name = '',
    this.userRole = '',
    this.isOwner = false,
    this.pets = const <ParentGroupPetResponse>[],
    this.members = const <ParentGroupMemberResponse>[],
  });

  final String id;
  final String name;
  final String userRole;
  final bool isOwner;
  final List<ParentGroupPetResponse> pets;
  final List<ParentGroupMemberResponse> members;

  factory ParentGroupResponse.fromMap(Map<String, dynamic> map) {
    final petsRaw = map['pets'];

    return ParentGroupResponse(
      id: _string(map['id']),
      name: _string(map['name']),
      userRole: _string(map['userRole']),
      isOwner: map['isOwner'] == true,
      pets: petsRaw is List<dynamic>
          ? petsRaw
                .whereType<Map<String, dynamic>>()
                .map(ParentGroupPetResponse.fromMap)
                .toList()
          : const <ParentGroupPetResponse>[],
      members: map['members'] is List<dynamic>
          ? (map['members'] as List<dynamic>)
                .whereType<Map<String, dynamic>>()
                .map(ParentGroupMemberResponse.fromMap)
                .toList()
          : const <ParentGroupMemberResponse>[],
    );
  }
}

class ParentGroupMemberResponse {
  const ParentGroupMemberResponse({
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

  factory ParentGroupMemberResponse.fromMap(Map<String, dynamic> map) {
    return ParentGroupMemberResponse(
      id: _string(map['id']),
      name: _string(map['name']),
      email: _string(map['email']),
      phone: _string(map['phone']),
      role: _string(map['role']),
      joinedAt: _string(map['joinedAt']),
      gender: _string(map['gender']),
      dateOfBirth: _string(map['dateOfBirth']),
      profilePicture: _string(map['profilePicture']),
    );
  }
}

class ParentGroupPetResponse {
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
  final ParentGroupBreedInfoResponse? breedInfo;

  factory ParentGroupPetResponse.fromMap(Map<String, dynamic> map) {
    return ParentGroupPetResponse(
      id: _string(map['id']),
      petNumber: _string(map['petNumber']),
      parentGroupId: _string(map['parentGroupId']),
      userId: _string(map['userId']),
      orderItemId: _string(map['orderItemId']),
      name: _string(map['name']),
      type: _string(map['type']),
      gender: _string(map['gender']),
      breedId: _string(map['breedId']),
      dob: _string(map['dob']),
      size: _string(map['size']),
      bcsScore: _int(map['bcsScore']),
      height: _double(map['height']),
      weight: _double(map['weight']),
      heightUnit: _string(map['heightUnit']),
      weightUnit: _string(map['weightUnit']),
      profilePicture: _string(map['profilePicture']),
      healthInfo: _string(map['healthInfo']),
      createdAtLegacy: _string(map['created_at']),
      updatedAtLegacy: _string(map['updated_at']),
      deletedAtLegacy: _string(map['deleted_at']),
      userIdLegacy: _string(map['user_id']),
      parentGroupIdLegacy: _string(map['parent_group_id']),
      breedInfo: map['breedInfo'] is Map<String, dynamic>
          ? ParentGroupBreedInfoResponse.fromMap(
              map['breedInfo'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

class ParentGroupBreedInfoResponse {
  const ParentGroupBreedInfoResponse({
    this.id = '',
    this.breedName = '',
    this.petType = '',
    this.sizeCategory = '',
  });

  final String id;
  final String breedName;
  final String petType;
  final String sizeCategory;

  factory ParentGroupBreedInfoResponse.fromMap(Map<String, dynamic> map) {
    return ParentGroupBreedInfoResponse(
      id: _string(map['id']),
      breedName: _string(map['breedName']),
      petType: _string(map['petType']),
      sizeCategory: _string(map['sizeCategory']),
    );
  }
}

String _string(dynamic value) =>
    value is String ? value : (value ?? '').toString();

int _int(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

double _double(dynamic value) {
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0;
  return 0;
}
