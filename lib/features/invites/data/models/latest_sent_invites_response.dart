import 'package:poochcare/features/invites/data/models/invitations_overview_response.dart';

class LatestSentInvitesResponse {
  const LatestSentInvitesResponse({
    this.userId = '',
    this.latestParentInvite,
    this.latestCoParentInvite,
  });

  final String userId;
  final InviteItemResponse? latestParentInvite;
  final InviteItemResponse? latestCoParentInvite;

  factory LatestSentInvitesResponse.fromMap(Map<String, dynamic> map) {
    final dynamic latestParentInviteRaw = map['latestParentInvite'];
    final dynamic latestCoParentInviteRaw = map['latestCoParentInvite'];

    return LatestSentInvitesResponse(
      userId: _string(map['userId']),
      latestParentInvite: latestParentInviteRaw is Map<String, dynamic>
          ? InviteItemResponseMapper.fromMap(latestParentInviteRaw)
          : null,
      latestCoParentInvite: latestCoParentInviteRaw is Map<String, dynamic>
          ? InviteItemResponseMapper.fromMap(latestCoParentInviteRaw)
          : null,
    );
  }
}

String _string(dynamic value) =>
    value is String ? value : (value ?? '').toString();
