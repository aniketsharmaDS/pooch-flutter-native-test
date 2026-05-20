import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/images/app_image_frame.dart';
import 'package:poochcare/core/widgets/others/icon_info.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class OrderItemPetCardModel {
  final String id;
  final String image;
  final String title;
  final String gender;
  final String healthStatus;
  final int price;

  const OrderItemPetCardModel({
    required this.id,
    required this.image,
    required this.title,
    required this.gender,
    required this.healthStatus,
    required this.price,
  });
}

class OrderItemPetCard extends StatelessWidget {
  final OrderItemPetCardModel model;
  final VoidCallback? onTap;

  const OrderItemPetCard({super.key, required this.model, this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isVaccinated = model.healthStatus == 'Vaccinated';

    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              /// IMAGE
              AppImageFrame(width: 91.w, height: 77.h, imageUrl: model.image),
              SizedBox(width: 16.w),

              /// CONTENT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TITLE
                    AppText.h4(
                      model.title,
                      color: AppColors.textSecondary,
                      fontSize: 14.sp,
                      maxLines: 2,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8.h),

                    /// GENDER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconInfo(
                          icon: model.gender.toLowerCase() == 'male'
                              ? AppIcons.svg.generic.male
                              : AppIcons.svg.generic.female,
                          text: model.gender,
                          iconColor: const Color(0xFF906556),
                          textColor: const Color(0xFF906556),
                        ),
                        IconInfo(
                          icon: AppIcons.svg.generic.vaccination,
                          text: model.healthStatus,
                          iconColor: isVaccinated
                              ? const Color(0xFF188C43) // green
                              : const Color(0xFFD32F2F), // red
                          textColor: isVaccinated
                              ? const Color(0xFF188C43)
                              : const Color(0xFFD32F2F),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),

                    /// PRICE
                    AppText.h1(
                      'INR ${model.price}',
                      color: AppColors.textSecondary,
                      fontSize: 14.sp,
                      style: const TextStyle(fontWeight: FontWeight.w600),
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
