import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/toast_service.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/store/auth/auth_store_event.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/features/pets/domain/models/breed.dart';
import 'package:poochcare/features/pets/domain/models/pet.dart';
import 'package:poochcare/features/pets/presentation/bloc/pets_bloc.dart';
import 'package:poochcare/features/pets/presentation/bloc/pets_event.dart';
import 'package:poochcare/features/pets/presentation/bloc/pets_state.dart';
import 'package:poochcare/features/pets/presentation/widgets/details_about_pet.dart';
import 'package:poochcare/features/pets/presentation/widgets/health_of_pet.dart';
import 'package:poochcare/features/pets/presentation/widgets/select_pet_species.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_event.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class CreatePetProfileScreen extends StatefulWidget
    implements AutoRouteWrapper {
  const CreatePetProfileScreen({
    super.key,
    this.initialPhoneNumber,
    this.initialEmail,
    this.initialCountryCode,
    this.isAddPetFlow = false,
  });

  final String? initialPhoneNumber;
  final String? initialEmail;
  final String? initialCountryCode;
  final bool isAddPetFlow;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<PetsBloc>(
      create: (_) => getIt<PetsBloc>(),
      child: this,
    );
  }

  @override
  State<CreatePetProfileScreen> createState() => _CreatePetProfileScreenState();
}

class _CreatePetProfileScreenState extends State<CreatePetProfileScreen> {
  final PageController _pageController = PageController();

  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final ValueNotifier<String?> _selectedBreedId = ValueNotifier<String?>(null);
  String? _selectedGender;
  DateTime? _selectedDob;
  File? _selectedPetImageFile;

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _otherHealthInfoController =
      TextEditingController();
  final ValueNotifier<String?> _selectedSize = ValueNotifier<String?>(null);
  final ValueNotifier<bool> _isCtaEnabled = ValueNotifier<bool>(false);
  String _weightUnit = 'kgs';
  String _heightUnit = 'cms';
  double _bcsValue = 1;
  bool _showWeightHeightErrors = false;

  int currentPage = 0;
  String selectedPet = '';
  int _createdPetCount = 0;

  @override
  void initState() {
    super.initState();
    if (!widget.isAddPetFlow) {
      _createdPetCount = context.read<AuthStoreBloc>().state.onboardingPetCount;
    }
    _nicknameController.addListener(_onFieldChanged);
    _dobController.addListener(_onFieldChanged);
    _weightController.addListener(_onFieldChanged);
    _heightController.addListener(_onFieldChanged);
    _selectedBreedId.addListener(_onBreedChanged);
    _selectedSize.addListener(_onFieldChanged);
    _updateCtaEnabled();
  }

  void _onBreedChanged() {
    _updateCtaEnabled();
    _updateSizeFromBreed();
  }

  void _updateSizeFromBreed() {
    final PetsState petsState = context.read<PetsBloc>().state;
    final String? breedId = _selectedBreedId.value;

    if (breedId == null || breedId.trim().isEmpty) {
      _selectedSize.value = null;
      return;
    }

    final List<Breed> matchingBreeds = petsState.breeds
        .where((breed) => breed.id == breedId)
        .toList();

    if (matchingBreeds.isEmpty) {
      _selectedSize.value = null;
      return;
    }

    final Breed selectedBreed = matchingBreeds.first;
    final String? sizeCategory = selectedBreed.sizeCategory;

    if (sizeCategory == null || sizeCategory.trim().isEmpty) {
      _selectedSize.value = null;
      return;
    }

    _selectedSize.value = _mapSizeCodeToUI(sizeCategory);
  }

  String _mapSizeCodeToUI(String sizeCode) {
    switch (sizeCode.toUpperCase().trim()) {
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
        final normalized = sizeCode.trim().toLowerCase();
        if (normalized.isEmpty) {
          return sizeCode;
        }
        return '${normalized[0].toUpperCase()}${normalized.substring(1)}';
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nicknameController.removeListener(_onFieldChanged);
    _dobController.removeListener(_onFieldChanged);
    _weightController.removeListener(_onFieldChanged);
    _heightController.removeListener(_onFieldChanged);
    _otherHealthInfoController.removeListener(_onFieldChanged);
    _selectedBreedId.removeListener(_onBreedChanged);
    _selectedSize.removeListener(_onFieldChanged);

    _nicknameController.dispose();
    _dobController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _otherHealthInfoController.dispose();
    _selectedBreedId.dispose();
    _selectedSize.dispose();
    _isCtaEnabled.dispose();

    super.dispose();
  }

  void _onFieldChanged() {
    _updateCtaEnabled();
  }

  void _updateCtaEnabled() {
    _isCtaEnabled.value = _isCurrentPageComplete();
  }

  void _resetForm() {
    _nicknameController.clear();
    _dobController.clear();
    _selectedBreedId.value = null;
    _selectedGender = null;
    _selectedDob = null;
    _selectedPetImageFile = null;
    _weightController.clear();
    _heightController.clear();
    _otherHealthInfoController.clear();
    _selectedSize.value = null;
    _weightUnit = 'kgs';
    _heightUnit = 'cms';
    _bcsValue = 1;
    _showWeightHeightErrors = false;
    setState(() {
      currentPage = 0;
      selectedPet = '';
    });
    // Clear image from BLoC state
    context.read<PetsBloc>().add(const PetImageCleared());
    _updateCtaEnabled();
    if (_pageController.hasClients) {
      _pageController.jumpToPage(0);
    }
  }

  String? _validateWeightHeight({
    required String label,
    required String selectedUnit,
    required String value,
  }) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return 'This field is required';
    }

    final double? parsedValue = double.tryParse(trimmed);
    if (parsedValue == null) {
      return 'Enter a valid number';
    }

    if (label == 'Weight') {
      if (selectedUnit == 'kgs') {
        if (parsedValue <= 0 || parsedValue > 200) {
          return 'Weight must be 0-200 kgs';
        }
      } else if (selectedUnit == 'lbs') {
        if (parsedValue <= 0 || parsedValue > 440) {
          return 'Weight must be 0-440 lbs';
        }
      }
    }

    if (label == 'Height') {
      if (selectedUnit == 'cms') {
        if (parsedValue < 5 || parsedValue > 200) {
          return 'Height must be 5-200 cms';
        }
      } else if (selectedUnit == 'fts') {
        if (parsedValue < 0.5 || parsedValue > 6.5) {
          return 'Height must be 0.5-6.5 fts';
        }
      }
    }

    return null;
  }

  void _showOnboardingSuccessTransition({required bool isMultiplePet}) {
    context.router.push(
      OnboardingSuccessfulTransitionRoute(
        initialPhoneNumber: widget.initialPhoneNumber,
        initialEmail: widget.initialEmail,
        initialCountryCode: widget.initialCountryCode,
        isMultiplePet: isMultiplePet,
      ),
    );
  }

  void _showPetAddedSuccessTransition() {
    context.router.push(const PetAddedSuccessfulTransitionRoute());
  }

  void _onBack() {
    final state = context.read<PetsBloc>().state;
    final bool isSubmitting = widget.isAddPetFlow
        ? state.addPetStatus == AddPetStatus.loading
        : state.status == PetsStatus.loading;

    if (isSubmitting) {
      return;
    }

    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _updateCtaEnabled();
      return;
    }

    // For add-pet flow, pop back to home
    if (widget.isAddPetFlow) {
      context.router.pop();
    } else {
      context.router.maybePop();
    }
  }

  bool _isCurrentPageComplete() {
    if (currentPage == 0) {
      // Page 0: Select Pet Species
      return selectedPet.isNotEmpty;
    } else if (currentPage == 1) {
      // Page 1: Details About Pet
      final hasNickname = _nicknameController.text.trim().isNotEmpty;
      final hasBreed = _selectedBreedId.value != null;
      final hasGender = _selectedGender != null && _selectedGender!.isNotEmpty;
      final hasDob = _dobController.text.trim().isNotEmpty;

      return hasNickname && hasBreed && hasGender && hasDob;
    } else if (currentPage == 2) {
      // Page 2: Health Of Pet (optional)
      return true;
    }

    return false;
  }

  void _onCtaTap() {
    if (currentPage < 2) {
      if (currentPage == 0 && selectedPet.isNotEmpty) {
        context.read<PetsBloc>().add(BreedsRequested(petType: selectedPet));
      }
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }

    final String name = _nicknameController.text.trim();
    final String? breedId = _selectedBreedId.value;
    final String? gender = _selectedGender;
    final String dob = _dobController.text.trim();
    final String size = (_selectedSize.value ?? '').trim();
    final String weightRaw = _weightController.text.trim();
    final String heightRaw = _heightController.text.trim();
    final String healthInfo = _otherHealthInfoController.text.trim();

    final double weight = weightRaw.isEmpty
        ? 0
        : (double.tryParse(weightRaw) ?? double.nan);
    final double height = heightRaw.isEmpty
        ? 0
        : (double.tryParse(heightRaw) ?? double.nan);

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

    final String? weightError = _validateWeightHeight(
      label: 'Weight',
      selectedUnit: _weightUnit,
      value: weightRaw,
    );
    final String? heightError = _validateWeightHeight(
      label: 'Height',
      selectedUnit: _heightUnit,
      value: heightRaw,
    );
    if (weightError != null || heightError != null) {
      setState(() => _showWeightHeightErrors = true);
      return;
    }

    // Get uploaded image URL from the BLoC state
    final PetsState petsState = context.read<PetsBloc>().state;
    if (petsState.isUploadingPetProfilePicture) {
      ToastService.showError('Please wait for image upload to finish');
      return;
    }
    final String? imageUrl = petsState.uploadedPetImageUrl;
    if (_selectedPetImageFile != null && (imageUrl ?? '').isEmpty) {
      ToastService.showError('Please upload a pet image');
      return;
    }

    final Pet pet = Pet(
      profilePicture: imageUrl,
      bcsScore: _bcsValue.round(),
      name: name,
      type: selectedPet,
      breedId: breedId,
      gender: gender,
      dob: dob,
      size: size,
      weight: weight.isNaN ? 0 : weight,
      height: height.isNaN ? 0 : height,
      heightUnit: _heightUnit == 'fts' ? 'feet' : _heightUnit,
      weightUnit: _weightUnit,
      healthInfo: healthInfo.isEmpty ? null : healthInfo,
    );

    final isParentGroupAvailable =
        getIt<UserProfileBloc>().state.parentGroups.isNotEmpty;

    if (widget.isAddPetFlow && isParentGroupAvailable) {
      context.read<PetsBloc>().add(AddPetRequested(pet));
    } else {
      context.read<PetsBloc>().add(CreatePetEvent(pet));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PetsBloc>().state;
    final bool isSubmitting = widget.isAddPetFlow
        ? state.addPetStatus == AddPetStatus.loading
        : state.status == PetsStatus.loading;

    return PopScope(
      canPop: currentPage == 0 && !isSubmitting,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop || isSubmitting) {
          return;
        }

        if (currentPage != 0) {
          _pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s17,
          ).copyWith(bottom: 15),
          child: ValueListenableBuilder<bool>(
            valueListenable: _isCtaEnabled,
            builder: (context, isCtaEnabled, _) {
              if (currentPage < 2) {
                return Opacity(
                  opacity: isCtaEnabled ? 1 : 0.5,
                  child: AppCircleButton(
                    icon: AppIcons.svg.generic.chevronRight,
                    size: AppCircleButtonSize.xlarge,
                    iconSize: AppIconSize.is16,
                    bgColor: AppColors.p5_900,
                    iconColor: AppColors.white,
                    onTap: isCtaEnabled ? _onCtaTap : null,
                  ),
                );
              }

              return BlocBuilder<PetsBloc, PetsState>(
                buildWhen: (prev, curr) {
                  return widget.isAddPetFlow
                      ? prev.addPetStatus != curr.addPetStatus
                      : prev.status != curr.status;
                },
                builder: (context, state) {
                  final bool isLoading = widget.isAddPetFlow
                      ? state.addPetStatus == AddPetStatus.loading
                      : state.status == PetsStatus.loading;

                  return AppButton(
                    backgroundColor: Colors.black,
                    label: widget.isAddPetFlow
                        ? 'Save Pet'
                        : 'Save Pet Profile',
                    isLoading: isLoading,
                    onPressed: isCtaEnabled && !isLoading ? _onCtaTap : null,
                  );
                },
              );
            },
          ),
        ),
        body: BlocListener<PetsBloc, PetsState>(
          listenWhen: (previous, current) {
            return previous.status != current.status ||
                previous.errorMessage != current.errorMessage ||
                previous.addPetStatus != current.addPetStatus ||
                previous.addPetErrorMessage != current.addPetErrorMessage;
          },
          listener: (context, state) {
            final genericError = (state.errorMessage ?? '').trim();
            final isParentGroupAvailable =
                getIt<UserProfileBloc>().state.parentGroups.isNotEmpty;
            if (genericError.isNotEmpty) {
              ToastService.showError(genericError);
            }

            if (widget.isAddPetFlow && isParentGroupAvailable) {
              // When parent groups is created
              final error = (state.addPetErrorMessage ?? '').trim();
              if (error.isNotEmpty) {
                ToastService.showError(error);
              }

              if (state.addPetStatus == AddPetStatus.success ||
                  state.status == PetsStatus.success) {
                getIt<UserProfileBloc>().add(const GetUserPetsEvent());
                _resetForm();
                _showPetAddedSuccessTransition();
              }

              return;
            } else if (widget.isAddPetFlow && !isParentGroupAvailable) {
              final profileBloc = getIt<UserProfileBloc>();
              final error = (state.errorMessage ?? '').trim();
              if (error.isNotEmpty) {
                ToastService.showError(error);
              }

              if (state.status == PetsStatus.success) {
                profileBloc.add(const GetUserPetsEvent());

                _resetForm();
                context.router.push(SaveHouseDetailsRoute(isMultiplePet: true));
              }
            }

            if (state.status == PetsStatus.success) {
              final authStoreBloc = context.read<AuthStoreBloc>();
              final storedCount = authStoreBloc.state.onboardingPetCount;
              if (_createdPetCount < storedCount) {
                _createdPetCount = storedCount;
              }
              _createdPetCount += 1;
              authStoreBloc.add(
                OnboardingPetCountUpdated(count: _createdPetCount),
              );
              _showOnboardingSuccessTransition(
                isMultiplePet: _createdPetCount > 1,
              );
              return;
            }
          },
          child: AppPrimaryBgContainer(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  PoochScreenAppBar(
                    title: widget.isAddPetFlow
                        ? 'Add pet'
                        : 'Create pet profile',
                    onBack: _onBack,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${currentPage + 1}',
                              style: TextStyle(
                                fontSize: AppFontSize.fs14,
                                color: AppColors.p4_900,
                              ),
                            ),
                            TextSpan(
                              text: '/3',
                              style: TextStyle(
                                fontSize: AppFontSize.fs14,
                                color: AppColors.p4_900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.s14.hBox,
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        setState(() => currentPage = index);
                        if (index == 2) {
                          _updateSizeFromBreed();
                        }
                        _updateCtaEnabled();
                      },
                      children: [
                        SelectPetSpecies(
                          selectedPet: selectedPet,
                          onSelect: (value) {
                            setState(() => selectedPet = value);
                            _selectedBreedId.value = null;
                            _updateCtaEnabled();
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.s16.w,
                          ),
                          child: BlocBuilder<PetsBloc, PetsState>(
                            buildWhen: (previous, current) =>
                                previous.breeds != current.breeds ||
                                previous.isBreedsLoading !=
                                    current.isBreedsLoading ||
                                previous.breedsPetType != current.breedsPetType,
                            builder: (context, state) {
                              final breeds = state.breedsPetType == selectedPet
                                  ? state.breeds
                                  : const <Breed>[];
                              final bool isBreedsLoading =
                                  state.isBreedsLoading &&
                                  state.breedsPetType == selectedPet;

                              return DetailsAboutPet(
                                petType: selectedPet,
                                nicknameController: _nicknameController,
                                dobController: _dobController,
                                selectedBreedId: _selectedBreedId,
                                breeds: breeds,
                                isBreedsLoading: isBreedsLoading,
                                selectedGender: _selectedGender,
                                onGenderSelected: (gender) {
                                  setState(() => _selectedGender = gender);
                                  _updateCtaEnabled();
                                },
                                selectedDob: _selectedDob,
                                onDobSelected: (date) {
                                  setState(() => _selectedDob = date);
                                  _updateCtaEnabled();
                                },
                                selectedPetImage: _selectedPetImageFile,
                                onPetImageSelected: (file) {
                                  setState(() => _selectedPetImageFile = file);
                                  _updateCtaEnabled();
                                },
                              );
                            },
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.s16.w,
                          ),
                          child: HealthOfPet(
                            petType: selectedPet,
                            weightController: _weightController,
                            heightController: _heightController,
                            otherHealthInfoController:
                                _otherHealthInfoController,
                            selectedSize: _selectedSize,
                            weightUnit: _weightUnit,
                            heightUnit: _heightUnit,
                            showWeightHeightErrors: _showWeightHeightErrors,
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
                        ),
                      ],
                    ),
                  ),
                  // AppSpacing.s10.hBox,
                  //  AppSpacing.s21.hBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
