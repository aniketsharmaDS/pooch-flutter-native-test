import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/utils/safe_parser_service.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';
import 'package:poochcare/core/widgets/dialogs/app_select_pet_dialog.dart';
import 'package:poochcare/core/widgets/headers/primary_widget_header.dart';
import 'package:poochcare/core/widgets/others/clinics/clinic_details_card.dart';
import 'package:poochcare/core/widgets/others/clinics/clinic_details_slot_card.dart';
import 'package:poochcare/core/widgets/others/payments/clininc_subscription_plan_card.dart';
import 'package:poochcare/core/widgets/others/price_summary_section.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/insight/data/cubit/appointment_request_cubit.dart';
import 'package:poochcare/features/insight/data/models/clinic_subs_preview_response_model.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_bloc.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_event.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_state.dart';
import 'package:poochcare/features/insight/presentation/bloc/subscribed_clinics_bloc/subscribed_clinics_bloc.dart';
import 'package:poochcare/features/insight/presentation/bloc/subscribed_clinics_bloc/subscribed_clinics_event.dart';
import 'package:poochcare/features/insight/presentation/bloc/subscribed_clinics_bloc/subscribed_clinics_state.dart';
import 'package:poochcare/features/user_profile/domain/models/user_pet.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class AppointmentPaymentSummaryScreen extends StatefulWidget {
  final String clinicId;
  final String planStatus; // e.g., 'NEW_SUBS', 'UPGRADE_SUBS', 'BOOK_SLOT'.
  const AppointmentPaymentSummaryScreen({
    required this.clinicId,
    required this.planStatus,
    super.key,
  });

  @override
  State<AppointmentPaymentSummaryScreen> createState() =>
      _AppointmentPaymentSummaryScreenState();
}

class _AppointmentPaymentSummaryScreenState
    extends State<AppointmentPaymentSummaryScreen> {
  Pet? selectedPet;
  late List<Pet> petsList = [];

  @override
  void initState() {
    super.initState();
    final appointmentCubit = getIt<AppointmentCubit>();
    context.read<ClinicBloc>().add(
      FetchSubsPreview(
        clinicId: widget.clinicId,
        petId: appointmentCubit.state.petId ?? '',
        subscriptionPlanId: appointmentCubit.state.planId ?? '',
        // consultationType: 'video_call',
        // promotionId: '',
        // couponCode: '',
      ),
    );
    final List<UserPet> pets = context.read<UserProfileBloc>().state.pets;
    petsList = pets.map((userPet) {
      return Pet(
        id: userPet.id,
        name: userPet.name,
        imageUrl: userPet.profilePicture ?? '',
        isSelected: appointmentCubit.state.petId == userPet.id,
      );
    }).toList();

    selectedPet = petsList.any((pet) => pet.isSelected)
        ? petsList.firstWhere((pet) => pet.isSelected)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return AppPrimaryScreenContainer(
      title: 'Cart',
      bottomNavigationBar: SafeArea(
        child: BlocBuilder<ClinicBloc, ClinicState>(
          builder: (context, state) {
            final appointmentCubit = getIt<AppointmentCubit>();
            final pricing = state.clinicSubsPreviewResponseData?.data.pricing;
            final addonData =
                state.clinicSubsPreviewResponseData?.data.addons[0];
            PreviewAddonModel? addonModel = addonData != null
                ? PreviewAddonModelMapper.fromJson(addonData.toJson())
                : null;

            final subscriptionPlans = [
              ...(state.clinicPlanResponseData?.data.plans ?? []),
            ];

            if (state.subsPreviewStatus == SubsPreviewStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.subsPreviewStatus == SubsPreviewStatus.failure) {
              return Center(child: AppText.bodyS('Something went wrong!'));
            }

            final String currency = pricing?.currency ?? 'INR';
            final String consultationFee = pricing != null
                ? '$currency ${SafeParserService.formatPrice(pricing.consultingFee)}'
                : '';
            final String serviceFee = pricing != null
                ? '$currency ${SafeParserService.formatPrice(pricing.serviceFee)}'
                : '';
            final String tax = pricing != null
                ? '$currency ${SafeParserService.formatPrice(pricing.taxAmount)}'
                : '';
            final String taxRate = pricing != null ? pricing.taxRate : '2%';

            String addOnsLabel = '';
            String addOns = '';

            final selectedPlan = subscriptionPlans
                .where((e) => e.id == appointmentCubit.state.planId)
                .toList();

            if (selectedPlan.isEmpty) {
              return Center(
                child: AppText.bodyS(
                  'No Plan is Selected! 2 ${subscriptionPlans.length}',
                ),
              );
            }

            final plan = selectedPlan[0];
            final isFree = plan.planType.toLowerCase() == 'free';
            final isMonthly = plan.planDuration.toLowerCase() == 'monthly';
            final isYearly = plan.planDuration.toLowerCase() == 'yearly';

            if (addonModel != null) {
              addOns =
                  '${addonModel.currency} ${SafeParserService.formatPrice(addonModel.price)}';
              if (isFree) {
                addOnsLabel = 'FREE Plan (Add Ons)';
              } else if (isMonthly) {
                addOnsLabel = 'Monthly Plan (Add Ons)';
              } else if (isYearly) {
                addOnsLabel = 'Annual Plan (Add Ons)';
              } else {
                addOnsLabel = '';
                addOns = '';
              }
            }

            final String total = pricing != null
                ? '$currency ${SafeParserService.formatPrice(pricing.totalAmount)}'
                : '';

            return Container(
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PriceSummarySection(
                    title: 'Booking Summary',
                    itemCount: 1,
                    rows: [
                      PriceSummaryRow(
                        title: 'Consultation Fee',
                        value: consultationFee,
                        titleColor: AppColors.p5_400,
                        valueColor: AppColors.p5_400,
                      ),
                      PriceSummaryRow(
                        title: 'Service Fee',
                        value: serviceFee,
                        titleColor: AppColors.p5_400,
                        valueColor: AppColors.p5_400,
                      ),
                      PriceSummaryRow(
                        title: 'Tax $taxRate',
                        value: tax,
                        titleColor: AppColors.p5_400,
                        valueColor: AppColors.p5_400,
                      ),
                      if (addOnsLabel.isNotEmpty) ...[
                        PriceSummaryRow(
                          title: addOnsLabel,
                          value: addOns,
                          titleColor: AppColors.p2,
                          valueColor: AppColors.p2,
                        ),
                      ],
                      PriceSummaryRow(
                        title: 'Total',
                        value: total,
                        titleColor: const Color(0xFF49454F),
                        valueColor: const Color(0xFF49454F),
                        isTotal: true,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.s10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.s16.w,
                      vertical: AppSpacing.s16.h,
                    ),
                    child:
                        BlocBuilder<
                          SubscribedClinicsBloc,
                          SusbcribedClinicsState
                        >(
                          builder: (context, subState) {
                            final isProcessing =
                                subState.purchaseStatus ==
                                SubscriptionPurchaseStatus.loading;

                            String btnLabel = 'Confirm And Pay';
                            if (widget.planStatus == 'BOOK_SLOT') {
                              btnLabel = 'Book Appointment';
                            }

                            return AppButton(
                              label: isProcessing ? 'Processing...' : btnLabel,
                              onPressed: isProcessing
                                  ? null
                                  : () {
                                      if (widget.planStatus == 'BOOK_SLOT') {
                                        context.router.push(
                                          AppointmentTransitionRoute(
                                            planStatus: widget.planStatus,
                                          ),
                                        );
                                      } else {
                                        _confirmAndPay(context);
                                      }
                                    },
                              size: AppButtonSize.medium,
                            );
                          },
                        ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: BlocListener<SubscribedClinicsBloc, SusbcribedClinicsState>(
            listener: (context, state) {
              if (state.purchaseStatus == SubscriptionPurchaseStatus.success) {
                context.read<SubscribedClinicsBloc>().add(
                  ResetPurchaseStatus(),
                );

                context.router.push(
                  AppointmentTransitionRoute(planStatus: widget.planStatus),
                );
              }

              if (state.purchaseStatus == SubscriptionPurchaseStatus.failure) {
                context.read<SubscribedClinicsBloc>().add(
                  ResetPurchaseStatus(),
                );

                context.router.push(const SubsPaymentFailedTransitionRoute());
              }
            },
            child: BlocBuilder<ClinicBloc, ClinicState>(
              buildWhen: (previous, current) {
                return previous.clinicDetailsData !=
                        current.clinicDetailsData ||
                    previous.clinicPlanResponseData !=
                        current.clinicPlanResponseData ||
                    previous.clinicDetailsStatus !=
                        current.clinicDetailsStatus ||
                    previous.clinicPlanStatus != current.clinicPlanStatus;
              },
              builder: (context, state) {
                final appointmentCubit = getIt<AppointmentCubit>();
                final clinicDetails = state.clinicDetailsData?.clinic;
                final totalVets = state.clinicDetailsData?.totalVets ?? 0;

                if (state.clinicDetailsStatus == ClinicDetailsStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.clinicDetailsStatus == ClinicDetailsStatus.failure) {
                  return Center(child: AppText.bodyS('Something went wrong!'));
                }

                final subscriptionPlans = [
                  ...(state.clinicPlanResponseData?.data.plans ?? []),
                ];

                final selectedPlan = subscriptionPlans
                    .where((e) => e.id == appointmentCubit.state.planId)
                    .toList();

                if (selectedPlan.isEmpty) {
                  return Center(
                    child: AppText.bodyS(
                      'No Plan is Selected! ${subscriptionPlans.length} ${appointmentCubit.state.planId}',
                    ),
                  );
                }

                final plan = selectedPlan[0];
                final isFree = plan.planType.toLowerCase() == 'free';
                final isMonthly = plan.planDuration.toLowerCase() == 'monthly';
                final isYearly = plan.planDuration.toLowerCase() == 'yearly';

                final title = isFree
                    ? 'Free'
                    : isMonthly
                    ? 'Monthly'
                    : 'Yearly';

                final variant = isFree
                    ? SubscriptionPlanVariants.free
                    : isMonthly
                    ? SubscriptionPlanVariants.monthly
                    : SubscriptionPlanVariants.yearly;

                final isAppointmentDateSeleted =
                    appointmentCubit.state.appointmentDate != null;

                return Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: AppColors.white_50,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: AppSpacing.s16.h,
                              horizontal: AppSpacing.s16.w,
                            ),
                            child: ClinicDetailsSlotCard(
                              clinic: ClinicDetailsCardModel(
                                id: clinicDetails?.id ?? '',
                                name: clinicDetails?.clinicName ?? '',
                                image: clinicDetails?.clinicImage ?? '',
                                vetCount: '$totalVets Vets',
                                experience:
                                    '${clinicDetails?.years}+ yrs experience',
                                location: clinicDetails?.city ?? '',
                                status: 'Open',
                                closingTime: '09.00 PM',
                                basePrice: '',
                              ),
                              onTap: () {},
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.s8.w,
                          ).copyWith(top: AppSpacing.s20.h),
                          child: const PrimaryWidgetHeader(
                            title: 'Subscription Plan',
                            removePadding: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.s8.w,
                          ),
                          child: ClinicSubscriptionPlanCard(
                            isSelectable: false,
                            subscriptionPlan: SubscriptionPlan(
                              title: title,
                              isBestValue: isYearly,
                              price:
                                  '${plan.currency} ${SafeParserService.formatPrice(plan.price)}',
                              isSelected: true,
                              isSubscribed: false,
                              features: [plan.features.featuresText],
                            ),
                            variant: variant,
                            onSelect: () {
                              setState(() {});
                            },
                          ),
                        ),

                        if (!isAppointmentDateSeleted) ...[
                          SizedBox(height: 12.h),
                          const PrimaryWidgetHeader(title: 'Subscribed For'),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.s16.w,
                            ).copyWith(bottom: AppSpacing.s24.h),
                            child: Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment.end, // 👈 add this
                              children: [
                                SizedBox(
                                  height: 120.h,
                                  child: PetCard(
                                    pet: Pet(
                                      id: selectedPet?.id ?? '',
                                      name: selectedPet?.name ?? '',
                                      imageUrl: selectedPet?.imageUrl ?? '',
                                      isSelected: true,
                                      isClickable: false,
                                    ),
                                    isSelected: true,
                                    onSelect: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _confirmAndPay(BuildContext context) {
    final appointmentCubit = getIt<AppointmentCubit>();
    final planId = appointmentCubit.state.planId ?? '';
    final petId = appointmentCubit.state.petId ?? '';
    final clinicId = appointmentCubit.state.clinicId ?? '';

    // Simple guard
    if (planId.isEmpty || petId.isEmpty) {
      AppDialog.show<bool>(
        context: context,
        title: 'Missing Data',
        content: 'Please select a pet and plan before proceeding.',
        primaryLabel: 'Ok',
        onPrimary: () async {
          return true;
        },
      );
      return;
    }

    // Dispatch purchase event
    context.read<SubscribedClinicsBloc>().add(
      PurchaseClinicSubscription(
        clinicId: clinicId,
        planId: planId,
        petId: petId,
      ),
    );
  }
}
