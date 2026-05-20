import 'dart:developer';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:poochcare/core/domain/models/user.dart' as core_user;
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/store/auth/auth_store_event.dart';
import 'package:poochcare/features/user_profile/domain/models/user_pet.dart';
import 'package:poochcare/features/user_profile/domain/models/user_profile.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_event.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_state.dart';
import 'package:poochcare/features/user_profile/repository/user_profile_repository.dart';

class UserProfileBloc extends HydratedBloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc({
    required UserProfileRepository repository,
    required AuthStoreBloc authStore,
  }) : _repository = repository,
       _authStore = authStore,
       super(const UserProfileState()) {
    on<UserProfileStarted>(_onStarted);
    on<UserProfileCleared>(_onCleared);
    on<GetParentGroupsEvent>(_onGetParentGroups);
    on<GetUserProfileEvent>(_onGetUserProfile);
    on<GetUserPetsEvent>(_onGetUserPets);
    on<UpdatePetProfileRequested>(_onUpdatePetProfileRequested);
    on<DeletePetRequested>(_onDeletePetRequested);
    on<UserProfileEditInitialized>(_onEditInitialized);
    on<UserProfileAvatarSelected>(_onAvatarSelected);
    on<UserProfileSubmitted>(_onSubmitted);
    on<UserProfileEditSubmitted>(_onEditSubmitted);
    on<ClearUserSessionData>(_onClearUserSessionData);
  }

  final UserProfileRepository _repository;
  final AuthStoreBloc _authStore;

  void _onClearUserSessionData(
    ClearUserSessionData event,
    Emitter<UserProfileState> emit,
  ) {
    emit(
      state.copyWith(
        status: UserProfileStatus.initial,
        clearData: true,
        clearError: true,
      ),
    );
  }

  void _onStarted(UserProfileStarted event, Emitter<UserProfileState> emit) {
    emit(state.copyWith(status: UserProfileStatus.initial, clearError: true));
  }

  Future<void> _onCleared(
    UserProfileCleared event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(const UserProfileState());
    await clear();
  }

  Future<void> _onGetUserProfile(
    GetUserProfileEvent event,
    Emitter<UserProfileState> emit,
  ) async {
    if (state.isProfileLoading) return;

    // if (state.isProfileLoading || state.profile != null) return;

    emit(state.copyWith(isProfileLoading: true, clearProfileError: true));

    try {
      final profile = await _repository.getUserProfile();

      // Keep auth store's basic user info in sync.
      final bool isOnboarded = _authStore.state.user?.isOnboarded ?? false;
      if (profile.id.trim().isNotEmpty) {
        _authStore.add(
          UserSignedIn(
            core_user.User(
              id: profile.id,
              name: profile.name,
              email: profile.email,
              phone: profile.phone,
              countryCode: profile.countryCode,
              isProfileCompleted: profile.isProfileCompleted,
              isPetOnboarded: profile.isPetOnboarded,
              isOnboarded: isOnboarded,
            ),
          ),
        );
      }

      emit(
        state.copyWith(
          isProfileLoading: false,
          profile: profile,
          profilePictureUrl: profile.profilePicture,
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(
          isProfileLoading: false,
          profileErrorMessage: error.message,
        ),
      );
    } catch (error) {
      log(error.toString());
      emit(
        state.copyWith(
          isProfileLoading: false,
          profileErrorMessage: 'Unable to load profile. Please try again.',
        ),
      );
    }
  }

  Future<void> _onGetUserPets(
    GetUserPetsEvent event,
    Emitter<UserProfileState> emit,
  ) async {
    if (state.isPetsLoading) return;

    emit(state.copyWith(isPetsLoading: true, clearPetsError: true));

    try {
      final pets = await _repository.getUserPets();
      _authStore.add(OnboardingPetCountUpdated(count: pets.length));
      emit(state.copyWith(isPetsLoading: false, pets: pets));
    } on ApiException catch (error) {
      emit(
        state.copyWith(isPetsLoading: false, petsErrorMessage: error.message),
      );
    } catch (error) {
      log(error.toString());
      emit(
        state.copyWith(
          isPetsLoading: false,
          petsErrorMessage: 'Unable to load pets. Please try again.',
        ),
      );
    }
  }

  Future<void> _onGetParentGroups(
    GetParentGroupsEvent event,
    Emitter<UserProfileState> emit,
  ) async {
    if (state.isParentGroupsLoading) return;
    // if (state.isParentGroupsLoading || state.parentGroups.isNotEmpty) return;

    emit(
      state.copyWith(isParentGroupsLoading: true, clearParentGroupsError: true),
    );

    try {
      final parentGroups = await _repository.getParentGroups();
      emit(
        state.copyWith(
          isParentGroupsLoading: false,
          parentGroups: parentGroups,
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(
          isParentGroupsLoading: false,
          parentGroupsErrorMessage: error.message,
        ),
      );
    } catch (error) {
      log(error.toString());
      emit(
        state.copyWith(
          isParentGroupsLoading: false,
          parentGroupsErrorMessage:
              'Unable to load parent groups. Please try again.',
        ),
      );
    }
  }

  Future<void> _onUpdatePetProfileRequested(
    UpdatePetProfileRequested event,
    Emitter<UserProfileState> emit,
  ) async {
    if (state.updatePetProfileStatus == UpdatePetProfileStatus.inProgress) {
      return;
    }

    if (!event.oldPet.canEdit) {
      emit(
        state.copyWith(
          updatePetProfileStatus: UpdatePetProfileStatus.failure,
          updatePetProfileErrorMessage:
              'You do not have permission to edit this pet.',
        ),
      );
      return;
    }

    final List<UserPet> optimisticPets = List<UserPet>.from(state.pets);
    final int index = optimisticPets.indexWhere((p) => p.id == event.oldPet.id);
    if (index != -1) {
      optimisticPets[index] = event.updatedPet;
    }

    emit(
      state.copyWith(
        pets: optimisticPets,
        updatePetProfileStatus: UpdatePetProfileStatus.inProgress,
        clearUpdatePetError: true,
      ),
    );

    try {
      await _repository.updatePetProfile(event.updatedPet);
      emit(
        state.copyWith(updatePetProfileStatus: UpdatePetProfileStatus.success),
      );
      emit(
        state.copyWith(
          updatePetProfileStatus: UpdatePetProfileStatus.initial,
          clearUpdatePetError: true,
        ),
      );
    } on ApiException catch (error) {
      final List<UserPet> rollbackPets = List<UserPet>.from(state.pets);
      final int rollbackIndex = rollbackPets.indexWhere(
        (p) => p.id == event.oldPet.id,
      );
      if (rollbackIndex != -1) {
        rollbackPets[rollbackIndex] = event.oldPet;
      }

      emit(
        state.copyWith(
          pets: rollbackPets,
          updatePetProfileStatus: UpdatePetProfileStatus.failure,
          updatePetProfileErrorMessage: error.message,
        ),
      );
    } catch (error) {
      log(error.toString());

      final List<UserPet> rollbackPets = List<UserPet>.from(state.pets);
      final int rollbackIndex = rollbackPets.indexWhere(
        (p) => p.id == event.oldPet.id,
      );
      if (rollbackIndex != -1) {
        rollbackPets[rollbackIndex] = event.oldPet;
      }

      emit(
        state.copyWith(
          pets: rollbackPets,
          updatePetProfileStatus: UpdatePetProfileStatus.failure,
          updatePetProfileErrorMessage:
              'Unable to update pet profile. Please try again.',
        ),
      );
    }
  }

  Future<void> _onDeletePetRequested(
    DeletePetRequested event,
    Emitter<UserProfileState> emit,
  ) async {
    if (state.deletePetStatus == DeletePetStatus.inProgress) {
      return;
    }

    if (!event.pet.canDelete) {
      emit(
        state.copyWith(
          deletePetStatus: DeletePetStatus.failure,
          deletePetErrorMessage:
              'You do not have permission to delete this pet.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        deletingPetId: event.pet.id,
        deletePetStatus: DeletePetStatus.inProgress,
        clearDeletePetError: true,
      ),
    );

    try {
      await _repository.deletePet(event.pet.id);

      // Remove pet from list after successful deletion
      final updatedPets = state.pets
          .where((pet) => pet.id != event.pet.id)
          .toList();

      emit(
        state.copyWith(
          pets: updatedPets,
          deletePetStatus: DeletePetStatus.success,
        ),
      );

      // Reset status after a short delay
      emit(
        state.copyWith(
          deletePetStatus: DeletePetStatus.initial,
          clearDeletePetError: true,
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(
          deletePetStatus: DeletePetStatus.failure,
          deletePetErrorMessage: error.message,
        ),
      );
    } catch (error) {
      log(error.toString());
      emit(
        state.copyWith(
          deletePetStatus: DeletePetStatus.failure,
          deletePetErrorMessage: 'Unable to delete pet. Please try again.',
        ),
      );
    }
  }

  void _onEditInitialized(
    UserProfileEditInitialized event,
    Emitter<UserProfileState> emit,
  ) {
    emit(
      state.copyWith(
        profile: event.profile,
        profilePictureUrl: event.profile.profilePicture,
        clearError: true,
      ),
    );
  }

  Future<void> _onAvatarSelected(
    UserProfileAvatarSelected event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        localProfileImageFile: event.file,
        isUploadingProfilePicture: true,
        clearError: true,
      ),
    );

    try {
      final userId = _authStore.state.user?.id ?? '';
      if (userId.trim().isEmpty) {
        emit(
          state.copyWith(
            isUploadingProfilePicture: false,
            errorMessage: 'Missing user id. Please login again.',
          ),
        );
        return;
      }

      final url = await _repository.uploadProfilePictureToS3(
        userId: userId,
        imageFile: event.file,
      );
      if (event.profileUploadingOrigin == ProfileUploadingOrigin.login) {
        final data = state.profile;
        final updatedProfile = await _repository.updateProfile(
          name: data?.name ?? '',
          email: data?.email ?? '',
          phone: data?.phone ?? '',
          dateOfBirth: data?.dateOfBirth ?? '',
          otpCode: null,
          countryCode: data?.countryCode ?? '',
          profilePicture: url,
          gender: data?.gender ?? '',
        );
        emit(
          state.copyWith(
            profilePictureUrl: url,
            isUploadingProfilePicture: false,
            profile: updatedProfile,
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          profilePictureUrl: url,
          isUploadingProfilePicture: false,
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(
          isUploadingProfilePicture: false,
          errorMessage: error.message,
        ),
      );
    } catch (error) {
      log(error.toString());
      emit(
        state.copyWith(
          isUploadingProfilePicture: false,
          errorMessage: 'Unable to upload profile picture. Please try again.',
        ),
      );
    }
  }

  Future<void> _onSubmitted(
    UserProfileSubmitted event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(status: UserProfileStatus.loading, clearError: true));

    try {
      final profile = await _repository.updateProfile(
        name: event.name,
        email: event.email,
        phone: event.phone,
        dateOfBirth: event.dateOfBirth,
        otpCode: event.otpCode,
        countryCode: event.countryCode,
        profilePicture: state.profilePictureUrl ?? '',
        gender: event.gender,
      );

      // Keep auth store's basic user info in sync.
      final bool isOnboarded = _authStore.state.user?.isOnboarded ?? false;
      final bool isProfileCompleted =
          _authStore.state.user?.isProfileCompleted ?? false;
      final bool isPetOnboarded =
          _authStore.state.user?.isPetOnboarded ?? false;
      _authStore.add(
        UserSignedIn(
          core_user.User(
            id: profile.id,
            name: profile.name,
            email: profile.email,
            isOnboarded: isOnboarded,
            countryCode: profile.countryCode,
            phone: profile.phone,
            isProfileCompleted: isProfileCompleted,
            isPetOnboarded: isPetOnboarded,
          ),
        ),
      );

      emit(state.copyWith(status: UserProfileStatus.success, profile: profile));
    } on ApiException catch (error) {
      emit(
        state.copyWith(
          status: UserProfileStatus.failure,
          errorMessage: error.message,
        ),
      );
    } catch (error) {
      log(error.toString());
      emit(
        state.copyWith(
          status: UserProfileStatus.failure,
          errorMessage: 'Unable to update profile. Please try again.',
        ),
      );
    }
  }

  Future<void> _onEditSubmitted(
    UserProfileEditSubmitted event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(status: UserProfileStatus.loading, clearError: true));

    try {
      final profilePicture =
          (state.profilePictureUrl ?? state.profile?.profilePicture ?? '')
              .trim();
      final profile = await _repository.updateProfile(
        name: event.name,
        email: event.email,
        phone: event.phone,
        dateOfBirth: event.dateOfBirth,
        otpCode: event.otp,
        countryCode: event.countryCode,
        profilePicture: profilePicture,
        gender: event.gender,
      );

      final bool isOnboarded = _authStore.state.user?.isOnboarded ?? false;
      final bool isProfileCompleted =
          _authStore.state.user?.isProfileCompleted ?? false;
      final bool isPetOnboarded =
          _authStore.state.user?.isPetOnboarded ?? false;
      _authStore.add(
        UserSignedIn(
          core_user.User(
            id: profile.id,
            name: profile.name,
            email: profile.email,
            phone: profile.phone,
            isOnboarded: isOnboarded,
            countryCode: profile.countryCode,
            isProfileCompleted: isProfileCompleted,
            isPetOnboarded: isPetOnboarded,
          ),
        ),
      );

      emit(
        state.copyWith(
          status: UserProfileStatus.success,
          profile: profile,
          profilePictureUrl: profile.profilePicture,
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(
          status: UserProfileStatus.failure,
          errorMessage: error.message,
        ),
      );
    } catch (error) {
      log(error.toString());
      emit(
        state.copyWith(
          status: UserProfileStatus.failure,
          errorMessage: 'Unable to update profile. Please try again.',
        ),
      );
    }
  }

  @override
  UserProfileState? fromJson(Map<String, dynamic> json) {
    try {
      final profileJson = json['profile'] as Map<String, dynamic>?;
      final profilePictureUrl = json['profilePictureUrl'] as String?;
      final petsJson = json['pets'] as List<dynamic>?;
      final parentGroupsJson = json['parentGroups'] as List<dynamic>?;

      final profile = profileJson == null
          ? null
          : UserProfile(
              id: profileJson['id'] as String? ?? '',
              name: profileJson['name'] as String? ?? '',
              email: profileJson['email'] as String? ?? '',
              phone: profileJson['phone'] as String? ?? '',
              primaryIdentifier:
                  profileJson['primaryIdentifier'] as String? ?? '',
              countryCode: profileJson['countryCode'] as String? ?? '',
              country: profileJson['country'] as String? ?? '',
              provider: profileJson['provider'] as String? ?? '',
              providerId: profileJson['providerId'] as String? ?? '',
              isSocialLogin: profileJson['isSocialLogin'] as bool? ?? false,
              role: profileJson['role'] as String? ?? '',
              isVerified: profileJson['isVerified'] as bool? ?? false,
              isActive: profileJson['isActive'] as bool? ?? false,
              isDeleted: profileJson['isDeleted'] as bool? ?? false,
              deletedBy: profileJson['deletedBy'] as String? ?? '',
              deletedAt: profileJson['deletedAt'] as String? ?? '',
              deletedAtLegacy: profileJson['deletedAtLegacy'] as String? ?? '',
              deletionReason: profileJson['deletionReason'] as String? ?? '',
              isOnboarded: profileJson['isOnboarded'] as bool? ?? false,
              isProfileCompleted:
                  profileJson['isProfileCompleted'] as bool? ?? false,
              isPetOnboarded: profileJson['isPetOnboarded'] as bool? ?? false,
              points: profileJson['points'] as int? ?? 0,
              createdAt: profileJson['createdAt'] as String? ?? '',
              updatedAt: profileJson['updatedAt'] as String? ?? '',
              createdAtLegacy: profileJson['createdAtLegacy'] as String? ?? '',
              updatedAtLegacy: profileJson['updatedAtLegacy'] as String? ?? '',
              profileId: profileJson['profileId'] as String? ?? '',
              profileUserId: profileJson['profileUserId'] as String? ?? '',
              profilePicture: profileJson['profilePicture'] as String? ?? '',
              dateOfBirth: profileJson['dateOfBirth'] as String? ?? '',
              gender: profileJson['gender'] as String? ?? '',
              bio: profileJson['bio'] as String? ?? '',
              languagePreference:
                  profileJson['languagePreference'] as String? ?? '',
              profileCreatedAt:
                  profileJson['profileCreatedAt'] as String? ?? '',
              profileUpdatedAt:
                  profileJson['profileUpdatedAt'] as String? ?? '',
              profileUserIdLegacy:
                  profileJson['profileUserIdLegacy'] as String? ?? '',
              parentGroups: _parentGroupsFromJson(
                profileJson['parentGroups'] as List<dynamic>?,
              ),
              invites:
                  profileJson['invites'] as List<dynamic>? ?? const <dynamic>[],
            );

      final pets =
          petsJson
              ?.map(
                (petJson) => _userPetFromJson(petJson as Map<String, dynamic>),
              )
              .toList() ??
          const <UserPet>[];

      return UserProfileState(
        profile: profile,
        profilePictureUrl: profilePictureUrl ?? profile?.profilePicture,
        pets: pets,
        parentGroups: parentGroupsJson == null
            ? (profile?.parentGroups ?? const <UserProfileParentGroup>[])
            : _parentGroupsFromJson(parentGroupsJson),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(UserProfileState state) {
    final profile = state.profile;
    final pets = state.pets;
    final profilePictureUrl = state.profilePictureUrl;

    if (profile == null && pets.isEmpty && (profilePictureUrl ?? '').isEmpty) {
      return null;
    }

    return {
      'profile': profile == null
          ? null
          : {
              'id': profile.id,
              'name': profile.name,
              'email': profile.email,
              'phone': profile.phone,
              'primaryIdentifier': profile.primaryIdentifier,
              'countryCode': profile.countryCode,
              'country': profile.country,
              'provider': profile.provider,
              'providerId': profile.providerId,
              'isSocialLogin': profile.isSocialLogin,
              'role': profile.role,
              'isVerified': profile.isVerified,
              'isActive': profile.isActive,
              'isDeleted': profile.isDeleted,
              'deletedBy': profile.deletedBy,
              'deletedAt': profile.deletedAt,
              'deletedAtLegacy': profile.deletedAtLegacy,
              'deletionReason': profile.deletionReason,
              'isOnboarded': profile.isOnboarded,
              'isProfileCompleted': profile.isProfileCompleted,
              'isPetOnboarded': profile.isPetOnboarded,
              'points': profile.points,
              'createdAt': profile.createdAt,
              'updatedAt': profile.updatedAt,
              'createdAtLegacy': profile.createdAtLegacy,
              'updatedAtLegacy': profile.updatedAtLegacy,
              'profileId': profile.profileId,
              'profileUserId': profile.profileUserId,
              'profilePicture': profile.profilePicture,
              'dateOfBirth': profile.dateOfBirth,
              'gender': profile.gender,
              'bio': profile.bio,
              'languagePreference': profile.languagePreference,
              'profileCreatedAt': profile.profileCreatedAt,
              'profileUpdatedAt': profile.profileUpdatedAt,
              'profileUserIdLegacy': profile.profileUserIdLegacy,
              'parentGroups': profile.parentGroups
                  .map(_parentGroupToJson)
                  .toList(),
              'invites': profile.invites,
            },
      'profilePictureUrl': profilePictureUrl,
      'pets': pets.map(_userPetToJson).toList(),
      'parentGroups': state.parentGroups.map(_parentGroupToJson).toList(),
    };
  }

  UserPet _userPetFromJson(Map<String, dynamic> json) {
    return UserPet(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      type: json['type'] as String? ?? '',
      breedId: json['breedId'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      dob: json['dob'] as String? ?? '',
      size: json['size'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      weightUnit: json['weightUnit'] as String?,
      heightUnit: json['heightUnit'] as String?,
      bcsScore: json['bcsScore'] as int?,
      healthInfo: json['healthInfo'] as String?,
      profilePicture: json['profilePicture'] as String?,
      breedName: json['breedName'] as String?,
      canEdit: json['canEdit'] as bool? ?? false,
      canDelete: json['canDelete'] as bool? ?? false,
    );
  }

  List<UserProfileParentGroup> _parentGroupsFromJson(List<dynamic>? json) {
    if (json == null) return const <UserProfileParentGroup>[];

    return json
        .whereType<Map<String, dynamic>>()
        .map(_parentGroupFromJson)
        .toList();
  }

  UserProfileParentGroup _parentGroupFromJson(Map<String, dynamic> json) {
    final petsJson = json['pets'] as List<dynamic>? ?? const <dynamic>[];
    final membersJson = json['members'] as List<dynamic>? ?? const <dynamic>[];

    return UserProfileParentGroup(
      id: json['id'] as String? ?? '',
      name: (json['name'] as String?) ?? (json['houseName'] as String?) ?? '',
      userRole: json['userRole'] as String? ?? '',
      isOwner: json['isOwner'] as bool? ?? false,
      pets: petsJson
          .whereType<Map<String, dynamic>>()
          .map(_parentGroupPetFromJson)
          .toList(),
      members: membersJson
          .whereType<Map<String, dynamic>>()
          .map(_parentGroupMemberFromJson)
          .toList(),
    );
  }

  UserProfileParentGroupMember _parentGroupMemberFromJson(
    Map<String, dynamic> json,
  ) {
    return UserProfileParentGroupMember(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      role: json['role'] as String? ?? '',
      joinedAt: json['joinedAt'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      dateOfBirth: json['dateOfBirth'] as String? ?? '',
      profilePicture: json['profilePicture'] as String? ?? '',
    );
  }

  UserProfileParentGroupPet _parentGroupPetFromJson(Map<String, dynamic> json) {
    return UserProfileParentGroupPet(
      id: json['id'] as String? ?? '',
      petNumber: json['petNumber'] as String? ?? '',
      parentGroupId: json['parentGroupId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      orderItemId: json['orderItemId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      type: json['type'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      breedId: json['breedId'] as String? ?? '',
      dob: json['dob'] as String? ?? '',
      size: json['size'] as String? ?? '',
      bcsScore: json['bcsScore'] as int? ?? 0,
      height: (json['height'] as num?)?.toDouble() ?? 0,
      weight: (json['weight'] as num?)?.toDouble() ?? 0,
      heightUnit: json['heightUnit'] as String? ?? '',
      weightUnit: json['weightUnit'] as String? ?? '',
      profilePicture: json['profilePicture'] as String? ?? '',
      healthInfo: json['healthInfo'] as String? ?? '',
      createdAtLegacy: json['createdAtLegacy'] as String? ?? '',
      updatedAtLegacy: json['updatedAtLegacy'] as String? ?? '',
      deletedAtLegacy: json['deletedAtLegacy'] as String? ?? '',
      userIdLegacy: json['userIdLegacy'] as String? ?? '',
      parentGroupIdLegacy: json['parentGroupIdLegacy'] as String? ?? '',
      breedInfo: _breedInfoFromJson(json['breedInfo'] as Map<String, dynamic>?),
    );
  }

  UserProfileBreedInfo? _breedInfoFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return UserProfileBreedInfo(
      id: json['id'] as String? ?? '',
      breedName: json['breedName'] as String? ?? '',
      petType: json['petType'] as String? ?? '',
      sizeCategory: json['sizeCategory'] as String? ?? '',
    );
  }

  Map<String, dynamic> _parentGroupToJson(UserProfileParentGroup group) {
    return <String, dynamic>{
      'id': group.id,
      'name': group.name,
      'userRole': group.userRole,
      'isOwner': group.isOwner,
      'pets': group.pets.map(_parentGroupPetToJson).toList(),
      'members': group.members.map(_parentGroupMemberToJson).toList(),
    };
  }

  Map<String, dynamic> _parentGroupMemberToJson(
    UserProfileParentGroupMember member,
  ) {
    return <String, dynamic>{
      'id': member.id,
      'name': member.name,
      'email': member.email,
      'phone': member.phone,
      'role': member.role,
      'joinedAt': member.joinedAt,
      'gender': member.gender,
      'dateOfBirth': member.dateOfBirth,
      'profilePicture': member.profilePicture,
    };
  }

  Map<String, dynamic> _parentGroupPetToJson(UserProfileParentGroupPet pet) {
    return <String, dynamic>{
      'id': pet.id,
      'petNumber': pet.petNumber,
      'parentGroupId': pet.parentGroupId,
      'userId': pet.userId,
      'orderItemId': pet.orderItemId,
      'name': pet.name,
      'type': pet.type,
      'gender': pet.gender,
      'breedId': pet.breedId,
      'dob': pet.dob,
      'size': pet.size,
      'bcsScore': pet.bcsScore,
      'height': pet.height,
      'weight': pet.weight,
      'heightUnit': pet.heightUnit,
      'weightUnit': pet.weightUnit,
      'profilePicture': pet.profilePicture,
      'healthInfo': pet.healthInfo,
      'createdAtLegacy': pet.createdAtLegacy,
      'updatedAtLegacy': pet.updatedAtLegacy,
      'deletedAtLegacy': pet.deletedAtLegacy,
      'userIdLegacy': pet.userIdLegacy,
      'parentGroupIdLegacy': pet.parentGroupIdLegacy,
      'breedInfo': _breedInfoToJson(pet.breedInfo),
    };
  }

  Map<String, dynamic>? _breedInfoToJson(UserProfileBreedInfo? info) {
    if (info == null) return null;

    return <String, dynamic>{
      'id': info.id,
      'breedName': info.breedName,
      'petType': info.petType,
      'sizeCategory': info.sizeCategory,
    };
  }

  Map<String, dynamic> _userPetToJson(UserPet pet) {
    return {
      'id': pet.id,
      'name': pet.name,
      'type': pet.type,
      'breedId': pet.breedId,
      'gender': pet.gender,
      'dob': pet.dob,
      'size': pet.size,
      'weight': pet.weight,
      'height': pet.height,
      'weightUnit': pet.weightUnit,
      'heightUnit': pet.heightUnit,
      'bcsScore': pet.bcsScore,
      'healthInfo': pet.healthInfo,
      'profilePicture': pet.profilePicture,
      'breedName': pet.breedName,
      'canEdit': pet.canEdit,
      'canDelete': pet.canDelete,
    };
  }
}
