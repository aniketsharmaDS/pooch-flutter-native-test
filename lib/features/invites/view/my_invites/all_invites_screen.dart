import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/features/invites/domain/models/invite_list_filter.dart';
import 'package:poochcare/features/invites/view/my_invites/my_invites_list_view.dart';

@RoutePage()
class AllInvitesScreen extends StatefulWidget {
  const AllInvitesScreen({super.key});

  @override
  State<AllInvitesScreen> createState() => _AllInvitesScreenState();
}

class _AllInvitesScreenState extends State<AllInvitesScreen> {
  @override
  Widget build(BuildContext context) {
    return const MyInvitesListView(filter: InviteListFilter.all);
  }
}
