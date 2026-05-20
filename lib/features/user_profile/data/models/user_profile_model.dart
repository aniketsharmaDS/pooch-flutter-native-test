import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'user_profile_model.mapper.dart';

@MappableClass()
class UserProfileModel with UserProfileModelMappable {
  const UserProfileModel({
    this.id = '',
    this.name = '',
    this.role = '',
    this.parentGroups = const <ParentGroupModel>[],
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String name;

  @MappableField(hook: SafeStringHook())
  final String role;

  final List<ParentGroupModel> parentGroups;
}

@MappableClass()
class ParentGroupModel with ParentGroupModelMappable {
  const ParentGroupModel({
    this.id = '',
    this.userRole = '',
    this.isOwner = false,
    this.pets = const <UserPetModel>[],
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String userRole;

  @MappableField(hook: SafeBoolHook())
  final bool isOwner;

  final List<UserPetModel> pets;
}

@MappableClass()
class UserPetModel with UserPetModelMappable {
  const UserPetModel({
    this.id = '',
    this.name = '',
    this.type = '',
    this.breedId = '',
    this.gender = '',
    this.dob = '',
    this.size,
    this.weight = 0,
    this.height = 0,
    this.weightUnit = '',
    this.heightUnit = '',
    this.bcsScore = 0,
    this.healthInfo,
    this.profilePicture,
    this.breedInfo,
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String name;

  @MappableField(hook: SafeStringHook())
  final String type;

  @MappableField(hook: SafeStringHook())
  final String breedId;

  @MappableField(hook: SafeStringHook())
  final String gender;

  @MappableField(hook: SafeStringHook())
  final String dob;

  @MappableField(hook: SafeStringHook())
  final String? size;

  @MappableField(hook: SafeDoubleHook())
  final double weight;

  @MappableField(hook: SafeDoubleHook())
  final double height;

  @MappableField(hook: SafeStringHook())
  final String weightUnit;

  @MappableField(hook: SafeStringHook())
  final String heightUnit;

  @MappableField(hook: SafeIntHook())
  final int bcsScore;

  @MappableField(hook: SafeStringHook())
  final String? healthInfo;

  @MappableField(hook: SafeStringHook())
  final String? profilePicture;

  final BreedInfoModel? breedInfo;
}

@MappableClass()
class BreedInfoModel with BreedInfoModelMappable {
  const BreedInfoModel({this.breedName = ''});

  @MappableField(hook: SafeStringHook())
  final String breedName;
}
