import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/theme/app_typography.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/fun/presentation/bloc/accessories_bloc/accessories_bloc.dart';
import 'package:poochcare/features/fun/presentation/bloc/accessories_bloc/accessories_event.dart';
import 'package:poochcare/features/fun/presentation/bloc/accessories_bloc/accessories_state.dart';
import 'package:poochcare/features/fun/presentation/widgets/accessories_widget.dart';
import 'package:poochcare/features/insight/presentation/widgets/state_wrapper.dart';

@RoutePage()
class YourAccessoriesScreen extends StatefulWidget implements AutoRouteWrapper {
  const YourAccessoriesScreen({super.key});

  @override
  State<YourAccessoriesScreen> createState() => _YourAccessoriesScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AccessoriesBloc>()
        ..add(const FetchMyAccessoriesEvent(1, true)),
      child: this,
    );
  }
}

class _YourAccessoriesScreenState extends State<YourAccessoriesScreen> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPrimaryBgContainer(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12),
              child: Column(
                children: [
                  const PoochScreenAppBar(title: 'Your accessories'),
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
                      color: AppColors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            AppText.h3(
                              'Virtual Pet',
                              fontSize: AppFontSize.fs20,
                            ),
                          ],
                        ),

                        const SizedBox(height: AppSpacing.s16),
                        AppIcon(
                          AppIcons.png.transitions.funPuppyWithCap,
                          height: 187.h,
                        ),

                        const SizedBox(height: AppSpacing.s40),

                        Row(
                          children: [
                            AppText.h1(
                              'Select Accessories',
                              fontSize: AppFontSize.fs14,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.s20),
                        BlocBuilder<AccessoriesBloc, AccessoriesState>(
                          builder: (context, state) {
                            final accessoriesItem = state.myAccessories;
                            return StateWrapper(
                              onRetry: () {
                                context.read<AccessoriesBloc>().add(
                                  const FetchMyAccessoriesEvent(1, true),
                                );
                              },
                              isLoading:
                                  state.myAccessoriesStatus ==
                                  MyAccessoriesStatus.loading,
                              isError:
                                  state.myAccessoriesStatus ==
                                  MyAccessoriesStatus.failure,
                              isEmpty: accessoriesItem.isEmpty,
                              title: 'Accessories',
                              child: AccessoriesWidget(
                                accessories: accessoriesItem,
                                selectedIndex: _selectedIndex,
                                onChange: (selectedIndex) {
                                  _selectedIndex = selectedIndex;
                                  setState(() {});
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s100),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: AppButton(
          label: 'Apply Now',
          onPressed: () {},
          size: AppButtonSize.medium,
          textStyle: AppTypography.h1.copyWith(fontSize: AppFontSize.fs14),
        ),
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
