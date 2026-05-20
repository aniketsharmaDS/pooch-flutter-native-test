import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_annotations.dart';

part 'pooch_missing_match_status_model.mapper.dart';

@MappableClass()
class PoochMissingMatchStatusModel with PoochMissingMatchStatusModelMappable {
  @SafeBool()
  final bool matched;

  final PoochPet? pet;

  const PoochMissingMatchStatusModel({this.matched = false, this.pet});
}

/// =========================
/// PET MODEL
/// =========================

@MappableClass()
class PoochPet with PoochPetMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String name;

  @SafeString()
  final String breedId;

  final PoochBreed? breed;

  @SafeString()
  final String type;

  @SafeString()
  final String size;

  @SafeString()
  final String gender;

  @SafeString()
  final String dob;

  @SafeString()
  final String profilePicture;

  const PoochPet({
    this.id = '',
    this.name = '',
    this.breedId = '',
    this.breed,
    this.type = '',
    this.size = '',
    this.gender = '',
    this.dob = '',
    this.profilePicture = '',
  });
}

/// =========================
/// BREED MODEL
/// =========================

@MappableClass()
class PoochBreed with PoochBreedMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String breedName;

  @SafeString()
  final String petType;

  const PoochBreed({this.id = '', this.breedName = '', this.petType = ''});
}
