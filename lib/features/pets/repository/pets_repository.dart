import 'dart:io';

import 'package:poochcare/core/services/image_upload_service.dart';
import 'package:poochcare/core/services/s3_upload_path_builder.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/features/pets/data/api/pets_api_service.dart';
import 'package:poochcare/features/pets/data/models/pet_insights_response.dart';
import 'package:poochcare/features/pets/data/models/pet_model.dart';
import 'package:poochcare/features/pets/domain/models/breed.dart';
import 'package:poochcare/features/pets/domain/models/pet.dart';

class PetsRepository {
  const PetsRepository({
    required PetsApiService api,
    required ImageUploadService imageUploadService,
    required AuthStoreBloc authStore,
  }) : _api = api,
       _imageUploadService = imageUploadService,
       _authStore = authStore;

  final PetsApiService _api;
  final ImageUploadService _imageUploadService;
  final AuthStoreBloc _authStore;

  Future<List<Breed>> fetchBreeds({required String petType}) {
    return _api.getBreeds(petType: petType);
  }

  Future<PetInsightsResponse> getPetInsights({String? petId}) {
    return _api.getPetInsights(petId: petId);
  }

  Future<void> createPet(Pet pet) async {
    final String? profilePictureUrl = await _maybeUploadProfilePicture(
      profilePicturePath: pet.profilePicture,
    );

    final PetModel model = PetModel(
      profilePicture: profilePictureUrl,
      bcsScore: pet.bcsScore,
      name: pet.name,
      type: pet.type,
      breedId: pet.breedId,
      gender: pet.gender,
      dob: pet.dob,
      size: pet.size,
      weight: pet.weight,
      height: pet.height,
      heightUnit: pet.heightUnit,
      weightUnit: pet.weightUnit,
      healthInfo: pet.healthInfo,
    );

    await _api.createPet(model);
  }

  Future<void> addPetToParentGroup({
    required String parentGroupId,
    required Pet pet,
  }) async {
    final String? profilePictureUrl = await _maybeUploadProfilePicture(
      profilePicturePath: pet.profilePicture,
    );

    final PetModel model = PetModel(
      profilePicture: profilePictureUrl,
      bcsScore: pet.bcsScore,
      name: pet.name,
      type: pet.type,
      breedId: pet.breedId,
      gender: pet.gender,
      dob: pet.dob,
      size: pet.size,
      weight: pet.weight,
      height: pet.height,
      heightUnit: pet.heightUnit,
      weightUnit: pet.weightUnit,
      healthInfo: pet.healthInfo,
    );

    await _api.addPetToParentGroup(parentGroupId: parentGroupId, pet: model);
  }

  Future<String> uploadPetProfilePictureToS3({
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
      entityType: UploadEntityType.pets,
      userId: userId,
      purpose: UploadPurpose.profile,
    );

    final fullUrl = await _imageUploadService.uploadSingleAndGetFullUrl(
      file: UploadUrlFileSpec(path: basePath, name: fileName, type: mimeType),
      fileBytes: bytes,
    );

    return fullUrl;
  }

  Future<String> uploadPetProfileImageDirect({required File imageFile}) async {
    final userId = _authStore.state.user?.id;
    if (userId == null || userId.trim().isEmpty) {
      throw ArgumentError('Cannot upload pet image: missing userId');
    }

    return uploadPetProfilePictureToS3(userId: userId, imageFile: imageFile);
  }

  Future<String?> _maybeUploadProfilePicture({
    required String? profilePicturePath,
  }) async {
    final String? raw = profilePicturePath?.trim();
    if (raw == null || raw.isEmpty) return null;

    final lower = raw.toLowerCase();
    if (lower.startsWith('http://') || lower.startsWith('https://')) {
      return raw;
    }

    final userId = _authStore.state.user?.id;
    if (userId == null || userId.trim().isEmpty) {
      throw ArgumentError('Cannot upload pet image: missing userId');
    }

    final file = File(raw);
    if (!await file.exists()) {
      return null;
    }

    return uploadPetProfilePictureToS3(userId: userId, imageFile: file);
  }
}
