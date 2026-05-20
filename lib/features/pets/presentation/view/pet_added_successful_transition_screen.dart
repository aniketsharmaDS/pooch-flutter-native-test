import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/features/test_screen/transition_screen/transition_screen.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class PetAddedSuccessfulTransitionScreen extends StatelessWidget {

  const PetAddedSuccessfulTransitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TransitionScreen(
      variant: TransitionScreenVariant.petAddedSuccess,
      onPrimaryPressed: () {
        context.router.replaceAll([const HomeRoute()]);
      },
      onSecondaryPressed: () {
        context.router.maybePop();
      },
    );
  }
}
