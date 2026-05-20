import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/widgets/cards/app_wave_card.dart';
import 'package:poochcare/core/widgets/enums/notch_variant.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class MessageShapeCard extends StatelessWidget {
  /// Lottie asset path to render in the circle.
  final String lottieAsset;
  final String headerTitle;
  final String headerDescription;
  final Color backgroundColor;
  final EdgeInsetsGeometry? margin;
  final double? imagePositionFromLeft;
  final double? imagePositionFromTop;

  const MessageShapeCard({
    super.key,
    required this.lottieAsset,
    required this.headerTitle,
    required this.headerDescription,
    this.backgroundColor = const Color(0xffEFE7DF),
    this.margin,
    this.imagePositionFromLeft = -20,
    this.imagePositionFromTop,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 470.h,
      height: MediaQuery.sizeOf(context).height * 0.6,
      width: 1.sw,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 20,
            height: 470.h,
            width: 1.sw,
            child: Padding(
              padding: margin ?? EdgeInsets.zero,
              child: AppWaveCard(
                backgroundColor: backgroundColor,
                borderRadius: 24,
                notchHeight: 0,
                notchWidth: 140,
                variant: AppCardNotchVariant.topRightBottomLeft,
                bottomNotchWidth: 60,
                bottomNotchHeight: 10,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFFE7B4), // #FFE7B4
                        Color(0xFFF5F1E5), // #F5F1E5
                      ],
                    ),
                  ),
                  width: double.maxFinite,
                  height: 470.h,
                  child: Padding(
                    padding: EdgeInsets.only(top: 50.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 70.h),
                          child: _MessageCardImage(
                            imageLeftPosition: imagePositionFromLeft ?? -20,
                            imageTopPosition: imagePositionFromTop ?? -10,
                            lottieAsset: lottieAsset,
                          ),
                        ),
                        SizedBox(height: 7.h),
                        AppText.support(
                          headerTitle,
                          textAlign: TextAlign.center,
                          color: AppColors.textFieldInputTextDefault,
                          variant: AppTextVariant.noEllipsis,
                          fontSize: 32.sp,
                        ),
                        SizedBox(height: 3.h),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 50.w,
                            right: 50.w,
                            bottom: 30.h,
                          ),
                          child: AppText.bodyM(
                            headerDescription,
                            fontSize: 16.sp,
                            textAlign: TextAlign.center,
                            color: AppColors.textFieldLabelDefault,
                            variant: AppTextVariant.noEllipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageCardImage extends StatelessWidget {
  final String lottieAsset;
  final double imageLeftPosition;
  final double? imageTopPosition;

  const _MessageCardImage({
    required this.lottieAsset,
    required this.imageLeftPosition,
    required this.imageTopPosition,
  });

  @override
  Widget build(BuildContext context) {
    final double size = 140.r;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          // width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
            border: Border.all(color: AppColors.dialogPrimaryBorder),
          ),
          padding: EdgeInsets.all(16.r),
        ),
        Positioned(
          top: imageTopPosition,
          left: imageLeftPosition,
          right: 0,
          child: SizedBox(
            height: 140.h,
            width: 140.h,
            child: Lottie.asset(fit: BoxFit.contain, lottieAsset, repeat: true),
          ),
        ),
      ],
    );
  }
}
