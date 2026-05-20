import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'invitations_overview_response.mapper.dart';

@MappableClass()
class InviteParentGroupResponse with InviteParentGroupResponseMappable {
  const InviteParentGroupResponse({
    this.id = '',
    this.houseName = '',
    this.parentName = '',
    this.createdBy = '',
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String houseName;

  @MappableField(hook: SafeStringHook())
  final String parentName;

  @MappableField(hook: SafeStringHook())
  final String createdBy;
}

@MappableClass()
class InviteUserResponse with InviteUserResponseMappable {
  const InviteUserResponse({
    this.id = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.gender = '',
    this.age = 0,
    this.profilePictureUrl,
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String name;

  @MappableField(hook: SafeStringHook())
  final String email;

  @MappableField(hook: SafeStringHook())
  final String phone;

  @MappableField(hook: SafeStringHook())
  final String gender;

  @MappableField(hook: SafeIntHook())
  final int age;

  @MappableField(key: 'profilePictureUrl', hook: SafeStringHook())
  final String? profilePictureUrl;
}

@MappableClass()
class InviteeResponse with InviteeResponseMappable {
  const InviteeResponse({
    this.id = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.gender = '',
    this.age = 0,
    this.type = '',
    this.profilePictureUrl = '',
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String name;

  @MappableField(hook: SafeStringHook())
  final String email;

  @MappableField(hook: SafeStringHook())
  final String phone;

  @MappableField(hook: SafeStringHook())
  final String gender;

  @MappableField(hook: SafeIntHook())
  final int age;

  @MappableField(hook: SafeStringHook())
  final String type;

  @MappableField(hook: SafeStringHook())
  final String profilePictureUrl;
}

@MappableClass()
class InviteItemResponse with InviteItemResponseMappable {
  const InviteItemResponse({
    this.id = '',
    this.parentGroupId = '',
    this.parentGroup = const InviteParentGroupResponse(),
    this.inviter = const InviteUserResponse(),
    this.invitee = const InviteeResponse(),
    this.status = '',
    this.invitedAt = '',
    this.respondedAt = '',
    this.expiresAt = '',
    this.isExpired = false,
    this.inviteLink = '',
    this.invitationType = '',
    this.assignedRole = '',
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String parentGroupId;

  final InviteParentGroupResponse parentGroup;

  final InviteUserResponse inviter;

  final InviteeResponse invitee;

  @MappableField(hook: SafeStringHook())
  final String status;

  @MappableField(hook: SafeStringHook())
  final String invitedAt;

  @MappableField(hook: SafeStringHook())
  final String respondedAt;

  @MappableField(hook: SafeStringHook())
  final String expiresAt;

  @MappableField(hook: SafeBoolHook())
  final bool isExpired;

  @MappableField(hook: SafeStringHook())
  final String inviteLink;

  @MappableField(hook: SafeStringHook())
  final String invitationType;

  @MappableField(hook: SafeStringHook())
  final String assignedRole;
}

@MappableClass()
class InvitationsOverviewResponse with InvitationsOverviewResponseMappable {
  const InvitationsOverviewResponse({
    this.userId = '',
    this.userIdentifier = '',
    this.invitations = const <InviteItemResponse>[],
    this.pagination = const InvitePaginationResponse(),
  });

  @MappableField(hook: SafeStringHook())
  final String userId;

  @MappableField(hook: SafeStringHook())
  final String userIdentifier;

  final List<InviteItemResponse> invitations;

  final InvitePaginationResponse pagination;
}

@MappableClass()
class InvitePaginationResponse with InvitePaginationResponseMappable {
  const InvitePaginationResponse({
    this.page = 0,
    this.limit = 0,
    this.total = 0,
    this.totalPages = 0,
    this.hasNextPage = false,
    this.hasPrevPage = false,
  });

  @MappableField(hook: SafeIntHook())
  final int page;

  @MappableField(hook: SafeIntHook())
  final int limit;

  @MappableField(hook: SafeIntHook())
  final int total;

  @MappableField(hook: SafeIntHook())
  final int totalPages;

  @MappableField(hook: SafeBoolHook())
  final bool hasNextPage;

  @MappableField(hook: SafeBoolHook())
  final bool hasPrevPage;
}
