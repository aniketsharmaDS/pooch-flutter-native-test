import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/utils/date_time_formattter.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/images/app_image_cached_widget.dart';
import 'package:poochcare/core/widgets/images/app_image_slider.dart';
import 'package:poochcare/core/widgets/others/community/community_profile_header.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/community/data/models/missing_pet_model.dart';

class MissingPoochListItemCard extends StatefulWidget {
  final MissingPetModel item;
  final bool isDetailView;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onCardTap;

  const MissingPoochListItemCard({
    super.key,
    required this.item,
    this.isDetailView = false,
    this.onAvatarTap,
    this.onCardTap,
  });

  @override
  State<MissingPoochListItemCard> createState() =>
      _MissingPoochListItemCardState();
}

class _MissingPoochListItemCardState extends State<MissingPoochListItemCard> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MissingPetModel item = widget.item;

    final bool hasDetailedMissingPoochs = widget.isDetailView;

    return GestureDetector(
      onTap: widget.onCardTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: AppSpacing.s16.h),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.s16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
              child: CommunityProfileHeader(
                userName: item.owner.name,
                avatarUrl: item.owner.profile?.profilePicture ?? '',
                timeAgo: formatTimeAgo(item.createdAt.toString()),
                badge: item.status.toUpperCase(),
                badgeBackgroundColor: const Color(0xFFFAC5C5),
                badgeTextColor: const Color(0xFFEF4444),
                onAvatarTap: widget.onAvatarTap,
              ),
            ),
            AppSpacing.s12.hBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
              child: _buildPostImage(),
            ),
            if (widget.item.status.toUpperCase() == 'MISSING') ...[
              AppSpacing.s10.hBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
                child: _buildMissingPoochsBadge(),
              ),
            ],
            AppSpacing.s12.hBox,
            if (!widget.isDetailView) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
                child: _buildPetSpecification(),
              ),
              AppSpacing.s1.hBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
                child: _buildBreedSpecification(),
              ),
            ],
            if (widget.isDetailView && widget.item.rewardAmount != null) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
                child: _buildPetDetailsWithRewardSection(),
              ),
            ],
            if (widget.item.missingDate != null &&
                widget.item.missingDate!.isNotEmpty) ...[
              AppSpacing.s13.hBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
                child: _buildLastSeen(),
              ),
            ],

            if (widget.item.lastKnownLocation.isNotEmpty) ...[
              AppSpacing.s10.hBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
                child: _buildLocationRow(),
              ),
            ],
            AppSpacing.s10.hBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
              child: _buildDescription(),
            ),

            if (widget.isDetailView && widget.item.rewardAmount != null) ...[
              AnimatedSize(
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeInOut,
                child: hasDetailedMissingPoochs
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12.h),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: _buildDetailedDisclaimer(
                              'Any reward mentioned is at the discretion of the reporter. The app is not involved in or responsible for reward exchanges.',
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPostImage() {
    if (widget.item.images.isEmpty &&
        (widget.item.pet.profilePicture == null ||
            widget.item.pet.profilePicture!.isEmpty)) {
      return Container(
        width: double.infinity,
        height: AppSpacing.s140.h,
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
          size: AppSpacing.s70.r,
          color: AppColors.textSecondary.withAlpha(180),
        ),
      );
    }

    final imageUrls = widget.item.images.map((e) => e.imageUrl).toList();

    if (widget.item.pet.profilePicture != null &&
        widget.item.pet.profilePicture!.isNotEmpty) {
      imageUrls.insert(0, widget.item.pet.profilePicture!);
    }
    log('imageUrls: $imageUrls');
    // Detail view: Show carousel with pagination dots overlay
    if (widget.isDetailView) {
      return AppImageSlider(
        pageController: _pageController,
        imageUrls: imageUrls,
        currentPage: _currentPage,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      );
    }

    // List view: Show 1 or 2 images side by side
    if (imageUrls.length == 1) {
      return AppImageCachedWidget(
        imageUrl: imageUrls.first,
        // width: double.infinity,
        width: AppSpacing.s160.w,
        height: AppSpacing.s140.h,
        borderRadius: BorderRadius.circular(AppSpacing.s14.r),
      );
    }

    // Multiple images: Show 2 side by side
    return Row(
      children: [
        Expanded(
          child: AppImageCachedWidget(
            imageUrl: imageUrls[0],
            width: double.infinity,
            height: AppSpacing.s140.h,
            borderRadius: BorderRadius.circular(AppSpacing.s14.r),
          ),
        ),
        AppSpacing.s8.wBox,
        Expanded(
          child: AppImageCachedWidget(
            imageUrl: imageUrls[1],
            width: double.infinity,
            height: AppSpacing.s140.h,
            borderRadius: BorderRadius.circular(AppSpacing.s14.r),
          ),
        ),
      ],
    );
  }

  Widget _buildMissingPoochsBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.s10.w,
        vertical: AppSpacing.s4.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.communityBadgeBackground,
        borderRadius: BorderRadius.circular(AppSpacing.s40.r),
      ),
      child: AppText.h3(
        'Missing Pooch Report',
        color: AppColors.white,
        fontSize: AppFontSize.fs10,
        style: const TextStyle(fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _buildLastSeen() {
    final MissingPetModel item = widget.item;
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
    final MissingPetModel item = widget.item;
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
      color: const Color(0xFFEF4444),
      fontSize: AppFontSize.fs14,
      maxLines: 3,
      style: const TextStyle(fontWeight: FontWeight.w600, height: 1.2),
    );
  }

  Widget _buildBreedSpecification() {
    final MissingPetModel item = widget.item;
    return AppText.bodyL(
      item.pet.breedInfo.breedName,
      color: const Color(0xFFAA3030),
      fontSize: AppFontSize.fs10,
      maxLines: 3,
      style: const TextStyle(fontWeight: FontWeight.w600, height: 1.2),
    );
  }

  Widget _buildDescription() {
    return AppText.h4(
      widget.item.description,
      color: const Color(0xFF2D2D2E),
      fontSize: AppFontSize.fs12,
      variant: widget.isDetailView
          ? AppTextVariant.noEllipsis
          : AppTextVariant.normal,
      maxLines: 2,
      style: const TextStyle(fontWeight: FontWeight.w400, height: 1.2),
    );
  }

  Widget _buildLocationRow() {
    final MissingPetModel item = widget.item;
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

  Widget _buildPetDetailsWithRewardSection() {
    final MissingPetModel item = widget.item;
    String type = item.pet.type.toLowerCase();
    String name = item.pet.name;
    String age = formatPetAge(dob: item.pet.dob);
    String gender = item.pet.gender.toLowerCase();

    String capitalize(String value) =>
        value.isNotEmpty ? value[0].toUpperCase() + value.substring(1) : value;
    String displayValue =
        '${capitalize(type)} . $age . $name, ${capitalize(gender)}';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.h1(
                displayValue,
                color: const Color(0xFFEF4444),
                fontSize: AppFontSize.fs14,
                maxLines: 3,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 4.h),
              AppText.bodyL(
                item.pet.breedInfo.breedName,
                color: const Color(0xFFAA3030),
                fontSize: AppFontSize.fs10,
                maxLines: 3,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
        AppSpacing.s16.wBox,
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppIcon(AppIcons.svg.community.reward, size: AppSpacing.s25.h),
              AppSpacing.s6.wBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.support(
                      'Reward',
                      color: const Color(0xFFB48A1B),
                      fontSize: AppFontSize.fs12,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    AppText.h1(
                      '${widget.item.currencyUnit ?? ''} ${widget.item.rewardAmount.toString()}',
                      color: const Color(0xFFE7B123),
                      fontSize: AppFontSize.fs14,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedDisclaimer(String missingPoochLongDescription) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.s12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF6ECE6),
        borderRadius: BorderRadius.circular(AppSpacing.s12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.h4('Disclaimer', color: const Color(0xFF320E02)),
          AppSpacing.s6.hBox,
          AppText.bodyS(
            missingPoochLongDescription,
            maxLines: 10,
            color: const Color(0xFF320E02),
            fontSize: AppFontSize.fs12,
            style: const TextStyle(fontWeight: FontWeight.w400, height: 1.5),
          ),
        ],
      ),
    );
  }
}
