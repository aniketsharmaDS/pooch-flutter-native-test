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
import 'package:poochcare/features/community/data/models/found_pet_model.dart';

class FoundPoochHlistItemCard extends StatelessWidget {
  final FoundPetModel item;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onCardTap;

  const FoundPoochHlistItemCard({
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
          horizontal: AppSpacing.s12.w,
          vertical: AppSpacing.s10.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.s14.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CommunityProfileHeader(
              userName: item.finder.name,
              avatarUrl: item.finder.profile.profilePicture,
              timeAgo: formatTimeAgo(item.createdAt),
              onAvatarTap: onAvatarTap,
            ),
            AppSpacing.s10.hBox,
            _buildPostImage(),
            AppSpacing.s9.hBox,
            _buildPetSpecification(),
            AppSpacing.s1.hBox,
            _buildBreedSpecification(),
            if (item.location.isNotEmpty) ...[
              AppSpacing.s7.hBox,
              _buildLastSeen(),
            ],
            if (item.location.isNotEmpty) ...[
              AppSpacing.s7.hBox,
              _buildLocationRow(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPostImage() {
    String imageUrl = '';

    MissingReport? report = item.missingReport;

    if (report != null) {
      imageUrl = report.pet.profilePicture;

      if (imageUrl.isEmpty) {
        imageUrl = report.images.isNotEmpty ? report.images.first.imageUrl : '';
      }
    }

    if (imageUrl.isEmpty) {
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
        AppImageFrame(
          width: double.infinity,
          height: AppSpacing.s124.h,
          imageUrl: imageUrl,
        ),
        Positioned(
          top: AppSpacing.s8.h,
          left: AppSpacing.s8.w,
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
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(AppSpacing.s16.r),
                ),
                child: AppText.support(
                  'Found',
                  color: const Color(0xFFFFF9E9),
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
        AppIcon(
          AppIcons.svg.generic.clock,
          size: AppFontSize.fs15,
          color: const Color(0xFF404041),
        ),
        AppSpacing.s5.wBox,
        Expanded(
          child: AppText.bodyL(
            'Found on: ${formatFancyDate(item.createdAt)}',
            // item.location,
            color: const Color(0xFF404041),
            style: TextStyle(fontSize: AppFontSize.fs10),
          ),
        ),
      ],
    );
  }

  Widget _buildPetSpecification() {
    MissingReport? report = item.missingReport;
    String displayValue = '';
    if (report != null) {
      String type = report.pet.type.toLowerCase();
      // String name = item.missingReport!.pet.name;
      // String age = formatPetAge(item.missingReport!.pet.dob);
      String gender = report.pet.gender.toLowerCase();
      String capitalize(String value) => value.isNotEmpty
          ? value[0].toUpperCase() + value.substring(1)
          : value;
      displayValue = '${capitalize(type)} . ${capitalize(gender)}';
    }
    return AppText.h1(
      displayValue,
      color: AppColors.textSecondary,
      fontSize: AppFontSize.fs14,
      maxLines: 1,
      style: const TextStyle(fontWeight: FontWeight.w600, height: 1.1),
    );
  }

  Widget _buildBreedSpecification() {
    MissingReport? report = item.missingReport;
    String displayValue = 'Unknown Breed';
    if (report != null && report.pet.breedInfo.breedName.isNotEmpty) {
      displayValue = report.pet.breedInfo.breedName;
    }

    return AppText.bodyL(
      displayValue,
      color: const Color(0xFF696764),
      fontSize: AppFontSize.fs10,
      maxLines: 1,
      style: const TextStyle(height: 1.1),
    );
  }

  Widget _buildLocationRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppIcon(
          AppIcons.svg.generic.mapPinLine,
          size: AppFontSize.fs15,
          color: const Color(0xFF404041),
        ),
        AppSpacing.s5.wBox,
        Expanded(
          child: AppText.bodyL(
            item.location,
            color: const Color(0xFF404041),
            style: TextStyle(fontSize: AppFontSize.fs10),
          ),
        ),
      ],
    );
  }
}
