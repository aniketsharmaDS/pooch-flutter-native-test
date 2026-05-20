import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class PoochSuperOfferNudge extends StatelessWidget {
  final VoidCallback? onAdd;

  const PoochSuperOfferNudge({super.key, this.onAdd});

  @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     width: double.infinity,
  //     padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(22.r),
  //       gradient: const LinearGradient(
  //         colors: [Color(0xFFFFBC20), Color(0xFFFFDB88)],
  //         begin: Alignment.topLeft,
  //         end: Alignment.bottomRight,
  //       ),
  //     ),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         // Align(
  //         //   alignment: Alignment.topLeft,
  //         //   child: Assets.svg.nudges.poochSuper.svg(height: 26.h, width: 53.w),
  //         // ),
  //         // SizedBox(height: 8.h),
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             // Container(
  //             //   color: Colors.red,
  //             //   child: Assets.svg.nudges.poochSuper.svg(height: 26.h, width: 53.w)),
  //             Expanded(flex: 3, child: _buildMainVisual()),
  //             SizedBox(width: 8.w),
  //             Expanded(flex: 1, child: _buildPriceAndAction()),
  //             /// 🔹 Top-left logo
  //             Positioned(
  //               top: 0,
  //               left: 0,
  //               child: Assets.svg.nudges.poochSuper.svg(
  //                 height: 26.h,
  //                 width: 53.w,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 6.w, right: 12.h, top: 9.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: const LinearGradient(
          colors: [Color(0xFFFFBC20), Color(0xFFFFDB88)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SizedBox(
        height: 90.h,
        child: Stack(
          children: [
            /// 🔹 Main content
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(width: 70.w), // space for logo
                Expanded(flex: 3, child: _buildMainVisual()),
                SizedBox(width: 8.w),
                Expanded(child: _buildPriceAndAction()),
              ],
            ),

            /// 🔹 Top-left logo
            Positioned(
              top: 0,
              left: 0,
              child: AppIcon(
                AppIcons.svg.nudges.poochSuper,
                height: 26.h,
                width: 53.w,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainVisual() {
    return SizedBox.expand(
      // height: 90.h,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            height: 85.h,
            width: 200.w,
            bottom: 0,
            child: AppIcon(AppIcons.png.nudges.poochHolder, fit: BoxFit.cover),
          ),
          Positioned(
            bottom: -5.h,
            right: 10.w,
            child: Container(
              constraints: BoxConstraints(minWidth: 150.w, maxWidth: 190.w),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText.h1(
                    'Get 10%',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: const Color(0xFFE7B123),
                      height: 1,
                    ),
                  ),

                  AppText.h3(
                    'On next 5 purchase',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF8C6B15),
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceAndAction() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: AppText.h1(
            'INR 500',
            style: TextStyle(fontSize: 14.sp, color: const Color(0xFF1B1B1B)),
          ),
        ),
        SizedBox(height: 10.h),
        AppButton(
          label: 'Add',
          onPressed: onAdd,
          size: AppButtonSize.xSmall,
          borderRadius: 8.r,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        ),
      ],
    );
  }
}
