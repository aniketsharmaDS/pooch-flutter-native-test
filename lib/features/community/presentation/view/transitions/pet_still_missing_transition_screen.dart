import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/features/test_screen/transition_screen/transition_screen.dart';
import 'package:poochcare/features/user_profile/domain/models/user_pet.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
// import 'package:poochcare/router/app_router.dart';

/// Screen shown after reporting a missing pet.
/// Provides options to continue to home or view pet details.
@RoutePage()
class PetStillMissingTransitionScreen extends StatelessWidget {
  final String petId;

  const PetStillMissingTransitionScreen({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    final pets = context.read<UserProfileBloc>().state.pets;

    String? petName = getPetNameById(petId, pets);

    return TransitionScreen(
      variant: TransitionScreenVariant.poochWillBeHomeSoon,
      petName: petName ?? 'your pooch',
      onPrimaryPressed: () {
        Navigator.pop(context);
        // context.router.replace(const OrdersListingRoute());
      },

      onSecondaryPressed: () {
        Navigator.pop(context);
        // context.router.replace(TrackOrderRoute(order: order));
      },
    );
  }

  String? getPetNameById(String petId, List<UserPet> pets) {
    try {
      return pets.firstWhere((pet) => pet.id == petId).name;
    } catch (e) {
      return ''; // or return ''
    }
  }
}
