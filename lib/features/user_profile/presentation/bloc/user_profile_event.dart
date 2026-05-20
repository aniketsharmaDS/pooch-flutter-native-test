import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:poochcare/features/user_profile/domain/models/user_pet.dart';
import 'package:poochcare/features/user_profile/domain/models/user_profile.dart';

enum ProfileUploadingOrigin { register, login }

sealed class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class UserProfileStarted extends UserProfileEvent {
  const UserProfileStarted();
}

class UserProfileCleared extends UserProfileEvent {
  const UserProfileCleared();
}

class GetUserPetsEvent extends UserProfileEvent {
  const GetUserPetsEvent();
}

class GetParentGroupsEvent extends UserProfileEvent {
  const GetParentGroupsEvent();
}

class GetUserProfileEvent extends UserProfileEvent {
  const GetUserProfileEvent();
}

class UpdatePetProfileRequested extends UserProfileEvent {
  const UpdatePetProfileRequested({
    required this.oldPet,
    required this.updatedPet,
  });

  final UserPet oldPet;
  final UserPet updatedPet;

  @override
  List<Object?> get props => <Object?>[oldPet, updatedPet];
}

class UserProfileAvatarSelected extends UserProfileEvent {
  const UserProfileAvatarSelected({
    required this.file,
    this.profileUploadingOrigin = ProfileUploadingOrigin.login,
  });
  final File file;
  final ProfileUploadingOrigin profileUploadingOrigin;

  @override
  List<Object?> get props => <Object?>[file.path, profileUploadingOrigin];
}

class UserProfileSubmitted extends UserProfileEvent {
  const UserProfileSubmitted({
    required this.name,
    required this.phone,
    required this.email,
    required this.dateOfBirth,
    required this.gender,
    this.otpCode = '',
    this.countryCode = '',
  });

  final String name;
  final String phone;
  final String email;
  final String dateOfBirth;
  final String gender;
  final String? otpCode;
  final String countryCode;

  @override
  List<Object?> get props => <Object?>[
    name,
    phone,
    email,
    dateOfBirth,
    gender,
    otpCode,
    countryCode,
  ];
}

class UserProfileEditInitialized extends UserProfileEvent {
  const UserProfileEditInitialized({required this.profile});

  final UserProfile profile;

  @override
  List<Object?> get props => <Object?>[profile];
}

class UserProfileEditSubmitted extends UserProfileEvent {
  const UserProfileEditSubmitted({
    required this.name,
    required this.phone,
    required this.email,
    required this.dateOfBirth,
    required this.gender,
    this.countryCode = '',
    this.otp,
  });

  final String name;
  final String phone;
  final String email;
  final String dateOfBirth;
  final String gender;
  final String countryCode;
  final String? otp;

  @override
  List<Object?> get props => <Object?>[
    name,
    phone,
    email,
    dateOfBirth,
    gender,
    countryCode,
    otp,
  ];
}

class DeletePetRequested extends UserProfileEvent {
  const DeletePetRequested({required this.pet});

  final UserPet pet;

  @override
  List<Object?> get props => <Object?>[pet.id];
}

class ClearUserSessionData extends UserProfileEvent {
  const ClearUserSessionData();
}

class GetUserParentGroupsListEvent extends UserProfileEvent {
  const GetUserParentGroupsListEvent();
}
