import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/features/home/domain/models/updated_and_reminder_model.dart';
import 'package:poochcare/features/home/domain/repository/updates_repository.dart';
import 'package:poochcare/features/home/presentation/bloc/updated_and_reminder_event.dart';
import 'package:poochcare/features/home/presentation/bloc/updated_and_reminder_state.dart';

class UpdatedAndReminderBloc
    extends Bloc<UpdatedAndReminderEvent, UpdatedAndReminderState> {
  final UpdatesRepository repository;

  UpdatedAndReminderBloc(this.repository)
    : super(const UpdatedAndReminderState()) {
    on<FetchUpdatesAndRemindersEvent>(_onFetch);
    on<ResetUpdatesAndRemindersEvent>(_onReset);
  }

  Future<void> _onFetch(
    FetchUpdatesAndRemindersEvent event,
    Emitter<UpdatedAndReminderState> emit,
  ) async {
    try {
      emit(state.copyWith(status: UpdatedAndReminderStatus.loading));

      final response = await repository.getUpdatesAndReminders();
      final items = response.data
          .map(UpdatedAndReminderModel.fromApi)
          .toList(growable: false);

      emit(
        state.copyWith(
          status: UpdatedAndReminderStatus.success,
          items: items,
          actionId: state.actionId + 1,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: UpdatedAndReminderStatus.failure,
          errorMessage: e.toString(),
          actionId: state.actionId + 1,
        ),
      );
    }
  }

  void _onReset(
    ResetUpdatesAndRemindersEvent event,
    Emitter<UpdatedAndReminderState> emit,
  ) {
    emit(const UpdatedAndReminderState());
  }
}
