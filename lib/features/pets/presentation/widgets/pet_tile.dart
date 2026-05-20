import 'package:flutter/material.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/pets/domain/models/pet.dart';

class PetTile extends StatelessWidget {
  const PetTile({required this.pet, super.key});

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: AppText.h1(pet.name),
      subtitle: AppText.h2('${pet.type} • Breed #${pet.breedId}'),
    );
  }
}
