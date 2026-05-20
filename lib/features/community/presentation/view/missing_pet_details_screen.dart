import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/pagination/pagination_state.dart';
import 'package:poochcare/core/services/snackbar_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/bottom_sheet/address/address_search_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';
import 'package:poochcare/core/widgets/dialogs/community_message_dialog.dart';
import 'package:poochcare/core/widgets/list_items/missing_pooch_list_item_card.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/community/data/models/missing_pet_model.dart';
import 'package:poochcare/features/community/presentation/bloc/found_pet/found_pet_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/missing_pet/all_missing_pets_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/missing_pet/my_missing_pets_bloc.dart';
import 'package:poochcare/features/community/presentation/view/report_missing_pet_form_screen.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class MissingPetDetailsScreen extends StatefulWidget
    implements AutoRouteWrapper {
  const MissingPetDetailsScreen({
    super.key,
    required this.reportId,
    this.isOwnPost = false,
    this.listType = 'default',
  });

  final String reportId;
  final String listType;
  final bool? isOwnPost;
  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AllMissingPetsBloc>.value(
          value: getIt<AllMissingPetsBloc>(),
        ),
        BlocProvider<MyMissingPetsBloc>.value(
          value: getIt<MyMissingPetsBloc>(),
        ),
        BlocProvider<FoundPetBloc>.value(value: getIt<FoundPetBloc>()),
      ],
      child: this,
    );
  }

  @override
  State<MissingPetDetailsScreen> createState() =>
      _MissingPetDetailsScreenState();
}

class _MissingPetDetailsScreenState extends State<MissingPetDetailsScreen> {
  bool get _isOwnPost => widget.isOwnPost == true;
  bool isDeleting = false;
  bool isSubmitting = false;
  bool isStillMising = true;
  MyMissingPetsBloc get myMissingPetBlock => context.read<MyMissingPetsBloc>();

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    _isOwnPost
        ? myMissingPetBlock.fetchMissingReportDetails(widget.reportId)
        : myMissingPetBlock.fetchMissingReportDetails(widget.reportId);
  }

  Future<void> _onRefresh() async {
    _isOwnPost
        ? await myMissingPetBlock.fetchMissingReportDetails(
            widget.reportId,
            isRefresh: true,
          )
        : await myMissingPetBlock.fetchMissingReportDetails(
            widget.reportId,
            isRefresh: true,
          );
  }

  @override
  Widget build(BuildContext context) {
    return AppPrimaryBgContainer(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: PoochScreenAppBar(
          title: '',
          actions: [
            Padding(
              padding: EdgeInsets.only(right: AppSpacing.s8.w),
              child: Row(
                children: [
                  // commneted as its not in the design
                  // AppCircleButton(
                  //   hitSlop: EdgeInsets.only(right: -AppSpacing.s3.w),
                  //   variant: AppCircleButtonVariant.secondary,
                  //   bgColor: AppColors.transparent,
                  //   iconSize: AppIconSize.is20,
                  //   showShadow: false,
                  //   icon: AppIcons.svg.generic.flag,
                  //   onTap: () async {
                  //     final scaffoldMessenger = ScaffoldMessenger.of(context);
                  //     final result = await CommunityReportDialog.show(
                  //       context: context,
                  //     );
                  //     if (result != null && mounted) {
                  //       scaffoldMessenger.showSnackBar(
                  //         SnackBar(
                  //           content: Text('Report submitted: ${result.reason}'),
                  //         ),
                  //       );
                  //     }
                  //   },
                  // ),
                  AppCircleButton(
                    hitSlop: EdgeInsets.only(right: -AppSpacing.s3.w),
                    variant: AppCircleButtonVariant.secondary,
                    bgColor: AppColors.transparent,
                    iconSize: AppIconSize.is20,
                    showShadow: false,
                    icon: AppIcons.svg.generic.share,
                    onTap: () => {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Share Event')),
                      ),
                    },
                  ),
                ],
              ),
            ),
          ],
        ),

        body: SafeArea(
          child: _isOwnPost
              ? BlocBuilder<
                  MyMissingPetsBloc,
                  PaginationState<MissingPetModel>
                >(builder: _build)
              : BlocBuilder<
                  MyMissingPetsBloc,
                  PaginationState<MissingPetModel>
                >(builder: _build),
        ),

        bottomNavigationBar: _isOwnPost
            ? BlocBuilder<MyMissingPetsBloc, PaginationState<MissingPetModel>>(
                builder: _buildBottomNavigation,
              )
            : BlocBuilder<MyMissingPetsBloc, PaginationState<MissingPetModel>>(
                builder: _buildBottomNavigation,
              ),
      ),
    );
  }

  Widget _build(BuildContext context, PaginationState<MissingPetModel> state) {
    final item = state.selectedItem;

    /// =============================
    /// LOADING
    /// =============================
    if (state.isDetailLoading && item == null) {
      return const Center(child: CircularProgressIndicator());
    }

    /// =============================
    /// ERROR
    /// =============================
    if (state.detailError != null && item == null) {
      return Center(child: Text(state.detailError!));
    }

    /// =============================
    /// EMPTY
    /// =============================
    if (item == null) {
      return const Center(child: Text('Pet not found'));
    }

    /// =============================
    /// UI
    /// =============================
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.s16.w,
          vertical: AppSpacing.s12.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isOwnPost && item.status != 'FOUND') ...[
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
                    AppText.h2('Is ${item.pet.name} Home?', maxLines: 2),
                    AppSpacing.s5.hBox,
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            variant: AppButtonVariant.outlined,
                            size: AppButtonSize.xSmall,
                            backgroundColor: AppColors.white_50,
                            isDisabled: isDeleting,
                            label: 'No',
                            onPressed: () {
                              context.pushRoute(
                                PetStillMissingTransitionRoute(
                                  petId: item.pet.id,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: AppSpacing.s12.w),
                        Expanded(
                          child: AppButton(
                            size: AppButtonSize.xSmall,
                            isDisabled: isDeleting,
                            label: 'Yes',
                            onPressed: () {
                              context.pushRoute(
                                PetIsHomeTransitionRoute(
                                  petId: item.pet.id,
                                  reportId: item.id,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppSpacing.s11.hBox,
            ],

            /// =============================
            /// EVENT CARD (REUSED COMPONENT)
            /// =============================
            MissingPoochListItemCard(isDetailView: true, item: item),
            SizedBox(height: AppSpacing.s16.h),

            /// =============================
            /// REFRESH LOADER
            /// =============================
            if (state.isDetailRefreshing)
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(
    BuildContext context,
    PaginationState<MissingPetModel> state,
  ) {
    final item = state.selectedItem;

    /// =============================
    /// LOADING
    /// =============================
    if (state.isDetailLoading && item == null) {
      return const Center(child: CircularProgressIndicator());
    }

    /// =============================
    /// UI
    /// =============================
    return _isOwnPost
        ? (item != null && item.status == 'FOUND')
              ? const SizedBox.shrink()
              : SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.s16.w,
                      vertical: AppSpacing.s16.h,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            variant: AppButtonVariant.outlined,
                            backgroundColor: AppColors.white_50,
                            isLoading: isDeleting,
                            label: 'Delete Post',
                            onPressed: () {
                              AppDialog.show(
                                icon: Lottie.asset(
                                  AppIcons.lottie.delete,
                                  repeat: false,
                                ),
                                context: context,
                                title: 'Delete Post?',
                                content:
                                    'This action cannot be undone. Are you sure you want to delete this post?',
                                primaryLabel: 'Cancel',
                                secondaryLabel: 'Delete',
                                onPrimary: () async {
                                  return true;
                                },
                                onSecondary: () async {
                                  deleteReportPost(widget.reportId);
                                  return true;
                                },
                              );
                            },
                            size: AppButtonSize.medium,
                          ),
                        ),
                        SizedBox(width: AppSpacing.s12.w),
                        Expanded(
                          child: AppButton(
                            isDisabled: isDeleting,
                            label: 'Edit Post',
                            onPressed: () {
                              context.pushRoute(
                                ReportMissingPetFormRoute(
                                  type: ReportMissingPetFormType.edit,
                                  reportId: widget.reportId,
                                ),
                              );
                            },
                            size: AppButtonSize.medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
        : SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.s16.w,
                vertical: AppSpacing.s16.h,
              ),
              child: Row(
                children: [
                  if (widget.listType == 'biometric_not_found') ...[
                    Expanded(
                      child: AppButton(
                        isLoading: isDeleting,
                        label: 'Not Sure, Still Notify Parent',
                        onPressed: () {
                          sendMessageToParent();
                        },
                        size: AppButtonSize.medium,
                      ),
                    ),
                  ],

                  if (widget.listType == 'manual_found_pet') ...[
                    Expanded(
                      child: AppButton(
                        isLoading: isDeleting,
                        label: 'Contact Pet Owner',
                        onPressed: () {
                          sendMessageToParent();
                        },
                        size: AppButtonSize.medium,
                      ),
                    ),
                  ],

                  if (widget.listType == 'default') ...[
                    Expanded(
                      child: AppButton(
                        isLoading: isDeleting,
                        label: 'I Found this Pooch',
                        onPressed: () {
                          context.pushRoute(
                            MissingVerifyBiometricRoute(
                              reportId: widget.reportId,
                            ),
                          );
                        },
                        size: AppButtonSize.medium,
                      ),
                    ),
                  ],

                  // Expanded(
                  //   child: AppButton(
                  //     isLoading: isDeleting,
                  //     label: 'I Found this Pooch',
                  //     onPressed: () {
                  //       context.pushRoute(
                  //         MissingVerifyBiometricRoute(
                  //           reportId: widget.reportId,
                  //         ),
                  //       );
                  //     },
                  //     size: AppButtonSize.medium,
                  //   ),
                  // ),
                ],
              ),
            ),
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
      title: 'Select location of the pet',
      // ignore: use_build_context_synchronously
      context: context,
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

    // CustomSnackbar.show(
    //   'Message sent to pet parent with location details. They will reach out to you if they need more info.',
    //   SnackbarType.success,
    // );

    setState(() {
      isSubmitting = true;
    });

    try {
      // ignore: unused_local_variable

      if (!mounted) return; // ✅ I

      await context.read<MyMissingPetsBloc>().reportMissingPetFound(
        payload: payload,
      );
      if (!mounted) return; // ✅ I
      // ignore: use_build_context_synchronously
      context.router.push(
        PoochParentChatRoute(
          userName: 'Pooch Parent',
          source: 'missing_pet_chat',
        ),
      );
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

  Future<void> deleteReportPost(String reportId) async {
    setState(() {
      isDeleting = true;
    });

    try {
      await context.read<MyMissingPetsBloc>().deleteReportPost(
        reportId: reportId,
      );
      // ignore: use_build_context_synchronously
      if (!mounted) return;

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

      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        isDeleting = false;
      });
    } finally {
      setState(() {
        isDeleting = false;
      });
    }
  }
}
