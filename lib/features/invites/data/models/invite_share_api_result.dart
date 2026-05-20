import 'package:poochcare/features/invites/data/models/invite_share_response.dart';

class InviteShareApiResult {
  const InviteShareApiResult({required this.data, required this.message});

  final InviteShareResponse data;
  final String message;
}
