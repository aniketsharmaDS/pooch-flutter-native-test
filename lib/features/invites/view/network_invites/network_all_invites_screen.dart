import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/features/invites/domain/models/invite_list_filter.dart';
import 'package:poochcare/features/invites/domain/models/invite_list_scope.dart';
import 'package:poochcare/features/invites/view/my_invites/my_invites_list_view.dart';

@RoutePage()
class NetworkAllInvitesScreen extends StatefulWidget {
  const NetworkAllInvitesScreen({super.key});

  @override
  State<NetworkAllInvitesScreen> createState() =>
      _NetworkAllInvitesScreenState();
}

class _NetworkAllInvitesScreenState extends State<NetworkAllInvitesScreen> {
  @override
  Widget build(BuildContext context) {
    return const MyInvitesListView(
      listScope: InviteListScope.networkInvites,
      filter: InviteListFilter.all,
    );
  }
}
