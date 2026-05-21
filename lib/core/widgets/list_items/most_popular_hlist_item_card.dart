import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class MostPopularHlistItem {
  final String id;
  final String name;
  final int ageInMonths;
  final double price;
  final double? originalPrice;
  final bool isVaccinated;
  final String? image;

  const MostPopularHlistItem({
    this.id = '',
    required this.name,
    required this.ageInMonths,
    required this.price,
    this.originalPrice,
    required this.isVaccinated,
    this.image,
  });
}

class MostPopularHlistItemCard extends StatelessWidget {
  final MostPopularHlistItem item;
  final void Function(String symptom)? onTap;

  const MostPopularHlistItemCard({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null ? () => onTap!(item.id) : null,
      child: SizedBox(
        width: 280.w,
        height: 370.h,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                  colors: [Color(0x99FFF7EA), Color(0xFFFCCE1D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.55),
                  width: 1.w,
                ),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black.withValues(alpha: 0.1),
                //     blurRadius: 30,
                //     offset: const Offset(0, 8),
                //   ),
                // ],
              ),
            ),

            Padding(
              // padding: EdgeInsets.only(top: 25.h, left: 29.w, right: 29.w),
              padding: EdgeInsets.symmetric(horizontal: 29.w, vertical: 25.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AppText.h2(
                          item.name,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      // if (isVaccinated)
                      Row(
                        children: [
                          AppIcon(
                            AppIcons.svg.generic.vaccination,
                            color: item.isVaccinated
                                ? AppColors.messageSuccess
                                : AppColors.error,
                          ),
                          AppSpacing.s3.wBox,
                          AppText.h3(
                            item.isVaccinated ? 'Vaccinated' : 'Not Vaccinated',
                            fontSize: AppFontSize.fs10,
                            color: item.isVaccinated
                                ? AppColors.messageSuccess
                                : AppColors.error,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          AppText.h1(
                            'INR ${item.price}',
                            fontSize: AppFontSize.fs14,
                            color: AppColors.p1_800,
                          ),
                          if (item.originalPrice != null) ...[
                            SizedBox(width: 3.w),
                            AppText.bodyS(
                              'INR ${item.originalPrice}',
                              fontSize: AppFontSize.fs10,
                              color: AppColors.p1_800,
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                decorationColor: AppColors.p1_800,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const Spacer(),
                      AppText.bodyL(
                        item.ageInMonths > 1
                            ? '${item.ageInMonths} months'
                            : '${item.ageInMonths} month',
                        fontSize: AppFontSize.fs12,
                        color: AppColors.p1_800,
                      ),
                    ],
                  ),
                  AppSpacing.s12.hBox,
                  Container(
                    height: AppSize.cs210.csh,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFCC03),
                      borderRadius: BorderRadius.circular(AppRadiusSize.r16),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: IgnorePointer(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 180.w,
                    height: 270.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        AppRadiusSize.r15,
                      ), // 👈 add radius here
                      child: CachedNetworkImage(
                        imageUrl:
                            item.image ??
                            'https://placedog.net/200/200?random=1',
                        fit: BoxFit.cover,
                        placeholder: (BuildContext context, String url) =>
                            Container(color: const Color(0xFFF2F2F2)),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Positioned(
            //   left: 0,
            //   right: 0,
            //   bottom: 0,
            //   child: ClipRRect(
            //     borderRadius: const BorderRadius.vertical(
            //       bottom: Radius.circular(AppRadiusSize.r15),
            //     ),
            //     child: BackdropFilter(
            //       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            //       child: Container(
            //         height: 86.h,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(AppRadiusSize.r15),
            //         ),
            //         // color: Colors.white.withValues(alpha: 0.05),
            //       ),
            //     ),
            //   ),
            // ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(AppRadiusSize.r15),
                ),
                child: SizedBox(
                  height: 86.h,
                  child: Stack(
                    children: [
                      /// 🔹 Blur layer (ONLY blur, no gradient)
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          color: Colors.transparent, // IMPORTANT
                        ),
                      ),

                      /// 🔹 Gradient overlay (your actual design)
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              AppColors.p5_900.withValues(alpha: 0.6),
                              AppColors.p5_900.withValues(alpha: 0.3),
                              AppColors.p5_900.withValues(alpha: 0.1),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.3, 0.7, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 24,
              child: Center(
                child: AppButton(
                  label: 'View details',
                  width: null,
                  onPressed: onTap != null ? () => onTap!(item.id) : null,
                  variant: AppButtonVariant.outlined,
                  enableGlass: true,
                  blurAmount: 15,
                  trailingSvgAsset: AppIcons.svg.generic.arrowUpRight,
                  size: AppButtonSize.small,
                  foregroundColor: AppColors.white,
                  borderColor: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
