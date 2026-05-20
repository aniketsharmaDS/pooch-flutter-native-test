import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/enums/notch_variant.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/pets/presentation/widgets/pet_option_wave_card.dart';

class SelectPetSpecies extends StatelessWidget {
  const SelectPetSpecies({
    super.key,
    required this.selectedPet,
    required this.onSelect,
  });

  final String selectedPet;
  final ValueChanged<String> onSelect;

  String _getTitle() {
    return "Tell us what's your pets species";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
      child: Column(
        children: [
          Center(
            child: AppText.h4(
              _getTitle(),
              fontSize: AppFontSize.fs32,
              color: AppColors.textPrimary,
              maxLines: 3,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
          AppSpacing.s25.hBox,
          PetOptionWaveCard(
            title: 'Dog',
            image: AppIcons.jpg.onboarding.dogSpecies,
            isSelected: selectedPet == 'dog',
            showBlur: selectedPet.isNotEmpty && selectedPet != 'dog',
            notchWidth: AppSize.cs100,
            notchHeight: AppSize.cs40,
            onTap: () => onSelect('dog'),
          ),
          AppSpacing.s20.hBox,
          PetOptionWaveCard(
            title: 'Cat',
            image: AppIcons.jpg.onboarding.catSpecies,
            isSelected: selectedPet == 'cat',
            showBlur: selectedPet.isNotEmpty && selectedPet != 'cat',
            variant: AppCardNotchVariant.bottomLeft,
            notchWidth: AppSize.cs100,
            notchHeight: AppSize.cs40,
            onTap: () => onSelect('cat'),
          ),
        ],
      ),
    );
  }
}
