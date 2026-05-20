import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/features/community/data/models/event_info_item_model.dart';
import 'package:poochcare/features/community/data/models/tips_info_item_model.dart';

part 'tip_event_item_model.mapper.dart';

@MappableClass()
class TipEventItemModel with TipEventItemModelMappable {
  const TipEventItemModel({
    this.id = '',
    this.type = '', // "event" | "tips"
    // ---------------- COMMON ----------------
    this.title = '',
    this.description = '',
    this.status = '',
    this.rejectionReason,
    this.isActive = true,
    this.isDeleted = false,
    this.isReported = false,
    this.reportedCount = 0,
    this.likesCount = 0,
    this.isLiked = false,
    this.isAuthor = false,
    this.createdAt = '',
    this.updatedAt = '',

    // ---------------- CATEGORY (UNIFIED OBJECT) ----------------
    this.category,

    // ---------------- EVENT CATEGORY ID ----------------
    this.eventCategoryId = '',

    // ---------------- TIPS CATEGORY ID ----------------
    this.tipCategoryId = '',

    // ---------------- EVENT ----------------
    this.organizerId = '',
    this.eventOrganizer,
    this.eventStartDate = '',
    this.eventEndDate,
    this.eventTime = '',
    this.location = '',
    this.addressDetails = '',
    this.latitude = '',
    this.longitude = '',
    this.isPaid = false,
    this.attendanceCount = 0,
    this.userRsvpStatus,
    this.images = const [],
    this.eventReports = const [],
    this.eventReportsCount = 0,
    this.isUserReported = false,
    this.showEventsBadge = true,

    // ---------------- TIPS ----------------
    this.userId = '',
    this.tipsUser,
    this.commentsCount = 0,
    this.isDraft = false,
    this.attachmentUrls = const [],
    this.hashtags = const [],
    this.tipsList = const [],
    this.showTipsBadge = false,
  });

  // ================= COMMON =================
  final String id;
  final String type;

  final String title;
  final String description;
  final String status;

  final String? rejectionReason;

  final bool isActive;
  final bool isDeleted;
  final bool isReported;

  final int reportedCount;
  final int likesCount;
  final bool isLiked;
  final bool isAuthor;

  final String createdAt;
  final String updatedAt;

  // ================= CATEGORY =================
  /// single object for both event & tips
  final TipsCategoryInfo? category; // EventCategoryInfo | TipsCategoryInfo

  // ================= CATEGORY IDS =================
  final String eventCategoryId;
  final String tipCategoryId;

  // ================= EVENT =================
  final String organizerId;
  final EventOrganizerInfo? eventOrganizer;

  final String eventStartDate;
  final String? eventEndDate;
  final String eventTime;

  final String location;
  final String addressDetails;
  final String latitude;
  final String longitude;

  final bool isPaid;
  final int attendanceCount;
  final String? userRsvpStatus;

  final List<EventImageInfo> images;

  final List<EventReportInfo> eventReports;
  final int eventReportsCount;

  final bool isUserReported;
  final bool showEventsBadge;

  // ================= TIPS =================
  final String userId;
  final TipsUserInfo? tipsUser;

  final int commentsCount;
  final bool isDraft;

  final List<String> attachmentUrls;
  final List<String> hashtags;
  final List<String> tipsList;

  final bool showTipsBadge;
}
