import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:poochcare/features/user_profile/domain/models/user_pet.dart';
import 'package:poochcare/features/user_profile/domain/models/user_profile.dart';

enum UserProfileStatus { initial, loading, success, failure }

enum UpdatePetProfileStatus { initial, inProgress, success, failure }

enum DeletePetStatus { initial, inProgress, success, failure }

enum ParentGroupListStatus { initial, loading, success, failure }

class UserProfileState extends Equatable {
  const UserProfileState({
    this.status = UserProfileStatus.initial,
    this.profile,
    this.errorMessage,
    this.parentGroups = const <UserProfileParentGroup>[],
    this.isParentGroupsLoading = false,
    this.parentGroupsErrorMessage,
    this.isProfileLoading = false,
    this.profileErrorMessage,
    this.pets = const <UserPet>[],
    this.isPetsLoading = false,
    this.petsErrorMessage,
    this.localProfileImageFile,
    this.profilePictureUrl,
    this.isUploadingProfilePicture = false,
    this.updatePetProfileStatus = UpdatePetProfileStatus.initial,
    this.updatePetProfileErrorMessage,
    this.deletePetStatus = DeletePetStatus.initial,
    this.deletePetErrorMessage,
    this.deletingPetId,
    this.parentGroupListStatus = ParentGroupListStatus.initial,
  });

  final ParentGroupListStatus parentGroupListStatus;
  final UserProfileStatus status;
  final UserProfile? profile;
  final String? errorMessage;

  final List<UserProfileParentGroup> parentGroups;
  final bool isParentGroupsLoading;
  final String? parentGroupsErrorMessage;

  final bool isProfileLoading;
  final String? profileErrorMessage;

  final List<UserPet> pets;
  final bool isPetsLoading;
  final String? petsErrorMessage;

  final File? localProfileImageFile;
  final String? profilePictureUrl;
  final bool isUploadingProfilePicture;

  final UpdatePetProfileStatus updatePetProfileStatus;
  final String? updatePetProfileErrorMessage;

  final DeletePetStatus deletePetStatus;
  final String? deletePetErrorMessage;
  final String? deletingPetId;

  UserProfileState copyWith({
    UserProfileStatus? status,
    UserProfile? profile,
    String? errorMessage,
    List<UserProfileParentGroup>? parentGroups,
    bool? isParentGroupsLoading,
    String? parentGroupsErrorMessage,
    bool? isProfileLoading,
    String? profileErrorMessage,
    List<UserPet>? pets,
    bool? isPetsLoading,
    String? petsErrorMessage,
    File? localProfileImageFile,
    String? profilePictureUrl,
    bool? isUploadingProfilePicture,
    UpdatePetProfileStatus? updatePetProfileStatus,
    String? updatePetProfileErrorMessage,
    DeletePetStatus? deletePetStatus,
    String? deletePetErrorMessage,
    String? deletingPetId,
    bool clearError = false,
    bool clearParentGroupsError = false,
    bool clearProfileError = false,
    bool clearPetsError = false,
    bool clearUpdatePetError = false,
    bool clearDeletePetError = false,
    bool clearData = false,
    ParentGroupListStatus? parentGroupListStatus,
  }) {
    return UserProfileState(
      parentGroupListStatus:
          parentGroupListStatus ?? this.parentGroupListStatus,
      status: status ?? this.status,
      profile: clearData ? null : (profile ?? this.profile),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      parentGroups: clearData
          ? const <UserProfileParentGroup>[]
          : (parentGroups ?? this.parentGroups),
      isParentGroupsLoading:
          isParentGroupsLoading ?? this.isParentGroupsLoading,
      parentGroupsErrorMessage: clearParentGroupsError
          ? null
          : (parentGroupsErrorMessage ?? this.parentGroupsErrorMessage),
      isProfileLoading: isProfileLoading ?? this.isProfileLoading,
      profileErrorMessage: clearProfileError
          ? null
          : (profileErrorMessage ?? this.profileErrorMessage),
      pets: clearData ? const <UserPet>[] : (pets ?? this.pets),
      isPetsLoading: isPetsLoading ?? this.isPetsLoading,
      petsErrorMessage: clearPetsError
          ? null
          : (petsErrorMessage ?? this.petsErrorMessage),
      localProfileImageFile: clearData
          ? null
          : localProfileImageFile ?? this.localProfileImageFile,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      isUploadingProfilePicture:
          isUploadingProfilePicture ?? this.isUploadingProfilePicture,
      updatePetProfileStatus:
          updatePetProfileStatus ?? this.updatePetProfileStatus,
      updatePetProfileErrorMessage: clearUpdatePetError
          ? null
          : (updatePetProfileErrorMessage ?? this.updatePetProfileErrorMessage),
      deletePetStatus: deletePetStatus ?? this.deletePetStatus,
      deletePetErrorMessage: clearDeletePetError
          ? null
          : (deletePetErrorMessage ?? this.deletePetErrorMessage),
      deletingPetId: deletingPetId ?? this.deletingPetId,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    status,
    profile,
    errorMessage,
    parentGroups,
    isParentGroupsLoading,
    parentGroupsErrorMessage,
    isProfileLoading,
    profileErrorMessage,
    pets,
    isPetsLoading,
    petsErrorMessage,
    localProfileImageFile?.path,
    profilePictureUrl,
    isUploadingProfilePicture,
    updatePetProfileStatus,
    updatePetProfileErrorMessage,
    deletePetStatus,
    deletePetErrorMessage,
    deletingPetId,
  ];
}
