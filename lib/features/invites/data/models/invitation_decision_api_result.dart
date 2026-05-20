import 'package:poochcare/features/invites/data/models/invitation_decision_response.dart';

class InvitationDecisionApiResult {
  const InvitationDecisionApiResult({
    required this.data,
    required this.message,
  });

  final InvitationDecisionResponse data;
  final String message;
}
