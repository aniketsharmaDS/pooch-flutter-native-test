import 'package:equatable/equatable.dart';

enum OnboardingJourneyType { none, existingPet, buyPet }

class OnboardingJourneyStoreState extends Equatable {
  const OnboardingJourneyStoreState({
    this.journeyType = OnboardingJourneyType.none,
  });

  final OnboardingJourneyType journeyType;

  bool get isBuyPet => journeyType == OnboardingJourneyType.buyPet;

  OnboardingJourneyStoreState copyWith({OnboardingJourneyType? journeyType}) {
    return OnboardingJourneyStoreState(
      journeyType: journeyType ?? this.journeyType,
    );
  }

  @override
  List<Object?> get props => <Object?>[journeyType];
}
