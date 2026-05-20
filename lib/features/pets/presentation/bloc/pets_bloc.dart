import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/features/pets/presentation/bloc/pets_event.dart';
import 'package:poochcare/features/pets/presentation/bloc/pets_state.dart';
import 'package:poochcare/features/pets/repository/pets_repository.dart';
import 'package:poochcare/features/user_profile/repository/user_profile_repository.dart';

class PetsBloc extends Bloc<PetsEvent, PetsState> {
  PetsBloc(this._repo, this._userProfileRepository) : super(const PetsState()) {
    on<CreatePetEvent>(_onCreatePet);
    on<AddPetRequested>(_onAddPetRequested);
    on<BreedsRequested>(_onBreedsRequested);
    on<GetPetInsightsEvent>(_onGetPetInsights);
    on<UploadPetProfileImageEvent>(_onUploadPetProfileImage);
    on<PetImageCleared>(_onPetImageCleared);
  }

  final PetsRepository _repo;
  final UserProfileRepository _userProfileRepository;

  Future<void> _onGetPetInsights(
    GetPetInsightsEvent event,
    Emitter<PetsState> emit,
  ) async {
    final petId = event.petId.trim();
    if (petId.isEmpty) {
      emit(
        state.copyWith(
          petInsightsStatus: PetInsightsStatus.failure,
          petInsightsErrorMessage: 'Unable to load pet insights.',
        ),
      );
      return;
    }

    if (state.petInsightsStatus == PetInsightsStatus.loading &&
        state.petInsightsPetId == petId) {
      return;
    }

    emit(
      state.copyWith(
        petInsightsStatus: PetInsightsStatus.loading,
        petInsightsPetId: petId,
        clearPetInsightsError: true,
      ),
    );

    try {
      final insights = await _repo.getPetInsights(petId: petId);
      emit(
        state.copyWith(
          petInsightsStatus: PetInsightsStatus.success,
          petInsightsPetId: petId,
          petInsights: insights,
        ),
      );
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          petInsightsStatus: PetInsightsStatus.failure,
          petInsightsPetId: petId,
          petInsightsErrorMessage: e.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          petInsightsStatus: PetInsightsStatus.failure,
          petInsightsPetId: petId,
          petInsightsErrorMessage: 'Unable to load pet insights.',
        ),
      );
    }
  }

  Future<void> _onBreedsRequested(
    BreedsRequested event,
    Emitter<PetsState> emit,
  ) async {
    if (state.isBreedsLoading) {
      return;
    }

    final bool isSameType = state.breedsPetType == event.petType;
    if (isSameType && state.breeds.isNotEmpty) {
      return;
    }

    emit(
      state.copyWith(
        isBreedsLoading: true,
        breedsPetType: event.petType,
        clearBreedsError: true,
        clearBreeds: !isSameType,
      ),
    );

    try {
      final breeds = await _repo.fetchBreeds(petType: event.petType);
      emit(
        state.copyWith(
          isBreedsLoading: false,
          breedsPetType: event.petType,
          breeds: breeds,
        ),
      );
    } on ApiException catch (e) {
      emit(
        state.copyWith(isBreedsLoading: false, breedsErrorMessage: e.message),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isBreedsLoading: false,
          breedsErrorMessage: 'Unable to load breeds',
        ),
      );
    }
  }

  Future<void> _onUploadPetProfileImage(
    UploadPetProfileImageEvent event,
    Emitter<PetsState> emit,
  ) async {
    emit(state.copyWith(isUploadingPetProfilePicture: true));

    try {
      final imageUrl = await _repo.uploadPetProfileImageDirect(
        imageFile: event.imageFile,
      );
      emit(
        state.copyWith(
          isUploadingPetProfilePicture: false,
          uploadedPetImageUrl: imageUrl,
        ),
      );
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          isUploadingPetProfilePicture: false,
          errorMessage: e.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isUploadingPetProfilePicture: false,
          errorMessage: 'Failed to upload image',
        ),
      );
    }
  }

  Future<void> _onCreatePet(
    CreatePetEvent event,
    Emitter<PetsState> emit,
  ) async {
    emit(state.copyWith(status: PetsStatus.loading));

    try {
      await _repo.createPet(event.pet);
      emit(state.copyWith(status: PetsStatus.success));
    } on ApiException catch (e) {
      emit(state.copyWith(status: PetsStatus.failure, errorMessage: e.message));
    } catch (_) {
      emit(
        state.copyWith(
          status: PetsStatus.failure,
          errorMessage: 'Something went wrong',
        ),
      );
    }
  }

  Future<void> _onAddPetRequested(
    AddPetRequested event,
    Emitter<PetsState> emit,
  ) async {
    if (state.addPetStatus == AddPetStatus.loading) {
      return;
    }

    emit(
      state.copyWith(
        addPetStatus: AddPetStatus.loading,
        clearAddPetError: true,
      ),
    );

    try {
      final parentGroupId = await _userProfileRepository
          .getPreferredParentGroupId();

      if (parentGroupId == null || parentGroupId.trim().isEmpty) {
        emit(
          state.copyWith(
            addPetStatus: AddPetStatus.failure,
            addPetErrorMessage: 'Unable to add pet. Please try again later.',
          ),
        );
        return;
      }

      await _repo.addPetToParentGroup(
        parentGroupId: parentGroupId,
        pet: event.pet,
      );
      emit(state.copyWith(addPetStatus: AddPetStatus.success));
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          addPetStatus: AddPetStatus.failure,
          addPetErrorMessage: e.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          addPetStatus: AddPetStatus.failure,
          addPetErrorMessage: 'Unable to add pet. Please try again.',
        ),
      );
    }
  }

  Future<void> _onPetImageCleared(
    PetImageCleared event,
    Emitter<PetsState> emit,
  ) async {
    emit(
      state.copyWith(
        uploadedPetImageUrl: '',
        isUploadingPetProfilePicture: false,
      ),
    );
  }
}
