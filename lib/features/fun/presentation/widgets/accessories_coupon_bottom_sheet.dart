import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/services/toast_service.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poochcare/core/widgets/others/coupon/apply_coupon_section.dart';
import 'package:poochcare/core/widgets/others/coupon/coupon_bottom_sheet.dart';
import 'package:poochcare/core/widgets/others/coupon/coupon_list_card.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/coupons/coupons_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/coupons/coupons_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/coupons/coupons_state.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';

class AccessoriesCouponBottomSheet {
  static Future<String?> show({
    required BuildContext context,
    required List<CouponItem> coupons,
    required CouponsBloc couponsBloc,
    required String accessoryId,
    required String petId,
    String? currentAppliedCode,
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
        child: _AccessoriesCouponBottomSheetContent(
          accessoryId: accessoryId,
          petId: petId,
          coupons: coupons,
          currentAppliedCode: currentAppliedCode,
        ),
      ),
    );
  }
}

class _AccessoriesCouponBottomSheetContent extends StatefulWidget {
  final List<CouponItem> coupons;
  final String? currentAppliedCode;
  final String accessoryId;
  final String petId;

  const _AccessoriesCouponBottomSheetContent({
    required this.coupons,
    this.currentAppliedCode,
    required this.accessoryId,
    required this.petId,
  });

  @override
  State<_AccessoriesCouponBottomSheetContent> createState() =>
      _AccessoriesCouponBottomSheetContentState();
}

class _AccessoriesCouponBottomSheetContentState
    extends State<_AccessoriesCouponBottomSheetContent> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CouponsBloc, CouponsState>(
      listener: (context, state) {
        if (state.status == CouponsStatus.success &&
            state.successMessage != null &&
            state.applyCouponResponse != null) {
          ToastService.showSuccess(state.successMessage!);
          Navigator.of(context).pop(
            state.applyingCouponCodeInAccessory ??
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
            state.applyingCouponCodeInAccessory != null &&
            !widget.coupons.any(
              (e) => e.code == state.applyingCouponCodeInAccessory,
            );

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ApplyCouponSection(
              isLoading: isApplyingManual,
              onApply: (code) async {
                applyCoupon(context, code);
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
                      code == state.appliedCouponCodeInAccessory;

                  final isApplying =
                      state.status == CouponsStatus.loading &&
                      state.applyingCouponCodeInAccessory == code;

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
                    couponTypeFiltering: CouponType.accessories,
                    subtitle: subtitle,
                    isApplied: isApplied,
                    isLoading: isApplying,
                    onApply: () {
                      applyCoupon(context, code);
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

  void applyCoupon(BuildContext context, String code) {
    final profileData = context.read<UserProfileBloc>().state;
    final country = profileData.profile?.countryCode == '91'
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
  }
}
