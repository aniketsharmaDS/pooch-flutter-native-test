import 'package:poochcare/core/utils/safe_parser_service.dart';

// 1. Root Response Model
class NotificationResponse {
  final bool success;
  final String message;
  final int status;
  final NotificationData? data;

  NotificationResponse({
    required this.success,
    required this.message,
    required this.status,
    this.data,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      success: SafeParserService.parseBool(json['success']),
      message: SafeParserService.parseString(json['message']),
      status: SafeParserService.parseInt(json['status']),
      data: SafeParserService.parseMap(json['data']).isNotEmpty
          ? NotificationData.fromJson(SafeParserService.parseMap(json['data']))
          : null,
    );
  }
}

// 2. Data Wrapper Model
class NotificationData {
  final List<Notification> notifications;
  final PaginationInfo pagination;

  NotificationData({required this.notifications, required this.pagination});

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      notifications: SafeParserService.parseList(
        json['notifications'],
        fromJson: (item) =>
            Notification.fromJson(SafeParserService.parseMap(item)),
      ),
      pagination: PaginationInfo.fromJson(
        SafeParserService.parseMap(json['pagination']),
      ),
    );
  }
}

// 3. Individual Notification Model
class Notification {
  final String id;
  final String userId;
  final String type;
  final String titleKey;
  final String messageKey;
  final Map<String, dynamic> titleParams;
  final Map<String, dynamic> messageParams;
  final Map<String, dynamic> data;
  final bool isRead;
  final DateTime? readAt;
  final DateTime sentAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Notification({
    required this.id,
    required this.userId,
    required this.type,
    required this.titleKey,
    required this.messageKey,
    required this.titleParams,
    required this.messageParams,
    required this.data,
    required this.isRead,
    this.readAt,
    required this.sentAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: SafeParserService.parseString(json['id']),
      userId: SafeParserService.parseString(json['userId']),
      type: SafeParserService.parseString(json['type']),
      titleKey: SafeParserService.parseString(json['titleKey']),
      messageKey: SafeParserService.parseString(json['messageKey']),
      titleParams: SafeParserService.parseMap(json['titleParams']),
      messageParams: SafeParserService.parseMap(json['messageParams']),
      data: SafeParserService.parseMap(json['data']),
      isRead: SafeParserService.parseBool(json['isRead']),
      readAt: SafeParserService.parseDateTime(json['readAt']),
      sentAt: SafeParserService.parseDateTime(json['sentAt']) ?? DateTime.now(),
      createdAt:
          SafeParserService.parseDateTime(json['createdAt']) ?? DateTime.now(),
      updatedAt:
          SafeParserService.parseDateTime(json['updatedAt']) ?? DateTime.now(),
    );
  }
}

// 4. Pagination Model
class PaginationInfo {
  final int total;
  final int page;
  final int limit;
  final int pages;

  PaginationInfo({
    required this.total,
    required this.page,
    required this.limit,
    required this.pages,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    return PaginationInfo(
      total: SafeParserService.parseInt(json['total']),
      page: SafeParserService.parseInt(json['page']),
      limit: SafeParserService.parseInt(json['limit']),
      pages: SafeParserService.parseInt(json['pages']),
    );
  }
}
