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
import 'package:poochcare/features/community/data/models/event_info_item_model.dart';

class EventHlistItemCard extends StatelessWidget {
  final EventInfoItemModel item;
  final VoidCallback? onCardTap;

  const EventHlistItemCard({super.key, required this.item, this.onCardTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        width: AppSpacing.s230.w,
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.s15.w,
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
              userName: item.organizer?.name ?? '',
              avatarUrl: item.organizer?.profile?.profilePicture ?? '',
              timeAgo: formatTimeAgo(item.createdAt),
              badge: item.category?.name ?? '',
            ),
            AppSpacing.s11.hBox,
            _buildPostImage(),
            if (item.eventStartDate.isNotEmpty &&
                item.eventTime.isNotEmpty) ...[
              AppSpacing.s11.hBox,
              _buildDateTimeRow(),
            ],
            AppSpacing.s17.hBox,
            _buildTitle(),
            AppSpacing.s2.hBox,
            _buildDescription(),
            if (item.location.isNotEmpty) ...[
              AppSpacing.s10.hBox,
              _buildLocationRow(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPostImage() {
    if (item.images.isEmpty) {
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

    return AppImageCachedWidget(
      imageUrl: item.images.isNotEmpty ? item.images.first.url : '',
      width: double.infinity,
      height: AppSpacing.s140.h,
      borderRadius: BorderRadius.circular(AppSpacing.s12.r),
    );
  }

  Widget _buildDateTimeRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            AppIcon(
              AppIcons.svg.generic.calendar,
              size: AppFontSize.fs15,
              color: AppColors.communityActionLabel,
            ),
            AppSpacing.s5.wBox,
            AppText.bodyL(
              formatStringDateToDayMonth(item.eventStartDate),
              color: AppColors.communityActionLabel,
              style: TextStyle(fontSize: AppFontSize.fs10),
            ),
            AppSpacing.s10.wBox,
            AppIcon(
              AppIcons.svg.generic.clock,
              size: AppFontSize.fs15,
              color: AppColors.communityActionLabel,
            ),
            AppSpacing.s5.wBox,
            AppText.bodyL(
              item.eventTime,
              color: AppColors.communityActionLabel,
              style: TextStyle(fontSize: AppFontSize.fs10),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return AppText.h1(
      item.title,
      color: AppColors.textSecondary,
      fontSize: AppFontSize.fs12,
      maxLines: 2,
      style: const TextStyle(fontWeight: FontWeight.w600, height: 1.1),
    );
  }

  Widget _buildDescription() {
    return AppText.h4(
      item.description,
      color: const Color(0xFF2D2D2E),
      fontSize: AppFontSize.fs12,
      maxLines: 1,
      style: const TextStyle(fontWeight: FontWeight.w400, height: 1.2),
    );
  }

  Widget _buildLocationRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppIcon(
          AppIcons.svg.generic.mapPinLine,
          size: AppFontSize.fs15,
          color: AppColors.communityActionLabel,
        ),
        AppSpacing.s5.wBox,
        Expanded(
          child: AppText.h3(
            item.location,
            maxLines: 1,
            color: AppColors.communityActionLabel,
            style: TextStyle(fontSize: AppFontSize.fs10),
          ),
        ),
      ],
    );
  }
}
