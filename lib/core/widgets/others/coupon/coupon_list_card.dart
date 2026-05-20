import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/services/toast_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/others/coupon/coupon_bottom_sheet.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class CouponListCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onApply;
  final bool isApplied;
  final bool isLoading;
  final List<String> currentCouponType;
  final CouponType? couponTypeFiltering;

  const CouponListCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onApply,
    this.isApplied = false,
    this.isLoading = false,
    this.couponTypeFiltering,
    required this.currentCouponType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 71,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isApplied ? const Color(0xFF1FB356) : const Color(0xFFFFECBC),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText.h2(title, color: const Color(0xFF6B5210), fontSize: 18),
                const SizedBox(height: 4),
                AppText.h4(subtitle, color: const Color(0xFFB48A1B)),
              ],
            ),
          ),
          AppButton(
            label: isApplied ? 'Applied' : 'Apply',
            width: 80.w,
            height: 32.h,
            isLoading: isLoading,
            isDisabled: isApplied,
            size: AppButtonSize.xSmall,
            variant: AppButtonVariant.text,
            backgroundColor: AppColors.transparent,
            foregroundColor:
                currentCouponType.contains(couponTypeFiltering?.name)
                ? isApplied
                      ? Colors.grey
                      : const Color(0xFF1FB356)
                : Colors.grey,
            onPressed: couponTypeFiltering != null
                ? currentCouponType.contains(couponTypeFiltering?.name)
                      ? onApply
                      : () {
                          ToastService.showInfo(
                            'This Coupon is not applicable here',
                          );
                        }
                : onApply,
            removePadding: true,
          ),
        ],
      ),
    );
  }
}
