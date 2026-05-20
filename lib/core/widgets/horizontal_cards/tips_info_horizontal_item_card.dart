import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/others/community/community_profile_header.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/test_screen/community/tips_info_list_screen.dart';

class TipsInfoHorizontalItemCard extends StatelessWidget {
  final TipsInfoItemModel item;
  final VoidCallback? onTap;

  const TipsInfoHorizontalItemCard({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: AppSpacing.s250.w,
        height: AppSpacing.s90.h,
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.s12.w,
          vertical: AppSpacing.s10.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.s12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: AppText.bodyS(
                item.description,
                color: AppColors.textSecondary,
                maxLines: 2,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
            ),
            SizedBox(height: AppSpacing.s8.h),
            CommunityProfileHeader(
              userName: item.userName,
              avatarUrl: item.userImage,
              timeAgo: item.timeAgo,
              badge: item.badge,
              badgeBackgroundColor: const Color(0xFFFFECBC),
            ),
          ],
        ),
      ),
    );
  }
}
