import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class AccessoriesCouponBanner extends StatelessWidget {
  final String offerText;
  final String description;
  final String couponCode;

  const AccessoriesCouponBanner({
    super.key,
    required this.couponCode,
    required this.description,
    required this.offerText,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey,
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s10),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadiusSize.r16),
              ),
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.s17),
                  AppText.h1(
                    'A great deal is waiting for you!',
                    fontSize: AppFontSize.fs16,
                  ),
                  const SizedBox(height: AppSpacing.s17),
                  consultationBannerWidget(
                    description: description,
                    offerText: offerText,
                  ),
                  const SizedBox(height: AppSpacing.s5),
                  AppText.bodyM(
                    'Valid until 19th August 2026',
                    fontSize: AppFontSize.fs10,
                  ),
                  const SizedBox(height: AppSpacing.s9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText.h1(
                        'Use code: $couponCode',
                        fontSize: AppFontSize.fs14,
                      ),
                      const SizedBox(width: AppSpacing.s15),
                      InkWell(
                        onTap: () {},
                        child: AppIcon(AppIcons.svg.generic.copy),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s12),
                  AppButton(
                    onPressed: () {},
                    label: 'Redeem Now',
                    width: null,
                    size: AppButtonSize.small,
                    height: 35,
                    trailingIcon: AppIcon(AppIcons.svg.generic.caretRight),
                  ),
                  const SizedBox(height: AppSpacing.s20),
                ],
              ),
            ),
            Positioned(
              right: 35,
              top: 15,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: AppIcon(AppIcons.svg.generic.close),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container consultationBannerWidget({
    required String offerText,
    required String description,
  }) {
    return Container(
      height: 140.h,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFFFAA00),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final contentMaxWidth = constraints.maxWidth * 0.56;

          return Stack(
            children: [
              Positioned(
                bottom: 0,
                top: 0,
                child: AppIcon(
                  AppIcons.png.nudges.accessoriesPoochBanner,
                  fit: BoxFit.cover,
                  size: 200,
                ),
              ),
              Positioned(
                right: -30,
                bottom: 0,
                top: 0,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: contentMaxWidth),
                    child: _buildContentSection(
                      contentMaxWidth,
                      offerText,
                      description,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContentSection(
    double contentMaxWidth,
    String offerText,
    String description,
  ) {
    // final buttonWidth = (contentMaxWidth * 0.82).clamp(100.0, 140.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.h1(
          'Get',
          maxLines: 2,
          style: TextStyle(
            fontSize: AppFontSize.fs16,
            color: AppColors.white_50,
            height: 1.2,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AppText.displayXL(
              offerText,
              maxLines: 1,
              style: TextStyle(
                fontSize: AppFontSize.fs32,
                color: AppColors.white_50,
                height: 1.1,
              ),
            ),
            const SizedBox(width: AppSpacing.s5),
            AppText.h1(
              'on',
              maxLines: 1,
              color: AppColors.white_50,
              style: TextStyle(height: 1.8, fontSize: AppFontSize.fs14),
            ),
          ],
        ),
        AppIcon(AppIcons.svg.generic.poochLogo, size: 28),
        AppText.h1(
          description,
          maxLines: 2,
          color: AppColors.black,
          style: TextStyle(height: 1.2, fontSize: AppFontSize.fs11),
        ),
      ],
    );
  }
}
