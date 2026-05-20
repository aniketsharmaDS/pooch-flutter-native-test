import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/Tabs/app_default_tab_bar.dart';
import 'package:poochcare/features/invites/domain/models/invite_list_filter.dart';
import 'package:poochcare/features/invites/domain/models/invite_status_filter.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_bloc/invite_bloc.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_bloc/invite_event.dart';
import 'package:poochcare/features/invites/widgets/filter_pop_up_menu_button.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class NetworkInvitesScreen extends StatefulWidget implements AutoRouteWrapper {
  const NetworkInvitesScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => getIt<InviteBloc>(), child: this);
  }

  @override
  State<NetworkInvitesScreen> createState() => _NetworkInvitesScreenState();
}

class _NetworkInvitesScreenState extends State<NetworkInvitesScreen> {
  InviteListFilter? _selectedFilter;
  InviteStatusFilter? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF2EDDD),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppRadiusSize.r16),
          topLeft: Radius.circular(AppRadiusSize.r16),
        ),
      ),
      child: Stack(
        children: [
          AppDefaultRouteTabs(
            isScrollable: true,
            labelPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s25,
            ),
            tabNames: const ['All', 'Sent', 'Received'],
            routes: const [
              NetworkAllInvitesRoute(),
              NetworkSentInvitesRoute(),
              NetworkReceivedInvitesRoute(),
            ],
            onTabChanged: (index) {
              final filter = _resolveFilterForIndex(index);
              if (_selectedFilter != filter) {
                _selectedFilter = filter;
                context.read<InviteBloc>().add(
                  GetMyNetworkInvitationsEvent(
                    filter: filter,
                    status: _selectedStatus,
                  ),
                );
              }
            },
          ),
          FilterPopUpMenuButton(
            isActive: _selectedStatus != null,
            onStatusSelected: (status) {
              setState(() {
                _selectedStatus = status;
              });
              final filter = _selectedFilter ?? InviteListFilter.all;
              context.read<InviteBloc>().add(
                GetMyNetworkInvitationsEvent(
                  filter: filter,
                  status: status,
                  forceRefresh: true,
                ),
              );
            },
            onReset: () {
              if (_selectedStatus == null) {
                return;
              }
              setState(() {
                _selectedStatus = null;
              });
              final filter = _selectedFilter ?? InviteListFilter.all;
              context.read<InviteBloc>().add(
                GetMyNetworkInvitationsEvent(
                  filter: filter,
                  forceRefresh: true,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  InviteListFilter _resolveFilterForIndex(int index) {
    switch (index) {
      case 1:
        return InviteListFilter.sent;
      case 2:
        return InviteListFilter.received;
      case 0:
      default:
        return InviteListFilter.all;
    }
  }
}
