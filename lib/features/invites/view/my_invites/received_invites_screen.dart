import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/features/invites/domain/models/invite_list_filter.dart';
import 'package:poochcare/features/invites/view/my_invites/my_invites_list_view.dart';

@RoutePage()
class ReceivedInvitesScreen extends StatefulWidget {
  const ReceivedInvitesScreen({super.key});

  @override
  State<ReceivedInvitesScreen> createState() => _ReceivedInvitesScreenState();
}

class _ReceivedInvitesScreenState extends State<ReceivedInvitesScreen> {
  @override
  Widget build(BuildContext context) {
    return const MyInvitesListView(filter: InviteListFilter.received);
  }
}
