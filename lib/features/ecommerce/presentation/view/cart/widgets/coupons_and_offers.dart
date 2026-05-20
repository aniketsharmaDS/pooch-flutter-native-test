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

class CouponsAndOffers extends StatefulWidget {
  const CouponsAndOffers({super.key});

  @override
  State<CouponsAndOffers> createState() => _CouponsAndOffersState();
}

class _CouponsAndOffersState extends State<CouponsAndOffers> {
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
        final appliedCode = state.appliedCouponCodeInCart;
        final isCouponApplied = appliedCode != null && appliedCode.isNotEmpty;

        final isApplying =
            state.status == CouponsStatus.loading &&
            state.applyingCouponCodeInCart != null;
        final isRemoving =
            state.status == CouponsStatus.loading &&
            state.applyingCouponCodeInCart == null &&
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
                  await CouponBottomSheet.show(
                    couponType: CouponType.products,
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
                            RemoveCouponEvent(appliedCode),
                          );
                        },
                      )
                    : ApplyCouponSection(
                        isLoading: isApplying,
                        onApply: (code) async {
                          context.read<CouponsBloc>().add(
                            ApplyCouponEvent(code),
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
