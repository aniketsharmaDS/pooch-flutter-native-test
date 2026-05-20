import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/utils/date_time_formattter.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/buttons/app_like_counter_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/images/app_image_cached_widget.dart';
import 'package:poochcare/core/widgets/others/community/community_profile_header.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/community/data/models/event_info_item_model.dart';
import 'package:poochcare/features/community/presentation/bloc/events/events_bloc.dart';

class EventListItemCard extends StatefulWidget {
  final EventInfoItemModel item;
  final bool isDetailView;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onCardTap;
  final bool isAttending;
  final bool isEngagementActive;
  final ValueChanged<bool>? onLikeChanged;
  final ValueChanged<bool>? onAttendanceChanged;

  const EventListItemCard({
    super.key,
    required this.item,

    this.isDetailView = false,
    this.onAvatarTap,
    this.onCardTap,
    this.isAttending = false,
    this.onLikeChanged,
    this.onAttendanceChanged,
    this.isEngagementActive = true,
  });

  @override
  State<EventListItemCard> createState() => _EventListItemCardState();
}

class _EventListItemCardState extends State<EventListItemCard> {
  late bool _isLiked;
  late int _likesCount;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.item.isLiked;
    _likesCount = widget.item.likesCount;
  }

  @override
  void didUpdateWidget(covariant EventListItemCard oldWidget) {
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

  void _handleAttendance(bool attending) {
    widget.onAttendanceChanged?.call(attending);
  }

  String get _resolvedDescription {
    final String safeTitle = widget.item.title.trim();
    final String safeDescription = widget.item.description.trim();
    if (safeTitle.isEmpty) return safeDescription;
    if (safeDescription.isEmpty) return safeTitle;
    return safeDescription;
    // return '$safeTitle $safeDescription';
  }

  @override
  Widget build(BuildContext context) {
    final bool hasDetailedEvents =
        widget.isDetailView && widget.item.description.isNotEmpty;
    final state = context.watch<EventsBloc>().state;
    final isLeaveProcessing = state.isProcessing(
      widget.item.id,
      EventActions.leaveEvent,
    );

    return GestureDetector(
      onTap: widget.onCardTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: AppSpacing.s16.w),
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
                userName: widget.item.organizer?.name ?? '',
                avatarUrl: widget.item.organizer?.profile?.profilePicture ?? '',
                timeAgo: formatTimeAgo(widget.item.createdAt),
                onAvatarTap: widget.onAvatarTap,
                badge: widget.item.category?.name ?? '',
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
                child: _buildEventsBadge(),
              ),
            ],
            AppSpacing.s12.hBox,
            if (widget.item.eventStartDate.isNotEmpty &&
                widget.item.eventTime.isNotEmpty) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
                child: _buildDateTimeRow(),
              ),
              AppSpacing.s10.hBox,
            ],
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
              child: _buildTitle(),
            ),
            AppSpacing.s2.hBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
              child: _buildDescription(),
            ),
            if (widget.item.location.isNotEmpty) ...[
              AppSpacing.s10.hBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
                child: _buildLocationRow(),
              ),
            ],
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
              child: hasDetailedEvents
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSpacing.s12.hBox,
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.s16.w,
                          ),
                          child: _buildDetailedEventsList(
                            widget.item.description,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
            if (widget.isDetailView && widget.isAttending) ...[
              AppSpacing.s14.hBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppText.h1(
                      "You're attending this event",
                      color: AppColors.textSecondary,
                      fontSize: AppFontSize.fs14,
                      maxLines: 3,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                    AppSpacing.s10.hBox,
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            label: 'Attending',
                            height: AppSpacing.s48.h,
                            disableRippleEffect: true,
                            onPressed: () => {},
                          ),
                        ),
                        AppSpacing.s12.wBox,
                        Expanded(
                          child: AppButton(
                            isLoading: isLeaveProcessing,
                            label: 'Leave Event',
                            onPressed: () => _handleAttendance(false),
                            variant: AppButtonVariant.outlined,
                            height: AppSpacing.s48.h,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPostImage() {
    if (widget.item.images.isEmpty) {
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
      imageUrl: widget.item.images.isNotEmpty
          ? widget.item.images.first.url
          : '',
      width: double.infinity,
      height: AppSpacing.s140.h,
      borderRadius: BorderRadius.circular(AppSpacing.s14.r),
    );
  }

  Widget _buildEventsBadge() {
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
        'Events',
        color: AppColors.white,
        fontSize: AppFontSize.fs10,
        style: const TextStyle(fontWeight: FontWeight.w400),
      ),
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
              formatStringDateToDayMonth(widget.item.eventStartDate),
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
              widget.item.eventTime,
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
      widget.item.title,
      color: AppColors.textSecondary,
      fontSize: AppFontSize.fs14,
      maxLines: 3,
      style: const TextStyle(fontWeight: FontWeight.w600, height: 1.2),
    );
  }

  Widget _buildDescription() {
    return AppText.h4(
      _resolvedDescription,
      color: const Color(0xFF2D2D2E),
      fontSize: AppFontSize.fs12,
      maxLines: 3,
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
            widget.item.location,
            color: AppColors.communityActionLabel,
            style: TextStyle(fontSize: AppFontSize.fs10),
            maxLines: widget.isDetailView ? 3 : 1,
          ),
        ),
      ],
    );
  }

  Widget _buildEngagementRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppLikeCounter(
          count: _likesCount,
          isLiked: _isLiked,
          onTap: _handleLikeTap,
          iconSize: AppFontSize.fs20,
          activeColor: AppColors.primary,
        ),
        AppText.bodyS(' Likes', color: AppColors.communityActionLabel),
      ],
    );
  }

  Widget _buildDetailedEventsList(String eventsLongDescription) {
    return AppText.bodyM(
      eventsLongDescription,
      maxLines: 100,
      color: AppColors.detailText,
      fontSize: AppFontSize.fs13,
      style: const TextStyle(fontWeight: FontWeight.w400, height: 1.6),
    );
  }
}
