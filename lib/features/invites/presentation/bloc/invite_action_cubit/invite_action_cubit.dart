import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/widgets/list_items/invitation_card/invitation_card.dart';
import 'package:poochcare/features/invites/data/models/invitation_decision_api_result.dart';
import 'package:poochcare/features/invites/data/models/invite_action_api_result.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_action_cubit/invite_action_state.dart';
import 'package:poochcare/features/invites/repository/invite_repository.dart';

class InviteActionCubit extends Cubit<InviteActionState> {
  final InviteRepository repository;
  final Invitation invitation;

  InviteActionCubit({required this.repository, required this.invitation})
    : super(InviteActionState());

  // Generalized handler to reduce boilerplate
  Future<void> _handleAction(
    InviteActionType action,
    Future<dynamic> Function() apiCall,
  ) async {
    emit(
      state.copyWith(
        processingAction: action,
        clearCompletedAction: true,
        clearError: true,
        clearSuccess: true,
      ),
    );

    try {
      final result = await apiCall();
      final message = _resolveSuccessMessage(result);
      emit(
        state.copyWith(
          clearAction: true,
          completedAction: action,
          successMessage: message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          clearAction: true,
          clearSuccess: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  String _resolveSuccessMessage(dynamic result) {
    if (result is InvitationDecisionApiResult) {
      final message = result.message.trim();
      if (message.isNotEmpty) {
        return message;
      }
    }
    if (result is InviteActionApiResult) {
      final message = result.message.trim();
      if (message.isNotEmpty) {
        return message;
      }
    }
    return 'Action completed successfully!';
  }

  // API Mappings
  Future<void> accept(String id) => _handleAction(
    InviteActionType.accept,
    () => repository.acceptInvitation(invitationId: id),
  );

  Future<void> reject(String id) => _handleAction(
    InviteActionType.reject,
    () => repository.rejectInvitation(invitationId: id),
  );

  Future<void> removeInvite(String groupId, String inviteId) => _handleAction(
    InviteActionType.removeInvitation,
    () => repository.removeInvitation(
      parentGroupId: groupId,
      invitationId: inviteId,
    ),
  );

  Future<void> removeMember(String groupId, String userId) => _handleAction(
    InviteActionType.removeMember,
    () => repository.removeMemberAccess(
      parentGroupId: groupId,
      targetUserId: userId,
    ),
  );

  Future<void> leaveGroup(String groupId, String inviteId) => _handleAction(
    InviteActionType.leaveGroup,
    () => repository.leaveParentGroup(
      parentGroupId: groupId,
      invitationId: inviteId,
    ),
  );

  Future<void> remind(String inviteId) => _handleAction(
    InviteActionType.remind,
    () => repository.sendReminder(invitationId: inviteId),
  );
}
