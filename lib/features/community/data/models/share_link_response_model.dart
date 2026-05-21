import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_annotations.dart';

part 'share_link_response_model.mapper.dart';

@MappableClass()
class ShareLinkResponseModel with ShareLinkResponseModelMappable {
  final bool success;

  @SafeString()
  final String message;

  @SafeInt()
  final int status;

  final ShareLinkResponseData data;

  final ShareMeta meta;

  const ShareLinkResponseModel({
    this.success = false,
    this.message = '',
    this.status = 0,
    this.data = const ShareLinkResponseData(),
    this.meta = const ShareMeta(),
  });
}

@MappableClass()
class ShareLinkResponseData with ShareLinkResponseDataMappable {
  // ===== COMMON FIELDS =====
  @SafeString()
  final String id;

  @SafeString()
  final String contentType; // tip | event

  @SafeString()
  final String title;

  @SafeString()
  final String description;

  @MappableField(hook: SafeListHook())
  final List<String> attachmentUrls;

  @SafeInt()
  final int likesCount;

  @SafeInt()
  final int commentsCount;

  @SafeString()
  final String createdAt;

  @SafeString()
  final String updatedAt;

  // ===== EVENT FIELDS (optional) =====
  @SafeString()
  final String? startDate;

  @SafeString()
  final String? endDate;

  @SafeString()
  final String? eventTime;

  @SafeString()
  final String? location;

  @SafeString()
  final String? addressDetails;

  @SafeString()
  final String? latitude;

  @SafeString()
  final String? longitude;

  @SafeBool()
  final bool? isPaid;

  @SafeInt()
  final int? attendanceCount;

  const ShareLinkResponseData({
    this.id = '',
    this.contentType = '',
    this.title = '',
    this.description = '',
    this.attachmentUrls = const [],
    this.likesCount = 0,
    this.commentsCount = 0,
    this.createdAt = '',
    this.updatedAt = '',

    // event optional fields
    this.startDate,
    this.endDate,
    this.eventTime,
    this.location,
    this.addressDetails,
    this.latitude,
    this.longitude,
    this.isPaid,
    this.attendanceCount,
  });
}

@MappableClass()
class ShareMeta with ShareMetaMappable {
  @SafeString()
  final String lang;

  @SafeString()
  final String timestamp;

  const ShareMeta({this.lang = '', this.timestamp = ''});
}
