import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:poochcare/features/scheduler/data/models/request_models/create_event_request_model.dart';
import 'package:poochcare/features/scheduler/data/models/request_models/create_reminder_request_model.dart';
import 'package:poochcare/features/scheduler/domain/repository/schedule_repository.dart';
import 'package:poochcare/features/scheduler/domain/ui_models/schedule_day_ui_model.dart';
import 'package:poochcare/features/scheduler/domain/ui_models/schedule_item_ui_model.dart';
import 'package:poochcare/features/scheduler/domain/ui_models/schedule_monthly_ui_model.dart';
import 'package:poochcare/features/scheduler/presentation/bloc/schedule_event.dart';
import 'package:poochcare/features/scheduler/presentation/bloc/schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository _repo;

  ScheduleBloc(this._repo)
    : super(
        ScheduleState(
          // selectedMonth: DateTime.now().month,

          // selectedYear: DateTime.now().year,

          // selectedDate: DateTime.now(),
          focusedDate: DateTime.now(),
        ),
      ) {
    on<LoadMonthlySchedule>(_onLoadMonthlySchedule);

    // on<ChangeScheduleMonth>(_onChangeMonth);

    // on<ChangeScheduleYear>(_onChangeYear);

    // on<ChangeSelectedDate>(_onChangeSelectedDate);

    // on<ChangeVisibleMonthYear>(_onChangeVisibleMonthYear);

    // on<ChangeVisibleWeekDate>((event, emit) {
    //   emit(state.copyWith(visibleWeekDate: event.date));
    // });

    on<ChangeFocusedDate>(_onChangeFocusedDate);

    on<CreateReminder>(_onCreateReminder);

    on<CreateEvent>(_onCreateEvent);

    on<UpdateReminder>(_onUpdateReminder);

    on<UpdateEvent>(_onUpdateEvent);

    on<DeleteSchedule>(_onDeleteSchedule);

    add(
      LoadMonthlySchedule(
        month: state.focusedDate.month,
        year: state.focusedDate.year,
      ),
    );
  }

  Future<void> _onLoadMonthlySchedule(
    LoadMonthlySchedule event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final data = await _repo.getMonthlySchedule(
        month: event.month,
        year: event.year,
      );

      emit(
        state.copyWith(
          monthlySchedule: data,

          isLoading: false,

          // selectedMonth: event.month,

          // selectedYear: event.year,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  // Future<void> _onChangeMonth(
  //   ChangeScheduleMonth event,
  //   Emitter<ScheduleState> emit,
  // ) async {
  //   /// prevent duplicate reload
  //   if (event.month == state.selectedMonth) {
  //     return;
  //   }

  //   emit(state.copyWith(selectedMonth: event.month));

  //   add(LoadMonthlySchedule(month: event.month, year: state.selectedYear));
  // }

  // Future<void> _onChangeYear(
  //   ChangeScheduleYear event,
  //   Emitter<ScheduleState> emit,
  // ) async {
  //   /// prevent duplicate reload
  //   if (event.year == state.selectedYear) {
  //     return;
  //   }

  //   final currentDate = state.selectedDate;

  //   /// preserve month/day while changing year
  //   final updatedDate = DateTime(
  //     event.year,
  //     currentDate.month,
  //     currentDate.day,
  //   );

  //   emit(state.copyWith(selectedYear: event.year, selectedDate: updatedDate));

  //   add(LoadMonthlySchedule(month: updatedDate.month, year: updatedDate.year));
  // }

  // Future<void> _onChangeSelectedDate(
  //   ChangeSelectedDate event,
  //   Emitter<ScheduleState> emit,
  // ) async {
  //   emit(state.copyWith(selectedDate: event.date));
  // }

  Future<void> _onCreateReminder(
    CreateReminder event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true, submitSuccess: false));

    try {
      await _repo.createReminder(request: event.request);

      emit(
        state.copyWith(
          isSubmitting: false,
          submitSuccess: true,

          successMessage: 'Reminder created successfully',
        ),
      );

      /// RELOAD CURRENT MONTH
      add(
        LoadMonthlySchedule(
          month: state.focusedDate.month,
          year: state.focusedDate.year,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, error: e.toString()));
    }
  }

  // void _onChangeVisibleMonthYear(
  //   ChangeVisibleMonthYear event,
  //   Emitter<ScheduleState> emit,
  // ) {
  //   emit(state.copyWith(selectedMonth: event.month, selectedYear: event.year));
  // }

  Future<void> _onChangeFocusedDate(
    ChangeFocusedDate event,
    Emitter<ScheduleState> emit,
  ) async {
    // emit(state.copyWith(focusedDate: event.date));

    // add(LoadMonthlySchedule(month: event.date.month, year: event.date.year));

    final previous = state.focusedDate;

    emit(state.copyWith(focusedDate: event.date));

    final monthChanged =
        previous.month != event.date.month || previous.year != event.date.year;

    if (monthChanged) {
      add(LoadMonthlySchedule(month: event.date.month, year: event.date.year));
    }
  }

  Future<void> _onCreateEvent(
    CreateEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true, submitSuccess: false));

    try {
      await _repo.createEvent(request: event.request);

      emit(
        state.copyWith(
          isSubmitting: false,
          submitSuccess: true,
          successMessage: 'Event created successfully',
        ),
      );

      // refresh calendar
      add(
        LoadMonthlySchedule(
          month: state.focusedDate.month,
          year: state.focusedDate.year,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, error: e.toString()));
    }
  }

  Future<void> _onDeleteSchedule(
    DeleteSchedule event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true, submitSuccess: false));

    try {
      await _repo.deleteSchedule(id: event.id);

      add(
        LoadMonthlySchedule(
          month: state.focusedDate.month,
          year: state.focusedDate.year,
        ),
      );

      emit(
        state.copyWith(
          isSubmitting: false,
          successMessage: 'Schedule deleted successfully',
        ),
      );
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, error: e.toString()));
    }
  }

  Future<void> _onUpdateReminder(
    UpdateReminder event,
    Emitter<ScheduleState> emit,
  ) async {
    final previousMonthly = state.monthlySchedule;
    final updatedItem = _buildUpdatedReminderItem(
      current: event.currentItem,
      request: event.request,
    );
    final updatedMonthly = _updateMonthlySchedule(previousMonthly, updatedItem);

    emit(
      state.copyWith(
        isSubmitting: true,
        submitSuccess: false,
        monthlySchedule: updatedMonthly,
      ),
    );

    try {
      await _repo.updateReminder(id: event.id, request: event.request);

      emit(
        state.copyWith(
          isSubmitting: false,
          submitSuccess: true,
          successMessage: 'Reminder updated successfully',
        ),
      );

      add(
        LoadMonthlySchedule(
          month: state.focusedDate.month,
          year: state.focusedDate.year,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isSubmitting: false,
          submitSuccess: false,
          error: e.toString(),
          monthlySchedule: previousMonthly,
        ),
      );
    }
  }

  Future<void> _onUpdateEvent(
    UpdateEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    final previousMonthly = state.monthlySchedule;
    final updatedItem = _buildUpdatedEventItem(
      current: event.currentItem,
      request: event.request,
    );
    final updatedMonthly = _updateMonthlySchedule(previousMonthly, updatedItem);

    emit(
      state.copyWith(
        isSubmitting: true,
        submitSuccess: false,
        monthlySchedule: updatedMonthly,
      ),
    );

    try {
      await _repo.updateEvent(id: event.id, request: event.request);

      emit(
        state.copyWith(
          isSubmitting: false,
          submitSuccess: true,
          successMessage: 'Event updated successfully',
        ),
      );

      add(
        LoadMonthlySchedule(
          month: state.focusedDate.month,
          year: state.focusedDate.year,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isSubmitting: false,
          submitSuccess: false,
          error: e.toString(),
          monthlySchedule: previousMonthly,
        ),
      );
    }
  }

  ScheduleItemUIModel _buildUpdatedReminderItem({
    required ScheduleItemUIModel current,
    required CreateReminderRequestModel request,
  }) {
    final updatedStart = _parseDateTime(request.date, request.time);

    return ScheduleItemUIModel(
      id: current.id,
      type: current.type,
      title: request.title,
      time: request.time,
      date: request.date,
      startDateTime: updatedStart,
      petId: request.petId,
      petName: current.petName,
      petType: current.petType,
      petGender: current.petGender,
      taskCategory: request.taskCategory,
      eventType: current.eventType,
      notes: request.notes,
      location: current.location,
      endDate: current.endDate,
      isMultiDay: current.isMultiDay,
      formattedTime: DateFormat('hh:mm a').format(updatedStart),
      indicatorColor: current.indicatorColor,
    );
  }

  ScheduleItemUIModel _buildUpdatedEventItem({
    required ScheduleItemUIModel current,
    required CreateEventRequestModel request,
  }) {
    final updatedStart = _parseDateTime(request.date, request.time);
    final isMultiDay = request.endDate != request.date;

    return ScheduleItemUIModel(
      id: current.id,
      type: current.type,
      title: request.title,
      time: request.time,
      date: request.date,
      startDateTime: updatedStart,
      petId: request.petId,
      petName: current.petName,
      petType: current.petType,
      petGender: current.petGender,
      taskCategory: current.taskCategory,
      eventType: request.eventType,
      notes: request.notes,
      location: request.location,
      endDate: request.endDate,
      isMultiDay: isMultiDay,
      formattedTime: DateFormat('hh:mm a').format(updatedStart),
      indicatorColor: current.indicatorColor,
    );
  }

  DateTime _parseDateTime(String date, String time) {
    final parsedDate = DateTime.tryParse(date);
    if (parsedDate == null) {
      return DateTime.now();
    }

    final parts = time.split(':');
    if (parts.length < 2) {
      return parsedDate;
    }

    return DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
      int.tryParse(parts[0]) ?? 0,
      int.tryParse(parts[1]) ?? 0,
    );
  }

  ScheduleMonthlyUIModel? _updateMonthlySchedule(
    ScheduleMonthlyUIModel? monthly,
    ScheduleItemUIModel updatedItem,
  ) {
    if (monthly == null) {
      return monthly;
    }

    final updatedDate = DateTime.tryParse(updatedItem.date);
    final inFocusedMonth =
        updatedDate != null &&
        updatedDate.month == state.focusedDate.month &&
        updatedDate.year == state.focusedDate.year;

    final updatedDays = <ScheduleDayUIModel>[];
    var inserted = false;

    for (final day in monthly.schedules) {
      final filtered = day.items
          .where((item) => item.id != updatedItem.id)
          .toList();
      final sameDay =
          updatedDate != null &&
          day.parsedDate.year == updatedDate.year &&
          day.parsedDate.month == updatedDate.month &&
          day.parsedDate.day == updatedDate.day;

      if (sameDay && inFocusedMonth) {
        final items = [...filtered, updatedItem]
          ..sort((a, b) => a.startDateTime.compareTo(b.startDateTime));
        updatedDays.add(
          ScheduleDayUIModel(
            date: day.date,
            parsedDate: day.parsedDate,
            items: items,
          ),
        );
        inserted = true;
        continue;
      }

      if (filtered.isEmpty) {
        continue;
      }

      if (filtered.length == day.items.length) {
        updatedDays.add(day);
      } else {
        filtered.sort((a, b) => a.startDateTime.compareTo(b.startDateTime));
        updatedDays.add(
          ScheduleDayUIModel(
            date: day.date,
            parsedDate: day.parsedDate,
            items: filtered,
          ),
        );
      }
    }

    if (inFocusedMonth && !inserted) {
      updatedDays.add(
        ScheduleDayUIModel(
          date: updatedItem.date,
          parsedDate: updatedDate,
          items: [updatedItem],
        ),
      );
    }

    updatedDays.sort((a, b) => a.parsedDate.compareTo(b.parsedDate));

    return ScheduleMonthlyUIModel(
      month: monthly.month,
      year: monthly.year,
      totalReminders: monthly.totalReminders,
      totalEvents: monthly.totalEvents,
      schedules: updatedDays,
      summary: monthly.summary,
    );
  }
}
