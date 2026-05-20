import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/features/invites/data/models/invitations_overview_response.dart';
import 'package:poochcare/features/invites/data/models/latest_sent_invites_response.dart';
import 'package:poochcare/features/invites/domain/models/invite_list_scope.dart';
import 'package:poochcare/features/invites/domain/models/invite_status_filter.dart';
import 'package:poochcare/features/invites/domain/models/invite_type.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_action_cubit/invite_action_state.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_bloc/invite_event.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_bloc/invite_state.dart';
import 'package:poochcare/features/invites/repository/invite_repository.dart';
import 'package:poochcare/features/user_profile/repository/user_profile_repository.dart';

class InviteBloc extends Bloc<InviteEvent, InviteState> {
  InviteBloc({
    required InviteRepository repository,
    required UserProfileRepository userProfileRepository,
  }) : _repository = repository,
       super(const InviteState()) {
    on<InviteParentEvent>(_onInviteParent);
    on<AcceptInviteByCodeEvent>(_onAcceptInviteByCode);
    on<GetMyInvitationsEvent>(_onGetMyInvitations);
    on<GetLatestSentInvitesEvent>(_onGetLatestSentInvites);
    on<GetMyNetworkInvitationsEvent>(_onGetMyNetworkInvitations);
    on<ApplyInviteActionEvent>(_onApplyInviteAction);
  }

  final InviteRepository _repository;

  // Future<void> _onAcceptedSuccess(
  //   InviteParentEvent event,
  //   Emitter<InviteState> emit,
  // ) async {
  //   if (state.status == InviteStatus.loading) {
  //     return;
  //   }
  //   final updatedItems = state.invitationsOverview?.invitations.pending.map((
  //     invite,
  //   ) {
  //     if (invite.id == 'targetId') {
  //       return invite.copyWith(status: 'accepted');
  //     }
  //     return invite;
  //   }).toList();

  //   emit(
  //     state.copyWith(
  //       invitationsOverview: state.invitationsOverview?.copyWith(
  //         invitations: InviteBucketsResponse(accepted: updatedItems ?? []),
  //       ),
  //     ),
  //   );
  // }

  Future<void> _onInviteParent(
    InviteParentEvent event,
    Emitter<InviteState> emit,
  ) async {
    if (state.status == InviteStatus.loading) {
      return;
    }

    final target = event.targetUserEmailOrPhone.trim();
    if (target.isEmpty) {
      emit(
        state.copyWith(
          status: InviteStatus.failure,
          errorMessage: 'Please enter a valid email or phone number.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: InviteStatus.loading,
        clearError: true,
        clearSuccess: true,
      ),
    );

    try {
      final role = event.inviteType == InviteType.parent
          ? 'parent'
          : 'co_parent';

      final result = await _repository.shareParentGroupInvite(
        parentGroupId: event.parentGroupId,
        targetUserEmailOrPhone: target,
        role: role,
        countryCode: event.countryCode,
        nickname: event.nickname,
      );

      final message = result.message.trim().isNotEmpty
          ? result.message.trim()
          : 'Invite sent successfully.';

      emit(
        state.copyWith(status: InviteStatus.success, successMessage: message),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(
          status: InviteStatus.failure,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: InviteStatus.failure,
          errorMessage: 'Unable to send invite. Please try again.',
        ),
      );
    }
  }

  Future<void> _onAcceptInviteByCode(
    AcceptInviteByCodeEvent event,
    Emitter<InviteState> emit,
  ) async {
    if (state.status == InviteStatus.loading) {
      return;
    }

    final invitationCode = event.invitationCode.trim();
    if (invitationCode.isEmpty) {
      emit(
        state.copyWith(
          status: InviteStatus.failure,
          errorMessage: 'Please enter a valid invitation code.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: InviteStatus.loading,
        clearError: true,
        clearSuccess: true,
      ),
    );

    try {
      final result = await _repository.acceptInvitationByCode(
        invitationCode: invitationCode,
        email: event.email,
      );

      final message = result.message.trim().isNotEmpty
          ? result.message.trim()
          : 'Invitation accepted successfully.';

      emit(
        state.copyWith(status: InviteStatus.success, successMessage: message),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(
          status: InviteStatus.failure,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: InviteStatus.failure,
          errorMessage: 'Unable to accept invitation. Please try again.',
        ),
      );
    }
  }

  Future<void> _onGetMyInvitations(
    GetMyInvitationsEvent event,
    Emitter<InviteState> emit,
  ) async {
    if (state.myInvitesStatus == MyInvitesStatus.loading &&
        !event.forceRefresh) {
      return;
    }

    if (!event.forceRefresh &&
        state.myInvitesStatus == MyInvitesStatus.success &&
        state.myInvitesFilter == event.filter &&
        state.myInvitesStatusFilter == event.status) {
      return;
    }

    emit(
      state.copyWith(
        myInvitesStatus: MyInvitesStatus.loading,
        myInvitesFilter: event.filter,
        myInvitesStatusFilter: event.status,
        clearMyInvitesError: true,
      ),
    );

    try {
      final overview = await _repository.getMyInvitations(
        filter: event.filter,
        status: event.status,
        forceRefresh: event.forceRefresh,
        page: event.page,
      );
      emit(
        state.copyWith(
          myInvitesStatus: MyInvitesStatus.success,
          invitationsOverview: overview,
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(
          myInvitesStatus: MyInvitesStatus.failure,
          myInvitesErrorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          myInvitesStatus: MyInvitesStatus.failure,
          myInvitesErrorMessage: 'Unable to load invites. Please try again.',
        ),
      );
    }
  }

  Future<void> _onGetLatestSentInvites(
    GetLatestSentInvitesEvent event,
    Emitter<InviteState> emit,
  ) async {
    if (state.latestSentInvitesStatus == LatestSentInvitesStatus.loading &&
        !event.forceRefresh) {
      return;
    }

    if (!event.forceRefresh &&
        state.latestSentInvitesStatus == LatestSentInvitesStatus.success) {
      return;
    }

    emit(
      state.copyWith(
        latestSentInvitesStatus: LatestSentInvitesStatus.loading,
        clearLatestSentInvitesError: true,
      ),
    );

    try {
      final response = await _repository.getLatestSentInvites();
      emit(
        state.copyWith(
          latestSentInvitesStatus: LatestSentInvitesStatus.success,
          latestSentInvites: response.data,
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(
          latestSentInvitesStatus: LatestSentInvitesStatus.failure,
          latestSentInvitesErrorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          latestSentInvitesStatus: LatestSentInvitesStatus.failure,
          latestSentInvitesErrorMessage:
              'Unable to load latest invites. Please try again.',
        ),
      );
    }
  }

  Future<void> _onGetMyNetworkInvitations(
    GetMyNetworkInvitationsEvent event,
    Emitter<InviteState> emit,
  ) async {
    if (state.networkInvitesStatus == NetworkInvitesStatus.loading &&
        !event.forceRefresh) {
      return;
    }

    if (!event.forceRefresh &&
        state.networkInvitesStatus == NetworkInvitesStatus.success &&
        state.networkInvitesFilter == event.filter &&
        state.networkInvitesStatusFilter == event.status) {
      return;
    }

    emit(
      state.copyWith(
        networkInvitesStatus: NetworkInvitesStatus.loading,
        networkInvitesFilter: event.filter,
        networkInvitesStatusFilter: event.status,
        clearNetworkInvitesError: true,
      ),
    );

    try {
      final overview = await _repository.getMyNetworkInvites(
        filter: event.filter,
        status: event.status,
        page: event.page,
      );
      emit(
        state.copyWith(
          networkInvitesStatus: NetworkInvitesStatus.success,
          networkInvitationsOverview: overview,
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(
          networkInvitesStatus: NetworkInvitesStatus.failure,
          networkInvitesErrorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          networkInvitesStatus: NetworkInvitesStatus.failure,
          networkInvitesErrorMessage:
              'Unable to load network invites. Please try again.',
        ),
      );
    }
  }

  void _onApplyInviteAction(
    ApplyInviteActionEvent event,
    Emitter<InviteState> emit,
  ) {
    final updatedLatestSentInvites = _applyLatestSentInvitesAction(
      latestSentInvites: state.latestSentInvites,
      action: event.action,
      invitationId: event.invitationId,
    );

    if (event.scope == InviteListScope.networkInvites) {
      final overview = state.networkInvitationsOverview;
      if (overview == null) {
        if (updatedLatestSentInvites != state.latestSentInvites) {
          emit(state.copyWith(latestSentInvites: updatedLatestSentInvites));
        }
        return;
      }

      final updated = _applyInviteAction(
        overview: overview,
        action: event.action,
        invitationId: event.invitationId,
        statusFilter: state.networkInvitesStatusFilter,
      );

      if (identical(updated, overview)) {
        if (updatedLatestSentInvites != state.latestSentInvites) {
          emit(state.copyWith(latestSentInvites: updatedLatestSentInvites));
        }
        return;
      }

      emit(
        state.copyWith(
          networkInvitationsOverview: updated,
          latestSentInvites: updatedLatestSentInvites,
        ),
      );
      return;
    }

    final overview = state.invitationsOverview;
    if (overview == null) {
      if (updatedLatestSentInvites != state.latestSentInvites) {
        emit(state.copyWith(latestSentInvites: updatedLatestSentInvites));
      }
      return;
    }

    final updated = _applyInviteAction(
      overview: overview,
      action: event.action,
      invitationId: event.invitationId,
      statusFilter: state.myInvitesStatusFilter,
    );

    if (identical(updated, overview)) {
      if (updatedLatestSentInvites != state.latestSentInvites) {
        emit(state.copyWith(latestSentInvites: updatedLatestSentInvites));
      }
      return;
    }

    emit(
      state.copyWith(
        invitationsOverview: updated,
        latestSentInvites: updatedLatestSentInvites,
      ),
    );
  }
}

LatestSentInvitesResponse? _applyLatestSentInvitesAction({
  required LatestSentInvitesResponse? latestSentInvites,
  required InviteActionType action,
  required String invitationId,
}) {
  if (latestSentInvites == null) {
    return null;
  }

  final shouldRemove =
      action == InviteActionType.accept ||
      action == InviteActionType.reject ||
      action == InviteActionType.removeInvitation ||
      action == InviteActionType.removeMember ||
      action == InviteActionType.leaveGroup;

  if (!shouldRemove) {
    return latestSentInvites;
  }

  final parentInvite = latestSentInvites.latestParentInvite;
  final coParentInvite = latestSentInvites.latestCoParentInvite;

  final updatedParentInvite =
      parentInvite != null && parentInvite.id == invitationId
      ? null
      : parentInvite;
  final updatedCoParentInvite =
      coParentInvite != null && coParentInvite.id == invitationId
      ? null
      : coParentInvite;

  if (updatedParentInvite == parentInvite &&
      updatedCoParentInvite == coParentInvite) {
    return latestSentInvites;
  }

  return LatestSentInvitesResponse(
    userId: latestSentInvites.userId,
    latestParentInvite: updatedParentInvite,
    latestCoParentInvite: updatedCoParentInvite,
  );
}

InvitationsOverviewResponse _applyInviteAction({
  required InvitationsOverviewResponse overview,
  required InviteActionType action,
  required String invitationId,
  required InviteStatusFilter? statusFilter,
}) {
  final items = overview.invitations;
  final index = items.indexWhere((item) => item.id == invitationId);
  if (index == -1) {
    return overview;
  }

  final updatedItems = List<InviteItemResponse>.from(items);
  var removed = false;

  switch (action) {
    case InviteActionType.accept:
      if (statusFilter == InviteStatusFilter.pending) {
        updatedItems.removeAt(index);
        removed = true;
      } else {
        final item = updatedItems[index];
        updatedItems[index] = item.copyWith(status: 'accepted');
      }
      break;
    case InviteActionType.reject:
    case InviteActionType.removeInvitation:
    case InviteActionType.removeMember:
    case InviteActionType.leaveGroup:
      updatedItems.removeAt(index);
      removed = true;
      break;
    case InviteActionType.remind:
      break;
  }

  if (!removed && identical(updatedItems, items)) {
    return overview;
  }

  final pagination = removed
      ? _decrementPagination(overview.pagination)
      : overview.pagination;

  return overview.copyWith(invitations: updatedItems, pagination: pagination);
}

InvitePaginationResponse _decrementPagination(
  InvitePaginationResponse pagination,
) {
  if (pagination.total <= 0) {
    return pagination;
  }

  return pagination.copyWith(total: pagination.total - 1);
}
