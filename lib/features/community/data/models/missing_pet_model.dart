import 'package:dart_mappable/dart_mappable.dart';

part 'missing_pet_model.mapper.dart';

@MappableClass()
class MissingPetModel with MissingPetModelMappable {
  final String id;
  final String petId;
  final String ownerId;
  final String lastKnownLocation;
  final bool isDeleted;

  final String? color;

  @MappableField(hook: DoubleHook())
  final double? latitude;

  @MappableField(hook: DoubleHook())
  final double? longitude;

  final String? missingDate;
  final String? missingTime;
  final String description;

  @MappableField(hook: DoubleHook())
  final double? rewardAmount;

  final String? currencyUnit;
  final String status;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? resolvedAt;

  final Pet pet;
  final Owner owner;
  final List<ImageModel> images;

  final bool? isAuthor;

  MissingPetModel({
    required this.id,
    required this.petId,
    required this.ownerId,
    required this.lastKnownLocation,
    required this.isDeleted,
    this.color,
    this.latitude,
    this.longitude,
    this.missingDate,
    this.missingTime,
    required this.description,
    this.rewardAmount,
    this.currencyUnit,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.resolvedAt,
    required this.pet,
    required this.owner,
    required this.images,
    this.isAuthor,
  });
}

@MappableClass()
class Pet with PetMappable {
  final String id;
  final String name;
  final String breedId;
  final String? profilePicture;
  final String gender;
  final DateTime dob;
  final String type;
  final BreedInfo breedInfo;

  Pet({
    required this.id,
    required this.name,
    required this.breedId,
    this.profilePicture,
    required this.gender,
    required this.dob,
    required this.type,
    required this.breedInfo,
  });
}

@MappableClass()
class Owner with OwnerMappable {
  final String id;
  final String name;
  final String? phone;
  final String? email;
  final OwnerProfile? profile;

  Owner({
    required this.id,
    required this.name,
    this.phone,
    this.email,
    this.profile,
  });
}

@MappableClass()
class OwnerProfile with OwnerProfileMappable {
  final String? profilePicture;

  OwnerProfile({this.profilePicture});
}

@MappableClass()
class BreedInfo with BreedInfoMappable {
  final String id;
  final String breedName;
  final String petType;

  BreedInfo({required this.id, required this.breedName, required this.petType});
}

@MappableClass()
class ImageModel with ImageModelMappable {
  final String id;
  final String imageUrl;

  ImageModel({required this.id, required this.imageUrl});
}

class DoubleHook extends MappingHook {
  const DoubleHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}
