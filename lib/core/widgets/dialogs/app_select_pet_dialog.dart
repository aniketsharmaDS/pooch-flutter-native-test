import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';
import 'package:poochcare/core/widgets/images/app_image_frame.dart';
import 'package:poochcare/core/widgets/radio/app_circle_radio.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';

/// ======================================================
/// MODELS
/// ======================================================

class Pet {
  final String id;
  final String name;
  final String imageUrl;
  bool isClickable;
  bool isSelected;

  Pet({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isClickable = true,
    this.isSelected = false,
  });
}

class AppSelectPetResult {
  final Pet selectedPet;
  final String? note;

  AppSelectPetResult({required this.selectedPet, this.note});
}

/// ======================================================
/// Choose Your Pet Dialog
/// ======================================================

class AppSelectPetDialog {
  static Future<AppSelectPetResult?> show({
    required BuildContext context,
    required List<Pet> pets,
    Pet? initiallySelectedPet, // <-- add this
    bool showNoteField = true,
  }) {
    return AppDialog.show<AppSelectPetResult>(
      context: context,
      title: 'Choose your pet',
      icon: const Icon(Icons.pets, color: Colors.orange),
      isPrimaryButtonEnabled:
          initiallySelectedPet != null, // <-- enable if there's an initial pet
      primaryLabel: 'Continue',
      secondaryLabel: 'Close',
      contentWidget: _SelectPetContent(
        showNoteField: showNoteField,
        pets: pets,
        initiallySelectedPet: initiallySelectedPet, // <-- pass down
      ),
      onPrimary: () async {
        return _SelectPetController.instance?.submit();
      },
      onSecondary: () async {
        return _SelectPetController.instance?.close();
      },
    );
  }
}

/// ======================================================
/// INTERNAL CONTROLLER (lightweight bridge)
/// ======================================================

class _SelectPetController {
  static _SelectPetController? instance;

  Pet? selectedPet;
  final TextEditingController noteController = TextEditingController();

  AppSelectPetResult? submit() {
    if (selectedPet == null) return null;

    return AppSelectPetResult(
      selectedPet: selectedPet!,
      note: noteController.text.trim().isEmpty
          ? null
          : noteController.text.trim(),
    );
  }

  AppSelectPetResult? close() {
    return null;
  }

  void dispose() {
    noteController.dispose();
    instance = null;
  }
}

/// ======================================================
/// CONTENT
/// ======================================================

class _SelectPetContent extends StatefulWidget {
  final List<Pet> pets;
  final Pet? initiallySelectedPet; // <-- add this
  final bool showNoteField;

  const _SelectPetContent({
    required this.pets,
    this.initiallySelectedPet,
    required this.showNoteField,
  });

  @override
  State<_SelectPetContent> createState() => _SelectPetContentState();
}

class _SelectPetContentState extends State<_SelectPetContent> {
  final controller = _SelectPetController();

  @override
  void initState() {
    super.initState();
    _SelectPetController.instance = controller;
    if (widget.initiallySelectedPet != null) {
      controller.selectedPet = widget.initiallySelectedPet;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// PET LIST
          SizedBox(
            height: 120.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: widget.pets.length,
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                final pet = widget.pets[index];
                final isSelected = controller.selectedPet?.id == pet.id;

                return GestureDetector(
                  onTap: () {
                    // setState(() => controller.selectedPet = pet);

                    setState(() {
                      controller.selectedPet = pet;

                      AppDialogContentState.instance?.updatePrimaryButton(true);
                    });
                  },
                  child: PetCard(
                    pet: pet,
                    isSelected: isSelected,
                    onSelect: () {
                      setState(() {
                        controller.selectedPet = pet;
                        AppDialogContentState.instance?.updatePrimaryButton(
                          true,
                        );
                      });
                    },
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 20.h),

          /// NOTE LABEL
          if (widget.showNoteField) ...[
            AppText.h2('Add a note (Optional)', maxLines: 1),

            SizedBox(height: 8.h),

            /// NOTE INPUT
            AppTextField(
              controller: controller.noteController,
              maxLines: 6,
              isTextArea: true,
              height: 90.h,
              minLines: 3,
              label: 'Share anything the vet should know.',
            ),
          ],
        ],
      ),
    );
  }
}

/// ======================================================
/// PET CARD
/// ======================================================

class PetCard extends StatelessWidget {
  final Pet pet;
  final bool isSelected;
  final VoidCallback onSelect;

  const PetCard({
    super.key,
    required this.pet,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.w,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppColors.primaryBorder, // <-- use border color from theme
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppText.h4(
                  pet.name,
                  color: AppColors.primary,
                  maxLines: 1,
                ),
              ),
              if (pet.isClickable) ...[
                AppCircleRadio(
                  label: '',
                  isSelected: isSelected,
                  onTap: () {
                    onSelect();
                  },
                ),
              ],
            ],
          ),

          SizedBox(height: 8.h),

          /// IMAGE
          Expanded(
            child: AppImageFrame(
              width: double.infinity,
              height: double.infinity,
              imageUrl: pet.imageUrl,
              // fit: BoxFit.cover,
              hasBorder: true,
            ),
          ),
        ],
      ),
    );
  }
}
