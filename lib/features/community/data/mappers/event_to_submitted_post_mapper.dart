// ignore_for_file: avoid_redundant_argument_values

import 'package:poochcare/features/community/data/models/event_info_item_model.dart';
import 'package:poochcare/features/community/data/models/my_submitted_posts_model.dart';

extension EventMapper on EventInfoItemModel {
  MySubmittedPostsModel toSubmittedPost() {
    return MySubmittedPostsModel(
      id: id,
      // ignore: prefer_single_quotes
      type: "event",
      title: title,
      description: description,
      attachmentUrls: images
          .map(
            (img) => Attachment(
              id: img.id,
              url: img.url.isNotEmpty ? img.url : img.imageUrl,
              name: img.name,
              size: img.size.toString(),
            ),
          )
          .toList(),
      status: status,
      likesCount: likesCount,
      commentsCount: 0,
      attendanceCount: attendanceCount,
      isDraft: false,
      isDeleted: isDeleted,
      isLiked: isLiked,
      category: category != null
          ? Category(id: category!.id, name: category!.name)
          : null,
      organizer: organizer,
      user: organizer != null
          ? User(
              id: organizer!.id,
              name: organizer!.name,
              email: organizer!.email,
              profile: UserProfile(
                profilePicture: organizer?.profile?.profilePicture ?? '',
              ),
            )
          : null,
      location: location,
      eventStartDate: eventStartDate,
      eventEndDate: eventEndDate,
      eventTime: eventTime,
      images: images
          .map(
            (img) => EventImage(
              id: img.id,
              url: img.url.isNotEmpty ? img.url : img.imageUrl,
              name: img.name,
              size: img.size.toString(),
            ),
          )
          .toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
