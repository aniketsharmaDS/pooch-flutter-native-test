import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/list_items/event_list_item_card.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/community/data/models/event_info_item_model.dart';
import 'package:poochcare/features/community/data/models/my_submitted_posts_model.dart';
import 'package:poochcare/features/community/presentation/bloc/events/events_bloc.dart';
import 'package:poochcare/router/app_router.dart';

class MyPostEventCard extends StatelessWidget {
  final MySubmittedPostsModel postItem;

  const MyPostEventCard({super.key, required this.postItem});

  @override
  Widget build(BuildContext context) {
    log('postItem in MyPostEventCard: ${postItem.toJson()}');
    final EventInfoItemModel eventItem = EventInfoItemModel(
      id: postItem.id,
      organizerId: postItem.organizer?.id ?? '',
      title: postItem.title,
      description: postItem.description,
      categoryId: postItem.category?.id ?? '',
      eventStartDate: postItem.eventStartDate?.toString() ?? '',
      eventEndDate: postItem.eventEndDate?.toString() ?? '',
      eventTime: postItem.eventTime,
      location: postItem.location,
      organizer: postItem.organizer,
      category: EventCategoryInfo(
        id: postItem.category?.id ?? '',
        name: postItem.category?.name ?? '',
      ),
      images: postItem.images
          .map(
            (attachment) => EventImageInfo(
              id: attachment.id, // No ID available in MySubmittedPostsModel
              url: attachment.url,
              name: attachment.name,
              size:
                  int.tryParse(attachment.size) ??
                  0, // Convert size to int, default to 0 if parsing fails
            ),
          )
          .toList(),
      // images: [const EventImageInfo(
      //   id: 'attachment.id', // No ID available in MySubmittedPostsModel
      //   url: 'https://pooch-developments.s3.amazonaws.com/users/event_images/images/cropped_image_1772180588125-1772180622084-af363518.png?AWSAccessKeyId=AKIAX2HPUGWIASJM2XUV&Expires=1777666655&Signature=mwYcWFwcZkZFL5DQvMVuvBuKkew%3D',
      //   name: 'attachment.name',
      //   size:  0, // Convert size to int, default to 0 if parsing fails
      // )],
      // addressDetails: postItem.addressDetails,
      // latitude: postItem.latitude,
      // longitude: postItem.longitude,
      // isPaid: postItem.isPaid,
      attendanceCount: postItem.attendanceCount,
      likesCount: postItem.likesCount,
      isLiked: postItem.isLiked,
      // reportedCount: postItem.reportedCount,
      // isReported: postItem.isReported,
      status: postItem.status,
      // rejectionReason: postItem.rejectionReason,
      // isActive: postItem.isActive,
      isDeleted: postItem.isDeleted,
      createdAt: postItem.createdAt ?? '',
      updatedAt: postItem.updatedAt ?? '',
      showEventsBadge: false,
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.p1_900,
        borderRadius: BorderRadius.circular(AppSpacing.s16.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.s16.w,
              vertical: AppSpacing.s6.h,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AppText.bodyS(
                'community.myPostEventCard.title'.tr(),
                color: AppColors.white,
              ),
            ),
          ),
          EventListItemCard(
            item: eventItem,
            isEngagementActive: false,
            onLikeChanged: (bool isLiked) {
              context.read<EventsBloc>().toggleEventLike(
                eventId: eventItem.id,
                targetIsLiked: isLiked,
              );
            },
            onCardTap: () {
              context.pushRoute(
                CommunityEventDetailsRoute(
                  eventId: eventItem.id,
                  isOwnPost: true,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
