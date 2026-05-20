import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_annotations.dart';

part 'pet_shelter_model.mapper.dart';

@MappableClass()
class PetShelterModel with PetShelterModelMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String shelterName;

  @SafeString()
  final String shelterType;

  @SafeString()
  final String email;

  @SafeString()
  final String website;

  @SafeString()
  final String address;

  @SafeString()
  final String city;

  @SafeString()
  final String state;

  @SafeString()
  final String pincode;

  @SafeString()
  final String country;

  @SafeString()
  final String latitude;

  @SafeString()
  final String longitude;

  @MappableField(key: 'phone_numbers', hook: SafeListHook())
  final List<PhoneNumber> phoneNumbers;

  @SafeString()
  final String description;

  @SafeString()
  final String status;

  @SafeBool()
  final bool isDeleted;

  @SafeString()
  final String deletedAt;

  @SafeString()
  final String deletedBy;

  @SafeString()
  final String createdAt;

  @SafeString()
  final String updatedAt;

  const PetShelterModel({
    this.id = '',
    this.shelterName = '',
    this.shelterType = '',
    this.email = '',
    this.website = '',
    this.address = '',
    this.city = '',
    this.state = '',
    this.pincode = '',
    this.country = '',
    this.latitude = '',
    this.longitude = '',
    this.phoneNumbers = const [],
    this.description = '',
    this.status = '',
    this.isDeleted = false,
    this.deletedAt = '',
    this.deletedBy = '',
    this.createdAt = '',
    this.updatedAt = '',
  });
}

/// =========================
/// PHONE NUMBER MODEL
/// =========================

@MappableClass()
class PhoneNumber with PhoneNumberMappable {
  @SafeString()
  final String type;

  @SafeString()
  final String number;

  @SafeString()
  final String country;

  @SafeString()
  final String countryCode;

  const PhoneNumber({
    this.type = '',
    this.number = '',
    this.country = '',
    this.countryCode = '',
  });
}
