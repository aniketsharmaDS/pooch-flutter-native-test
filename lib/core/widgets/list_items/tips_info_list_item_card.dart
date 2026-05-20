import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/utils/date_time_formattter.dart';
import 'package:poochcare/core/widgets/buttons/app_like_counter_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/images/app_image_cached_widget.dart';
import 'package:poochcare/core/widgets/others/community/community_profile_header.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/community/data/models/tips_info_item_model.dart';

class TipsInfoListItemCard extends StatefulWidget {
  final TipsInfoItemModel item;
  final bool isDetailView;
  final bool isEngagementActive;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onCommentTap;
  final VoidCallback? onCardTap;
  final ValueChanged<bool>? onLikeChanged;

  const TipsInfoListItemCard({
    super.key,
    required this.item,
    this.isDetailView = false,
    this.isEngagementActive = true,
    this.onAvatarTap,
    this.onCommentTap,
    this.onCardTap,
    this.onLikeChanged,
  });

  @override
  State<TipsInfoListItemCard> createState() => _TipsInfoListItemCardState();
}

class _TipsInfoListItemCardState extends State<TipsInfoListItemCard> {
  late bool _isLiked;
  late int _likesCount;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.item.isLiked;
    _likesCount = widget.item.likesCount;
  }

  @override
  void didUpdateWidget(covariant TipsInfoListItemCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.isLiked != widget.item.isLiked) {
      _isLiked = widget.item.isLiked;
    }
    if (oldWidget.item.likesCount != widget.item.likesCount) {
      _likesCount = widget.item.likesCount;
    }
  }

  void _handleLikeTap() {
    // setState(() {
    //   _isLiked = !_isLiked;
    //   if (_isLiked) {
    //     _likesCount += 1;
    //   } else {
    //     _likesCount = (_likesCount - 1).clamp(0, 1 << 31);
    //   }
    // });
    widget.onLikeChanged?.call(!_isLiked);
  }

  String get _resolvedDescription {
    final String safeTitle = widget.item.title.trim();
    final String safeDescription = widget.item.description.trim();
    if (safeTitle.isEmpty) return safeDescription;
    if (safeDescription.isEmpty) return safeTitle;
    return safeDescription;
  }

  @override
  Widget build(BuildContext context) {
    final bool hasDetailedTips =
        widget.isDetailView && widget.item.tipsList.isNotEmpty;

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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CommunityProfileHeader(
                userName: widget.item.user?.name ?? '',
                avatarUrl: widget.item.user?.profile?.profilePicture ?? '',
                timeAgo: formatTimeAgo(widget.item.createdAt),
                badge: widget.item.category?.name ?? '',
                onAvatarTap: widget.onAvatarTap,
              ),
            ),
            AppSpacing.s12.hBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildPostImage(),
            ),
            if (widget.item.showTipsBadge) ...[
              AppSpacing.s10.hBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildTipsBadge(),
              ),
            ],
            AppSpacing.s12.hBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildTitleView(),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: _buildDescription(),
            // ),
            if (widget.item.hashtags.isNotEmpty) ...[
              AppSpacing.s8.hBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildHashtags(),
              ),
            ],
            AppSpacing.s10.hBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildDescriptionView(),
            ),
            if (widget.isEngagementActive) ...[
              if (widget.item.status == 'APPROVED') ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.s8.w),
                  child: _buildEngagementRow(),
                ),
              ],
            ],
            AnimatedSize(
              duration: const Duration(milliseconds: 240),
              curve: Curves.easeInOut,
              child: hasDetailedTips
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSpacing.s12.hBox,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: _buildDetailedTipsList(widget.item.tipsList),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostImage() {
    TipsInfoItemModel item = widget.item;
    TipsImageInfo? tipsImageInfo = item.attachmentUrls.isNotEmpty
        ? item.attachmentUrls.first
        : null;
    String postImage = '';
    if (tipsImageInfo != null) {
      postImage = tipsImageInfo.imageUrl.isNotEmpty
          ? tipsImageInfo.imageUrl
          : tipsImageInfo.url;
    }
    if (postImage.isEmpty) {
      return Container(
        width: double.infinity,
        // height: widget.isDetailView ? 180.h : 140.h,
        height: AppSpacing.s140.h,
        decoration: BoxDecoration(
          color: AppColors.background.withAlpha(100),
          borderRadius: BorderRadius.circular(AppSpacing.s14.r),
          border: Border.all(
            color: AppColors.background.withAlpha(150),
            width: AppSpacing.s5.w,
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
      // imageUrl: postImage,
      imageUrl: postImage.isNotEmpty ? postImage : '',
      width: double.infinity,
      // height: widget.isDetailView ? 180.h : 160.h,
      height: AppSpacing.s140.h,
      borderRadius: BorderRadius.circular(AppSpacing.s14.r),
    );
  }

  Widget _buildTipsBadge() {
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
        'Tips & Info',
        color: AppColors.white,
        fontSize: AppFontSize.fs10,
        style: const TextStyle(fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _buildTitleView() {
    final String safeTitle = widget.item.title.trim();
    if (widget.isDetailView) {
      return AppText.support(
        safeTitle,
        color: AppColors.textPrimary,
        fontSize: AppFontSize.fs18,
        variant: AppTextVariant.noEllipsis,
      );
    }
    return AppText.support(
      safeTitle,
      color: AppColors.textPrimary,
      fontSize: AppFontSize.fs14,
      maxLines: 2,
      // variant: AppTextVariant.noEllipsis,
    );
  }

  // ignore: unused_element
  Widget _buildDescription() {
    if (widget.isDetailView) {
      return AppText.h4(
        _resolvedDescription,
        maxLines: 5,
        color: AppColors.textSecondary,
        fontSize: AppFontSize.fs18,
        style: const TextStyle(fontWeight: FontWeight.w400, height: 1.2),
      );
    }

    return AppText.h4(
      _resolvedDescription,
      color: AppColors.textSecondary,
      fontSize: AppFontSize.fs14,
      maxLines: 3,
      style: const TextStyle(fontWeight: FontWeight.w400, height: 1.2),
    );
  }

  Widget _buildDescriptionView() {
    if (widget.isDetailView) {
      return AppText.support(
        _resolvedDescription,
        color: AppColors.p5,
        fontSize: AppFontSize.fs12,
        variant: AppTextVariant.noEllipsis,
      );
    }
    return Container();
  }

  Widget _buildHashtags() {
    return Wrap(
      spacing: AppSpacing.s6.w,
      runSpacing: AppSpacing.s4.h,
      children: widget.item.hashtags.map((String tag) {
        final String displayTag = tag.startsWith('#') ? tag : '#$tag';
        return AppText.support(
          displayTag,
          color: AppColors.communityHashtagText,
          style: const TextStyle(fontWeight: FontWeight.w500),
        );
      }).toList(),
    );
  }

  Widget _buildEngagementRow() {
    return Row(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppLikeCounter(
              count: _likesCount,
              isLiked: _isLiked,
              onTap: _handleLikeTap,
              iconSize: AppSpacing.s20.r,
              activeColor: AppColors.primary,
            ),
            AppText.bodyS(' Likes', color: AppColors.communityActionLabel),
          ],
        ),
        AppSpacing.s18.wBox,
        InkWell(
          onTap: widget.onCommentTap,
          borderRadius: BorderRadius.circular(20.r),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.s2.w,
              vertical: AppSpacing.s2.h,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(AppIcons.svg.generic.comments),
                SizedBox(width: AppSpacing.s6.w),
                AppText.bodyS(
                  '${widget.item.commentsCount.toString().padLeft(2, '0')} Comments',
                  color: AppColors.communityActionLabel,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedTipsList(List<String> tips) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List<Widget>.generate(tips.length, (int index) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: index == tips.length - 1 ? 0 : AppSpacing.s8.h,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: AppSpacing.s2.h),
                child: AppText.h4(
                  '•',
                  color: AppColors.detailText,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              AppSpacing.s8.hBox,
              Expanded(
                child: AppText.bodyS(
                  tips[index],
                  maxLines: 5,
                  color: AppColors.detailText,
                  fontSize: AppFontSize.fs12,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
