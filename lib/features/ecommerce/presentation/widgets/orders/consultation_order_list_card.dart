import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class ConsultationOrderListCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String dateTime;
  final String orderId;
  final String status;
  final ImageProvider image;
  final VoidCallback onUpgrade;

  const ConsultationOrderListCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.dateTime,
    required this.orderId,
    required this.status,
    required this.image,
    required this.onUpgrade,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 90),
      // padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadiusSize.r12),
        gradient: const LinearGradient(
          colors: [Color(0xFFFFBC20), Color(0xFFFFDB88)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      // child: IntrinsicHeight(
      //   child: Row(
      //     children: [
      //       _buildImageSection(),
      //       const SizedBox(width: 12),
      //       Expanded(child: _buildContentSection()),
      //       const SizedBox(width: 12),
      //       _buildRightColumn(),
      //     ],
      //   ),
      // ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadiusSize.r12),
        child: Stack(
          children: [
            // LEFT IMAGE (background style)
            Positioned(
              left: 0,
              bottom: 0,
              top: 8.h,
              child: SizedBox(
                width: AppSize.cs110,
                height: AppSize.cs90,
                child: AppIcon(AppIcons.png.orders.poochSuper),
              ),
            ),

            // CONTENT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  const SizedBox(width: 110), // 👈 space for image

                  Expanded(child: _buildContentSection()),

                  const SizedBox(width: 12),

                  _buildRightColumn(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRightColumn() {
    return SizedBox(
      height: AppSize.cs70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [_buildStatusBadge(), _buildUpgradeButton()],
      ),
    );
  }

  // Widget _buildImageSection() {
  //   return ClipRRect(
  //     child: Container(
  //       color: Colors.red,
  //       child: SizedBox(
  //         width: AppSize.cs110,
  //         height: AppSize.cs90,
  //         child: AppIcon(
  //          AppIcons.png.orders.poochSuper,
  //         ),
  //         // child: Image(image: image, fit: BoxFit.cover),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildContentSection() {
    return SizedBox(
      height: AppSize.cs70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText.h4(
            title,
            maxLines: 1,
            style: const TextStyle(color: AppColors.p4_600),
          ),
          // const SizedBox(height: 4),
          AppText.h4(
            subtitle,
            maxLines: 1,
            style: const TextStyle(fontSize: 12, color: AppColors.p1_900),
          ),
          // const SizedBox(height: 4),
          AppText.h4(
            dateTime,
            maxLines: 1,
            style: const TextStyle(fontSize: 12, color: AppColors.p1_900),
          ),
          // const SizedBox(height: 4),
          AppText.h3(
            'Order Id: $orderId',
            maxLines: 1,
            style: const TextStyle(
              fontSize: 10,
              fontFamily: 'Gilroy600',
              color: Color(0xFF2D2D2E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9E9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: AppText.support(
        'Status: $status',
        maxLines: 1,
        style: const TextStyle(color: Color(0xFF8C6B15)),
      ),
    );
  }

  Widget _buildUpgradeButton() {
    return AppButton(
      label: 'Upgrade',
      onPressed: onUpgrade,
      backgroundColor: Colors.white,
      variant: AppButtonVariant.outlined,
      size: AppButtonSize.extraSmall,
      width: AppSize.cs85,
      height: AppSize.cs36,
      // width: AppSize.,
    );
  }
}
