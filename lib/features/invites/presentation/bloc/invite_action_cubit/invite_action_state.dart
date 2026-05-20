enum InviteActionType {
  accept,
  reject,
  removeInvitation,
  removeMember,
  leaveGroup,
  remind,
}

class InviteActionState {
  final InviteActionType? processingAction;
  final InviteActionType? completedAction;
  final String? errorMessage;
  final String? successMessage;

  InviteActionState({
    this.processingAction,
    this.completedAction,
    this.errorMessage,
    this.successMessage,
  });

  InviteActionState copyWith({
    InviteActionType? processingAction,
    InviteActionType? completedAction,
    String? errorMessage,
    String? successMessage,
    bool clearAction = false,
    bool clearCompletedAction = false,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return InviteActionState(
      processingAction: clearAction
          ? null
          : (processingAction ?? this.processingAction),
      completedAction: clearCompletedAction
          ? null
          : (completedAction ?? this.completedAction),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage: clearSuccess
          ? null
          : (successMessage ?? this.successMessage),
    );
  }
}
