import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/pagination/pagination_state.dart';
import 'package:poochcare/core/services/snackbar_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/utils/date_time_formattter.dart';
import 'package:poochcare/core/widgets/bottom_sheet/address/address_search_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/dialogs/community_message_dialog.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/images/app_image_cached_widget.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/community/data/models/missing_pet_model.dart';
import 'package:poochcare/features/community/presentation/bloc/found_pet/found_pet_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/missing_pet/all_missing_pets_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/missing_pet/my_missing_pets_bloc.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class MissingBiometricPetFoundScreen extends StatefulWidget
    implements AutoRouteWrapper {
  final String reportId;

  const MissingBiometricPetFoundScreen({super.key, required this.reportId});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MyMissingPetsBloc>.value(
          value: getIt<MyMissingPetsBloc>(),
        ),
        BlocProvider<AllMissingPetsBloc>.value(
          value: getIt<AllMissingPetsBloc>(),
        ),
        BlocProvider<FoundPetBloc>.value(value: getIt<FoundPetBloc>()),
      ],
      child: this,
    );
  }

  @override
  State<MissingBiometricPetFoundScreen> createState() =>
      _MissingBiometricPetFoundScreenState();
}

class _MissingBiometricPetFoundScreenState
    extends State<MissingBiometricPetFoundScreen> {
  AddressResult? selectedAddress;
  bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return PopScope<bool>(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        // _handleBack();
      },
      child: AppPrimaryScreenContainer(
        title: '',
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(12.0.w),
          child: AppButton(
            label: 'community.missingBiometricPetFoundScreen.contactPetParent'
                .tr(),
            onPressed: () {
              // Will Go to chat screen with pet parent. For now, just show snackbar
              sendMessageToParent();
            },
          ),
        ),
        // onBack: _handleBack,
        child: SafeArea(
          child: BlocBuilder<MyMissingPetsBloc, PaginationState<MissingPetModel>>(
            builder: (context, state) {
              final item = state.selectedItem;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: AppSpacing.s25.h,
                        horizontal: AppSpacing.s16.w,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppSpacing.s16.r),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppText.h1(
                            'community.missingBiometricPetFoundScreen.title'
                                .tr(),
                            color: AppColors.p1,
                            maxLines: 1,
                          ),
                          AppSpacing.s5.hBox,
                          AppText.h1(
                            'community.missingBiometricPetFoundScreen.subtitle'
                                .tr(),
                            maxLines: 3,
                            color: AppColors.p1_900,
                            fontSize: AppFontSize.fs14,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    AppSpacing.s18.hBox,
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: AppSpacing.s25.h,
                        horizontal: AppSpacing.s16.w,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppSpacing.s16.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPostImage(item),
                          AppSpacing.s16.hBox,
                          _buildSpecification(item),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPostImage(MissingPetModel? item) {
    if (item?.images.isEmpty == true &&
        (item?.pet.profilePicture == null ||
            item?.pet.profilePicture!.isEmpty == true)) {
      return Container(
        width: double.infinity,
        height: AppSpacing.s320.h,
        decoration: BoxDecoration(
          color: AppColors.background.withAlpha(100),
          borderRadius: BorderRadius.circular(AppSpacing.s14.r),
          border: Border.all(
            color: AppColors.background.withAlpha(150),
            width: AppSpacing.s1p5.w,
          ),
        ),
        alignment: Alignment.center,
        child: AppIcon(
          AppIcons.svg.generic.poochTail,
          size: AppSpacing.s70.r,
          color: AppColors.textSecondary.withAlpha(180),
        ),
      );
    }

    final imageUrls = item?.images.map((e) => e.imageUrl).toList() ?? [];

    if (item?.pet.profilePicture != null &&
        item?.pet.profilePicture!.isEmpty == false) {
      imageUrls.insert(0, item!.pet.profilePicture!);
    }
    log('imageUrls: $imageUrls');

    if (imageUrls.isEmpty) {
      return Container(
        width: double.infinity,
        height: AppSpacing.s320.h,
        decoration: BoxDecoration(
          color: AppColors.background.withAlpha(100),
          borderRadius: BorderRadius.circular(AppSpacing.s14.r),
          border: Border.all(
            color: AppColors.background.withAlpha(150),
            width: AppSpacing.s1p5.w,
          ),
        ),
        alignment: Alignment.center,
        child: AppIcon(
          AppIcons.svg.generic.poochTail,
          size: AppSpacing.s70.r,
          color: AppColors.textSecondary.withAlpha(180),
        ),
      );
    }
    // Detail view: Show carousel with pagination dots overlay

    // List view: Show 1 or 2 images side by side

    return AppImageCachedWidget(
      imageUrl: imageUrls.first,
      width: double.infinity,
      height: AppSpacing.s320.h,
      borderRadius: BorderRadius.circular(AppSpacing.s14.r),
    );
  }

  Widget _buildSpecification(MissingPetModel? item) {
    String type = item?.pet.type.toLowerCase() ?? '';
    String name = item?.pet.name ?? '';
    String age = formatPetAge(dob: item?.pet.dob);
    String gender = item?.pet.gender.toLowerCase() ?? '';

    String capitalize(String value) =>
        value.isNotEmpty ? value[0].toUpperCase() + value.substring(1) : value;
    String displayValue =
        '${capitalize(type)} . $age . $name, ${capitalize(gender)}';

    return AppText.h1(
      displayValue,
      maxLines: 3,
      fontSize: AppFontSize.fs14,
      textAlign: TextAlign.left,
    );
  }

  Future<void> sendMessageToParent() async {
    final resultNote = await CommunityMessageDialog.show(context: context);
    if (resultNote == null || resultNote.isCancelled) {
      return;
    }

    if (!resultNote.isCancelled && resultNote.message.trim().isEmpty) {
      CustomSnackbar.show(
        'please add a note about the pet’s condition or any other relevant info to share with the pet parent',
        SnackbarType.info,
      );
      return;
    }

    AddressResult? result = await AddressSearchBottomSheet.show(
      // ignore: use_build_context_synchronously
      context: context,
      onSelectedApiCall: (place) async {
        selectedAddress = place; // show selected address in the field
      },
    );

    if (result == null) {
      CustomSnackbar.show(
        'Please select an address where the found pet was located',
        SnackbarType.info,
      );
      return;
    }

    final payload = buildVerificationPayload(
      missingReportId: widget.reportId,
      verificationMethod: 'BIOMETRIC',
      notes: resultNote.message.trim(),
      latitude: result.latitude, // Default to Mumbai coordinates if null
      longitude: result.longitude,
      location: result.description,
    );
    log('Verification Payload: $payload');

    setState(() {
      isSubmitting = true;
    });

    try {
      // ignore: unused_local_variable

      if (!mounted) return; // ✅ I

      await context.read<MyMissingPetsBloc>().reportMissingPetFound(
        payload: payload,
      );
      if (!mounted) return;

      // ignore: use_build_context_synchronously
      context.router.push(
        PoochParentChatRoute(
          userName: 'Pooch Parent',
          source: 'missing_pet_chat',
        ),
      );
      // ✅ I
      context.read<AllMissingPetsBloc>().refreshMissingPets();
      context.read<MyMissingPetsBloc>().refreshMissingPets();

      context.read<FoundPetBloc>().fetchInitialFoundPets(
        scopeType: FoundPetScopeType.allFoundPets,
        scopePetType: 'all',
      );
      // ignore: inference_failure_on_instance_creation
      await Future.delayed(const Duration(milliseconds: 1000));
      // ignore: use_build_context_synchronously
      context.read<FoundPetBloc>().fetchInitialFoundPets(
        scopeType: FoundPetScopeType.allLatelyFoundPets,
      );
      // ignore: inference_failure_on_instance_creation
      await Future.delayed(const Duration(milliseconds: 1000));
      // ignore: use_build_context_synchronously
      context.read<FoundPetBloc>().fetchInitialFoundPets(
        scopeType: FoundPetScopeType.allMyLatelyFoundPets,
      );
    } catch (e) {
      CustomSnackbar.show(
        'Failed to submit the report. Please try again.',
        SnackbarType.error,
      );
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }

    // CustomSnackbar.show(
    //   'Message sent to pet parent with location details. They will reach out to you if they need more info.',
    //   SnackbarType.success,
    // );
    // context.read<AllMissingPetsBloc>().refreshMissingPets();
    // context.read<MyMissingPetsBloc>().refreshMissingPets();
    // // ignore: use_build_context_synchronously
    // context.router.push(
    //   PoochParentChatRoute(
    //     userName: 'Pooch Parent',
    //     source: 'missing_pet_chat',
    //   ),
    // );
  }

  Map<String, dynamic> buildVerificationPayload({
    required String missingReportId,
    required String verificationMethod,
    required String notes,
    required double latitude,
    required double longitude,
    required String location,
  }) {
    return {
      'missing_report_id': missingReportId,
      'verification_method': verificationMethod,
      'notes': notes,
      'latitude': latitude,
      'longitude': longitude,
      'location': location,
    };
  }
}
