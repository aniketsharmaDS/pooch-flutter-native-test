import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/dropdowns/app_dropdowns.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/menus/app_popup_menu.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/user_profile/domain/models/user_pet.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';

enum PetSelectionVariant { dropdown, popup }

class PetSelectionFormField extends StatelessWidget {
  const PetSelectionFormField({
    super.key,
    required this.selectedPetNotifier,
    this.onPetChanged,
    this.variant = PetSelectionVariant.dropdown,

    /// popup specific
    this.popupHeaderTitle,
    this.popupIconPath,
  });

  final ValueNotifier<String?> selectedPetNotifier;
  final ValueChanged<String?>? onPetChanged;
  final PetSelectionVariant variant;

  /// popup extras
  final String? popupHeaderTitle;
  final String? popupIconPath;

  @override
  Widget build(BuildContext context) {
    final pets = context.watch<UserProfileBloc>().state.pets;
    final hasSinglePet = pets.length == 1;

    /// Auto select if only one pet
    if (hasSinglePet) {
      final singlePetId = pets.first.id;
      if (selectedPetNotifier.value != singlePetId) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!context.mounted) return;
          selectedPetNotifier.value = singlePetId;
          onPetChanged?.call(singlePetId);
        });
      }
    }

    switch (variant) {
      case PetSelectionVariant.dropdown:
        return _buildDropdown(context, pets, hasSinglePet);

      case PetSelectionVariant.popup:
        return _buildPopup(context, pets, hasSinglePet);
    }
  }

  /// =============================
  /// DROPDOWN (existing behavior)
  /// =============================
  Widget _buildDropdown(
    BuildContext context,
    List<UserPet> pets,
    bool hasSinglePet,
  ) {
    final petItems = pets
        .map(
          (pet) => DropdownItem<String>(
            value: pet.id,
            height: AppSpacing.s40.h,
            child: Text(pet.name),
          ),
        )
        .toList(growable: false);

    return AppDropdowns<String>(
      items: petItems,
      valueListenable: selectedPetNotifier,
      isExpanded: true,
      isSearchable: !hasSinglePet,
      noResultsWidget: const SizedBox(
        height: 150,
        child: Center(child: Text('No pet found!')),
      ),
      isMandatory: true,
      hint: AppText.bodyM('Pet', color: AppColors.textFieldLabelDefault),
      onChanged: hasSinglePet
          ? null
          : (v) {
              selectedPetNotifier.value = v;
              onPetChanged?.call(v);
            },
    );
  }

  /// =============================
  /// POPUP VARIANT
  /// =============================
  Widget _buildPopup(
    BuildContext context,
    List<UserPet> pets,
    bool hasSinglePet,
  ) {
    final selectedId = selectedPetNotifier.value;

    final selectedPet = pets.isNotEmpty
        ? pets.firstWhere((p) => p.id == selectedId, orElse: () => pets.first)
        : null;

    /// Convert pets → popup items
    // final items = [
    //   allPetsItem,

    //   ...pets.map(
    //     (pet) => AppPopupMenuItem(
    //       // title: pet.name,

    //         titleWidget: AppText.bodyM(
    //         pet.name,
    //         color: selectedPetNotifier.value == pet.id
    //             ? AppColors.primary
    //             : AppColors.textPrimary,

    //         style: selectedPetNotifier.value == pet.id
    //             ? const TextStyle(fontWeight: FontWeight.w600)
    //             : null,
    //       ),
    //       onTap: () {
    //         selectedPetNotifier.value = pet.id;

    //         onPetChanged?.call(pet.id);
    //       },
    //     ),
    //   ),
    // ];

    final items = [
      AppPopupMenuItem(
        titleWidget: ValueListenableBuilder<String?>(
          valueListenable: selectedPetNotifier,

          builder: (context, value, _) {
            final isSelected = value == null;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isSelected
                    ? AppText.h1('All Pets', fontSize: AppFontSize.fs14)
                    : AppText.bodyM(
                        'All Pets',
                        fontSize: AppFontSize.fs14,
                        color: AppColors.p5_400,
                      ),
                if (isSelected)
                  AppIcon(AppIcons.svg.generic.check, color: AppColors.p1),
              ],
            );
          },
        ),

        onTap: () {
          selectedPetNotifier.value = null;

          onPetChanged?.call(null);
        },
      ),

      ...pets.map(
        (pet) => AppPopupMenuItem(
          titleWidget: ValueListenableBuilder<String?>(
            valueListenable: selectedPetNotifier,

            builder: (context, value, _) {
              final isSelected = value == pet.id;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isSelected
                      ? AppText.h1(pet.name, fontSize: AppFontSize.fs14)
                      : AppText.bodyM(
                          pet.name,
                          fontSize: AppFontSize.fs14,
                          color: AppColors.p5_400,
                        ),

                  if (isSelected)
                    AppIcon(AppIcons.svg.generic.check, color: AppColors.p1),
                ],
              );
            },
          ),

          onTap: () {
            selectedPetNotifier.value = pet.id;

            onPetChanged?.call(pet.id);
          },
        ),
      ),
    ];

    /// Single pet → no popup, just display
    if (hasSinglePet && selectedPet != null) {
      return _selectedView(selectedPet.name);
    }

    return AppPopupMenu(
      headerTitle: popupHeaderTitle ?? 'Select Pet',
      items: items,
      iconPath: popupIconPath ?? AppIcons.svg.actions.petDog,
    );
  }

  /// =============================
  /// COMMON SELECTED VIEW
  /// =============================
  Widget _selectedView(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(child: Text(title, overflow: TextOverflow.ellipsis)),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}
