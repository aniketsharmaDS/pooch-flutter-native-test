import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class PetPhotoCardModel {
  final String id;
  final String imageUrl;
  final String petInfo; // e.g., "Dog . Female . 2 yrs . Bella . Female"

  const PetPhotoCardModel({
    required this.id,
    required this.imageUrl,
    required this.petInfo,
  });
}

class PetPhotoCard extends StatelessWidget {
  final PetPhotoCardModel pet;
  final VoidCallback? onTap;

  const PetPhotoCard({super.key, required this.pet, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppSpacing.s340.w,
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.s14.w,
          vertical: AppSpacing.s16.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSpacing.s16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// PET IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.s16.r),
              child: SizedBox(
                width: AppSpacing.s320.w,
                height: AppSpacing.s320.h,
                child: CachedNetworkImage(
                  imageUrl: pet.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(color: const Color(0xFFF2F2F2)),
                  errorWidget: (context, error, stackTrace) => Container(
                    color: const Color(0xFFF2F2F2),
                    child: const Icon(Icons.image_not_supported),
                  ),
                ),
              ),
            ),

            AppSpacing.s17.hBox,

            /// PET INFO TEXT
            Padding(
              padding: EdgeInsets.only(left: AppSpacing.s11.w),
              child: AppText.h1(
                pet.petInfo,
                color: AppColors.textSecondary,
                fontSize: AppFontSize.fs12,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
