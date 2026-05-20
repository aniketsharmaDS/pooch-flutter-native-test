import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'tips_comment_info_model.mapper.dart';

/// =====================
/// COMMENT MODEL (Unified)
/// =====================
@MappableClass()
class TipsCommentInfoModel with TipsCommentInfoModelMappable {
  const TipsCommentInfoModel({
    this.id = '',
    this.tipId = '',
    this.userId = '',
    this.parentCommentId,
    this.comment = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.user,
    this.isCurrentUser = false,
    this.messageStatus = 'posted', // 'posted', 'pending', 'failed'
    // Optional (only in full comments API)
    this.hasReplies,
    this.replyCount,
    this.replies = const [], // 👈 important
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String tipId;

  @MappableField(hook: SafeStringHook())
  final String userId;

  final String? parentCommentId;

  @MappableField(hook: SafeStringHook())
  final String comment;

  @MappableField(hook: SafeStringHook())
  final String createdAt;

  @MappableField(hook: SafeStringHook())
  final String updatedAt;

  final TipsCommentUserInfo? user;

  final bool isCurrentUser;

  /// Present only in full comments API
  final bool? hasReplies;

  /// Present only in full comments API
  @MappableField(hook: SafeIntHook())
  final int? replyCount;

  @MappableField(hook: SafeStringHook(defaultValue: 'posted'))
  final String messageStatus;

  @MappableField(hook: SafeListHook<TipsCommentInfoModel>())
  final List<TipsCommentInfoModel> replies;
}

/// =====================
/// COMMENT USER
/// =====================
@MappableClass()
class TipsCommentUserInfo with TipsCommentUserInfoMappable {
  const TipsCommentUserInfo({
    this.id = '',
    this.name = '',
    this.email = '',
    this.phone,
    this.countryCode,
    this.profile,
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String name;

  @MappableField(hook: SafeStringHook())
  final String email;

  /// Only in full comments API
  final String? phone;

  /// Only in full comments API
  final String? countryCode;

  final TipsCommentUserProfile? profile;
}

/// =====================
/// USER PROFILE
/// =====================
@MappableClass()
class TipsCommentUserProfile with TipsCommentUserProfileMappable {
  const TipsCommentUserProfile({this.profilePicture});

  final String? profilePicture;
}
