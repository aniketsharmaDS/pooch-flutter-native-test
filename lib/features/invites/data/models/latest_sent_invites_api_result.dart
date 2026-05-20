import 'package:poochcare/features/invites/data/models/latest_sent_invites_response.dart';

class LatestSentInvitesApiResult {
  const LatestSentInvitesApiResult({required this.data, required this.message});

  final LatestSentInvitesResponse data;
  final String message;
}
