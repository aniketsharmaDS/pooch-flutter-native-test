import 'package:equatable/equatable.dart';

abstract class UpdatedAndReminderEvent extends Equatable {
  const UpdatedAndReminderEvent();

  @override
  List<Object?> get props => [];
}

class FetchUpdatesAndRemindersEvent extends UpdatedAndReminderEvent {
  const FetchUpdatesAndRemindersEvent();
}

class ResetUpdatesAndRemindersEvent extends UpdatedAndReminderEvent {}
