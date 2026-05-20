import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/config/app_config.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/dropdowns/app_dropdowns.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/others/app_profile_avatar.dart';
import 'package:poochcare/core/widgets/radio/app_radio_pet_gender.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';
import 'package:poochcare/features/pets/domain/models/breed.dart';
import 'package:poochcare/features/pets/presentation/bloc/pets_bloc.dart';
import 'package:poochcare/features/pets/presentation/bloc/pets_event.dart';
import 'package:poochcare/features/pets/presentation/bloc/pets_state.dart';
import 'package:poochcare/features/pets/presentation/widgets/pet_dob_warning_dialog.dart';

class DetailsAboutPet extends StatefulWidget {
  const DetailsAboutPet({
    super.key,
    required this.petType,
    required this.nicknameController,
    required this.dobController,
    required this.selectedBreedId,
    required this.breeds,
    required this.isBreedsLoading,
    required this.selectedGender,
    required this.onGenderSelected,
    required this.selectedDob,
    required this.onDobSelected,
    this.initialImageUrl,
    required this.selectedPetImage,
    required this.onPetImageSelected,
    this.isBreedEditable = true,
    this.currentBreedName,
    this.isEditableGender = true,
    this.isEditMode = false,
    this.originalDob,
  });

  final String petType;
  final TextEditingController nicknameController;
  final TextEditingController dobController;
  final ValueNotifier<String?> selectedBreedId;
  final List<Breed> breeds;
  final bool isBreedsLoading;
  final String? selectedGender;
  final ValueChanged<String> onGenderSelected;
  final DateTime? selectedDob;
  final ValueChanged<DateTime> onDobSelected;
  final String? initialImageUrl;
  final File? selectedPetImage;
  final ValueChanged<File?> onPetImageSelected;
  final bool isBreedEditable;
  final String? currentBreedName;
  final bool isEditableGender;
  final bool isEditMode;
  final DateTime? originalDob;

  @override
  State<DetailsAboutPet> createState() => _DetailsAboutPetState();
}

class _DetailsAboutPetState extends State<DetailsAboutPet> {
  bool _isDobFlowInProgress = false;

  String _getTitle() {
    return 'Details about \nyour ${widget.petType}';
  }

  List<DropdownItem<String>> get _breedItems {
    return widget.breeds
        .map(
          (Breed breed) => DropdownItem<String>(
            value: breed.id,
            height: AppSpacing.s40.h,
            child: Text(breed.name),
          ),
        )
        .toList();
  }

  @override
  void didUpdateWidget(covariant DetailsAboutPet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.petType != widget.petType) {
      widget.selectedBreedId.value = null;
    }
  }

  int _dobWarningThresholdDays() {
    final raw = (AppConfig.getEnv('PET_DOB_WARNING_DAYS') ?? '').trim();
    return int.tryParse(raw) ?? 90;
  }

  DateTime _normalizeDate(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }

  Future<void> _openDobPicker() async {
    final now = _normalizeDate(DateTime.now());
    final firstDate = DateTime(now.year - 30, now.month, now.day);

    DateTime tempSelectedDate = _normalizeDate(widget.selectedDob ?? now);

    final selectedDate = await AppBottomSheet.show<DateTime>(
      context: context,
      title: 'Select Date of Birth',
      content: StatefulBuilder(
        builder: (context, setModalState) {
          return CalendarDatePicker(
            initialDate: tempSelectedDate,
            firstDate: firstDate,
            lastDate: now,
            currentDate: now,
            onDateChanged: (date) {
              setModalState(() {
                tempSelectedDate = _normalizeDate(date);
              });
            },
          );
        },
      ),
      actions: [
        AppButton(
          label: 'Done',
          onPressed: () {
            Navigator.of(context).pop(tempSelectedDate);
          },
        ),
      ],
    );

    if (selectedDate == null) return;
    await _handleDobSelected(_normalizeDate(selectedDate));
  }

  Future<void> _handleDobSelected(DateTime date) async {
    if (_isDobFlowInProgress) return;

    final now = _normalizeDate(DateTime.now());
    final current = widget.selectedDob != null
        ? _normalizeDate(widget.selectedDob!)
        : null;

    if (current != null && current == date) {
      return;
    }

    _isDobFlowInProgress = true;
    try {
      if (!widget.isEditMode) {
        final confirmed = await PetDobWarningDialog.showNewPetDobWarning(
          context,
        );

        if (confirmed == true && mounted) {
          widget.onDobSelected(date);
          widget.dobController.text = _formatDate(date);
          return;
        }

        if (confirmed == false && mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            _openDobPicker();
          });
        }

        return;
      }

      final thresholdDays = _dobWarningThresholdDays();
      final old = widget.originalDob != null
          ? _normalizeDate(widget.originalDob!)
          : (widget.selectedDob != null
                ? _normalizeDate(widget.selectedDob!)
                : now);

      final diffDays = old.difference(date).inDays.abs();
      if (diffDays <= thresholdDays) {
        if (!mounted) return;
        widget.onDobSelected(date);
        widget.dobController.text = _formatDate(date);
        return;
      }

      final confirmed = await PetDobWarningDialog.showEditPetDobWarning(
        context,
      );

      if (confirmed == true && mounted) {
        widget.onDobSelected(date);
        widget.dobController.text = _formatDate(date);
      } else if (confirmed == false && mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          _openDobPicker();
        });
      }
    } finally {
      _isDobFlowInProgress = false;
    }
  }

  String _formatDate(DateTime date) {
    final String day = date.day.toString().padLeft(2, '0');
    final String month = date.month.toString().padLeft(2, '0');
    final String year = date.year.toString();
    return '$day-$month-$year';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.s32.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          BlocBuilder<PetsBloc, PetsState>(
            buildWhen: (prev, curr) =>
                prev.uploadedPetImageUrl != curr.uploadedPetImageUrl ||
                prev.isUploadingPetProfilePicture !=
                    curr.isUploadingPetProfilePicture,
            builder: (context, state) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  AppProfileAvatar(
                    containerHeight: AppSpacing.s140.h,
                    containerBgColor: AppColors.white.withValues(alpha: 0.8),
                    containerBorderColor: AppColors.textFieldBorderDefault,
                    size: AppSpacing.s110.h,
                    variant: AppProfileAvatarVariant.actionButton,
                    localImageFile: widget.selectedPetImage,
                    imageUrl:
                        state.uploadedPetImageUrl ?? widget.initialImageUrl,
                    actionIcon: AppIcons.svg.generic.camera,
                    actionPosition: ActionPosition.rightCenter,
                    onFileSelected: (file) async {
                      context.read<PetsBloc>().add(
                        UploadPetProfileImageEvent(imageFile: file),
                      );
                      widget.onPetImageSelected(file);
                    },
                  ),
                  if (state.isUploadingPetProfilePicture)
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.35),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2.6,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          AppSpacing.s20.hBox,
          AppTextField(
            label: 'Enter nickname',
            isMandatory: true,
            controller: widget.nicknameController,
            textInputAction: TextInputAction.next,
            preventSpecialCharacters: true,
          ),
          AppSpacing.s25.hBox,
          AppRadioPetGender(
            initialGender: widget.selectedGender,
            onGenderSelected: widget.onGenderSelected,
            isEditableGender: widget.isEditableGender,
          ),
          AppSpacing.s20.hBox,
          if (widget.isBreedEditable)
            AppDropdowns<String>(
              items: _breedItems,
              valueListenable: widget.selectedBreedId,
              isExpanded: true,
              isSearchable: true,
              isMandatory: true,
              dropdownStyleData: DropdownStyleData(
                maxHeight: MediaQuery.sizeOf(context).height * 0.45,
                offset: const Offset(0, -4),
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.s5.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSpacing.s16.r),
                ),
              ),
              hint: AppText.bodyM(
                widget.isBreedsLoading ? 'Loading breeds...' : 'Select breed',
                color: AppColors.textFieldLabelDefault,
              ),
              onChanged: (value) {
                if (value != null) {
                  widget.selectedBreedId.value = value;
                }
              },
            )
          else
            AppTextField(
              label: 'Breed',
              hintText: 'Breed',
              isReadOnly: true,
              controller: TextEditingController(
                text: widget.currentBreedName ?? '',
              ),
              enabled: false,
            ),
          AppSpacing.s20.hBox,
          AppTextField(
            label: 'Date of birth',
            isMandatory: true,
            hintText: 'DD/MM/YYYY',
            controller: widget.dobController,
            isReadOnly: true,
            onPressed: _openDobPicker,
            suffixWidget: AppIcon(
              AppIcons.svg.generic.calendar,
              size: AppIconSize.is16,
            ),
          ),
          AppSpacing.s16.hBox,
        ],
      ),
    );
  }
}
