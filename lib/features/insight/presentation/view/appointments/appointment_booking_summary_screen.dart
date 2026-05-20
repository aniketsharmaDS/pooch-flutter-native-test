import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/utils/date_time_formattter.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/dialogs/app_select_pet_dialog.dart';
import 'package:poochcare/core/widgets/headers/primary_widget_header.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/others/clinics/clinic_details_card.dart';
import 'package:poochcare/core/widgets/others/clinics/clinic_details_slot_card.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/insight/data/cubit/appointment_request_cubit.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_bloc.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_event.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_state.dart';
import 'package:poochcare/features/user_profile/domain/models/user_pet.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class AppointmentBookingSummaryScreen extends StatefulWidget {
  final String clinicId;

  const AppointmentBookingSummaryScreen({required this.clinicId, super.key});

  @override
  State<AppointmentBookingSummaryScreen> createState() =>
      _AppointmentBookingSummaryScreenState();
}

class _AppointmentBookingSummaryScreenState
    extends State<AppointmentBookingSummaryScreen> {
  Pet? selectedPet;
  late List<Pet> petsList = [];
  bool isListenerActive = false;

  @override
  void initState() {
    super.initState();
    final appointmentCubit = getIt<AppointmentCubit>();
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
    // context.read<ClinicBloc>().add(
    //   // FetchClinicDetails(clinicId: widget.clinicId),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return AppPrimaryScreenContainer(
      title: 'Booking summary',
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.s16.w,
            vertical: AppSpacing.s16.h,
          ),
          child: Row(
            children: [
              /// Button 1
              Expanded(
                child: BlocConsumer<ClinicBloc, ClinicState>(
                  listener: (context, state) {
                    // API completed successfully
                    if (state.clinicPlanStatus == ClinicPlanStatus.success &&
                        isListenerActive) {
                      // Get subscription having remaining credits
                      setState(() {
                        isListenerActive = false; // Reset the listener flag
                      });
                      final activeSubscription = state
                          .clinicPlanResponseData
                          ?.data
                          .activeSubscriptions
                          .firstWhereOrNull((sub) => sub.hasRemainingCredits);

                      if (!context.mounted) return;

                      if (activeSubscription != null) {
                        // Move to booking/payment success flow
                        final appointmentCubit = getIt<AppointmentCubit>();
                        appointmentCubit.updateClinic(
                          clinicId: widget.clinicId,
                          planId: activeSubscription.planId,
                        );
                        context.router.push(
                          AppointmentPaymentSummaryRoute(
                            clinicId: widget.clinicId,
                            planStatus: 'BOOK_SLOT',
                          ),
                        );
                      } else {
                        // No credits left
                        if (!context.mounted) return;
                        context.router.push(
                          ClinicPlanSelectionRoute(clinicId: widget.clinicId),
                        );
                      }
                    }

                    // Optional error handling
                    if (state.clinicPlanStatus == ClinicPlanStatus.failure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.errorMessage ?? 'Something went wrong',
                          ),
                        ),
                      );
                    }
                  },

                  builder: (context, subState) {
                    final isProcessing =
                        subState.clinicPlanStatus == ClinicPlanStatus.loading;
                    return AppButton(
                      isLoading: isProcessing,
                      label: 'Confirm Booking',
                      onPressed: () {
                        setState(() {
                          isListenerActive = true; // Reset the listener flag
                        });
                        context.read<ClinicBloc>().add(
                          FetchClinicPlans(
                            clinicId: widget.clinicId,
                            petId: selectedPet?.id ?? '',
                          ),
                        );
                      },
                      size: AppButtonSize.medium,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white_50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppRadiusSize.r16.rr),
              topRight: Radius.circular(AppRadiusSize.r16.rr),
              bottomRight: Radius.circular(AppRadiusSize.r16.rr),
              bottomLeft: Radius.circular(AppRadiusSize.r16.rr),
            ),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: AppSpacing.s16.w,
            vertical: AppSpacing.s16.h,
          ),
          child: BlocBuilder<ClinicBloc, ClinicState>(
            builder: (context, state) {
              final appointmentCubit = getIt<AppointmentCubit>();
              final clinicDetails = state.clinicDetailsData?.clinic;
              final subscriptionPlans =
                  state.clinicDetailsData?.subscriptionPlans ?? [];
              final totalVets = state.clinicDetailsData?.totalVets ?? 0;

              if (state.clinicDetailsStatus == ClinicDetailsStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.clinicDetailsStatus == ClinicDetailsStatus.failure) {
                return Center(child: AppText.bodyS('Something went wrong!'));
              }

              final paidPlans = subscriptionPlans
                  .where((e) => e.planType == 'paid')
                  .toList();

              paidPlans.sort((a, b) {
                final aPrice = double.tryParse(a.price.toString()) ?? 0;
                final bPrice = double.tryParse(b.price.toString()) ?? 0;

                return aPrice.compareTo(bPrice);
              });

              return Stack(
                children: [
                  Column(
                    children: [
                      Padding(
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
                            status: '',
                            closingTime: '',
                            basePrice: '',
                          ),
                          onTap: () {},
                        ),
                      ),

                      const PrimaryWidgetHeader(title: 'Clinic appointment'),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.s16.w,
                        ),
                        child: Row(
                          children: [
                            AppIcon(
                              AppIcons.svg.generic.calendar,
                              size: AppRadiusSize.r18.rr,
                              color: const Color(0xFF7F7F80),
                            ),
                            SizedBox(width: AppSpacing.s9.w),
                            AppText.h3(
                              // appointmentCubit.state.appointmentTime ?? 'asdas',
                              formatAppointmentDateTime(
                                appointmentCubit.state.appointmentTime ?? '',
                              ),
                              fontSize: AppFontSize.fs16,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.s16.w,
                            vertical: AppSpacing.s15.h,
                          ),
                          child: AppButton(
                            variant: AppButtonVariant.outlined,
                            onPressed: () => {Navigator.of(context).pop()},
                            size: AppButtonSize.medium,
                            width: null,
                            label: 'Change date & Time',
                            trailingSvgAsset: AppIcons.svg.generic.edit,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      const PrimaryWidgetHeader(title: 'Booked For'),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.s16.w,
                        ),
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

                            SizedBox(width: AppSpacing.s9.w),
                            AppButton(
                              variant: AppButtonVariant.outlined,
                              onPressed: () async {
                                final result = await AppSelectPetDialog.show(
                                  context:
                                      context, // ✅ safe, captured before await
                                  pets: petsList,
                                  initiallySelectedPet: selectedPet,
                                );

                                if (!mounted) return;

                                if (result != null) {
                                  selectedPet = result.selectedPet;
                                  setState(() {});
                                  appointmentCubit.updatePet(
                                    petId: result.selectedPet.id,
                                    petName: result.selectedPet.name,
                                    petImage: result.selectedPet.imageUrl,
                                    petNotes: result.note,
                                  );
                                }
                              },
                              size: AppButtonSize.medium,
                              width: null,
                              label: 'Change Pet',
                              trailingSvgAsset: AppIcons.svg.generic.edit,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
