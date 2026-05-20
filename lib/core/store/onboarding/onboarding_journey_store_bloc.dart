import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:poochcare/core/store/onboarding/onboarding_journey_store_event.dart';
import 'package:poochcare/core/store/onboarding/onboarding_journey_store_state.dart';

class OnboardingJourneyStoreBloc
    extends
        HydratedBloc<OnboardingJourneyStoreEvent, OnboardingJourneyStoreState> {
  OnboardingJourneyStoreBloc() : super(const OnboardingJourneyStoreState()) {
    on<OnboardingJourneyStarted>(_onJourneyStarted);
    on<OnboardingJourneyCleared>(_onJourneyCleared);
  }

  void _onJourneyStarted(
    OnboardingJourneyStarted event,
    Emitter<OnboardingJourneyStoreState> emit,
  ) {
    emit(state.copyWith(journeyType: event.journeyType));
  }

  void _onJourneyCleared(
    OnboardingJourneyCleared event,
    Emitter<OnboardingJourneyStoreState> emit,
  ) {
    emit(const OnboardingJourneyStoreState());
  }

  @override
  OnboardingJourneyStoreState? fromJson(Map<String, dynamic> json) {
    final rawType = json['journeyType'] as String?;
    final OnboardingJourneyType journeyType = OnboardingJourneyType.values
        .firstWhere(
          (type) => type.name == rawType,
          orElse: () => OnboardingJourneyType.none,
        );
    return OnboardingJourneyStoreState(journeyType: journeyType);
  }

  @override
  Map<String, dynamic>? toJson(OnboardingJourneyStoreState state) {
    return <String, dynamic>{'journeyType': state.journeyType.name};
  }
}
