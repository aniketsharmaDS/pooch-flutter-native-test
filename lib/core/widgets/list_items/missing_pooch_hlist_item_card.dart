import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/utils/date_time_formattter.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/images/app_image_frame.dart';
import 'package:poochcare/core/widgets/others/community/community_profile_header.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/community/data/models/missing_pet_model.dart';

class MissingPoochHlistItemCard extends StatelessWidget {
  final MissingPetModel item;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onCardTap;

  const MissingPoochHlistItemCard({
    super.key,
    required this.item,
    this.onAvatarTap,
    this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        width: AppSpacing.s180.w,
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.s10.w,
          vertical: AppSpacing.s10.h,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF7F8),
          borderRadius: BorderRadius.circular(AppSpacing.s16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CommunityProfileHeader(
              userName: item.owner.name,
              avatarUrl: item.owner.profile?.profilePicture ?? '',
              timeAgo: formatTimeAgo(item.createdAt.toString()),
              onAvatarTap: onAvatarTap,
            ),
            AppSpacing.s10.hBox,
            _buildPostImage(),
            AppSpacing.s9.hBox,
            _buildPetSpecification(),
            AppSpacing.s1.hBox,
            _buildBreedSpecification(),
            if (item.missingDate != null && item.missingDate!.isNotEmpty) ...[
              AppSpacing.s10.hBox,
              _buildLastSeen(),
            ],
            if (item.lastKnownLocation.isNotEmpty) ...[
              AppSpacing.s7.hBox,
              _buildLocationRow(),
            ],
            AppSpacing.s10.hBox,
            _buildDescription(),
          ],
        ),
      ),
    );
  }

  Widget _buildPostImage() {
    if (item.pet.profilePicture == null || item.pet.profilePicture!.isEmpty) {
      return Container(
        width: double.infinity,
        height: AppSpacing.s124.h,
        decoration: BoxDecoration(
          color: AppColors.background.withAlpha(100),
          borderRadius: BorderRadius.circular(AppSpacing.s14.r),
          border: Border.all(
            color: AppColors.background.withAlpha(150),
            width: AppSpacing.s1p5.w,
          ),
        ),
        alignment: Alignment.center,
        child: AppIcon(
          AppIcons.svg.generic.poochTail,
          size: AppSpacing.s60.r,
          color: AppColors.textSecondary.withAlpha(180),
        ),
      );
    }

    // Single image with badge
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        AspectRatio(
          aspectRatio: 145 / 124,
          child: AppImageFrame(
            width: double.infinity,
            height: AppSpacing.s124.h,
            imageUrl: item.pet.profilePicture ?? '',
          ),
        ),
        Positioned(
          top: AppSpacing.s5.h,
          left: AppSpacing.s11.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.s16.r),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.s9.w,
                  vertical: AppSpacing.s4.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(AppSpacing.s16.r),
                ),
                child: AppText.support(
                  item.status.toUpperCase(),
                  color: AppColors.p1_50,
                  // style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLastSeen() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            AppIcon(
              AppIcons.svg.generic.clock,
              size: AppFontSize.fs15,
              color: AppColors.missingColor,
            ),
            AppSpacing.s5.wBox,
            AppText.bodyL(
              'Last Seen: ${formatDateAndTime(missingDate: item.missingDate, missingTime: item.missingTime)}',
              color: AppColors.missingColor,
              style: TextStyle(fontSize: AppFontSize.fs10),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPetSpecification() {
    String type = item.pet.type.toLowerCase();
    String name = item.pet.name;
    String age = formatPetAge(dob: item.pet.dob);
    String gender = item.pet.gender.toLowerCase();

    String capitalize(String value) =>
        value.isNotEmpty ? value[0].toUpperCase() + value.substring(1) : value;
    String displayValue =
        '${capitalize(type)} . $age\n$name, ${capitalize(gender)}';
    return AppText.h1(
      displayValue,
      color: const Color(0xFFF26969),
      fontSize: AppFontSize.fs14,
      maxLines: 2,
      style: const TextStyle(fontWeight: FontWeight.w600, height: 1.1),
    );
  }

  Widget _buildBreedSpecification() {
    return AppText.bodyL(
      item.pet.breedInfo.breedName,
      color: AppColors.missingColor,
      fontSize: AppFontSize.fs10,
      maxLines: 2,
      style: const TextStyle(height: 1.1),
    );
  }

  Widget _buildDescription() {
    return AppText.support(
      item.description,
      color: AppColors.p5_400,
      fontSize: AppFontSize.fs10,
      maxLines: 2,
      style: const TextStyle(fontWeight: FontWeight.w400, height: 1.1),
    );
  }

  Widget _buildLocationRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppIcon(
          AppIcons.svg.generic.mapPinLine,
          size: AppFontSize.fs15,
          color: AppColors.missingColor,
        ),
        AppSpacing.s5.wBox,
        Expanded(
          child: AppText.bodyL(
            item.lastKnownLocation,
            color: AppColors.missingColor,
            style: TextStyle(fontSize: AppFontSize.fs10),
          ),
        ),
      ],
    );
  }
}
