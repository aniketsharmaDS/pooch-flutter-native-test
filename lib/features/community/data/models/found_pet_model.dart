import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_annotations.dart';

part 'found_pet_model.mapper.dart';

@MappableClass()
class FoundPetModel with FoundPetModelMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String? missingReportId;

  @SafeString()
  final String finderId;

  @SafeString()
  final String verificationMethod;

  @SafeBool()
  final bool isVerified;

  @SafeBool()
  final bool isDeleted;

  @SafeString()
  final String notes;

  @SafeString()
  final String latitude;

  @SafeString()
  final String longitude;

  @SafeString()
  final String location;

  @SafeString()
  final String createdAt;

  final MissingReport? missingReport;
  final Finder finder;

  @SafeBool()
  final bool isAuthor;

  const FoundPetModel({
    this.id = '',
    this.missingReportId,
    this.finderId = '',
    this.verificationMethod = '',
    this.isVerified = false,
    this.isDeleted = false,
    this.notes = '',
    this.latitude = '',
    this.longitude = '',
    this.location = '',
    this.createdAt = '',
    this.missingReport,
    this.finder = const Finder(),
    this.isAuthor = false,
  });
}

@MappableClass()
class MissingReport with MissingReportMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String description;

  @SafeString()
  final String lastKnownLocation;

  @SafeString()
  final String missingDate;

  @SafeString()
  final String missingTime;

  @SafeString()
  final String rewardAmount;

  @SafeString()
  final String status;

  final Pet pet;
  final Owner owner;

  @MappableField(hook: SafeListHook())
  final List<ReportImage> images;

  const MissingReport({
    this.id = '',
    this.description = '',
    this.lastKnownLocation = '',
    this.missingDate = '',
    this.missingTime = '',
    this.rewardAmount = '',
    this.status = '',
    this.pet = const Pet(),
    this.owner = const Owner(),
    this.images = const [],
  });
}

@MappableClass()
class Pet with PetMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String name;

  @SafeString()
  final String profilePicture;

  @SafeString()
  final String gender;

  @SafeString()
  final String type;

  final BreedInfo breedInfo;

  const Pet({
    this.id = '',
    this.name = '',
    this.profilePicture = '',
    this.gender = '',
    this.type = '',
    this.breedInfo = const BreedInfo(),
  });
}

@MappableClass()
class BreedInfo with BreedInfoMappable {
  @SafeString()
  final String breedName;

  const BreedInfo({this.breedName = ''});
}

@MappableClass()
class Owner with OwnerMappable {
  @SafeString()
  final String name;

  @SafeString()
  final String phone;

  final UserProfile profile;

  const Owner({
    this.name = '',
    this.phone = '',
    this.profile = const UserProfile(),
  });
}

@MappableClass()
class Finder with FinderMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String name;

  @SafeString()
  final String? phone;

  final UserProfile profile;

  const Finder({
    this.id = '',
    this.name = '',
    this.phone,
    this.profile = const UserProfile(),
  });
}

@MappableClass()
class UserProfile with UserProfileMappable {
  @SafeString()
  final String? profilePicture;

  const UserProfile({this.profilePicture});
}

@MappableClass()
class ReportImage with ReportImageMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String imageUrl;

  const ReportImage({this.id = '', this.imageUrl = ''});
}
