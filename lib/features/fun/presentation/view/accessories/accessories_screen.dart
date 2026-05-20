import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/services/snackbar_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/theme/app_typography.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/dialogs/app_select_pet_dialog.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/bottom_sheets/need_help_bottom_sheet.dart';
import 'package:poochcare/features/fun/presentation/bloc/accessories_bloc/accessories_bloc.dart';
import 'package:poochcare/features/fun/presentation/bloc/accessories_bloc/accessories_event.dart';
import 'package:poochcare/features/fun/presentation/bloc/accessories_bloc/accessories_state.dart';
import 'package:poochcare/features/fun/presentation/bloc/accessories_order_summary_bloc/accessories_order_summary_bloc.dart';
import 'package:poochcare/features/fun/presentation/bloc/accessories_order_summary_bloc/accessories_order_summary_event.dart';
import 'package:poochcare/features/fun/presentation/bloc/accessories_order_summary_bloc/accessories_order_summary_state.dart';
import 'package:poochcare/features/fun/presentation/widgets/accessories_widget.dart';
import 'package:poochcare/features/insight/data/cubit/appointment_request_cubit.dart';
import 'package:poochcare/features/insight/presentation/widgets/state_wrapper.dart';
import 'package:poochcare/features/user_profile/domain/models/user_pet.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class AccessoriesScreen extends StatefulWidget implements AutoRouteWrapper {
  final String? couponCode;
  const AccessoriesScreen({super.key, this.couponCode});

  @override
  State<AccessoriesScreen> createState() => _AccessoriesScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AccessoriesBloc>()
        ..add(
          FetchAccessoriesEvent(
            page: 1,
            isForceRefresh: true,
            couponCode: couponCode,
          ),
        ),
      child: this,
    );
  }
}

class _AccessoriesScreenState extends State<AccessoriesScreen> {
  Pet? selectedPet;
  late List<Pet> petsList = [];
  Accessory? _selectedAccessory;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPrimaryBgContainer(
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              final accessoryBloc = context.read<AccessoriesBloc>();
              accessoryBloc.add(
                const FetchAccessoriesEvent(page: 1, isForceRefresh: true),
              );
              await accessoryBloc.stream.firstWhere(
                (element) => element.status == AccessoriesStatus.success,
              );
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12),

                child: Column(
                  children: [
                    const PoochScreenAppBar(title: 'Accessories'),
                    const SizedBox(height: AppSpacing.s10),
                    Container(
                      alignment: Alignment.center,
                      height: 69.h,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(AppRadiusSize.r12),
                      ),
                      padding: const EdgeInsets.only(
                        left: AppSpacing.s16,
                        right: AppSpacing.s10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText.h1(
                                '200 AED to unlock new skill',
                                fontSize: AppFontSize.fs14,
                              ),
                              const SubscribedButton(),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.s10),
                          const LinearProgressIndicator(
                            value: 0.8,
                            color: AppColors.p2,
                            backgroundColor: AppColors.p2_100,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.s16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.s14,
                        vertical: AppSpacing.s16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppRadiusSize.r16),
                        color: AppColors.s3_50,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText.h3(
                                'Virtual Pet',
                                fontSize: AppFontSize.fs20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.router.push(
                                    const YourAccessoriesRoute(),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppText.h3(
                                      'Your Accessories',
                                      fontSize: AppFontSize.fs14,
                                    ),
                                    AppIcon(
                                      AppIcons.svg.generic.arrowUpRight,
                                      size: 16.h,
                                      color: AppColors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: AppSpacing.s16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppIcon(
                                AppIcons.png.transitions.funPuppyWithCap,
                                height: 187.h,
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.s10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppText.bodyS(
                                'Every accessory boosts your rank',
                                fontSize: AppFontSize.fs12,
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.s40),

                          Row(
                            children: [
                              AppText.h1(
                                'Buy Accessories',
                                fontSize: AppFontSize.fs14,
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.s20),
                          SizedBox(
                            height: 220.h,
                            child: BlocBuilder<AccessoriesBloc, AccessoriesState>(
                              buildWhen: (previous, current) =>
                                  previous != current,
                              builder: (context, state) {
                                final accessoriesItem = state.accessories;

                                return NotificationListener<ScrollNotification>(
                                  onNotification:
                                      (ScrollNotification scrollInfo) {
                                        if (scrollInfo.metrics.pixels >=
                                            scrollInfo.metrics.maxScrollExtent *
                                                0.8) {
                                          context.read<AccessoriesBloc>().add(
                                            const FetchAccessoriesEvent(),
                                          );
                                        }
                                        return false;
                                      },
                                  child: StateWrapper(
                                    isEmpty: state.accessories.isEmpty,
                                    isError:
                                        state.status ==
                                        AccessoriesStatus.failure,
                                    isLoading:
                                        state.status ==
                                            AccessoriesStatus.loading &&
                                        state.accessories.isEmpty,
                                    title: 'Accessory',
                                    onRetry: () {
                                      context.read<AccessoriesBloc>().add(
                                        const FetchAccessoriesEvent(),
                                      );
                                    },
                                    child: AccessoriesWidget(
                                      state: state,
                                      accessories: accessoriesItem,
                                      onChange: (selectedAccessory) {
                                        _selectedAccessory = selectedAccessory;
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: AppSpacing.s20),

                          const NoteWidget(),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s20),
                    BlocProvider.value(
                      value: getIt<AccessoriesOrderSummaryBloc>(),
                      child:
                          BlocConsumer<
                            AccessoriesOrderSummaryBloc,
                            AccessoriesOrderSummaryState
                          >(
                            listener: (context, state) {
                              if (state.accessoriesOrderSummarydStatus ==
                                  AccessoriesOrderSummaryStatus.failure) {
                                CustomSnackbar.show(
                                  state.errorMessage ?? '',
                                  SnackbarType.error,
                                );
                              }
                            },
                            builder: (context, state) {
                              final isLoading =
                                  state.accessoriesOrderSummarydStatus ==
                                  AccessoriesOrderSummaryStatus.loading;
                              return BlocSelector<
                                AccessoriesBloc,
                                AccessoriesState,
                                String?
                              >(
                                selector: (state) => state.selectedAccessoryId,
                                builder: (context, selectedAccessory) =>
                                    AppButton(
                                      label: 'Buy Now',
                                      isLoading: isLoading,
                                      isDisabled: selectedAccessory == null,
                                      onPressed: () async {
                                        onBuyNowClick(context: context);
                                      },
                                      size: AppButtonSize.medium,
                                      textStyle: AppTypography.h1.copyWith(
                                        fontSize: AppFontSize.fs14,
                                      ),
                                    ),
                              );
                            },
                          ),
                    ),
                    const SizedBox(height: AppSpacing.s10),

                    AppButton(
                      textStyle: AppTypography.h1.copyWith(
                        fontSize: AppFontSize.fs14,
                      ),

                      backgroundColor: AppColors.p1,
                      foregroundColor: AppColors.black,
                      label: 'View Leaderboard',
                      onPressed: () {
                        context.router.push(const LeaderboardRoute());
                      },
                      size: AppButtonSize.medium,
                    ),
                    const SizedBox(height: AppSpacing.s30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onBuyNowClick({required BuildContext context}) async {
    final result = await AppSelectPetDialog.show(
      showNoteField: false,
      context: context, // ✅ safe, captured before await
      pets: petsList,
      initiallySelectedPet: selectedPet,
    );

    if (!mounted) return;
    if (!context.mounted) return;

    if (result != null) {
      selectedPet = result.selectedPet;
      final accessoriesBloc = context.read<AccessoriesOrderSummaryBloc>();

      final profileData = context.read<UserProfileBloc>().state;
      final country = profileData.profile?.countryCode == '91'
          ? 'India'
          : profileData.profile?.countryCode == '971'
          ? 'UAE'
          : '';
      accessoriesBloc.add(
        FetchAccessoriesOrderSummaryEvent(
          1,
          true,
          _selectedAccessory?.id ?? '',
          country,
          null,
          selectedPet?.id ?? '',
          1,
        ),
      );
      final data = await accessoriesBloc.stream.firstWhere(
        (element) =>
            element.accessoriesOrderSummarydStatus ==
                AccessoriesOrderSummaryStatus.success ||
            element.accessoriesOrderSummarydStatus ==
                AccessoriesOrderSummaryStatus.failure,
      );

      if (data.accessoriesOrderSummarydStatus ==
          AccessoriesOrderSummaryStatus.success) {
        if (!context.mounted) return;

        context.router.push(
          AccessoryOrderSummaryRoute(
            couponCode: widget.couponCode,
            accessoryId: _selectedAccessory?.id ?? '',
            petId: result.selectedPet.id,
          ),
        );
      } else {
        return;
      }
    }
  }
}

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s16,
        vertical: AppSpacing.s12,
      ),
      decoration: BoxDecoration(
        color: AppColors.p3_50,
        borderRadius: BorderRadius.circular(AppRadiusSize.r12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              AppText.h3(
                'Please Note',
                color: AppColors.p4_800,
                fontSize: AppFontSize.fs14,
              ),
            ],
          ),
          AppText.bodyS(
            fontSize: AppFontSize.fs12,
            color: AppColors.p4_800,
            variant: AppTextVariant.noEllipsis,
            'The proceeds from all virtual accessoris you buy for your pooch go towards charities supporting the pet care community',
          ),
        ],
      ),
    );
  }
}

class SubscribedButton extends StatelessWidget {
  const SubscribedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        height: 26.h,
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(AppRadiusSize.r8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s6),
        child: AppText.h3(
          'Subscribed',
          fontSize: AppFontSize.fs12,
          color: AppColors.white,
        ),
      ),
    );
  }
}
