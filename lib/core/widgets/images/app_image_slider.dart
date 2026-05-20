import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';

class AppImageSlider extends StatelessWidget {
  const AppImageSlider({
    super.key,
    required PageController pageController,
    required this.imageUrls,
    required int currentPage,
    required this.onPageChanged,
    this.height,
    this.borderRadius,
  }) : _pageController = pageController,
       _currentPage = currentPage;

  final PageController _pageController;
  final List<String> imageUrls;
  final int _currentPage;
  final void Function(int)? onPageChanged;
  final double? height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(14.r),
        child: Container(
          height: height ?? 320.h,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.p1_200, AppColors.background],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          alignment: Alignment.center,
          child: AppIcon(
            AppIcons.svg.generic.poochLogo,
            width: 48.w,
            height: 48.h,
          ),
        ),
      );
    }

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(14.r),
          child: SizedBox(
            height: height ?? 320.h,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: onPageChanged,
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return AppIcon(
                  imageUrls[index],
                  width: double.infinity,
                  height: height ?? 320.h,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
        // Pagination dots overlay
        if (imageUrls.length > 1)
          Positioned(
            bottom: 12.h,
            right: 12.w,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                imageUrls.length,
                (index) => Container(
                  width: _currentPage == index ? 31.w : 7.w,
                  height: 7.h,
                  margin: EdgeInsets.only(right: 6.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    color: _currentPage == index
                        ? AppColors.primary
                        : const Color(0xFFFFECBC),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
