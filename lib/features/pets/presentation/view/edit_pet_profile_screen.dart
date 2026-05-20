import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/toast_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/pets/domain/models/breed.dart';
import 'package:poochcare/features/pets/presentation/bloc/pets_bloc.dart';
import 'package:poochcare/features/pets/presentation/bloc/pets_state.dart';
import 'package:poochcare/features/pets/presentation/widgets/details_about_pet.dart';
import 'package:poochcare/features/pets/presentation/widgets/health_of_pet.dart';
import 'package:poochcare/features/user_profile/domain/models/user_pet.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_event.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_state.dart';

@RoutePage()
class EditPetProfileScreen extends StatefulWidget implements AutoRouteWrapper {
  const EditPetProfileScreen({super.key, required this.pet});

  final UserPet pet;

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserProfileBloc>.value(value: getIt<UserProfileBloc>()),
        BlocProvider<PetsBloc>(create: (_) => getIt<PetsBloc>()),
      ],
      child: this,
    );
  }

  @override
  State<EditPetProfileScreen> createState() => _EditPetProfileScreenState();
}

class _EditPetProfileScreenState extends State<EditPetProfileScreen> {
  final PageController _pageController = PageController();

  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final ValueNotifier<String?> _selectedBreedId = ValueNotifier<String?>(null);
  String? _selectedGender;
  DateTime? _selectedDob;
  DateTime? _originalDob;
  File? _selectedPetImageFile;

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _otherHealthInfoController =
      TextEditingController();
  final ValueNotifier<String?> _selectedSize = ValueNotifier<String?>(null);
  String _weightUnit = 'kgs';
  String _heightUnit = 'cms';
  double _bcsValue = 1;

  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    _prefillFromPet(widget.pet);

    _nicknameController.addListener(_onFieldChanged);
    _dobController.addListener(_onFieldChanged);
    _weightController.addListener(_onFieldChanged);
    _heightController.addListener(_onFieldChanged);
    _selectedBreedId.addListener(_onFieldChanged);
    _selectedSize.addListener(_onFieldChanged);
  }

  @override
  void dispose() {
    _pageController.dispose();

    _nicknameController.removeListener(_onFieldChanged);
    _dobController.removeListener(_onFieldChanged);
    _weightController.removeListener(_onFieldChanged);
    _heightController.removeListener(_onFieldChanged);
    _selectedBreedId.removeListener(_onFieldChanged);
    _selectedSize.removeListener(_onFieldChanged);

    _nicknameController.dispose();
    _dobController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _otherHealthInfoController.dispose();
    _selectedBreedId.dispose();
    _selectedSize.dispose();

    super.dispose();
  }

  void _onFieldChanged() {
    setState(() {});
  }

  void _prefillFromPet(UserPet pet) {
    _nicknameController.text = pet.name;

    _selectedGender = pet.gender;

    _selectedBreedId.value = pet.breedId.trim().isNotEmpty ? pet.breedId : null;

    _weightController.text = pet.weight != null && pet.weight! > 0
        ? pet.weight!.toString()
        : '';
    _heightController.text = pet.height != null && pet.height! > 0
        ? pet.height!.toString()
        : '';
    _selectedSize.value = (pet.size ?? '').trim().isNotEmpty
        ? _unmapPetSize(pet.size!)
        : null;

    _weightUnit = (pet.weightUnit ?? '').trim().isNotEmpty
        ? pet.weightUnit!
        : 'kgs';
    _heightUnit = (pet.heightUnit ?? '').trim().isNotEmpty
        ? pet.heightUnit!
        : 'cms';

    _bcsValue = (pet.bcsScore ?? 1).toDouble();

    _otherHealthInfoController.text = (pet.healthInfo ?? '').trim();

    final DateTime? parsed = _tryParseDob(pet.dob);
    _selectedDob = parsed;
    _originalDob = parsed;
    if (parsed != null) {
      _dobController.text = _formatDob(parsed);
    } else {
      _dobController.text = pet.dob;
    }
  }

  String _unmapPetSize(String size) {
    switch (size.toUpperCase()) {
      case 'TOY':
        return 'Toy';
      case 'S':
        return 'Small';
      case 'M':
        return 'Medium';
      case 'L':
        return 'Large';
      case 'GIANT':
        return 'Giant';
      default:
        final normalized = size.trim().toLowerCase();
        if (normalized.isEmpty) {
          return size;
        }
        return '${normalized[0].toUpperCase()}${normalized.substring(1)}';
    }
  }

  DateTime? _tryParseDob(String raw) {
    final value = raw.trim();
    if (value.isEmpty) return null;

    try {
      return DateTime.parse(value);
    } catch (_) {
      // Fall through.
    }

    // Try dd-mm-yyyy
    try {
      final parts = value.split('-');
      if (parts.length != 3) return null;
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      return DateTime(year, month, day);
    } catch (_) {
      return null;
    }
  }

  String _formatDob(DateTime date) {
    final String day = date.day.toString().padLeft(2, '0');
    final String month = date.month.toString().padLeft(2, '0');
    final String year = date.year.toString();
    return '$day-$month-$year';
  }

  void _onBack() {
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }

    context.router.maybePop();
  }

  UserPet _buildUpdatedPet({
    required List<Breed> currentBreeds,
    required PetsState petsState,
  }) {
    final String name = _nicknameController.text.trim();
    final String breedId = (_selectedBreedId.value ?? '').trim();
    final String gender = (_selectedGender ?? '').trim();
    final String dob = _dobController.text.trim();
    final String size = (_selectedSize.value ?? '').trim();
    final double weight = double.tryParse(_weightController.text.trim()) ?? 0;
    final double height = double.tryParse(_heightController.text.trim()) ?? 0;
    final String healthInfo = _otherHealthInfoController.text.trim();

    final String? newImageUrl =
        (petsState.uploadedPetImageUrl ?? '').trim().isNotEmpty
        ? petsState.uploadedPetImageUrl
        : null;

    final String? nextBreedName = currentBreeds
        .where((b) => b.id == breedId)
        .map((b) => b.name)
        .cast<String?>()
        .firstWhere(
          (e) => (e ?? '').trim().isNotEmpty,
          orElse: () => widget.pet.breedName,
        );

    return UserPet(
      id: widget.pet.id,
      name: name,
      type: widget.pet.type,
      breedId: breedId,
      gender: gender,
      dob: dob,
      size: size.isNotEmpty ? size : null,
      weight: weight > 0 ? weight : null,
      height: height > 0 ? height : null,
      weightUnit: _weightUnit,
      heightUnit: _heightUnit,
      bcsScore: _bcsValue.round(),
      healthInfo: healthInfo.isNotEmpty ? healthInfo : null,
      profilePicture: newImageUrl ?? widget.pet.profilePicture,
      breedName: nextBreedName,
      canEdit: widget.pet.canEdit,
      canDelete: widget.pet.canDelete,
    );
  }

  bool _isNoOpUpdate(UserPet updatedPet) {
    bool sameString(String? a, String? b) =>
        (a ?? '').trim() == (b ?? '').trim();

    bool sameDouble(double? a, double? b) {
      final av = a ?? 0;
      final bv = b ?? 0;
      return av == bv;
    }

    bool sameInt(int? a, int? b) => (a ?? 0) == (b ?? 0);

    return sameString(widget.pet.profilePicture, updatedPet.profilePicture) &&
        sameInt(widget.pet.bcsScore, updatedPet.bcsScore) &&
        sameString(widget.pet.name, updatedPet.name) &&
        sameString(widget.pet.type, updatedPet.type) &&
        sameString(widget.pet.breedId, updatedPet.breedId) &&
        sameString(widget.pet.gender, updatedPet.gender) &&
        sameString(widget.pet.dob, updatedPet.dob) &&
        sameString(widget.pet.size, updatedPet.size) &&
        sameDouble(widget.pet.weight, updatedPet.weight) &&
        sameDouble(widget.pet.height, updatedPet.height) &&
        sameString(widget.pet.heightUnit, updatedPet.heightUnit) &&
        sameString(widget.pet.weightUnit, updatedPet.weightUnit) &&
        sameString(widget.pet.healthInfo, updatedPet.healthInfo);
  }

  void _onCtaTap({required List<Breed> breeds, required PetsState petsState}) {
    if (!widget.pet.canEdit) {
      ToastService.showError('You do not have permission to edit this pet.');
      return;
    }

    if (currentPage == 0) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }

    // Validate all required fields before proceeding (same as create)
    final String name = _nicknameController.text.trim();
    final String? breedId = _selectedBreedId.value;
    final String? gender = _selectedGender;
    final String dob = _dobController.text.trim();
    final String? size = _selectedSize.value;
    final double? weight = double.tryParse(_weightController.text.trim());
    final double? height = double.tryParse(_heightController.text.trim());

    if (name.isEmpty) {
      ToastService.showError('Please enter a nickname');
      return;
    }
    if (breedId == null) {
      ToastService.showError('Please select a breed');
      return;
    }
    if (gender == null || gender.isEmpty) {
      ToastService.showError('Please select a gender');
      return;
    }
    if (dob.isEmpty) {
      ToastService.showError('Please select date of birth');
      return;
    }
    if (size == null || size.isEmpty) {
      ToastService.showError('Please select size');
      return;
    }
    if (weight == null || weight <= 0) {
      ToastService.showError('Please enter valid weight');
      return;
    }
    if (height == null || height <= 0) {
      ToastService.showError('Please enter valid height');
      return;
    }

    final updatedPet = _buildUpdatedPet(
      currentBreeds: breeds,
      petsState: petsState,
    );

    if (_isNoOpUpdate(updatedPet)) {
      context.router.maybePop();
      return;
    }

    // Show confirm dialog
    _showConfirmChangesDialog(updatedPet);
  }

  void _showConfirmChangesDialog(UserPet updatedPet) {
    AppDialog.show<bool>(
      context: context,
      title: 'Confirm Changes',
      content:
          'This update will significantly affect your pet\'s profile. Do you want to proceed?',
      primaryLabel: 'Yes, Continue',
      secondaryLabel: 'No, Go Back',
      icon: Lottie.asset(AppIcons.lottie.question, width: 120, height: 120),
      onPrimary: () async {
        context.read<UserProfileBloc>().add(
          UpdatePetProfileRequested(oldPet: widget.pet, updatedPet: updatedPet),
        );
        return true;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserProfileBloc, UserProfileState>(
          listenWhen: (prev, curr) =>
              prev.updatePetProfileStatus != curr.updatePetProfileStatus ||
              prev.updatePetProfileErrorMessage !=
                  curr.updatePetProfileErrorMessage,
          listener: (context, state) {
            if (state.updatePetProfileStatus ==
                UpdatePetProfileStatus.failure) {
              ToastService.showError(
                state.updatePetProfileErrorMessage ??
                    'Unable to update pet profile. Please try again.',
              );
            }

            if (state.updatePetProfileStatus ==
                UpdatePetProfileStatus.success) {
              context.router.maybePop();
            }
          },
        ),
        BlocListener<PetsBloc, PetsState>(
          listenWhen: (prev, curr) => prev.errorMessage != curr.errorMessage,
          listener: (context, state) {
            final msg = (state.errorMessage ?? '').trim();
            if (msg.isNotEmpty) {
              ToastService.showError(msg);
            }
          },
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s17,
          ).copyWith(bottom: 15),
          child: BlocBuilder<PetsBloc, PetsState>(
            builder: (context, petsState) {
              return BlocBuilder<UserProfileBloc, UserProfileState>(
                builder: (context, userProfileState) {
                  final breeds = petsState.breedsPetType == widget.pet.type
                      ? petsState.breeds
                      : const <Breed>[];

                  final bool isSaving =
                      userProfileState.updatePetProfileStatus ==
                      UpdatePetProfileStatus.inProgress;

                  if (currentPage == 0) {
                    return AppCircleButton(
                      icon: AppIcons.svg.generic.chevronRight,
                      size: AppCircleButtonSize.xlarge,
                      iconSize: AppIconSize.is16,
                      bgColor: AppColors.p5_900,
                      iconColor: AppColors.white,
                      onTap: () =>
                          _onCtaTap(breeds: breeds, petsState: petsState),
                    );
                  }

                  return AppButton(
                    label: 'Save Pet Profile',
                    isLoading: isSaving,
                    onPressed: () =>
                        _onCtaTap(breeds: breeds, petsState: petsState),
                  );
                },
              );
            },
          ),
        ),
        body: AppPrimaryBgContainer(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AppSpacing.s12.hBox,
                  SizedBox(
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: _onBack,
                            style: IconButton.styleFrom(
                              foregroundColor: AppColors.textPrimary,
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(
                                AppSpacing.s24,
                                AppSpacing.s24,
                              ),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: AppIcon(
                              AppIcons.svg.generic.chevronLeft,
                              size: AppIconSize.is16,
                            ),
                          ),
                        ),
                        AppText.h3(
                          'Edit pet profile',
                          fontSize: AppFontSize.fs16,
                          color: AppColors.p4_900,
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.s15.hBox,
                  Center(
                    child: AppText.h4(
                      '${currentPage + 1}/2',
                      color: AppColors.p4_900,
                    ),
                  ),
                  AppSpacing.s25.hBox,
                  Expanded(
                    child: BlocBuilder<PetsBloc, PetsState>(
                      builder: (context, petsState) {
                        return BlocBuilder<UserProfileBloc, UserProfileState>(
                          builder: (context, userProfileState) {
                            final breeds =
                                petsState.breedsPetType == widget.pet.type
                                ? petsState.breeds
                                : const <Breed>[];
                            final bool isBreedsLoading =
                                petsState.isBreedsLoading &&
                                petsState.breedsPetType == widget.pet.type;

                            return PageView(
                              controller: _pageController,
                              physics: const NeverScrollableScrollPhysics(),
                              onPageChanged: (index) {
                                setState(() => currentPage = index);
                              },
                              children: [
                                DetailsAboutPet(
                                  petType: widget.pet.type,
                                  nicknameController: _nicknameController,
                                  dobController: _dobController,
                                  selectedBreedId: _selectedBreedId,
                                  breeds: breeds,
                                  isBreedsLoading: isBreedsLoading,
                                  selectedGender: _selectedGender,
                                  onGenderSelected: (gender) {
                                    setState(() => _selectedGender = gender);
                                  },
                                  selectedDob: _selectedDob,
                                  onDobSelected: (date) {
                                    setState(() => _selectedDob = date);
                                  },
                                  isEditMode: true,
                                  originalDob: _originalDob,
                                  initialImageUrl: widget.pet.profilePicture,
                                  selectedPetImage: _selectedPetImageFile,
                                  onPetImageSelected: (file) {
                                    setState(
                                      () => _selectedPetImageFile = file,
                                    );
                                  },
                                  isBreedEditable: false,
                                  currentBreedName: widget.pet.breedName,
                                  isEditableGender: false,
                                ),
                                HealthOfPet(
                                  petType: widget.pet.type,
                                  weightController: _weightController,
                                  heightController: _heightController,
                                  otherHealthInfoController:
                                      _otherHealthInfoController,
                                  selectedSize: _selectedSize,
                                  weightUnit: _weightUnit,
                                  heightUnit: _heightUnit,
                                  isSizeEditable: false,
                                  onWeightHeightChanged:
                                      (weight, weightUnit, height, heightUnit) {
                                        setState(() {
                                          _weightUnit = weightUnit;
                                          _heightUnit = heightUnit;
                                        });
                                      },
                                  bcsValue: _bcsValue,
                                  onBcsChanged: (value) {
                                    setState(() => _bcsValue = value);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  AppSpacing.s20.hBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
