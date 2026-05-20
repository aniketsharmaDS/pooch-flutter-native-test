import 'package:equatable/equatable.dart';
import 'package:poochcare/core/store/onboarding/onboarding_journey_store_state.dart';

sealed class OnboardingJourneyStoreEvent extends Equatable {
  const OnboardingJourneyStoreEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class OnboardingJourneyStarted extends OnboardingJourneyStoreEvent {
  const OnboardingJourneyStarted(this.journeyType);

  final OnboardingJourneyType journeyType;

  @override
  List<Object?> get props => <Object?>[journeyType];
}

class OnboardingJourneyCleared extends OnboardingJourneyStoreEvent {
  const OnboardingJourneyCleared();
}
