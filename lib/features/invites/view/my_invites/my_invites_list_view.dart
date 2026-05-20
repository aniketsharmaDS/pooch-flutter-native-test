import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/list_items/invitation_card/invitation_card.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/invites/data/models/invitations_overview_response.dart';
import 'package:poochcare/features/invites/domain/models/invite_list_filter.dart';
import 'package:poochcare/features/invites/domain/models/invite_list_scope.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_action_cubit/invite_action_cubit.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_bloc/invite_bloc.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_bloc/invite_event.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_bloc/invite_state.dart';
import 'package:poochcare/features/invites/repository/invite_repository.dart';

class MyInvitesListView extends StatelessWidget {
  const MyInvitesListView({
    super.key,
    required this.filter,
    this.listScope = InviteListScope.myInvites,
  });

  final InviteListFilter filter;
  final InviteListScope listScope;

  Future<void> _onRefresh(BuildContext context) async {
    final bloc = context.read<InviteBloc>();
    if (listScope == InviteListScope.networkInvites) {
      bloc.add(
        GetMyNetworkInvitationsEvent(
          filter: filter,
          status: bloc.state.networkInvitesStatusFilter,
          forceRefresh: true,
        ),
      );
      await bloc.stream.firstWhere(
        (state) => state.networkInvitesStatus != NetworkInvitesStatus.loading,
      );
      return;
    }

    bloc.add(
      GetMyInvitationsEvent(
        filter: filter,
        status: bloc.state.myInvitesStatusFilter,
        forceRefresh: true,
      ),
    );
    await bloc.stream.firstWhere(
      (state) => state.myInvitesStatus != MyInvitesStatus.loading,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InviteBloc, InviteState>(
      buildWhen: (previous, current) => listScope == InviteListScope.myInvites
          ? (previous.myInvitesStatus != current.myInvitesStatus ||
                previous.invitationsOverview != current.invitationsOverview ||
                previous.myInvitesErrorMessage != current.myInvitesErrorMessage)
          : (previous.networkInvitesStatus != current.networkInvitesStatus ||
                previous.networkInvitationsOverview !=
                    current.networkInvitationsOverview ||
                previous.networkInvitesErrorMessage !=
                    current.networkInvitesErrorMessage),
      builder: (context, state) {
        // final status = state.myInvitesStatus;
        final content = _buildContent(context, state, filter, listScope);
        return RefreshIndicator(
          onRefresh: () => _onRefresh(context),
          child: content,
        );
      },
    );
  }
}

Widget _buildContent(
  BuildContext context,
  InviteState state,
  InviteListFilter filter,
  InviteListScope listScope,
) {
  final isLoading = listScope == InviteListScope.myInvites
      ? state.myInvitesStatus == MyInvitesStatus.loading
      : state.networkInvitesStatus == NetworkInvitesStatus.loading;

  final isInitial = listScope == InviteListScope.myInvites
      ? state.myInvitesStatus == MyInvitesStatus.initial
      : state.networkInvitesStatus == NetworkInvitesStatus.initial;

  final activeFilter = listScope == InviteListScope.myInvites
      ? state.myInvitesFilter
      : state.networkInvitesFilter;

  final errorMessage = listScope == InviteListScope.myInvites
      ? state.myInvitesErrorMessage
      : state.networkInvitesErrorMessage;

  final invitationOverview = listScope == InviteListScope.myInvites
      ? state.invitationsOverview
      : state.networkInvitationsOverview;

  if (isLoading && activeFilter == filter) {
    return _buildScrollableMessage(const CircularProgressIndicator());
  }

  if ((isInitial || isLoading) && invitationOverview == null) {
    return _buildScrollableMessage(const CircularProgressIndicator());
  }

  if (!isLoading && invitationOverview == null) {
    return _buildScrollableMessage(
      _EmptyMessage(
        message: errorMessage ?? 'Unable to load invites. Please try again.',
      ),
    );
  }

  final overview = invitationOverview;
  if (overview == null) {
    return _buildScrollableMessage(const CircularProgressIndicator());
  }

  final items = _filterInvites(overview, filter);
  if (items.isEmpty) {
    return _buildScrollableMessage(
      const _EmptyMessage(message: 'No invites found.'),
    );
  }

  return ListView.builder(
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s11),
    physics: const AlwaysScrollableScrollPhysics(),
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];
      final isSent = _resolveIsSent(item, overview.userId);
      return Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.s16),
        child: BlocProvider(
          create: (context) => InviteActionCubit(
            repository: getIt<InviteRepository>(),
            invitation: _buildInvitation(item, isSent),
          ),
          child: InvitationCard(
            listScope: listScope,
            invitation: _buildInvitation(item, isSent),
          ),
        ),
      );
    },
  );
}

Widget _buildScrollableMessage(Widget child) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s11),
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(child: child),
          ),
        ],
      );
    },
  );
}

class _EmptyMessage extends StatelessWidget {
  const _EmptyMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppText.bodyM(
        message,
        color: const Color(0xFF8C6B15),
        textAlign: TextAlign.center,
      ),
    );
  }
}

List<InviteItemResponse> _filterInvites(
  InvitationsOverviewResponse overview,
  InviteListFilter filter,
) {
  final all = overview.invitations;

  if (filter == InviteListFilter.all) {
    return all;
  }

  final userId = overview.userId;
  return all.where((item) {
    final isSent = _resolveIsSent(item, userId);
    if (filter == InviteListFilter.sent) {
      return isSent == true;
    }
    if (filter == InviteListFilter.received) {
      return isSent == false;
    }
    return false;
  }).toList();
}

bool? _resolveIsSent(InviteItemResponse item, String userId) {
  final normalizedUserId = userId.trim();
  if (normalizedUserId.isNotEmpty) {
    final inviterId = item.inviter.id.trim();
    final inviteeId = item.invitee.id.trim();
    if (inviterId.isNotEmpty || inviteeId.isNotEmpty) {
      if (inviterId == normalizedUserId) {
        return true;
      }
      if (inviteeId == normalizedUserId) {
        return false;
      }
    }
  }

  final type = item.invitationType.trim().toLowerCase();
  if (type == 'sent' || type == 'outgoing') {
    return true;
  }
  if (type == 'received' || type == 'incoming') {
    return false;
  }

  return null;
}

Invitation _buildInvitation(InviteItemResponse item, bool? isSentOverride) {
  final isSent = isSentOverride ?? true;
  final displayUser = _resolveDisplayUser(item, isSent);
  final ageGender = _buildAgeGender(displayUser.age, displayUser.gender);
  final role = _formatRole(item.assignedRole);
  final isAccepted = item.status.trim().toLowerCase() == 'accepted';
  final petName = item.parentGroup.houseName.trim().isNotEmpty
      ? item.parentGroup.houseName.trim()
      : 'House';
  final imageUrl = isSent
      ? item.invitee.profilePictureUrl
      : item.inviter.profilePictureUrl;

  return Invitation(
    inviteeUserId: item.invitee.id,
    id: item.id,
    parentGroupId: item.parentGroup.id,
    isRequestSent: isSent,
    isAccepted: isAccepted,
    useButterflyImage: true,
    petName: petName,
    userName: _buildDisplayName(displayUser),
    ageGender: ageGender,
    role: role,
    imageUrl: imageUrl ?? '',
  );
}

_DisplayUser _resolveDisplayUser(InviteItemResponse item, bool isSent) {
  final primary = isSent
      ? _displayUserFromInvitee(item.invitee)
      : _displayUserFromInviter(item.inviter);
  final fallback = isSent
      ? _displayUserFromInviter(item.inviter)
      : _displayUserFromInvitee(item.invitee);

  if (primary.name.trim().isNotEmpty ||
      primary.email.trim().isNotEmpty ||
      primary.phone.trim().isNotEmpty) {
    return primary;
  }
  return fallback;
}

_DisplayUser _displayUserFromInviter(InviteUserResponse user) {
  return _DisplayUser(
    name: user.name,
    email: user.email,
    phone: user.phone,
    age: user.age,
    gender: user.gender,
  );
}

_DisplayUser _displayUserFromInvitee(InviteeResponse user) {
  return _DisplayUser(
    name: user.name,
    email: user.email,
    phone: user.phone,
    age: user.age,
    gender: user.gender,
  );
}

String _buildDisplayName(_DisplayUser user) {
  final name = user.name.trim();
  if (name.isNotEmpty) {
    return name;
  }
  final email = user.email.trim();
  if (email.isNotEmpty) {
    return email;
  }
  final phone = user.phone.trim();
  if (phone.isNotEmpty) {
    return phone;
  }
  return 'Unknown';
}

String _buildAgeGender(int age, String gender) {
  final normalizedGender = gender.trim();
  final hasAge = age > 0;
  final hasGender = normalizedGender.isNotEmpty;

  if (hasAge && hasGender) {
    return '$age, ${_formatGender(normalizedGender)}';
  }
  if (hasAge) {
    return '$age';
  }
  if (hasGender) {
    return _formatGender(normalizedGender);
  }
  return '';
}

String _formatGender(String gender) {
  final normalized = gender.toLowerCase();
  if (normalized == 'female') {
    return 'Female';
  }
  if (normalized == 'male') {
    return 'Male';
  }
  if (normalized == 'other') {
    return 'Other';
  }
  return gender;
}

String _formatRole(String role) {
  final normalized = role.trim().toLowerCase();
  if (normalized == 'co_parent' || normalized == 'co-parent') {
    return 'Co-Parent';
  }
  if (normalized == 'parent') {
    return 'Parent';
  }
  if (normalized.isEmpty) {
    return 'Co-Parent';
  }
  return role;
}

class _DisplayUser {
  const _DisplayUser({
    required this.name,
    required this.email,
    required this.phone,
    required this.age,
    required this.gender,
  });

  final String name;
  final String email;
  final String phone;
  final int age;
  final String gender;
}
