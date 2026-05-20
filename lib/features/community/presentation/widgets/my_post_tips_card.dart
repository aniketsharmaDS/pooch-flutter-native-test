import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/list_items/tips_info_list_item_card.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/community/data/models/my_submitted_posts_model.dart';
import 'package:poochcare/features/community/data/models/tips_info_item_model.dart';
import 'package:poochcare/router/app_router.dart';

class MyPostTipsCard extends StatelessWidget {
  final MySubmittedPostsModel postItem;

  const MyPostTipsCard({super.key, required this.postItem});

  @override
  Widget build(BuildContext context) {
    final TipsInfoItemModel eventItem = TipsInfoItemModel(
      id: postItem.id,
      title: postItem.title,
      description: postItem.description,
      categoryId: postItem.category?.id ?? '',
      user: TipsUserInfo(
        id: postItem.user?.id ?? '',
        name: postItem.user?.name ?? '',
        email: postItem.user?.email ?? '',
        profile: TipsUserProfile(
          profilePicture: postItem.user?.profile.profilePicture ?? '',
        ),
      ),
      category: TipsCategoryInfo(
        id: postItem.category?.id ?? '',
        name: postItem.category?.name ?? '',
      ),
      attachmentUrls: postItem.attachmentUrls
          .map(
            (attachment) => TipsImageInfo(
              id: attachment.id,
              imageUrl: attachment.url,
              size: int.tryParse(attachment.size) ?? 0,
              url: attachment.url,
            ),
          )
          .toList(),
      // images: postItem.images.map((attachment) => EventImageInfo(
      //   id: attachment.id, // No ID available in MySubmittedPostsModel
      //   url: attachment.url,
      //   name: attachment.name,
      //   size: int.tryParse(attachment.size) ?? 0, // Convert size to int, default to 0 if parsing fails
      // )).toList(),
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
      // attendanceCount: postItem.attendanceCount,
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
      // showEventsBadge: false,
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
                'Tips and Information',
                color: AppColors.white,
              ),
            ),
          ),
          TipsInfoListItemCard(
            isEngagementActive: false,
            item: eventItem,
            onLikeChanged: (bool isLiked) {},
            onCardTap: () {
              context.pushRoute(
                CommunityTipsGuideDetailsRoute(
                  tipId: eventItem.id,
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
