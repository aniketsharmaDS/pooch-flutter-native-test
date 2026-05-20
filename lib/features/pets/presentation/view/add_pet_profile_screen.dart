import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/features/pets/presentation/bloc/pets_bloc.dart';
import 'package:poochcare/features/pets/presentation/view/create_pet_profile_screen.dart';

@RoutePage()
class AddPetProfileScreen extends StatelessWidget {
  const AddPetProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PetsBloc>(
      create: (_) => getIt<PetsBloc>(),
      child: const CreatePetProfileScreen(isAddPetFlow: true),
    );
  }
}
