import 'package:equatable/equatable.dart';
import 'package:poochcare/core/domain/models/user.dart';

class AuthStoreState extends Equatable {
  const AuthStoreState({
    this.user,
    this.isAuthenticated = false,
    this.splashCompleted = false,
    this.introCompleted = false,
    this.onboardingPetCount = 0,
    this.inviteSheetSkipped = false,
  });

  final User? user;
  final bool isAuthenticated;
  final bool splashCompleted;
  final bool introCompleted;
  final int onboardingPetCount;
  final bool inviteSheetSkipped;

  AuthStoreState copyWith({
    User? user,
    bool clearUser = false,
    bool? isAuthenticated,
    bool? splashCompleted,
    bool? introCompleted,
    int? onboardingPetCount,
    bool? inviteSheetSkipped,
  }) {
    return AuthStoreState(
      user: clearUser ? null : (user ?? this.user),
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      splashCompleted: splashCompleted ?? this.splashCompleted,
      introCompleted: introCompleted ?? this.introCompleted,
      onboardingPetCount: onboardingPetCount ?? this.onboardingPetCount,
      inviteSheetSkipped: inviteSheetSkipped ?? this.inviteSheetSkipped,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    user,
    isAuthenticated,
    splashCompleted,
    introCompleted,
    onboardingPetCount,
    inviteSheetSkipped,
  ];
}
