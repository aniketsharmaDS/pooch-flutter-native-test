import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/features/test_screen/transition_screen/transition_screen.dart';
import 'package:poochcare/router/app_router.dart';

/// Screen shown after successful pet creation during onboarding.
/// Provides options to continue to home or add another pet.
@RoutePage()
class OnboardingSuccessfulTransitionScreen extends StatelessWidget {
  final String? initialPhoneNumber;
  final String? initialEmail;
  final String? initialCountryCode;
  final bool isMultiplePet;

  const OnboardingSuccessfulTransitionScreen({
    super.key,
    this.initialPhoneNumber,
    this.initialEmail,
    this.initialCountryCode,
    required this.isMultiplePet,
  });

  @override
  Widget build(BuildContext context) {
    return TransitionScreen(
      variant: TransitionScreenVariant.onBoardingSuccess,
      onPrimaryPressed: () {
        context.router.replaceAll([
          SaveHouseDetailsRoute(
            isMultiplePet: isMultiplePet,
            initialPhoneNumber: initialPhoneNumber,
            initialEmail: initialEmail,
            initialCountryCode: initialCountryCode,
          ),
        ]);
      },
      onSecondaryPressed: () {
        // Pop until root to ensure fresh CreatePetProfileRoute instance
        context.router.popUntilRoot();
        context.router.push(CreatePetProfileRoute());
      },
    );
  }
}
