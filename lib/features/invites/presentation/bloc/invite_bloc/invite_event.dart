import 'package:equatable/equatable.dart';
import 'package:poochcare/features/invites/domain/models/invite_list_filter.dart';
import 'package:poochcare/features/invites/domain/models/invite_list_scope.dart';
import 'package:poochcare/features/invites/domain/models/invite_status_filter.dart';
import 'package:poochcare/features/invites/domain/models/invite_type.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_action_cubit/invite_action_state.dart';

sealed class InviteEvent extends Equatable {
  const InviteEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class InviteParentEvent extends InviteEvent {
  const InviteParentEvent({
    required this.inviteType,
    required this.targetUserEmailOrPhone,
    this.countryCode,
    this.nickname,
    required this.parentGroupId,
  });

  final InviteType inviteType;
  final String targetUserEmailOrPhone;
  final String? countryCode;
  final String? nickname;
  final String parentGroupId;

  @override
  List<Object?> get props => <Object?>[
    inviteType,
    targetUserEmailOrPhone,
    countryCode,
    nickname,
    parentGroupId,
  ];
}

class GetMyInvitationsEvent extends InviteEvent {
  const GetMyInvitationsEvent({
    required this.filter,
    this.status,
    this.page,
    this.forceRefresh = false,
  });

  final InviteListFilter filter;
  final InviteStatusFilter? status;
  final int? page;
  final bool forceRefresh;

  @override
  List<Object?> get props => <Object?>[filter, status, page, forceRefresh];
}

class GetLatestSentInvitesEvent extends InviteEvent {
  const GetLatestSentInvitesEvent({this.forceRefresh = false});

  final bool forceRefresh;

  @override
  List<Object?> get props => <Object?>[forceRefresh];
}

class GetMyNetworkInvitationsEvent extends InviteEvent {
  const GetMyNetworkInvitationsEvent({
    required this.filter,
    this.status,
    this.page,
    this.forceRefresh = false,
  });

  final InviteListFilter filter;
  final InviteStatusFilter? status;
  final int? page;
  final bool forceRefresh;

  @override
  List<Object?> get props => <Object?>[filter, status, page, forceRefresh];
}

class ApplyInviteActionEvent extends InviteEvent {
  const ApplyInviteActionEvent({
    required this.action,
    required this.invitationId,
    this.scope = InviteListScope.myInvites,
  });

  final InviteActionType action;
  final String invitationId;
  final InviteListScope scope;

  @override
  List<Object?> get props => <Object?>[action, invitationId, scope];
}

class AcceptInviteByCodeEvent extends InviteEvent {
  const AcceptInviteByCodeEvent({required this.invitationCode, this.email});

  final String invitationCode;
  final String? email;

  @override
  List<Object?> get props => <Object?>[invitationCode, email];
}
