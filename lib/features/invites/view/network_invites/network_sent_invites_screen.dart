import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/features/invites/domain/models/invite_list_filter.dart';
import 'package:poochcare/features/invites/domain/models/invite_list_scope.dart';
import 'package:poochcare/features/invites/view/my_invites/my_invites_list_view.dart';

@RoutePage()
class NetworkSentInvitesScreen extends StatefulWidget {
  const NetworkSentInvitesScreen({super.key});

  @override
  State<NetworkSentInvitesScreen> createState() =>
      _NetworkSentInvitesScreenState();
}

class _NetworkSentInvitesScreenState extends State<NetworkSentInvitesScreen> {
  @override
  Widget build(BuildContext context) {
    return const MyInvitesListView(
      listScope: InviteListScope.networkInvites,
      filter: InviteListFilter.sent,
    );
  }
}
