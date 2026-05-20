import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'tips_info_item_model.mapper.dart';

@MappableClass()
class TipsInfoItemModel with TipsInfoItemModelMappable {
  const TipsInfoItemModel({
    this.id = '',
    this.userId = '',
    this.categoryId = '',
    this.title = '',
    this.description = '',
    this.attachmentUrls = const [],
    this.likesCount = 0,
    this.commentsCount = 0,
    this.status = '',
    this.rejectionReason,
    this.isDraft = false,
    this.isActive = true,
    this.isDeleted = false,
    this.reportedCount = 0,
    this.isReported = false,
    this.createdAt = '',
    this.updatedAt = '',
    this.user,
    this.category,
    this.isLiked = false,
    this.isAuthor = false,
    this.showTipsBadge = false,
    this.hashtags = const [],
    this.tipsList = const [],
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String userId;

  @MappableField(hook: SafeStringHook())
  final String categoryId;

  @MappableField(hook: SafeStringHook())
  final String title;

  @MappableField(hook: SafeStringHook())
  final String description;

  final List<TipsImageInfo> attachmentUrls;

  @MappableField(hook: SafeIntHook())
  final int likesCount;

  @MappableField(hook: SafeIntHook())
  final int commentsCount;

  @MappableField(hook: SafeStringHook())
  final String status;

  final String? rejectionReason;

  final bool isDraft;
  final bool isActive;
  final bool isDeleted;

  @MappableField(hook: SafeIntHook())
  final int reportedCount;

  final bool isReported;

  @MappableField(hook: SafeStringHook())
  final String createdAt;

  @MappableField(hook: SafeStringHook())
  final String updatedAt;

  final TipsUserInfo? user;
  final TipsCategoryInfo? category;
  final bool isLiked;
  final bool isAuthor;
  final bool showTipsBadge;
  final List<String> hashtags;
  final List<String> tipsList;
}

@MappableClass()
class TipsUserInfo with TipsUserInfoMappable {
  const TipsUserInfo({
    this.id = '',
    this.name = '',
    this.email = '',
    this.profile,
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String name;

  @MappableField(hook: SafeStringHook())
  final String email;

  final TipsUserProfile? profile;
}

@MappableClass()
class TipsUserProfile with TipsUserProfileMappable {
  const TipsUserProfile({this.profilePicture});

  final String? profilePicture;
}

@MappableClass()
class TipsCategoryInfo with TipsCategoryInfoMappable {
  const TipsCategoryInfo({this.id = '', this.name = ''});

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String name;
}

@MappableClass()
class TipsImageInfo with TipsImageInfoMappable {
  const TipsImageInfo({
    this.id = '',
    this.imageUrl = '',
    this.url = '',
    this.name = '',
    this.size = 0,
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String imageUrl;

  @MappableField(hook: SafeStringHook())
  final String url;

  @MappableField(hook: SafeStringHook())
  final String name;

  @MappableField(hook: SafeIntHook())
  final int size;
}
