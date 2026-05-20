import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'event_info_item_model.mapper.dart';

@MappableClass()
class EventInfoItemModel with EventInfoItemModelMappable {
  const EventInfoItemModel({
    this.id = '',
    this.organizerId = '',
    this.title = '',
    this.description = '',
    this.categoryId = '',
    this.eventStartDate = '',
    this.eventEndDate,
    this.eventTime = '',
    this.location = '',
    this.addressDetails = '',
    this.latitude = '',
    this.longitude = '',
    this.isPaid = false,
    this.attendanceCount = 0,
    this.likesCount = 0,
    this.reportedCount = 0,
    this.isReported = false,
    this.status = '',
    this.rejectionReason,
    this.isActive = true,
    this.isDeleted = false,
    this.createdAt = '',
    this.updatedAt = '',
    this.organizer,
    this.images = const [],
    this.category,
    this.userRsvpStatus,
    this.isLiked = false,
    this.isAuthor = false,
    this.showEventsBadge = true,

    /// ✅ NEW FIELDS (DETAIL SUPPORT) for details modal
    this.reports = const [],
    this.reportsCount = 0,
    this.isUserReported = false,
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String organizerId;

  @MappableField(hook: SafeStringHook())
  final String title;

  @MappableField(hook: SafeStringHook())
  final String description;

  @MappableField(hook: SafeStringHook())
  final String categoryId;

  @MappableField(hook: SafeStringHook())
  final String eventStartDate;

  final String? eventEndDate;

  @MappableField(hook: SafeStringHook())
  final String eventTime;

  @MappableField(hook: SafeStringHook())
  final String location;

  @MappableField(hook: SafeStringHook())
  final String addressDetails;

  @MappableField(hook: SafeStringHook())
  final String latitude;

  @MappableField(hook: SafeStringHook())
  final String longitude;

  final bool isPaid;

  @MappableField(hook: SafeIntHook())
  final int attendanceCount;

  @MappableField(hook: SafeIntHook())
  final int likesCount;

  @MappableField(hook: SafeIntHook())
  final int reportedCount;

  final bool isReported;

  @MappableField(hook: SafeStringHook())
  final String status;

  final String? rejectionReason;

  final bool isActive;
  final bool isDeleted;

  @MappableField(hook: SafeStringHook())
  final String createdAt;

  @MappableField(hook: SafeStringHook())
  final String updatedAt;

  final EventOrganizerInfo? organizer;

  final List<EventImageInfo> images;

  final EventCategoryInfo? category;

  final String? userRsvpStatus;

  final bool isLiked;
  final bool isAuthor;
  final bool showEventsBadge;

  /// ✅ NEW FIELDS
  final List<EventReportInfo> reports;

  @MappableField(hook: SafeIntHook())
  final int reportsCount;

  final bool isUserReported;
}

@MappableClass()
class EventOrganizerInfo with EventOrganizerInfoMappable {
  const EventOrganizerInfo({
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

  final EventOrganizerProfile? profile;
}

@MappableClass()
class EventOrganizerProfile with EventOrganizerProfileMappable {
  const EventOrganizerProfile({this.profilePicture});

  final String? profilePicture;
}

@MappableClass()
class EventImageInfo with EventImageInfoMappable {
  const EventImageInfo({
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

@MappableClass()
class EventCategoryInfo with EventCategoryInfoMappable {
  const EventCategoryInfo({this.id = '', this.name = ''});

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String name;
}

/// ✅ NEW MODEL FOR REPORTS
@MappableClass()
class EventReportInfo with EventReportInfoMappable {
  const EventReportInfo({this.id = '', this.reason = '', this.status = ''});

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String reason;

  @MappableField(hook: SafeStringHook())
  final String status;
}
