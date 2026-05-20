import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';
import 'package:poochcare/core/widgets/dialogs/app_filter_dialog.dart';
import 'package:poochcare/core/widgets/dialogs/app_select_pet_dialog.dart';
import 'package:poochcare/core/widgets/dialogs/community_report_dialog.dart';

@RoutePage()
class AppButtonScreen extends StatefulWidget {
  const AppButtonScreen({super.key});

  @override
  State<AppButtonScreen> createState() => AppButtonScreenState();
}

class AppButtonScreenState extends State<AppButtonScreen> {
  final List<FilterSectionItem> _petFilterSections = const [
    FilterSectionItem(
      id: 'age',
      title: 'Age',
      selectionType: FilterSelectionType.multiple,
      options: [
        FilterOptionItem(id: 'puppy', label: 'Puppy'),
        FilterOptionItem(id: 'adult_dog', label: 'Adult dog'),
      ],
    ),
    FilterSectionItem(
      id: 'gender',
      title: 'Gender',
      selectionType: FilterSelectionType.multiple,
      options: [
        FilterOptionItem(id: 'male', label: 'Male'),
        FilterOptionItem(id: 'female', label: 'Female'),
      ],
    ),
    FilterSectionItem(
      id: 'breed',
      title: 'Breed',
      selectionType: FilterSelectionType.multiple,
      enableSearch: true,
      searchHint: 'Type breed',
      options: [
        FilterOptionItem(id: 'labrador_retriever', label: 'Labrador Retriever'),
        FilterOptionItem(id: 'golden_retriever', label: 'Golden Retriever'),
        FilterOptionItem(id: 'german_shepherd', label: 'German Shepherd'),
        FilterOptionItem(id: 'french_bulldog', label: 'French Bulldog'),
        FilterOptionItem(id: 'poodle', label: 'Poodle'),
        FilterOptionItem(id: 'beagle', label: 'Beagle'),
        FilterOptionItem(id: 'bulldog', label: 'Bulldog'),
        FilterOptionItem(
          id: 'australian_shepherd',
          label: 'Australian Shepherd',
        ),
        FilterOptionItem(id: 'boxer', label: 'Boxer'),
        FilterOptionItem(id: 'dachshund', label: 'Dachshund'),
      ],
    ),
    FilterSectionItem(
      id: 'size',
      title: 'Size',
      selectionType: FilterSelectionType.single,
      options: [
        FilterOptionItem(id: 'small', label: 'Small'),
        FilterOptionItem(id: 'medium', label: 'Medium'),
        FilterOptionItem(id: 'large', label: 'Large'),
        FilterOptionItem(id: 'extra_large', label: 'Extra Large'),
        FilterOptionItem(id: 'giant', label: 'Giant'),
      ],
    ),
    FilterSectionItem(
      id: 'energy',
      title: 'Energy',
      selectionType: FilterSelectionType.multiple,
      options: [
        FilterOptionItem(id: 'very_active', label: 'Very Active'),
        FilterOptionItem(id: 'sporty', label: 'Sporty'),
        FilterOptionItem(id: 'working_drive', label: 'Working Drive'),
        FilterOptionItem(id: 'chill', label: 'Chill'),
        FilterOptionItem(id: 'balanced', label: 'Balanced'),
        FilterOptionItem(id: 'calm', label: 'Calm'),
      ],
    ),
    FilterSectionItem(
      id: 'grooming',
      title: 'Grooming',
      selectionType: FilterSelectionType.multiple,
      options: [
        FilterOptionItem(
          id: 'basic_bath_and_blow_dry',
          label: 'Basic Bath & Blow Dry',
        ),
        FilterOptionItem(
          id: 'full_grooming',
          label: 'Full Grooming (Bath + Haircut)',
        ),
        FilterOptionItem(
          id: 'puppy_grooming_package',
          label: 'Puppy Grooming Package',
        ),
        FilterOptionItem(
          id: 'breed_specific_styling',
          label: 'Breed-Specific Styling',
        ),
        FilterOptionItem(
          id: 'de_shedding_treatment',
          label: 'De-shedding Treatment',
        ),
        FilterOptionItem(
          id: 'nail_trimming_and_filing',
          label: 'Nail Trimming & Filing',
        ),
        FilterOptionItem(id: 'ear_cleaning', label: 'Ear Cleaning'),
        FilterOptionItem(
          id: 'teeth_cleaning',
          label: 'Teeth Cleaning (Non-anesthetic)',
        ),
      ],
    ),
    FilterSectionItem(
      id: 'temperament',
      title: 'Temperament',
      selectionType: FilterSelectionType.multiple,
      options: [
        FilterOptionItem(id: 'confident', label: 'Confident'),
        FilterOptionItem(id: 'friendly', label: 'Friendly'),
        FilterOptionItem(id: 'shy', label: 'Shy'),
        FilterOptionItem(id: 'independent', label: 'Independent'),
        FilterOptionItem(id: 'active', label: 'Active'),
        FilterOptionItem(id: 'calm_temperament', label: 'Calm'),
        FilterOptionItem(id: 'stubborn', label: 'Stubborn'),
      ],
    ),
    FilterSectionItem(
      id: 'allergies',
      title: 'Allergies',
      selectionType: FilterSelectionType.multiple,
      options: [
        FilterOptionItem(id: 'food_allergies', label: 'Food Allergies'),
        FilterOptionItem(id: 'pollen_allergy', label: 'Pollen Allergy'),
        FilterOptionItem(id: 'dust_mite_allergy', label: 'Dust Mite Allergy'),
        FilterOptionItem(id: 'mold_allergy', label: 'Mold Allergy'),
        FilterOptionItem(id: 'grass_allergy', label: 'Grass Allergy'),
        FilterOptionItem(id: 'contact_allergy', label: 'Contact Allergy'),
        FilterOptionItem(id: 'medication_allergy', label: 'Medication Allergy'),
        FilterOptionItem(
          id: 'insect_bite_allergy',
          label: 'Insect Bite Allergy',
        ),
        FilterOptionItem(
          id: 'flea_allergy_dermatitis',
          label: 'Flea Allergy Dermatitis (FAD)',
        ),
        FilterOptionItem(
          id: 'household_chemical_allergy',
          label: 'Household Chemical Allergy',
        ),
      ],
    ),
  ];

  Map<String, Set<String>> _petFilterSelections = {
    'age': {'puppy'},
    'gender': {'male'},
    'breed': {'labrador_retriever'},
    'size': {'medium'},
    'energy': {'very_active'},
    'grooming': {'basic_bath_and_blow_dry'},
    'temperament': {'confident'},
    'allergies': {'food_allergies'},
  };

  final List<Pet> petsList = [
    Pet(
      id: '1',
      name: 'Rudolph',
      imageUrl: 'https://images.unsplash.com/photo-1558788353-f76d92427f16',
    ),
    Pet(
      id: '2',
      name: 'Cadbury',
      imageUrl: 'https://images.unsplash.com/photo-1537151625747-768eb6cf92b2',
    ),
    Pet(
      id: '3',
      name: 'Bella',
      imageUrl: 'https://images.unsplash.com/photo-1598133894008-61f7fdb8cc3a',
    ),
    Pet(
      id: '4',
      name: 'Max',
      imageUrl: 'https://images.unsplash.com/photo-1543466835-00a7907e9de1',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 18.h),
                AppButton(
                  label: 'Show Dialog',
                  size: AppButtonSize.small,
                  onPressed: () => {
                    // Handle action
                    /// 1. SIMPLE DIALOG
                    AppDialog.show(
                      icon: const Icon(
                        Icons.warning,
                        size: 36,
                        color: Colors.red,
                      ),
                      context: context,
                      title: 'Simple Dialog',
                      content:
                          'This is a simple dialog with just a title and content.',
                      primaryLabel: 'Delete',
                      secondaryLabel: 'Cancel',
                      onPrimary: () async {
                        return true;
                      },
                    ),
                  },
                ),
                SizedBox(height: 18.h),

                AppButton(
                  leadingIcon: const Icon(Icons.female, color: Colors.pink),
                  trailingIcon: const Icon(Icons.female, color: Colors.pink),
                  label: 'Show Pet Selection',
                  size: AppButtonSize.small,
                  onPressed: () async {
                    final scaffoldMessenger = ScaffoldMessenger.of(context);

                    final result = await AppSelectPetDialog.show(
                      context: context, // ✅ safe, captured before await
                      pets: petsList,
                      initiallySelectedPet:
                          petsList.any((pet) => pet.isSelected)
                          ? petsList.firstWhere((pet) => pet.isSelected)
                          : null,
                    );

                    // Check if widget is still mounted
                    if (!mounted) return;

                    if (result != null) {
                      for (final pet in petsList) {
                        pet.isSelected = pet.id == result.selectedPet.id;
                      }

                      // Safe to use context here
                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          content: Text('Selected: ${result.selectedPet.name}'),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 18.h),
                AppButton(
                  label: 'Report This Post',
                  height: 40.h,
                  onPressed: () async {
                    final scaffoldMessenger = ScaffoldMessenger.of(context);
                    final result = await CommunityReportDialog.show(
                      context: context,
                    );
                    if (result != null && mounted) {
                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          content: Text('Report submitted: ${result.reason}'),
                        ),
                      );
                    }
                  },
                  customTextStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 18.h),
                AppButton(
                  label: 'Show Filter Dialog',
                  size: AppButtonSize.small,
                  onPressed: () => _openCustomFilterDialog(),
                ),
                SizedBox(height: 18.h),
                AppButton(
                  label: 'Action3',
                  isDisabled: true,
                  size: AppButtonSize.small,
                  onPressed: () => {
                    // Handle action
                  },
                ),
                SizedBox(height: 18.h),
                AppButton(
                  label: 'Action4',
                  isDisabled: true,
                  variant: AppButtonVariant.outlined,
                  size: AppButtonSize.small,
                  onPressed: () => {
                    // Handle action
                  },
                ),
                SizedBox(height: 18.h),
                AppButton(
                  label: 'Action Outlined 2nd Variant',
                  isDisabled: true,
                  variant: AppButtonVariant.outlined,
                  size: AppButtonSize.small,
                  backgroundColor: AppColors.buttonOutlinedBg2,
                  onPressed: () => {
                    // Handle action
                  },
                ),
                SizedBox(height: 18.h),
                AppButton(
                  variant: AppButtonVariant.text,
                  label: 'Action5',
                  isDisabled: true,
                  size: AppButtonSize.small,
                  onPressed: () => {
                    // Handle action
                  },
                ),

                SizedBox(height: 18.h),
                AppButton(
                  width: null,
                  label: 'Save (Wrap Content)',
                  leadingIcon: const Icon(Icons.save),
                  onPressed: () {},
                ),

                SizedBox(height: 18.h),
                AppButton(
                  width: null,
                  label: 'Save (Wrap Content)',
                  variant: AppButtonVariant.text,
                  leadingIcon: const Icon(Icons.save),
                  onPressed: () {},
                ),

                SizedBox(height: 18.h),
                AppButton(
                  variant: AppButtonVariant.text,
                  label: 'Continue (Full Width)',
                  size: AppButtonSize.small,
                  onPressed: () => {
                    // Handle action
                  },
                ),

                SizedBox(height: 18.h),
                AppButton(
                  label: 'Custom Width (220)',
                  width: 220.w,
                  trailingIcon: const Icon(Icons.arrow_forward),
                  size: AppButtonSize.small,
                  onPressed: () => {
                    // Handle action
                  },
                ),
                SizedBox(height: 18.h),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: 'Cancel',
                        variant: AppButtonVariant.outlined,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: AppButton(label: 'Confirm', onPressed: () {}),
                    ),
                  ],
                ),
                SizedBox(height: 18.h),
                AppCircleButton(
                  onTap: () {},
                  size: AppCircleButtonSize.large,
                  shadowColor: Colors.black,
                  icon: AppIcons.svg.appBar.bell,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openCustomFilterDialog() async {
    final result = await AppFilterDialog.show(
      context,
      sections: _petFilterSections,
      initialSelectedValues: _petFilterSelections,
      // title: 'Filters',
      // leftPanelBackground: const Color(0xFFFEF3E6),
    );

    if (result == null) return;

    setState(() {
      _petFilterSelections = result.selectedValues;
    });
  }
}
