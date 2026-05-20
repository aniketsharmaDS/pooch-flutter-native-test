import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/domain/models/pet.dart';
import 'package:poochcare/core/store/pets/pets_store_bloc.dart';
import 'package:poochcare/core/store/pets/pets_store_state.dart';
import 'package:poochcare/core/widgets/cards/app_card.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class PetListWidget extends StatelessWidget {
  const PetListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PetsStoreBloc, PetsStoreState, List<Pet>>(
      selector: (PetsStoreState state) =>
          state.petIds.map((String id) => state.petsById[id]!).toList(),
      builder: (BuildContext context, List<Pet> pets) {
        return AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppText.bodyL(
                'Pets',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              if (pets.isEmpty)
                AppText.bodyM('No pets found')
              else
                ...pets.map(
                  (Pet pet) => Padding(
                    padding: EdgeInsets.only(bottom: 6.h),
                    child: AppText.bodyS('\${pet.name} \u2022 \${pet.breed}'),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
