import 'dart:io';

import 'package:poochcare/core/services/image_upload_service.dart';
import 'package:poochcare/core/services/s3_upload_path_builder.dart';
import 'package:poochcare/features/user_profile/data/api/user_profile_api_service.dart';
import 'package:poochcare/features/user_profile/data/mappers/get_parent_groups_mapper.dart';
import 'package:poochcare/features/user_profile/data/mappers/identifier_otp_send_mapper.dart';
import 'package:poochcare/features/user_profile/data/mappers/save_house_details_mapper.dart';
import 'package:poochcare/features/user_profile/data/mappers/user_profile_mapper.dart';
import 'package:poochcare/features/user_profile/data/mappers/user_profile_pets_mapper.dart';
import 'package:poochcare/features/user_profile/domain/models/identifier_otp_send_result.dart';
import 'package:poochcare/features/user_profile/domain/models/save_house_details.dart';
import 'package:poochcare/features/user_profile/domain/models/user_pet.dart';
import 'package:poochcare/features/user_profile/domain/models/user_profile.dart';

class UserProfileRepository {
  const UserProfileRepository({
    required UserProfileApiService api,
    required ImageUploadService imageUploadService,
  }) : _api = api,
       _imageUploadService = imageUploadService;

  final UserProfileApiService _api;
  final ImageUploadService _imageUploadService;

  Future<UserProfile> getUserProfile() async {
    final response = await _api.getUserProfileDetails();
    return UserProfileMapper.toDomain(response);
  }

  Future<IdentifierOtpSendResult> sendOtpForIdentifier({
    String? countryCode,
    String? newEmail,
    String? newPhone,
  }) async {
    final result = await _api.sendOtpForIdentifier(
      countryCode: countryCode,
      newEmail: newEmail,
      newPhone: newPhone,
    );

    return IdentifierOtpSendMapper.toDomain(
      result.data,
      message: result.message,
    );
  }

  Future<UserProfile> updateProfile({
    required String name,
    required String email,
    required String phone,
    required String dateOfBirth,
    required String? otpCode,
    required String countryCode,
    required String profilePicture,
    required String gender,
  }) async {
    final result = await _api.updateProfile(
      name: name,
      email: email,
      phone: phone,
      dateOfBirth: dateOfBirth,
      otpCode: otpCode,
      countryCode: countryCode,
      profilePicture: profilePicture,
      gender: gender,
    );

    return UserProfileMapper.toDomain(result.data);
  }

  Future<List<UserPet>> getUserPets() async {
    final profile = await _api.getProfile();
    return profile.toPets();
  }

  Future<List<UserProfileParentGroup>> getParentGroups() async {
    final result = await _api.getParentGroups();
    return GetParentGroupsMapper.toDomain(result.data);
  }

  Future<String?> getPreferredParentGroupId() async {
    final profile = await _api.getProfile();
    final groups = profile.parentGroups;
    if (groups.isEmpty) return null;

    for (final group in groups) {
      final id = group.id.trim();
      if (group.isOwner && id.isNotEmpty) {
        return id;
      }
    }

    for (final group in groups) {
      final id = group.id.trim();
      if (id.isNotEmpty) {
        return id;
      }
    }

    return null;
  }

  Future<void> updatePetProfile(UserPet pet) async {
    await _api.updateParentGroupPet(
      petId: pet.id,
      payload: <String, dynamic>{
        'profilePicture': (pet.profilePicture ?? '').trim(),
        'bcsScore': pet.bcsScore ?? 0,
        'name': pet.name.trim(),
        'type': pet.type.trim(),
        'breedId': pet.breedId.trim(),
        'gender': pet.gender.trim(),
        'dob': pet.dob.trim(),
        'size': _mapPetSize(pet.size),
        'weight': pet.weight ?? 0,
        'height': pet.height ?? 0,
        'heightUnit': _mapHeightUnit(pet.heightUnit),
        'weightUnit': _mapWeightUnit(pet.weightUnit),
        'healthInfo': (pet.healthInfo ?? '').trim(),
      },
    );
  }

  Future<void> deletePet(String petId) async {
    await _api.deleteParentGroupPet(petId: petId);
  }

  String _mapPetSize(String? size) {
    if (size == null) return '';
    switch (size.toLowerCase()) {
      case 'toy':
      case 'small':
        return 'S';
      case 'medium':
        return 'M';
      case 'large':
        return 'L';
      case 'giant':
        return 'GIANT';
      default:
        return size;
    }
  }

  String _mapWeightUnit(String? unit) {
    if (unit == null) return '';
    switch (unit.toLowerCase()) {
      case 'kg':
      case 'kgs':
        return 'kgs';
      case 'lb':
      case 'lbs':
        return 'lbs';
      default:
        return unit;
    }
  }

  String _mapHeightUnit(String? unit) {
    if (unit == null) return '';
    switch (unit.toLowerCase()) {
      case 'cm':
      case 'cms':
        return 'cms';
      case 'ft':
      case 'fts':
        return 'fts';
      default:
        return unit;
    }
  }

  Future<SaveHouseDetails> saveHouseDetails({
    required String parentName,
    required String houseName,
    required String relation,
    required bool isMultiplePets,
  }) async {
    final result = await _api.saveHouseDetails(
      parentName: parentName,
      houseName: houseName,
      relation: relation,
      isMultiplePets: isMultiplePets,
    );

    return SaveHouseDetailsMapper.toDomain(result.data);
  }

  Future<String> uploadProfilePictureToS3({
    required String userId,
    required File imageFile,
  }) async {
    if (userId.trim().isEmpty) {
      throw ArgumentError.value(userId, 'userId', 'userId cannot be empty');
    }

    if (!await imageFile.exists()) {
      throw ArgumentError.value(
        imageFile,
        'imageFile',
        'imageFile does not exist',
      );
    }

    final originalFileName = imageFile.path.split(Platform.pathSeparator).last;
    final mimeType = ImageUploadService.inferImageMimeTypeFromFileName(
      originalFileName,
    );
    final fileName = ImageUploadService.sanitizeUploadFileName(
      originalFileName: originalFileName,
      mimeType: mimeType,
    );
    final bytes = await imageFile.readAsBytes();

    final basePath = S3UploadPathBuilder.build(
      entityType: UploadEntityType.users,
      userId: userId,
      purpose: UploadPurpose.profile,
    );

    final fullUrl = await _imageUploadService.uploadSingleAndGetFullUrl(
      file: UploadUrlFileSpec(path: basePath, name: fileName, type: mimeType),
      fileBytes: bytes,
    );

    return fullUrl;
  }
}
