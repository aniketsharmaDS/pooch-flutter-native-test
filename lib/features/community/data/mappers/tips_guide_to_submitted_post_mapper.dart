// ignore_for_file: avoid_redundant_argument_values

import 'package:poochcare/features/community/data/models/my_submitted_posts_model.dart';
import 'package:poochcare/features/community/data/models/tips_info_item_model.dart';

extension TipsMapper on TipsInfoItemModel {
  MySubmittedPostsModel toSubmittedPost() {
    return MySubmittedPostsModel(
      id: id,
      type: 'tip',

      title: title,
      description: description,

      /// Convert List<String> → Attachment
      attachmentUrls: attachmentUrls
          .map(
            (item) => Attachment(
              id: item.id, // no id available → reuse url
              url: item.imageUrl,
              name: item.name, // no name available → use empty string
              size: item.size.toString(),
            ),
          )
          .toList(),
      status: status,
      likesCount: likesCount,
      commentsCount: commentsCount,

      /// Not applicable for tips
      attendanceCount: 0,

      isDraft: isDraft,
      isDeleted: isDeleted,
      isLiked: isLiked,

      /// Category mapping
      category: category != null
          ? Category(id: category!.id, name: category!.name)
          : null,

      /// User mapping
      user: user != null
          ? User(
              id: user!.id,
              name: user!.name,
              email: user!.email,
              profile: UserProfile(
                profilePicture: user?.profile?.profilePicture ?? '',
              ),
            )
          : null,

      /// Not applicable for tips
      organizer: null,
      location: '',
      eventStartDate: null,
      eventEndDate: null,
      eventTime: '',

      /// No images in tips → keep empty
      images: const [],

      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
