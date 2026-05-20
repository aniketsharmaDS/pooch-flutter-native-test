import 'package:equatable/equatable.dart';
import 'package:poochcare/features/pets/data/models/pet_insights_response.dart';
import 'package:poochcare/features/pets/domain/models/breed.dart';

enum PetsStatus { initial, loading, success, failure }

enum AddPetStatus { initial, loading, success, failure }

enum PetInsightsStatus { initial, loading, success, failure }

class PetsState extends Equatable {
  const PetsState({
    this.status = PetsStatus.initial,
    this.errorMessage,
    this.addPetStatus = AddPetStatus.initial,
    this.addPetErrorMessage,
    this.breeds = const <Breed>[],
    this.isBreedsLoading = false,
    this.breedsErrorMessage,
    this.breedsPetType,
    this.uploadedPetImageUrl,
    this.isUploadingPetProfilePicture = false,
    this.petInsightsStatus = PetInsightsStatus.initial,
    this.petInsights,
    this.petInsightsPetId,
    this.petInsightsErrorMessage,
  });

  final PetsStatus status;
  final String? errorMessage;

  final AddPetStatus addPetStatus;
  final String? addPetErrorMessage;

  final List<Breed> breeds;
  final bool isBreedsLoading;
  final String? breedsErrorMessage;
  final String? breedsPetType;

  final String? uploadedPetImageUrl;
  final bool isUploadingPetProfilePicture;

  final PetInsightsStatus petInsightsStatus;
  final PetInsightsResponse? petInsights;
  final String? petInsightsPetId;
  final String? petInsightsErrorMessage;

  PetsState copyWith({
    PetsStatus? status,
    String? errorMessage,
    AddPetStatus? addPetStatus,
    String? addPetErrorMessage,
    List<Breed>? breeds,
    bool? isBreedsLoading,
    String? breedsErrorMessage,
    String? breedsPetType,
    String? uploadedPetImageUrl,
    bool? isUploadingPetProfilePicture,
    PetInsightsStatus? petInsightsStatus,
    PetInsightsResponse? petInsights,
    String? petInsightsPetId,
    String? petInsightsErrorMessage,
    bool clearBreedsError = false,
    bool clearBreeds = false,
    bool clearAddPetError = false,
    bool clearPetInsightsError = false,
  }) {
    return PetsState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      addPetStatus: addPetStatus ?? this.addPetStatus,
      addPetErrorMessage: clearAddPetError
          ? null
          : (addPetErrorMessage ?? this.addPetErrorMessage),
      breeds: clearBreeds ? const <Breed>[] : (breeds ?? this.breeds),
      isBreedsLoading: isBreedsLoading ?? this.isBreedsLoading,
      breedsErrorMessage: clearBreedsError
          ? null
          : (breedsErrorMessage ?? this.breedsErrorMessage),
      breedsPetType: breedsPetType ?? this.breedsPetType,
      uploadedPetImageUrl: uploadedPetImageUrl ?? this.uploadedPetImageUrl,
      isUploadingPetProfilePicture:
          isUploadingPetProfilePicture ?? this.isUploadingPetProfilePicture,
      petInsightsStatus: petInsightsStatus ?? this.petInsightsStatus,
      petInsights: petInsights ?? this.petInsights,
      petInsightsPetId: petInsightsPetId ?? this.petInsightsPetId,
      petInsightsErrorMessage: clearPetInsightsError
          ? null
          : (petInsightsErrorMessage ?? this.petInsightsErrorMessage),
    );
  }

  @override
  List<Object?> get props => <Object?>[
    status,
    errorMessage,
    addPetStatus,
    addPetErrorMessage,
    breeds,
    isBreedsLoading,
    breedsErrorMessage,
    breedsPetType,
    uploadedPetImageUrl,
    isUploadingPetProfilePicture,
    petInsightsStatus,
    petInsights,
    petInsightsPetId,
    petInsightsErrorMessage,
  ];
}
