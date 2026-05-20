import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/snackbar_service.dart';
import 'package:poochcare/features/community/presentation/bloc/found_pet/found_pet_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/missing_pet/all_missing_pets_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/missing_pet/my_missing_pets_bloc.dart';
import 'package:poochcare/features/test_screen/transition_screen/transition_screen.dart';
import 'package:poochcare/features/user_profile/domain/models/user_pet.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';

/// Screen shown after reporting a missing pet.
/// Provides options to continue to home or view pet details.
@RoutePage()
class PetIsHomeTransitionScreen extends StatefulWidget
    implements AutoRouteWrapper {
  final String petId;
  final String reportId;

  const PetIsHomeTransitionScreen({
    super.key,
    required this.petId,
    required this.reportId,
  });

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MyMissingPetsBloc>.value(
          value: getIt<MyMissingPetsBloc>(),
        ),
        BlocProvider<AllMissingPetsBloc>.value(
          value: getIt<AllMissingPetsBloc>(),
        ),
        BlocProvider<FoundPetBloc>.value(value: getIt<FoundPetBloc>()),
      ],
      child: this,
    );
  }

  @override
  State<PetIsHomeTransitionScreen> createState() =>
      _PetIsHomeTransitionScreenState();
}

class _PetIsHomeTransitionScreenState extends State<PetIsHomeTransitionScreen> {
  bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final pets = context.read<UserProfileBloc>().state.pets;

    final String? petName = getPetNameById(widget.petId, pets);

    return TransitionScreen(
      variant: TransitionScreenVariant.closeMissingPooch,
      petName: petName ?? 'your pooch',
      isPrimaryLoader: isSubmitting,
      onPrimaryPressed: () async {
        await reuniteThePet();
      },
      onSecondaryPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String? getPetNameById(String petId, List<UserPet> pets) {
    try {
      return pets.firstWhere((pet) => pet.id == petId).name;
    } catch (e) {
      return '';
    }
  }

  Future<void> reuniteThePet() async {
    setState(() {
      isSubmitting = true;
    });

    try {
      await context.read<MyMissingPetsBloc>().reUnitePooch(
        reportId: widget.reportId,
      );

      if (!mounted) return;

      context.read<AllMissingPetsBloc>().refreshMissingPets();

      context.read<MyMissingPetsBloc>().refreshMissingPets();

      context.read<FoundPetBloc>().fetchInitialFoundPets(
        scopeType: FoundPetScopeType.allFoundPets,
        scopePetType: 'all',
      );

      await Future<dynamic>.delayed(const Duration(milliseconds: 1000));

      if (!mounted) return;

      context.read<FoundPetBloc>().fetchInitialFoundPets(
        scopeType: FoundPetScopeType.allLatelyFoundPets,
      );

      await Future<dynamic>.delayed(const Duration(milliseconds: 1000));

      if (!mounted) return;

      context.read<FoundPetBloc>().fetchInitialFoundPets(
        scopeType: FoundPetScopeType.allMyLatelyFoundPets,
      );
      context.router.popUntilRoot();
    } catch (e) {
      log(e.toString());
      CustomSnackbar.show(
        'Failed to submit the report. Please try again.',
        SnackbarType.error,
      );
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }
  }
}
