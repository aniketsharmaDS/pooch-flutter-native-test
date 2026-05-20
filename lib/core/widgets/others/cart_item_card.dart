import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/images/app_image_frame.dart';
import 'package:poochcare/core/widgets/others/icon_info.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class CartItemModel {
  final String id;
  final String name;
  final String age;
  final String gender;
  final bool isVaccinated;
  final int price;
  final String deliveryText;
  final String imageUrl;
  final String expectedDeliveryTime;

  const CartItemModel({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.isVaccinated,
    required this.price,
    required this.deliveryText,
    required this.imageUrl,
    required this.expectedDeliveryTime,
  });
}

class CartItemCard extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final bool hideDeleteButton;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.onDelete,
    this.hideDeleteButton = false,
  });

  bool get _isNetworkImage => isNetworkUrl(item.imageUrl);

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: SizedBox(width: 129.w, height: 110.h, child: _imageWidget()),
    );
  }

  Widget _imageWidget() {
    if (_isNetworkImage) {
      return AppImageFrame(
        width: 64.w,
        height: 64.h,
        imageUrl: item.imageUrl.trim().isEmpty
            ? AppIcons.png.explore.dogCat
            : item.imageUrl,

        // fit: BoxFit.contain,
      );
    }

    return AppIcon(item.imageUrl, fit: BoxFit.cover);
  }

  bool isNetworkUrl(String path) {
    try {
      final uri = Uri.parse(path);
      // Check if the scheme is http or https
      return uri.isScheme('HTTP') || uri.isScheme('HTTPS');
    } catch (e) {
      // If parsing fails, it's definitely not a valid URL
      return false;
    }
  }

  // Widget _buildErrorState() {
  //   return Container(
  //     color: const Color(0xFFF2F2F2),
  //     alignment: Alignment.center,
  //     child: const Icon(Icons.image_not_supported, color: Color(0xFFB0B0B0)),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      // borderRadius: BorderRadius.circular(16),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        // borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          height: 130.h,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: AppText.bodyL(
                            '${item.name}, ${item.age}',
                            maxLines: 2,
                            color: AppColors.textPrimary,
                            style: TextStyle(fontSize: 12.sp, height: 1.2),
                          ),
                        ),
                        Visibility(
                          visible: !hideDeleteButton,
                          maintainAnimation: true,
                          maintainSize: true,
                          maintainState: true,
                          child: InkWell(
                            onTap: onDelete,
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: AppIcon(
                                AppIcons.svg.generic.delete,
                                size: 16,
                                color: const Color(0xFF906556),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconInfo(
                          icon: item.gender.toLowerCase() == 'female'
                              ? AppIcons.svg.generic.female
                              : AppIcons.svg.generic.male,
                          text: item.gender,
                          iconColor: const Color(0xFF906556),
                          textColor: const Color(0xFF906556),
                        ),
                        if (item.isVaccinated) ...[
                          const SizedBox(width: 15),
                          IconInfo(
                            icon: AppIcons.svg.generic.vaccination,
                            text: 'Vaccinated & Dewormed',
                            iconColor: const Color(0xFF188C43),
                            textColor: const Color(0xFF188C43),
                          ),
                        ],
                      ],
                    ),
                    // const SizedBox(height: 14),
                    AppText.h1(
                      'INR ${item.price}',
                      color: AppColors.textSecondary,
                      fontSize: 14.sp,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    // const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF9E9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: AppText.bodyL(
                              item.deliveryText,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 8,
                                fontFamily: 'Gilroy500',
                                color: Color(0xFF5A1903),
                              ),
                            ),
                          ),
                          Flexible(
                            child: AppText.h1(
                              item.expectedDeliveryTime,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 8,
                                color: Color(0xFF5A1903),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
