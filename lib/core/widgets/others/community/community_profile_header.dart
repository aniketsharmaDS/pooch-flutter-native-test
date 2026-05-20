import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/others/community/profile_avatar.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class CommunityProfileHeader extends StatelessWidget {
  final String userName;

  /// Time label shown below the user name.
  final String? timeAgo;

  /// Backward-compatible alias for [timeAgo].
  final String? date;

  final String? avatarUrl;

  /// Right-side status badge (e.g., Care / Health).
  final String? badge;

  /// Backward-compatible alias for [badge].
  final String? tagText;

  /// Badge background color.
  final Color? badgeBackgroundColor;

  /// Badge text color.
  final Color? badgeTextColor;

  /// Kept for backward compatibility with previous API.
  final String? postedByText;
  final String? categoryText;
  final String? categoryLabel;

  final bool isHeader;

  final VoidCallback? onAvatarTap;

  const CommunityProfileHeader({
    super.key,
    required this.userName,
    this.timeAgo,
    this.date,
    this.avatarUrl,
    this.badge,
    this.tagText,
    this.badgeBackgroundColor,
    this.badgeTextColor,
    this.postedByText,
    this.categoryText,
    this.categoryLabel,
    this.onAvatarTap,
    this.isHeader = true,
  });

  @override
  Widget build(BuildContext context) {
    final String resolvedTime = (timeAgo ?? date ?? '').trim();
    final String resolvedBadge = (badge ?? tagText ?? '').trim();

    return Row(
      children: [
        ProfileAvatar(
          networkImage: avatarUrl,
          initials: userName.isNotEmpty ? userName[0] : '?',
          size: 30,
          onTap: onAvatarTap,
        ),
        AppSpacing.s5.wBox,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText.h3(
                userName,
                fontSize: isHeader ? AppFontSize.fs14 : AppFontSize.fs10,
                style: const TextStyle(fontWeight: FontWeight.w400),
                maxLines: 1,
              ),
              if (resolvedTime.isNotEmpty) ...[
                AppText.bodyL(
                  resolvedTime,
                  fontSize: AppFontSize.fs10,
                  color: isHeader ? AppColors.p5 : AppColors.p5_300,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                  maxLines: 1,
                ),
              ],
            ],
          ),
        ),

        if (resolvedBadge.isNotEmpty) ...[
          AppSpacing.s8.hBox,
          _buildRightBadge(resolvedBadge),
        ],
      ],
    );
  }

  Widget _buildRightBadge(String text) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.s8.w,
        AppSpacing.s3.h,
        AppSpacing.s8.w,
        AppSpacing.s3.h,
      ),
      decoration: BoxDecoration(
        color: badgeBackgroundColor ?? const Color(0xFFE9F9EF),
        borderRadius: BorderRadius.circular(AppSpacing.s12.r),
      ),
      child: AppText.support(
        text,
        color: badgeTextColor ?? const Color(0xFF22C55E),
        fontSize: AppFontSize.fs10,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
