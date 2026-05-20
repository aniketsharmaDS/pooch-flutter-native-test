import 'package:equatable/equatable.dart';
import 'package:poochcare/features/invites/data/models/invitations_overview_response.dart';
import 'package:poochcare/features/invites/data/models/latest_sent_invites_response.dart';
import 'package:poochcare/features/invites/domain/models/invite_list_filter.dart';
import 'package:poochcare/features/invites/domain/models/invite_status_filter.dart';

enum InviteStatus { initial, loading, success, failure }

enum MyInvitesStatus { initial, loading, success, failure }

enum LatestSentInvitesStatus { initial, loading, success, failure }

enum NetworkInvitesStatus { initial, loading, success, failure }

class InviteState extends Equatable {
  const InviteState({
    this.status = InviteStatus.initial,
    this.successMessage,
    this.errorMessage,
    this.myInvitesStatus = MyInvitesStatus.initial,
    this.myInvitesFilter = InviteListFilter.all,
    this.myInvitesStatusFilter,
    this.invitationsOverview,
    this.myInvitesErrorMessage,
    this.latestSentInvitesStatus = LatestSentInvitesStatus.initial,
    this.latestSentInvites,
    this.latestSentInvitesErrorMessage,
    this.networkInvitesStatus = NetworkInvitesStatus.initial,
    this.networkInvitesFilter = InviteListFilter.all,
    this.networkInvitesStatusFilter,
    this.networkInvitationsOverview,
    this.networkInvitesErrorMessage,
  });

  final InviteStatus status;
  final String? successMessage;
  final String? errorMessage;
  final MyInvitesStatus myInvitesStatus;
  final InviteListFilter myInvitesFilter;
  final InviteStatusFilter? myInvitesStatusFilter;
  final InvitationsOverviewResponse? invitationsOverview;
  final String? myInvitesErrorMessage;
  final LatestSentInvitesStatus latestSentInvitesStatus;
  final LatestSentInvitesResponse? latestSentInvites;
  final String? latestSentInvitesErrorMessage;
  final NetworkInvitesStatus networkInvitesStatus;
  final InviteListFilter networkInvitesFilter;
  final InviteStatusFilter? networkInvitesStatusFilter;
  final InvitationsOverviewResponse? networkInvitationsOverview;
  final String? networkInvitesErrorMessage;

  InviteState copyWith({
    InviteStatus? status,
    String? successMessage,
    String? errorMessage,
    bool clearSuccess = false,
    bool clearError = false,
    MyInvitesStatus? myInvitesStatus,
    InviteListFilter? myInvitesFilter,
    InviteStatusFilter? myInvitesStatusFilter,
    InvitationsOverviewResponse? invitationsOverview,
    String? myInvitesErrorMessage,
    bool clearMyInvitesError = false,
    LatestSentInvitesStatus? latestSentInvitesStatus,
    LatestSentInvitesResponse? latestSentInvites,
    String? latestSentInvitesErrorMessage,
    bool clearLatestSentInvitesError = false,
    NetworkInvitesStatus? networkInvitesStatus,
    InviteListFilter? networkInvitesFilter,
    InviteStatusFilter? networkInvitesStatusFilter,
    InvitationsOverviewResponse? networkInvitationsOverview,
    String? networkInvitesErrorMessage,
    bool clearNetworkInvitesError = false,
  }) {
    return InviteState(
      status: status ?? this.status,
      successMessage: clearSuccess
          ? null
          : (successMessage ?? this.successMessage),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      myInvitesStatus: myInvitesStatus ?? this.myInvitesStatus,
      myInvitesFilter: myInvitesFilter ?? this.myInvitesFilter,
      myInvitesStatusFilter:
          myInvitesStatusFilter ?? this.myInvitesStatusFilter,
      invitationsOverview: invitationsOverview ?? this.invitationsOverview,
      myInvitesErrorMessage: clearMyInvitesError
          ? null
          : (myInvitesErrorMessage ?? this.myInvitesErrorMessage),
      latestSentInvitesStatus:
          latestSentInvitesStatus ?? this.latestSentInvitesStatus,
      latestSentInvites: latestSentInvites ?? this.latestSentInvites,
      latestSentInvitesErrorMessage: clearLatestSentInvitesError
          ? null
          : (latestSentInvitesErrorMessage ??
                this.latestSentInvitesErrorMessage),
      networkInvitesStatus: networkInvitesStatus ?? this.networkInvitesStatus,
      networkInvitesFilter: networkInvitesFilter ?? this.networkInvitesFilter,
      networkInvitesStatusFilter:
          networkInvitesStatusFilter ?? this.networkInvitesStatusFilter,
      networkInvitationsOverview:
          networkInvitationsOverview ?? this.networkInvitationsOverview,
      networkInvitesErrorMessage: clearNetworkInvitesError
          ? null
          : (networkInvitesErrorMessage ?? this.networkInvitesErrorMessage),
    );
  }

  @override
  List<Object?> get props => <Object?>[
    status,
    successMessage,
    errorMessage,
    myInvitesStatus,
    myInvitesFilter,
    myInvitesStatusFilter,
    invitationsOverview,
    myInvitesErrorMessage,
    latestSentInvitesStatus,
    latestSentInvites,
    latestSentInvitesErrorMessage,
    networkInvitesStatus,
    networkInvitesFilter,
    networkInvitesStatusFilter,
    networkInvitationsOverview,
    networkInvitesErrorMessage,
  ];
}
