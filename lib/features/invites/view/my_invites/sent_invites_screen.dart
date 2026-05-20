import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/features/invites/domain/models/invite_list_filter.dart';
import 'package:poochcare/features/invites/view/my_invites/my_invites_list_view.dart';

@RoutePage()
class SentInvitesScreen extends StatefulWidget {
  const SentInvitesScreen({super.key});

  @override
  State<SentInvitesScreen> createState() => _SentInvitesScreenState();
}

class _SentInvitesScreenState extends State<SentInvitesScreen> {
  @override
  Widget build(BuildContext context) {
    return const MyInvitesListView(filter: InviteListFilter.sent);
  }
}
