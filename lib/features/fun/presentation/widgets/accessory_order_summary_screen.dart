import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide TransitionRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/snackbar_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/utils/app_extensions/price_formatter_extension.dart';
import 'package:poochcare/core/utils/app_extensions/string_capitalise_extension.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';
import 'package:poochcare/core/widgets/others/price_summary_section.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/coupons/coupons_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/coupons/coupons_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/coupons/coupons_state.dart';
import 'package:poochcare/features/fun/presentation/bloc/accessories_order_summary_bloc/accessories_order_summary_bloc.dart';
import 'package:poochcare/features/fun/presentation/bloc/accessories_order_summary_bloc/accessories_order_summary_event.dart';
import 'package:poochcare/features/fun/presentation/bloc/accessories_order_summary_bloc/accessories_order_summary_state.dart';
import 'package:poochcare/features/fun/presentation/widgets/accessory_coupons_and_offers.dart';
import 'package:poochcare/features/insight/presentation/view/appointments/widgets/accessory_summary_item.dart';
import 'package:poochcare/features/test_screen/transition_screen/transition_screen.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class AccessoryOrderSummaryScreen extends StatefulWidget
    implements AutoRouteWrapper {
  final String accessoryId;
  final String petId;
  final String? couponCode;
  const AccessoryOrderSummaryScreen({
    super.key,
    this.couponCode,
    required this.accessoryId,
    required this.petId,
  });

  @override
  State<AccessoryOrderSummaryScreen> createState() =>
      _AccessoryOrderSummaryScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AccessoriesOrderSummaryBloc>()
        ..add(
          FetchAccessoriesOrderSummaryEvent(
            1,
            true,
            accessoryId,
            'India',
            couponCode,
            petId,
            1,
          ),
        ),
      child: this,
    );
  }
}

class _AccessoryOrderSummaryScreenState
    extends State<AccessoryOrderSummaryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CouponsBloc>().add(
      const FetchCouponsEvent(couponType: 'accessories'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppPrimaryScreenContainer(
      title: 'Accessories',
      child: SafeArea(
        child: BlocConsumer<AccessoriesOrderSummaryBloc, AccessoriesOrderSummaryState>(
          listener: (context, state) async {
            if (state.accessoriesOrderSummarydStatus ==
                AccessoriesOrderSummaryStatus.success) {
              if (state.accessoryData?.coupon != null &&
                  (state.accessoryData?.coupon.code ?? '').isNotEmpty) {
                await context.read<CouponsBloc>().stream.firstWhere(
                  (element) => element.status == CouponsStatus.success,
                );
                if (!context.mounted) return;
                context.read<CouponsBloc>().add(
                  ApplyAccessoryCouponLocally(
                    state.accessoryData?.coupon,
                    state.accessoryData?.coupon.code ?? '',
                  ),
                );
              }
            }
            if (state.accessoryPaymentStatus ==
                    AccessoryPaymentStatus.success &&
                state.successMessage != null) {
              CustomSnackbar.show(
                state.successMessage ?? '',
                SnackbarType.success,
              );
            } else if (state.accessoryPaymentStatus ==
                    AccessoryPaymentStatus.failure &&
                state.errorMessage != null) {
              CustomSnackbar.show(state.errorMessage ?? '', SnackbarType.error);
            }
          },
          builder: (context, state) {
            if (state.accessoriesOrderSummarydStatus ==
                AccessoriesOrderSummaryStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            final data = state.accessoryData;
            final pricing = state.accessoryData?.pricing;

            return Column(
              children: [
                Container(
                  decoration: const BoxDecoration(color: AppColors.white_50),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSpacing.s16.h,
                      horizontal: AppSpacing.s16.w,
                    ),
                    child: AccessorySummaryItem(
                      imageUrl: data?.accessory.thumbnail ?? '',
                      accessoryCategory:
                          data?.accessory.accessoryCategory.capitalize() ?? '',
                      price:
                          '${data?.pricing.currency} ${data?.pricing.basePrice.formatPrice()}',
                    ),
                  ),
                ),
                const Spacer(),

                AccessoryCouponsAndOffers(
                  accessoryId: widget.accessoryId,
                  petId: widget.petId,
                ),
                const SizedBox(height: AppSpacing.s10),

                BlocBuilder<CouponsBloc, CouponsState>(
                  builder: (context, couponState) {
                    final isCouponApplied =
                        couponState.appliedCouponCodeInAccessory != null &&
                        (couponState.appliedCouponCodeInAccessory ?? '')
                            .trim()
                            .isNotEmpty;
                    final discount = isCouponApplied
                        ? couponState.accessoryCouponResponse?.appliedDiscount
                              .formatPrice()
                        : null;
                    final totalPrice = isCouponApplied
                        ? (state.accessoryData?.pricing.basePrice ?? 0) -
                              (couponState
                                      .accessoryCouponResponse
                                      ?.appliedDiscount ??
                                  0)
                        : state.accessoryData?.pricing.basePrice;
                    final priceUnit = data?.pricing.currency;
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
                                title: 'MRP',
                                value:
                                    '$priceUnit ${pricing?.basePrice.formatPrice() ?? 0}',
                                titleColor: AppColors.p5_400,
                                valueColor: AppColors.p5_400,
                              ),
                              PriceSummaryRow(
                                title: 'Delivery Fee',
                                value: '$priceUnit 0',
                                titleColor: AppColors.p5_400,
                                valueColor: AppColors.p5_400,
                              ),
                              PriceSummaryRow(
                                title: 'Tax 2%',
                                value: '$priceUnit 0',
                                titleColor: AppColors.p5_400,
                                valueColor: AppColors.p5_400,
                              ),
                              if (isCouponApplied) ...[
                                PriceSummaryRow(
                                  title: 'Coupon Discount',
                                  value: '$priceUnit -${discount ?? ''}',
                                  titleColor: AppColors.a1,
                                  valueColor: AppColors.a1,
                                ),
                              ],
                              PriceSummaryRow(
                                title: 'Total',
                                value:
                                    '$priceUnit ${totalPrice?.formatPrice() ?? 0}',
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
                            child: AppButton(
                              isLoading:
                                  state.accessoryPaymentStatus ==
                                  AccessoryPaymentStatus.submitting,
                              label: 'Pay Now',
                              onPressed: () {
                                _showJourneyDialog(context);
                              },
                              size: AppButtonSize.medium,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _showJourneyDialog(BuildContext context) async {
    final result = await AppDialog.show<bool>(
      context: context,
      title: 'Choose Journey',
      content: 'Select a journey to continue with your checkout flow.',
      primaryLabel: 'Success',
      secondaryLabel: 'Failure',
      onPrimary: () async {
        final profileData = context.read<UserProfileBloc>().state;
        final couponCode = context
            .read<CouponsBloc>()
            .state
            .appliedCouponCodeInAccessory;
        context.read<AccessoriesOrderSummaryBloc>().add(
          PurchaseAccessory(
            couponCode: couponCode,
            accessoryId: widget.accessoryId,
            petId: widget.petId,
            country: profileData.profile?.countryCode == '91'
                ? 'India'
                : profileData.profile?.countryCode == '971'
                ? 'UAE'
                : '',
          ),
        );

        final resultState = await context
            .read<AccessoriesOrderSummaryBloc>()
            .stream
            .firstWhere(
              (element) =>
                  element.accessoryPaymentStatus ==
                      AccessoryPaymentStatus.success ||
                  element.accessoryPaymentStatus ==
                      AccessoryPaymentStatus.failure,
            );

        if (resultState.accessoryPaymentStatus ==
            AccessoryPaymentStatus.success) {
          return true;
        }

        // If failure, close the dialog and allow the BlocConsumer listener
        // to show the error snackbar. Returning false closes the dialog.
        return false;
      },
      onSecondary: () async => false,
    );

    if (!context.mounted || result == null) {
      return;
    }

    if (result) {
      context.router.replaceAll([const PurchaseSuccessRoute()]);
      return;
    }

    context.router.push(
      TransitionRoute(
        variant: TransitionScreenVariant.retryPayment,
        onPrimaryPressed: () {
          Navigator.pop(context);
        },
        onSecondaryPressed: () {
          context.router.replaceAll([const HomeRoute()]);
        },
      ),
    );
  }
}
