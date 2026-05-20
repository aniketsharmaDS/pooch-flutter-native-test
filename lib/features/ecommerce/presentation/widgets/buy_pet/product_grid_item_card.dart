import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/buttons/app_wishlist_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/images/app_image_frame.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/wishlist/wishlist_bloc.dart';

class ProductItem {
  final String id;
  final String name;
  final String age;
  final int price;
  final int? originalPrice;
  final bool isVaccinated;
  final bool? isWishlisted;
  final bool isPopular;
  final String image;

  const ProductItem({
    this.id = '',
    required this.name,
    required this.age,
    required this.price,
    this.originalPrice,
    this.isVaccinated = false,
    this.isWishlisted = false,
    this.isPopular = false,
    required this.image,
  });
}

class ProductGridCard extends StatelessWidget {
  final ProductItem product;
  final VoidCallback onTap;
  final VoidCallback onWishlistTap;

  const ProductGridCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onWishlistTap,
  });

  @override
  Widget build(BuildContext context) {
    final isWishlisted = context
        .watch<WishlistBloc>()
        .state
        .wishlistIds
        .contains(product.id);
    return Material(
      borderRadius: BorderRadius.circular(AppRadiusSize.r16),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadiusSize.r16),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Important: avoid Expanded
          children: [
            // IMAGE + POPULAR BADGE
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(AppSpacing.s10.w),
                  child: AppImageFrame(
                    width: double.infinity,
                    height: 130.h,
                    imageUrl: product.image,
                    // fit: BoxFit.cover,
                  ),
                ),
                if (product.isPopular)
                  Positioned(
                    top: AppSpacing.s16.h,
                    left: AppSpacing.s220.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadiusSize.r12),
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.s8.w,
                            vertical: AppSpacing.s3.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(
                              AppRadiusSize.r12,
                            ),
                          ),
                          child: AppText.support(
                            'Popular',
                            color: AppColors.p1_50,
                            style: TextStyle(fontSize: AppFontSize.fs9),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // CONTENT
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppRadiusSize.r16),
                    bottomRight: Radius.circular(AppRadiusSize.r16),
                  ),
                ),
                // color: Colors.green,
                child: Padding(
                  // padding: EdgeInsets.fromLTRB(0, AppSpacing.s9.h, 0, 0),
                  padding: EdgeInsets.fromLTRB(
                    AppSpacing.s10,
                    AppSpacing.s3.h,
                    AppSpacing.s10,
                    AppSpacing.s6.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // Important
                    children: [
                      // NAME + WISHLIST
                      Row(
                        children: [
                          Expanded(
                            child: AppText.h1(
                              product.name,
                              maxLines: 1,
                              fontSize: AppFontSize.fs14,
                              color: AppColors.p2,
                              style: const TextStyle(height: 1.2),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          AppWishlistButton(
                            isSelected: isWishlisted,
                            onTap: onWishlistTap,
                          ),
                        ],
                      ),

                      // AGE
                      AppText.support(product.age, color: AppColors.p2),

                      AppSpacing.s6.hBox,

                      // PRICE
                      Row(
                        children: [
                          AppText.h1(
                            'INR ${product.price}',
                            fontSize: AppFontSize.fs14,
                            style: const TextStyle(height: 1.2),
                          ),

                          if (product.originalPrice != null) ...[
                            AppSpacing.s6.wBox,
                            AppText.support(
                              'INR ${product.originalPrice}',
                              color: AppColors.p5_200,
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                decorationColor: AppColors.p4_100,
                              ),
                            ),
                          ],
                        ],
                      ),

                      // SizedBox(height: 4.h),
                      AppSpacing.s6.hBox,
                      // VACCINATED
                      SizedBox(
                        // height: 16.h, // reserve space for optional badge
                        child: Row(
                          children: [
                            AppIcon(
                              AppIcons.svg.generic.vaccination,
                              color: product.isVaccinated
                                  ? AppColors.messageSuccess
                                  : AppColors.error,
                            ),
                            AppSpacing.s3.wBox,
                            AppText.h3(
                              product.isVaccinated
                                  ? 'Vaccinated'
                                  : 'Not Vaccinated',
                              fontSize: AppFontSize.fs10,
                              color: product.isVaccinated
                                  ? AppColors.messageSuccess
                                  : AppColors.error,
                            ),
                          ],
                        ),
                      ),
                      AppSpacing.s10.hBox,
                      // BUTTON
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppButton(
                            removePadding: true,
                            variant: AppButtonVariant.text,
                            label: 'View Details',
                            height: AppSize.cs16,
                            trailingIcon: AppIcon(
                              AppIcons.svg.generic.chevronRight,
                              size: AppIconSize.is14,
                              color: AppColors.black,
                            ),
                            onPressed: onTap,
                            size: AppButtonSize.small,
                            width: null, // important, wrap content
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
