import 'package:equatable/equatable.dart';
import 'package:poochcare/core/domain/models/user.dart';

sealed class AuthStoreEvent extends Equatable {
  const AuthStoreEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class UserSignedIn extends AuthStoreEvent {
  const UserSignedIn(this.user);

  final User user;

  @override
  List<Object?> get props => <Object?>[user];
}

class UserSignedOut extends AuthStoreEvent {
  const UserSignedOut();
}

class SplashCompleted extends AuthStoreEvent {
  const SplashCompleted();
}

class IntroCompleted extends AuthStoreEvent {
  const IntroCompleted();
}

class OnBoardingComplete extends AuthStoreEvent {
  const OnBoardingComplete();
}

class PetOnboardingCompleted extends AuthStoreEvent {
  const PetOnboardingCompleted();
}

class InviteSheetSkipped extends AuthStoreEvent {
  const InviteSheetSkipped();
}

class InviteSheetSkipCleared extends AuthStoreEvent {
  const InviteSheetSkipCleared();
}

class ParentNameUpdated extends AuthStoreEvent {
  const ParentNameUpdated({required this.name});

  final String name;

  @override
  List<Object?> get props => <Object?>[name];
}

class ProfileCompletionUpdated extends AuthStoreEvent {
  const ProfileCompletionUpdated();
}

class OnboardingPetCountUpdated extends AuthStoreEvent {
  const OnboardingPetCountUpdated({required this.count});

  final int count;

  @override
  List<Object?> get props => <Object?>[count];
}

class OnboardingPetCountCleared extends AuthStoreEvent {
  const OnboardingPetCountCleared();
}
