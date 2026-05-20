import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poochcare/core/theme/app_colors.dart';

class AppBottomTabNavItem {
  final String iconPath;
  final String title;
  const AppBottomTabNavItem({required this.iconPath, required this.title});
}

class AppBottomTabNav extends StatelessWidget {
  final List<AppBottomTabNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onChanged;

  const AppBottomTabNav({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            height: 68.h,
            // margin: EdgeInsets.only(
            //   left: 10.w,
            //   right: 10.w,
            //   top: 15.h,
            //   bottom: 10.h,
            // ),
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(132, 109, 15, 0.26),
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(items.length, (index) {
                final item = items[index];
                final isSelected = currentIndex == index;

                return _AppBottomTabNavItemWidget(
                  item: item,
                  isSelected: isSelected,
                  onTap: () => onChanged(index),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBottomTabNavItemWidget extends StatelessWidget {
  final AppBottomTabNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _AppBottomTabNavItemWidget({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(40.r),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(
            horizontal: isSelected ? 18.w : 16.w,
            vertical: 5.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40.r),
            boxShadow: [
              BoxShadow(
                offset: Offset(1.w, 1.h),
                blurRadius: 4.r,
                color: Colors.black.withValues(alpha: 0.15),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// ICON
              SvgPicture.asset(
                item.iconPath,
                height: 20
                    .h, // in design its 18, but 20 looks better naked eye so changed
                colorFilter: ColorFilter.mode(
                  isSelected ? AppColors.tabActive : AppColors.tabInactive,
                  BlendMode.srcIn,
                ),
              ),

              /// TEXT ANIMATION
              ClipRect(
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 300),
                  alignment: Alignment.centerLeft,
                  widthFactor: isSelected ? 1 : 0,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gilroy700',
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
