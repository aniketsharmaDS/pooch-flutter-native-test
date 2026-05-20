import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/features/invites/domain/models/invite_list_filter.dart';
import 'package:poochcare/features/invites/domain/models/invite_list_scope.dart';
import 'package:poochcare/features/invites/view/my_invites/my_invites_list_view.dart';

@RoutePage()
class NetworkReceivedInvitesScreen extends StatefulWidget {
  const NetworkReceivedInvitesScreen({super.key});

  @override
  State<NetworkReceivedInvitesScreen> createState() =>
      _NetworkReceivedInvitesScreenState();
}

class _NetworkReceivedInvitesScreenState
    extends State<NetworkReceivedInvitesScreen> {
  @override
  Widget build(BuildContext context) {
    return const MyInvitesListView(
      listScope: InviteListScope.networkInvites,
      filter: InviteListFilter.received,
    );
  }
}
