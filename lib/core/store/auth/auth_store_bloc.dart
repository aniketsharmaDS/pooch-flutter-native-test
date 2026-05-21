import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:poochcare/core/domain/models/user.dart';
import 'package:poochcare/core/store/auth/auth_store_event.dart';
import 'package:poochcare/core/store/auth/auth_store_state.dart';

class AuthStoreBloc extends HydratedBloc<AuthStoreEvent, AuthStoreState> {
  AuthStoreBloc() : super(const AuthStoreState()) {
    on<UserSignedIn>(_onUserSignedIn);
    on<UserSignedOut>(_onUserSignedOut);
    on<SplashCompleted>(_onSplashCompleted);
    on<IntroCompleted>(_onIntroCompleted);
    on<OnBoardingComplete>(_onBoardingComplete);
    on<PetOnboardingCompleted>(_onPetOnboardingCompleted);
    on<InviteSheetSkipped>(_onInviteSheetSkipped);
    on<InviteSheetSkipCleared>(_onInviteSheetSkipCleared);
    on<ParentNameUpdated>(_onParentNameUpdated);
    on<ProfileCompletionUpdated>(_onProfileCompletionUpdated);
    on<OnboardingPetCountUpdated>(_onOnboardingPetCountUpdated);
    on<OnboardingPetCountCleared>(_onOnboardingPetCountCleared);
    on<BuyPetJourneyCompleted>(_onBuyPetJourneyCompleted);
  }

  void _onBoardingComplete(
    OnBoardingComplete event,
    Emitter<AuthStoreState> emit,
  ) {
    emit(
      state.copyWith(
        user: state.user?.copyWith(isOnboarded: true),
        onboardingPetCount: 0,
        inviteSheetSkipped: false,
      ),
    );
  }

  void _onPetOnboardingCompleted(
    PetOnboardingCompleted event,
    Emitter<AuthStoreState> emit,
  ) {
    final user = state.user;
    emit(
      state.copyWith(
        user: user?.copyWith(isPetOnboarded: true),
        inviteSheetSkipped: false,
      ),
    );
  }

  void _onInviteSheetSkipped(
    InviteSheetSkipped event,
    Emitter<AuthStoreState> emit,
  ) {
    emit(state.copyWith(inviteSheetSkipped: true));
  }

  void _onInviteSheetSkipCleared(
    InviteSheetSkipCleared event,
    Emitter<AuthStoreState> emit,
  ) {
    emit(state.copyWith(inviteSheetSkipped: false));
  }

  void _onParentNameUpdated(
    ParentNameUpdated event,
    Emitter<AuthStoreState> emit,
  ) {
    final user = state.user;
    if (user == null) {
      return;
    }

    emit(state.copyWith(user: user.copyWith(name: event.name)));
  }

  void _onProfileCompletionUpdated(
    ProfileCompletionUpdated event,
    Emitter<AuthStoreState> emit,
  ) {
    final user = state.user;
    if (user == null) {
      return;
    }

    emit(state.copyWith(user: user.copyWith(isProfileCompleted: true)));
  }

  void _onUserSignedIn(UserSignedIn event, Emitter<AuthStoreState> emit) {
    final primaryIdentifier = state.user?.primaryIdentifier;
    emit(
      state.copyWith(
        user: event.user.copyWith(primaryIdentifier: primaryIdentifier),
        isAuthenticated: true,
      ),
    );
  }

  void _onUserSignedOut(UserSignedOut event, Emitter<AuthStoreState> emit) {
    emit(
      state.copyWith(
        clearUser: true,
        isAuthenticated: false,
        splashCompleted: false,
        introCompleted: false,
        onboardingPetCount: 0,
        inviteSheetSkipped: false,
      ),
    );
  }

  void _onSplashCompleted(SplashCompleted event, Emitter<AuthStoreState> emit) {
    emit(state.copyWith(splashCompleted: true));
  }

  void _onIntroCompleted(IntroCompleted event, Emitter<AuthStoreState> emit) {
    emit(state.copyWith(introCompleted: true));
  }

  void _onOnboardingPetCountUpdated(
    OnboardingPetCountUpdated event,
    Emitter<AuthStoreState> emit,
  ) {
    emit(state.copyWith(onboardingPetCount: event.count));
  }

  void _onOnboardingPetCountCleared(
    OnboardingPetCountCleared event,
    Emitter<AuthStoreState> emit,
  ) {
    emit(state.copyWith(onboardingPetCount: 0));
  }

  @override
  AuthStoreState? fromJson(Map<String, dynamic> json) {
    try {
      return AuthStoreState(
        user: json['user'] != null
            ? User(
                hasBoughtPet: json['user']['hasBoughtPet'] as bool,
                id: json['user']['id'] as String,
                name: json['user']['name'] as String,
                email: json['user']['email'] as String?,
                phone: json['user']['phone'] as String?,
                isProfileCompleted:
                    json['user']['isProfileCompleted'] as bool? ?? false,
                isPetOnboarded:
                    json['user']['isPetOnboarded'] as bool? ?? false,
                isOnboarded: json['user']['isOnboarded'] as bool? ?? false,
                countryCode: json['user']['countryCode'] as String?,
                primaryIdentifier: json['user']['primaryIdentifier'] as String?,
              )
            : null,

        isAuthenticated: json['isAuthenticated'] as bool? ?? false,
        // Always show splash on app launch; completion is session-only.
        // splashCompleted: false,
        // splashCompleted: json['splashCompleted'] as bool? ?? false,
        introCompleted: json['introCompleted'] as bool? ?? false,
        onboardingPetCount: json['onboardingPetCount'] as int? ?? 0,
        inviteSheetSkipped: json['inviteSheetSkipped'] as bool? ?? false,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthStoreState state) {
    return {
      'user': state.user != null
          ? {
              'hasBoughtPet': state.user?.hasBoughtPet ?? false,
              'id': state.user!.id,
              'name': state.user!.name,
              'email': state.user!.email,
              'phone': state.user!.phone,
              'isProfileCompleted': state.user!.isProfileCompleted,
              'isPetOnboarded': state.user!.isPetOnboarded,
              'isOnboarded': state.user!.isOnboarded,
              'countryCode': state.user!.countryCode,
              'primaryIdentifier': state.user!.primaryIdentifier,
            }
          : null,
      'isAuthenticated': state.isAuthenticated,
      'splashCompleted': state.splashCompleted,
      'introCompleted': state.introCompleted,
      'onboardingPetCount': state.onboardingPetCount,
      'inviteSheetSkipped': state.inviteSheetSkipped,
    };
  }

  FutureOr<void> _onBuyPetJourneyCompleted(
    BuyPetJourneyCompleted event,
    Emitter<AuthStoreState> emit,
  ) async {
    final user = state.user;
    if (user == null) {
      return;
    }

    emit(state.copyWith(user: user.copyWith(hasBoughtPet: true)));
  }
}
