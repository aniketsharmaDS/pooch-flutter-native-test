import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/services/toast_service.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poochcare/core/widgets/others/coupon/apply_coupon_section.dart';
import 'package:poochcare/core/widgets/others/coupon/coupon_list_card.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/coupons/coupons_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/coupons/coupons_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/coupons/coupons_state.dart';

enum CouponType { products, accessories, subscriptions, consultations }

class CouponItem {
  final String title;
  final String subTitle;
  final String code;

  CouponItem({required this.title, required this.subTitle, required this.code});
}

class CouponBottomSheet {
  static Future<String?> show({
    required BuildContext context,
    required List<CouponItem> coupons,
    required CouponsBloc couponsBloc,
    String? currentAppliedCode,
    CouponType? couponType,
  }) {
    return AppBottomSheet.show<String>(
      context: context,
      title: 'All Coupons',
      backgroundColor: const Color(0xFFFEF3E6),
      borderRadius: 12,
      actionsPadding: EdgeInsets.zero,
      actions: [],
      content: BlocProvider.value(
        value: couponsBloc,
        child: _CouponBottomSheetContent(
          coupons: coupons,
          currentAppliedCode: currentAppliedCode,
          couponType: couponType,
        ),
      ),
    );
  }
}

class _CouponBottomSheetContent extends StatefulWidget {
  final List<CouponItem> coupons;
  final String? currentAppliedCode;
  final CouponType? couponType;

  const _CouponBottomSheetContent({
    required this.coupons,
    this.currentAppliedCode,
    this.couponType,
  });

  @override
  State<_CouponBottomSheetContent> createState() =>
      _CouponBottomSheetContentState();
}

class _CouponBottomSheetContentState extends State<_CouponBottomSheetContent> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CouponsBloc, CouponsState>(
      listener: (context, state) {
        if (state.status == CouponsStatus.success &&
            state.successMessage != null &&
            state.applyCouponResponse != null) {
          ToastService.showSuccess(state.successMessage!);
          Navigator.of(context).pop(
            state.applyingCouponCodeInCart ??
                state
                    .applyCouponResponse
                    ?.discountBreakdown
                    ?.itemDiscounts
                    ?.firstOrNull
                    ?.productId,
          );
        } else if (state.status == CouponsStatus.failure &&
            state.errorMessage != null) {
          ToastService.showError(state.errorMessage!);
        }
      },
      builder: (context, state) {
        final isApplyingManual =
            state.status == CouponsStatus.loading &&
            state.applyingCouponCodeInCart != null &&
            !widget.coupons.any(
              (e) => e.code == state.applyingCouponCodeInCart,
            );

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ApplyCouponSection(
              isLoading: isApplyingManual,
              onApply: (code) async {
                context.read<CouponsBloc>().add(ApplyCouponEvent(code));
              },
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.coupons.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  if (widget.coupons.isEmpty) {
                    return Center(
                      child: AppText.h4(
                        'No Coupons Are Available',
                        fontSize: AppFontSize.fs12,
                      ),
                    );
                  }

                  final coupon = widget.coupons[index];
                  final title = coupon.title;
                  final subtitle = coupon.subTitle;
                  final code = coupon.code;
                  final isApplied =
                      code == widget.currentAppliedCode ||
                      code == state.appliedCouponCodeInCart;

                  final isApplying =
                      state.status == CouponsStatus.loading &&
                      state.applyingCouponCodeInCart == code;

                  return CouponListCard(
                    title: title,
                    currentCouponType: state.coupons[index].rules != null
                        ? state
                                  .coupons[index]
                                  .rules
                                  ?.first
                                  .targetProductTypes ??
                              []
                        : [],
                    couponTypeFiltering: widget.couponType,
                    subtitle: subtitle,
                    isApplied: isApplied,
                    isLoading: isApplying,
                    onApply: () {
                      context.read<CouponsBloc>().add(ApplyCouponEvent(code));
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
