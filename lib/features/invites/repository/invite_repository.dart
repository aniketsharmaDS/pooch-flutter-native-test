import 'package:poochcare/features/invites/data/api/invite_api_service.dart';
import 'package:poochcare/features/invites/data/models/invitation_decision_api_result.dart';
import 'package:poochcare/features/invites/data/models/invitations_overview_response.dart';
import 'package:poochcare/features/invites/data/models/invite_action_api_result.dart';
import 'package:poochcare/features/invites/data/models/invite_share_api_result.dart';
import 'package:poochcare/features/invites/data/models/latest_sent_invites_api_result.dart';
import 'package:poochcare/features/invites/domain/models/invite_list_filter.dart';
import 'package:poochcare/features/invites/domain/models/invite_status_filter.dart';

class InviteRepository {
  InviteRepository(this._api);

  final InviteApiService _api;

  Future<InviteShareApiResult> shareParentGroupInvite({
    required String parentGroupId,
    required String targetUserEmailOrPhone,
    required String role,
    String? countryCode,
    String? nickname,
  }) {
    return _api.shareParentGroupInvite(
      parentGroupId: parentGroupId,
      targetUserEmailOrPhone: targetUserEmailOrPhone,
      role: role,
      countryCode: countryCode,
      nickname: nickname,
    );
  }

  Future<InvitationsOverviewResponse> getMyInvitations({
    required InviteListFilter filter,
    bool forceRefresh = false,
    InviteStatusFilter? status,
    int? page,
  }) async {
    final response = await _api.getMyInvitations(
      filter: filter,
      status: status,
      page: page,
    );
    return response;
  }

  Future<InvitationsOverviewResponse> getMyNetworkInvites({
    required InviteListFilter filter,
    InviteStatusFilter? status,
    int? page,
  }) {
    return _api.getMyNetworkInvites(filter: filter, status: status, page: page);
  }

  Future<LatestSentInvitesApiResult> getLatestSentInvites() {
    return _api.getLatestSentInvites();
  }

  Future<InviteActionApiResult> removeInvitation({
    required String parentGroupId,
    required String invitationId,
  }) {
    return _api.removeInvitation(
      parentGroupId: parentGroupId,
      invitationId: invitationId,
    );
  }

  Future<InviteActionApiResult> sendReminder({required String invitationId}) {
    return _api.sendReminder(invitationId: invitationId);
  }

  Future<InviteActionApiResult> removeMemberAccess({
    required String parentGroupId,
    required String targetUserId,
  }) {
    return _api.removeMemberAccess(
      parentGroupId: parentGroupId,
      targetUserId: targetUserId,
    );
  }

  Future<InvitationDecisionApiResult> acceptInvitation({
    required String invitationId,
  }) {
    return _api.acceptInvitation(invitationId: invitationId);
  }

  Future<InviteActionApiResult> acceptInvitationByCode({
    required String invitationCode,
    String? email,
  }) {
    return _api.acceptInvitationByCode(
      invitationCode: invitationCode,
      email: email,
    );
  }

  Future<InvitationDecisionApiResult> rejectInvitation({
    required String invitationId,
  }) {
    return _api.rejectInvitation(invitationId: invitationId);
  }

  Future<InviteActionApiResult> leaveParentGroup({
    required String parentGroupId,
    required String invitationId,
  }) {
    return _api.leaveParentGroup(
      parentGroupId: parentGroupId,
      invitationId: invitationId,
    );
  }
}
