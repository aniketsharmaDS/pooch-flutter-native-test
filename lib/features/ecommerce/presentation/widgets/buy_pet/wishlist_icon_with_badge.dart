import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/wishlist/wishlist_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/wishlist/wishlist_state.dart';

class WishlistIconWithBadge extends StatelessWidget {
  final VoidCallback? onTap;

  const WishlistIconWithBadge({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WishlistBloc, WishlistState, int>(
      selector: (state) => state.wishlistCount,
      builder: (context, count) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            AppCircleButton(
              variant: AppCircleButtonVariant.secondary,
              showShadow: false,
              // showBadge: count > 0,
              // badgeCount: count,
              // badgeTextColor: AppColors.white,
              icon: AppIcons.svg.generic.heartFilledGradient,
              iconColor: AppColors.activeColor,
              iconSize: AppIconSize.is18,
              onTap: onTap,
            ),

            // /  Badge
            if (count > 0)
              Positioned(
                right: 4.w,
                top: 2.h,
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: const BoxDecoration(
                    color: AppColors.activeColor,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Center(
                    child: AppText.support(
                      count > 9 ? '9+' : '$count',
                      style: const TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
