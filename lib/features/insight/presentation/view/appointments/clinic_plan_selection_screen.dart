import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/utils/safe_parser_service.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/dialogs/app_select_pet_dialog.dart';
import 'package:poochcare/core/widgets/others/payments/clininc_subscription_plan_card.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/insight/data/cubit/appointment_request_cubit.dart';
import 'package:poochcare/features/insight/data/models/clinic_subs_plans_response_model.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_bloc.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_event.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_state.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class ClinicPlanSelectionScreen extends StatefulWidget {
  final String clinicId;
  const ClinicPlanSelectionScreen({required this.clinicId, super.key});

  @override
  @override
  State<ClinicPlanSelectionScreen> createState() =>
      _ClinicPlanSelectionScreenState();
}

class _ClinicPlanSelectionScreenState extends State<ClinicPlanSelectionScreen> {
  Pet? selectedPet;
  String? selectedPlanId;
  bool isPlanSelected = false;
  bool isSubscribedOnce = false;

  @override
  void initState() {
    super.initState();
    final appointmentCubit = getIt<AppointmentCubit>();
    context.read<ClinicBloc>().add(
      FetchClinicDetails(clinicId: widget.clinicId),
    );
    context.read<ClinicBloc>().add(
      FetchClinicPlans(
        clinicId: widget.clinicId,
        petId: appointmentCubit.state.petId ?? '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppPrimaryScreenContainer(
      title: 'Select a plan',
      bottomNavigationBar: SafeArea(
        child: GlassContainer(
          blur: 20,
          color: AppColors.p2_50.withValues(alpha: 0.29),
          // gradient: LinearGradient(
          //   begin: Alignment.bottomCenter,
          //   end: Alignment.topCenter,
          //   colors: [
          //     AppColors.p2_50.withValues(alpha: 0.9),
          //     AppColors.p2_50.withValues(alpha: 0.7),
          //     AppColors.p2_50.withValues(alpha: 0.5),
          //     AppColors.p2_50.withValues(alpha: 0.3),
          //     AppColors.white.withValues(alpha: 0.2),
          //   ],
          // ),
          //--code to remove border
          border: const Border.fromBorderSide(BorderSide.none),
          // shadowStrength: 5,
          // shape: BoxShape.circle,
          borderRadius: BorderRadius.circular(0),
          // shadowColor: const Color(0xFFDDCDB6).withValues(alpha: 0.29),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.s16.w,
              vertical: AppSpacing.s16.h,
            ),
            child: AppButton(
              isDisabled: !isPlanSelected,
              label: isSubscribedOnce ? 'Upgrade Now' : 'Buy Now',
              onPressed: () {
                final appointmentCubit = getIt<AppointmentCubit>();
                appointmentCubit.updateClinic(
                  clinicId: widget.clinicId,
                  planId: selectedPlanId,
                );
                context.router.push(
                  AppointmentPaymentSummaryRoute(
                    clinicId: widget.clinicId,
                    planStatus: isSubscribedOnce ? 'Upgrade' : 'Buy',
                  ),
                );
              },
              size: AppButtonSize.medium,
            ),
          ),
        ),
      ),
      child: SafeArea(
        child: BlocBuilder<ClinicBloc, ClinicState>(
          buildWhen: (previous, current) =>
              previous.clinicDetailsStatus != current.clinicDetailsStatus ||
              previous.clinicPlanStatus != current.clinicPlanStatus,
          builder: (context, state) {
            // final clinicDetails = state.clinicDetailsData?.clinic;
            // // final subscriptionPlans =
            // //     state.clinicDetailsData?.subscriptionPlans ?? [];
            // final totalVets = state.clinicDetailsData?.totalVets ?? 0;

            if (state.clinicPlanStatus == ClinicPlanStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.clinicPlanStatus == ClinicPlanStatus.failure) {
              return Center(child: AppText.bodyS('Something went wrong!'));
            }

            final subscriptionPlans = [
              ...(state.clinicPlanResponseData?.data.plans ?? []),
            ];

            subscriptionPlans.sort((a, b) {
              int getRank(ClinicPlanModel plan) {
                final type = plan.planType.toLowerCase();
                final duration = plan.planDuration.toLowerCase();
                // Free plans first
                if (type == 'free') {
                  return 0;
                }
                // Monthly paid plans
                if (duration == 'monthly') {
                  return 1;
                }
                // Yearly paid plans
                return 2;
              }

              final rankCompare = getRank(a).compareTo(getRank(b));
              if (rankCompare != 0) {
                return rankCompare;
              }
              // Sort by price inside same category
              final aPrice = double.tryParse(a.price) ?? 0;
              final bPrice = double.tryParse(b.price) ?? 0;
              return aPrice.compareTo(bPrice);
            });

            final hasSubscribedPlan = subscriptionPlans.any(
              (plan) => plan.isSubscribed || plan.isAlreadyBought,
            );

            //  to upde the button status from screen builder.
            if (isSubscribedOnce != hasSubscribedPlan) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    isSubscribedOnce = hasSubscribedPlan;
                  });
                }
              });
            }

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.s9.w,
                AppSpacing.s16.h,
                AppSpacing.s9.w,
                AppSpacing.s16.h, // space for bottom nav
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSpacing.s16.h,
                      horizontal: AppSpacing.s48.w,
                    ).copyWith(bottom: AppSpacing.s24.h),
                    child: AppText.h4(
                      'Choose a plan that suits you',
                      fontSize: AppFontSize.fs32,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ...List.generate(subscriptionPlans.length, (index) {
                    final plan = subscriptionPlans[index];

                    final isFree = plan.planType.toLowerCase() == 'free';

                    final isMonthly =
                        plan.planDuration.toLowerCase() == 'monthly';

                    final isYearly =
                        plan.planDuration.toLowerCase() == 'yearly';

                    final title = isFree
                        ? 'Free'
                        : isMonthly
                        ? 'Monthly'
                        : 'Annual';

                    final variant = isFree
                        ? SubscriptionPlanVariants.free
                        : isMonthly
                        ? SubscriptionPlanVariants.monthly
                        : SubscriptionPlanVariants.yearly;

                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: ClinicSubscriptionPlanCard(
                        isSelectable:
                            !(isFree &&
                                (plan.isSubscribed ||
                                    plan.isAlreadyBought)), // Free plan can be subscribed only once
                        subscriptionPlan: SubscriptionPlan(
                          // title: plan.planName.toUpperCase(),
                          title: title,
                          isBestValue: isYearly,
                          price:
                              '${plan.currency} ${SafeParserService.formatPrice(plan.price)}',
                          isSelected: selectedPlanId == plan.id,
                          isSubscribed:
                              plan.isSubscribed || plan.isAlreadyBought,
                          features: plan.features.displayFeatures,
                        ),
                        variant: variant,
                        onSelect: () {
                          setState(() {
                            selectedPlanId = plan.id;
                            isPlanSelected = true;
                          });
                        },
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
