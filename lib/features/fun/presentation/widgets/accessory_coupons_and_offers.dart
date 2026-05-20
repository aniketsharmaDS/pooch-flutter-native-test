import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/services/toast_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/headers/primary_widget_header.dart';
import 'package:poochcare/core/widgets/others/coupon/applied_coupon_widget.dart';
import 'package:poochcare/core/widgets/others/coupon/apply_coupon_section.dart';
import 'package:poochcare/core/widgets/others/coupon/coupon_bottom_sheet.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/coupons/coupons_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/coupons/coupons_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/coupons/coupons_state.dart';
import 'package:poochcare/features/fun/presentation/widgets/accessories_coupon_bottom_sheet.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';

class AccessoryCouponsAndOffers extends StatefulWidget {
  final String accessoryId;
  final String petId;

  const AccessoryCouponsAndOffers({
    super.key,
    required this.accessoryId,
    required this.petId,
  });

  @override
  State<AccessoryCouponsAndOffers> createState() =>
      _AccessoryCouponsAndOffersState();
}

class _AccessoryCouponsAndOffersState extends State<AccessoryCouponsAndOffers> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CouponsBloc, CouponsState>(
      listener: (context, state) {
        if (state.status == CouponsStatus.success &&
            state.successMessage != null) {
          ToastService.showSuccess(state.successMessage!);
        } else if (state.status == CouponsStatus.failure &&
            state.errorMessage != null) {
          ToastService.showError(state.errorMessage!);
        }
      },
      builder: (context, state) {
        final coupons = state.coupons;
        final appliedCode = state.appliedCouponCodeInAccessory;
        final isCouponApplied = appliedCode != null && appliedCode.isNotEmpty;

        final isApplying =
            state.status == CouponsStatus.loading &&
            state.applyingCouponCodeInAccessory != null;
        final isRemoving =
            state.status == CouponsStatus.loading &&
            state.applyingCouponCodeInAccessory == null &&
            isCouponApplied;

        return Container(
          color: AppColors.white,
          child: Column(
            children: [
              PrimaryWidgetHeader(
                fontSize: AppFontSize.fs16,
                title: 'Coupons & offers',
                buttonTitle: 'View All',
                onButtonTap: () async {
                  await AccessoriesCouponBottomSheet.show(
                    accessoryId: widget.accessoryId,
                    petId: widget.petId,
                    context: context,
                    couponsBloc: context.read<CouponsBloc>(),
                    currentAppliedCode: appliedCode,
                    coupons: coupons.map((e) {
                      return CouponItem(
                        title: e.title ?? '',
                        subTitle: e.description ?? '',
                        code: e.couponCode ?? '',
                      );
                    }).toList(),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.s10,
                ).copyWith(bottom: AppSpacing.s15),
                child: isCouponApplied
                    ? AppliedCouponWidget(
                        code: appliedCode,
                        isLoading: isRemoving,
                        onRemove: () {
                          context.read<CouponsBloc>().add(
                            const RemoveCouponLocallyEvent(),
                          );
                        },
                      )
                    : ApplyCouponSection(
                        isLoading: isApplying,
                        onApply: (code) async {
                          final profileData = context
                              .read<UserProfileBloc>()
                              .state;
                          final country =
                              profileData.profile?.countryCode == '91'
                              ? 'India'
                              : profileData.profile?.countryCode == '971'
                              ? 'UAE'
                              : '';
                          context.read<CouponsBloc>().add(
                            ApplyAccessoryCouponEvent(
                              code,
                              widget.accessoryId,
                              country,
                              widget.petId,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
