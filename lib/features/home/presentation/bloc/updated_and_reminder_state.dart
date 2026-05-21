import 'package:equatable/equatable.dart';
import 'package:poochcare/features/home/domain/models/updated_and_reminder_model.dart';

enum UpdatedAndReminderStatus { initial, loading, success, failure }

class UpdatedAndReminderState extends Equatable {
  final UpdatedAndReminderStatus status;
  final List<UpdatedAndReminderModel> items;
  final String errorMessage;
  final int actionId;

  const UpdatedAndReminderState({
    this.status = UpdatedAndReminderStatus.initial,
    this.items = const [],
    this.errorMessage = '',
    this.actionId = 0,
  });

  UpdatedAndReminderState copyWith({
    UpdatedAndReminderStatus? status,
    List<UpdatedAndReminderModel>? items,
    String? errorMessage,
    int? actionId,
  }) {
    return UpdatedAndReminderState(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
      actionId: actionId ?? this.actionId,
    );
  }

  @override
  List<Object?> get props => [status, items, errorMessage, actionId];
}
