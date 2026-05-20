import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/others/coupon/dashed_rect_painter.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class AppliedCouponWidget extends StatelessWidget {
  final String code;
  final VoidCallback onRemove;
  final bool isLoading;

  const AppliedCouponWidget({
    super.key,
    required this.code,
    required this.onRemove,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,

      child: Row(
        children: [
          // Main container with solid border
          Expanded(
            child: Stack(
              children: [
                // Solid outer border container #BCE3B9
                Container(
                  height: 56.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFBCE3B9)),
                  ),
                  padding: EdgeInsets.only(right: 16.w, left: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Dashed border coupon box
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CustomPaint(
                            painter: DashedRectPainter(
                              color: const Color(0xFF188C43),
                            ),
                            child: Container(
                              width: 0.42.sw,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 10.h,
                              ),
                              decoration: const BoxDecoration(
                                color: Color(0x1A1FB356),
                                // borderRadius: BorderRadius.circular(10),
                              ),
                              child: AppText.h4(
                                code,
                                color: const Color(0xFF260B01),
                              ),
                            ),
                          ),
                          // Scissor on dashed border top-left
                          Positioned(
                            top: -9,
                            left: 8,
                            child: SizedBox(
                              width: 18,
                              height: 18,
                              child: AppIcon(AppIcons.svg.coupons.scissor),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 12.w),
                      AppIcon(
                        AppIcons.svg.generic.check,
                        size: 22,
                        color: const Color(0xFF22C55E),
                      ),
                      // Check tick inside container

                      // const SizedBox(width: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          // Remove button outside
          AppButton(
            width: 100.w,
            size: AppButtonSize.small,
            label: 'Remove',
            isLoading: isLoading,
            variant: AppButtonVariant.text,
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
