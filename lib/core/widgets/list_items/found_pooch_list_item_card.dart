import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/utils/date_time_formattter.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/images/app_image_cached_widget.dart';
import 'package:poochcare/core/widgets/others/community/community_profile_header.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/community/data/models/found_pet_model.dart';

class FoundPoochListItemCard extends StatefulWidget {
  final FoundPetModel item;
  final bool isDetailView;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onCardTap;

  const FoundPoochListItemCard({
    super.key,
    required this.item,
    this.isDetailView = false,
    this.onAvatarTap,
    this.onCardTap,
  });

  @override
  State<FoundPoochListItemCard> createState() => _FoundPoochListItemCardState();
}

class _FoundPoochListItemCardState extends State<FoundPoochListItemCard> {
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
    final FoundPetModel item = widget.item;
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
                userName: item.finder.name,
                avatarUrl: item.finder.profile.profilePicture,
                timeAgo: formatTimeAgo(item.createdAt),
                badge: 'Found',
                onAvatarTap: widget.onAvatarTap,
              ),
            ),
            AppSpacing.s12.hBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
              child: _buildPostImage(),
            ),
            if (widget.isDetailView) ...[
              AppSpacing.s10.hBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
                child: _buildFoundPoochsBadge(),
              ),
            ],
            AppSpacing.s17.hBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
              child: _buildPetSpecification(),
            ),
            AppSpacing.s1.hBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
              child: _buildBreedSpecification(),
            ),
            if (item.missingReport != null &&
                item.missingReport!.missingDate.isNotEmpty) ...[
              AppSpacing.s13.hBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
                child: _buildLastSeen(widget.isDetailView),
              ),
            ],

            if (item.location.isNotEmpty) ...[
              AppSpacing.s10.hBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
                child: _buildLocationRow(widget.isDetailView),
              ),
            ],
            AppSpacing.s10.hBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
              child: _buildDescription(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostImage() {
    final FoundPetModel item = widget.item;

    List<String> imageUrls = [];

    MissingReport? report = item.missingReport;

    if (report != null) {
      /// 1. Add profile picture
      final profile = report.pet.profilePicture;
      if (profile.isNotEmpty) {
        imageUrls.add(profile);
      }

      /// 2. Add ALL report images
      if (report.images.isNotEmpty) {
        imageUrls.addAll(
          report.images.map((e) => e.imageUrl).where((url) => url.isNotEmpty),
        );
      }
    }

    if (imageUrls.isEmpty) {
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

    // Detail view: Show carousel with pagination dots overlay
    if (widget.isDetailView) {
      return Stack(
        alignment: Alignment.bottomRight,
        children: [
          SizedBox(
            height: AppSpacing.s320.h,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return AppImageCachedWidget(
                  imageUrl: imageUrls[index],
                  width: double.infinity,
                  height: AppSpacing.s320.h,
                  borderRadius: BorderRadius.circular(AppSpacing.s14.r),
                );
              },
            ),
          ),
          // Pagination dots overlay
          if (imageUrls.length > 1)
            Positioned(
              bottom: AppSpacing.s12.h,
              right: AppSpacing.s12.w,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  imageUrls.length,
                  (index) => Container(
                    width: _currentPage == index
                        ? AppSpacing.s31.w
                        : AppSpacing.s7.w,
                    height: AppSpacing.s7.h,
                    margin: EdgeInsets.only(right: AppSpacing.s6.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSpacing.s6.r),
                      color: _currentPage == index
                          ? AppColors.primary
                          : const Color(0xFFFFECBC),
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    }

    // List view: Show 1 or 2 images side by side
    if (imageUrls.length == 1) {
      return AppImageCachedWidget(
        imageUrl: imageUrls.first,
        width: double.infinity,
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

  Widget _buildFoundPoochsBadge() {
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
        'Found Pet',
        color: AppColors.white,
        fontSize: AppFontSize.fs10,
        style: const TextStyle(fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _buildLastSeen(bool isDetailView) {
    final FoundPetModel item = widget.item;
    MissingReport? report = item.missingReport;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            AppIcon(
              AppIcons.svg.generic.clock,
              size: AppFontSize.fs15,
              color: isDetailView
                  ? const Color(0xFFAA3030)
                  : const Color(0xFF404041),
            ),
            AppSpacing.s5.wBox,
            AppText.bodyL(
              'Last Seen: ${formatDateAndTime(missingDate: report?.missingDate, missingTime: report?.missingTime)}',
              color: isDetailView
                  ? const Color(0xFFAA3030)
                  : const Color(0xFF404041),
              style: TextStyle(fontSize: AppFontSize.fs10),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPetSpecification() {
    MissingReport? report = widget.item.missingReport;
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
      maxLines: 3,
      style: const TextStyle(fontWeight: FontWeight.w600, height: 1.2),
    );
  }

  Widget _buildBreedSpecification() {
    MissingReport? report = widget.item.missingReport;
    String displayValue = 'Unknown Breed';
    if (report != null && report.pet.breedInfo.breedName.isNotEmpty) {
      displayValue = report.pet.breedInfo.breedName;
    }
    return AppText.bodyL(
      displayValue,
      color: const Color(0xFF3A3A3B),
      fontSize: AppFontSize.fs10,
      maxLines: 3,
      style: const TextStyle(fontWeight: FontWeight.w600, height: 1.2),
    );
  }

  Widget _buildLocationRow(bool isDetailView) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppIcon(
          AppIcons.svg.generic.mapPinLine,
          size: AppFontSize.fs15,
          color: isDetailView
              ? const Color(0xFFAA3030)
              : const Color(0xFF404041),
        ),
        AppSpacing.s5.wBox,
        Expanded(
          child: AppText.bodyL(
            widget.item.location,
            color: isDetailView
                ? const Color(0xFFAA3030)
                : const Color(0xFF404041),
            style: TextStyle(fontSize: AppFontSize.fs10),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    final FoundPetModel item = widget.item;
    MissingReport? report = item.missingReport;

    return AppText.bodyS(
      report?.description ?? '',
      color: const Color(0xFF666667),
      fontSize: AppFontSize.fs12,
      maxLines: widget.isDetailView ? 10 : 2,
      style: const TextStyle(fontWeight: FontWeight.w400, height: 1.2),
    );
  }
}
