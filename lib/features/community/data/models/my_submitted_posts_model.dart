import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_annotations.dart';
import 'package:poochcare/features/community/data/models/event_info_item_model.dart';

part 'my_submitted_posts_model.mapper.dart';

@MappableClass()
class MySubmittedPostsModel with MySubmittedPostsModelMappable {
  @SafeString()
  final String id;

  @SafeString()
  final String type;

  @SafeString()
  final String title;

  @SafeString()
  final String description;

  @MappableField(hook: SafeListHook())
  final List<Attachment> attachmentUrls;

  @SafeString()
  final String status;

  @SafeInt()
  final int likesCount;

  @SafeInt()
  final int commentsCount;

  @SafeInt()
  final int attendanceCount;

  @SafeBool()
  final bool isDraft;

  @SafeBool()
  final bool isDeleted;

  @SafeBool()
  final bool isLiked;

  final Category? category;

  final User? user;
  final EventOrganizerInfo? organizer;

  @SafeString()
  final String location;

  @SafeString()
  final String? eventStartDate;

  @SafeString()
  final String? eventEndDate;

  @SafeString()
  final String eventTime;

  @MappableField(hook: SafeListHook())
  final List<EventImage> images;

  @SafeString()
  final String? createdAt;

  @SafeString()
  final String? updatedAt;

  const MySubmittedPostsModel({
    this.id = '',
    this.type = '',
    this.title = '',
    this.description = '',
    this.attachmentUrls = const [],
    this.status = '',
    this.likesCount = 0,
    this.commentsCount = 0,
    this.attendanceCount = 0,
    this.isDraft = false,
    this.isDeleted = false,
    this.isLiked = false,
    this.category,
    this.user,
    this.organizer,
    this.location = '',
    this.eventStartDate,
    this.eventEndDate,
    this.eventTime = '',
    this.images = const [],
    this.createdAt,
    this.updatedAt,
  });
}

/// =========================
/// MINIMAL DEPENDENT MODELS
/// =========================

@MappableClass()
class Attachment with AttachmentMappable {
  final String id;
  final String url;
  final String name;
  final String size;

  const Attachment({
    this.id = '',
    this.url = '',
    this.name = '',
    this.size = '',
  });
}

@MappableClass()
class EventImage with EventImageMappable {
  final String id;
  final String url;
  final String name;
  final String size;

  const EventImage({
    this.id = '',
    this.url = '',
    this.name = '',
    this.size = '',
  });
}

@MappableClass()
class Category with CategoryMappable {
  final String id;
  final String name;

  const Category({this.id = '', this.name = ''});
}

@MappableClass()
class User with UserMappable {
  final String id;
  final String name;
  final String email;
  final UserProfile profile;

  const User({
    this.id = '',
    this.name = '',
    this.email = '',
    this.profile = const UserProfile(),
  });
}

@MappableClass()
class UserProfile with UserProfileMappable {
  final String profilePicture;

  const UserProfile({this.profilePicture = ''});
}
