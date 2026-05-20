import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'invite_share_response.mapper.dart';

@MappableClass()
class InviteShareInvitationResponse with InviteShareInvitationResponseMappable {
  const InviteShareInvitationResponse({
    this.id = '',
    this.inviteePhone = '',
    this.targetContact = '',
    this.contactType = '',
    this.assignedRole = '',
    this.roleDisplayName = '',
    this.isNetworkInvite = false,
    this.networkInviteType = '',
    this.status = '',
    this.expiresAt = '',
    this.inviteLink = '',
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String inviteePhone;

  @MappableField(hook: SafeStringHook())
  final String targetContact;

  @MappableField(hook: SafeStringHook())
  final String contactType;

  @MappableField(hook: SafeStringHook())
  final String assignedRole;

  @MappableField(hook: SafeStringHook())
  final String roleDisplayName;

  @MappableField(hook: SafeBoolHook())
  final bool isNetworkInvite;

  @MappableField(hook: SafeStringHook())
  final String networkInviteType;

  @MappableField(hook: SafeStringHook())
  final String status;

  @MappableField(hook: SafeStringHook())
  final String expiresAt;

  @MappableField(hook: SafeStringHook())
  final String inviteLink;
}

@MappableClass()
class InviteShareResponse with InviteShareResponseMappable {
  const InviteShareResponse({
    this.parentGroupId = '',
    this.type = '',
    this.invitation = const InviteShareInvitationResponse(),
    this.sharedBy = '',
    this.invitedAt = '',
  });

  @MappableField(hook: SafeStringHook())
  final String parentGroupId;

  @MappableField(hook: SafeStringHook())
  final String type;

  final InviteShareInvitationResponse invitation;

  @MappableField(hook: SafeStringHook())
  final String sharedBy;

  @MappableField(hook: SafeStringHook())
  final String invitedAt;
}
