import 'package:auto_route/auto_route.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/toast_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/selectors/app_year_picker_sheet.dart';
import 'package:poochcare/core/widgets/texts/app_search_field.dart';
import 'package:poochcare/features/scheduler/domain/ui_models/schedule_event_model.dart';
import 'package:poochcare/features/scheduler/presentation/bloc/schedule_bloc.dart';
import 'package:poochcare/features/scheduler/presentation/bloc/schedule_event.dart';
import 'package:poochcare/features/scheduler/presentation/bloc/schedule_state.dart';
import 'package:poochcare/features/scheduler/presentation/view/add_schedule_screen.dart';
import 'package:poochcare/features/scheduler/presentation/widgets/schedule_day_view.dart';
import 'package:poochcare/features/scheduler/presentation/widgets/schedule_details_bottom_sheet.dart';
import 'package:poochcare/features/scheduler/presentation/widgets/schedule_header.dart';
import 'package:poochcare/features/scheduler/presentation/widgets/schedule_month_view.dart';
import 'package:poochcare/features/scheduler/presentation/widgets/schedule_week_view.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';

enum ScheduleViewType { monthly, weekly, daily }

@RoutePage()
class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  ScheduleViewType selectedView = ScheduleViewType.monthly;
  late final TextEditingController _searchController;

  late final DateTime profileCreatedAt;

  // bool _isPastMonth(int year, int month) {
  //   final now = DateTime.now();

  //   return year < now.year || (year == now.year && month < now.month);
  // }

  bool _isPastDate(DateTime date) {
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);
    final normalizedDate = DateTime(date.year, date.month, date.day);

    return normalizedDate.isBefore(normalizedToday);
  }

  bool _isPastWeek(DateTime date) {
    final today = DateTime.now();

    final normalizedToday = DateTime(today.year, today.month, today.day);

    final startOfWeek = date.subtract(Duration(days: date.weekday % 7));

    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    return endOfWeek.isBefore(normalizedToday);
  }

  // bool _isPastVisibleWeek(DateTime visibleWeekDate) {
  //   final today = DateTime.now();

  //   final normalizedToday = DateTime(today.year, today.month, today.day);

  //   /// Sunday-start week
  //   final startOfWeek = visibleWeekDate.subtract(
  //     Duration(days: visibleWeekDate.weekday % 7),
  //   );

  //   final endOfWeek = startOfWeek.add(const Duration(days: 6));

  //   return endOfWeek.isBefore(normalizedToday);
  // }

  Future<void> _handleDelete(ScheduleBloc bloc, String id) async {
    bloc.add(DeleteSchedule(id));

    await bloc.stream.firstWhere((state) => !state.isSubmitting);

    final current = bloc.state;
    if (current.error != null) {
      ToastService.showError(current.error!);
      throw Exception(current.error);
    }

    ToastService.showSuccess(
      current.successMessage ?? 'Schedule deleted successfully',
    );
  }

  List<CalendarEventData<Object?>> buildCalendarEvents(ScheduleState state) {
    final monthlySchedule = state.monthlySchedule;

    if (monthlySchedule == null) {
      return [];
    }

    return monthlySchedule.schedules
        .expand((day) => day.items)
        .map(
          (item) => CalendarEventData<Object?>(
            date: item.startDateTime,

            startTime: item.startDateTime,

            endTime: item.startDateTime.add(const Duration(hours: 1)),

            title: item.title,

            color: item.indicatorColor,

            event: item,
          ),
        )
        .toList();
  }

  List<CalendarEventData<ScheduleEventModel>> buildCalendarViewEvents(
    List<ScheduleEventModel> events,
  ) {
    return events.map((e) {
      return CalendarEventData<ScheduleEventModel>(
        date: e.startTime,
        startTime: e.startTime,
        endTime: e.endTime,
        title: e.title,
        color: e.color,
        event: e,
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();

    final createdAt = context.read<UserProfileBloc>().state.profile!.createdAt;

    _searchController = TextEditingController();

    profileCreatedAt = DateTime.parse(createdAt);
  }

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ScheduleBloc>(),
      // ..add(
      //   LoadMonthlySchedule(
      //     month: DateTime.now().month,
      //     year: DateTime.now().year,
      //   ),
      // ),
      child: Builder(
        builder: (context) {
          return BlocBuilder<ScheduleBloc, ScheduleState>(
            builder: (context, state) {
              final bloc = context.read<ScheduleBloc>();
              // final isPastSelectedDate = selectedView == ScheduleViewType.weekly
              //     ? _isPastWeek(state.selectedDate)
              //     : _isPastDate(state.selectedDate);

              final now = DateTime.now();

              // final isCurrentVisibleMonth =
              //     state.selectedMonth == now.month &&
              //     state.selectedYear == now.year;

              // final isPastSelectedDate =
              //     selectedView == ScheduleViewType.monthly
              //     ? isCurrentVisibleMonth
              //           ? _isPastDate(state.focusedDate)
              //           : _isPastMonth(state.selectedYear, state.selectedMonth)
              //     : selectedView == ScheduleViewType.weekly
              //     ? _isPastVisibleWeek(state.visibleWeekDate)
              //     : _isPastDate(state.focusedDate);

              final focusedDate = state.focusedDate;

              final isPastSelectedDate =
                  selectedView == ScheduleViewType.monthly
                  ? focusedDate.year == now.year &&
                            focusedDate.month == now.month
                        ? _isPastDate(focusedDate)
                        : DateTime(
                            focusedDate.year,
                            focusedDate.month,
                          ).isBefore(DateTime(now.year, now.month))
                  : selectedView == ScheduleViewType.weekly
                  ? _isPastWeek(focusedDate)
                  : _isPastDate(focusedDate);
              return SafeArea(
                child: Stack(
                  children: [
                    if (state.isLoading && state.monthlySchedule == null)
                      const Center(child: CircularProgressIndicator())
                    else
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: AppSearchField(
                              controller: _searchController,
                              onChanged: (value) {
                                // _onSearch(value);
                              },
                              onSubmitted: (value) {},
                            ),
                          ),

                          AppSpacing.s25.hBox,

                          ScheduleHeader(
                            // selectedDate: DateTime(
                            //   state.selectedYear,
                            //   state.selectedMonth,
                            // ),
                            // selectedDate:
                            //     selectedView == ScheduleViewType.monthly
                            //     ? DateTime(
                            //         state.selectedYear,
                            //         state.selectedMonth,
                            //       )
                            //     : selectedView == ScheduleViewType.weekly
                            //     ? state.visibleWeekDate
                            //     : state.focusedDate,
                            selectedDate: state.focusedDate,
                            selectedYear: state.focusedDate.year,
                            // selectedYear: state.selectedYear,
                            selectedView: selectedView,
                            isLoading: state.isLoading,

                            onViewChanged: (v) {
                              setState(() {
                                selectedView = v;
                              });

                              // if (v == ScheduleViewType.weekly) {
                              //   bloc.add(
                              //     ChangeVisibleWeekDate(state.focusedDate),
                              //   );
                              // }
                            },

                            onYearTap: () async {
                              final bloc = context.read<ScheduleBloc>();
                              final year = await AppYearPickerSheet.show(
                                context: context,
                                initialYear: state.focusedDate.year,
                                accountCreatedAt: profileCreatedAt,
                                futureYearsCount: 10,
                              );

                              if (!mounted) return;
                              if (year != null) {
                                // setState(() {
                                //   selectedYear = year;
                                // });
                                // bloc.add(ChangeScheduleYear(year));

                                bloc.add(
                                  ChangeFocusedDate(
                                    DateTime(
                                      year,
                                      state.focusedDate.month,
                                      state.focusedDate.day,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),

                          AppSpacing.s20.hBox,

                          if (selectedView == ScheduleViewType.monthly)
                            _buildView(state, bloc)
                          else
                            Expanded(child: _buildView(state, bloc)),

                          // Expanded(child: _buildView()),
                        ],
                      ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 100,

                      child: Center(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: isPastSelectedDate
                              ? () {
                                  ToastService.showError(
                                    'You cannot add tasks in the past',
                                  );
                                }
                              : null,
                          child: SizedBox(
                            width: 210,
                            child: AppButton(
                              label: 'Add New Task',
                              height: AppSize.cs48,
                              trailingIcon: AppIcon(
                                AppIcons.svg.generic.plusSign,
                                color: AppColors.white,
                              ),
                              isDisabled: isPastSelectedDate,
                              onPressed: isPastSelectedDate
                                  ? null
                                  : () async {
                                      final bloc = context.read<ScheduleBloc>();

                                      context.router.pushWidget(
                                        BlocProvider.value(
                                          value: bloc,
                                          child: AddScheduleScreen(
                                            initialDate: state.focusedDate,
                                          ),
                                        ),
                                      );
                                    },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildView(ScheduleState state, ScheduleBloc bloc) {
    switch (selectedView) {
      case ScheduleViewType.monthly:
        return ScheduleMonthView(
          events: buildCalendarEvents(state),
          selectedDate: state.focusedDate,

          onDayEventsTap: (date, events) {
            if (events.isEmpty) return;

            ScheduleDetailsBottomSheet.show(
              context: context,
              date: date,
              events: events,
              onEdit: (item) {
                context.router.pushWidget(
                  BlocProvider.value(
                    value: bloc,
                    child: AddScheduleScreen(
                      initialItem: item,
                      isEditing: true,
                    ),
                  ),
                );
              },
              onDelete: (item) {
                return _handleDelete(bloc, item.id);
              },
            );
          },

          onDateSelected: (date) {
            //  bloc.add(ChangeSelectedDate(date));
            bloc.add(ChangeFocusedDate(date));
          },

          onPageChanged: (date) {
            // /// update selected date
            // bloc.add(ChangeSelectedDate(date));

            // /// reload api
            // bloc.add(LoadMonthlySchedule(month: date.month, year: date.year));

            //  bloc.add(
            //   ChangeVisibleMonthYear(month: date.month, year: date.year),
            // );

            // bloc.add(LoadMonthlySchedule(month: date.month, year: date.year));

            bloc.add(ChangeFocusedDate(DateTime(date.year, date.month)));
          },
        );

      case ScheduleViewType.daily:
        final controller = EventController<Object?>();

        controller.addAll(buildCalendarEvents(state));

        return ScheduleDayView(
          controller: controller,

          selectedDate: state.focusedDate,

          onPageChange: (date) {
            // bloc.add(ChangeSelectedDate(date));

            // bloc.add(ChangeFocusedDate(date));

            // if (date.month != state.selectedMonth ||
            //     date.year != state.selectedYear) {
            //   bloc.add(LoadMonthlySchedule(month: date.month, year: date.year));
            // }

            bloc.add(ChangeFocusedDate(date));
          },
          onEdit: (item) {
            context.router.pushWidget(
              BlocProvider.value(
                value: bloc,
                child: AddScheduleScreen(initialItem: item, isEditing: true),
              ),
            );
          },
          onDelete: (item) {
            return _handleDelete(bloc, item.id);
          },
        );
      case ScheduleViewType.weekly:
        return ScheduleWeekView(
          events: buildCalendarEvents(state),

          onEventTap: (event) {
            ScheduleDetailsBottomSheet.show(
              context: context,
              date: event.date,
              events: [event],
              onEdit: (item) {
                context.router.pushWidget(
                  BlocProvider.value(
                    value: bloc,
                    child: AddScheduleScreen(
                      initialItem: item,
                      isEditing: true,
                    ),
                  ),
                );
              },
              onDelete: (item) {
                return _handleDelete(bloc, item.id);
              },
            );
          },

          selectedDate: state.focusedDate,

          onPageChange: (date) {
            // bloc.add(ChangeSelectedDate(date));

            // if (date.month != state.selectedMonth ||
            //     date.year != state.selectedYear) {
            //   bloc.add(LoadMonthlySchedule(month: date.month, year: date.year));
            // }

            // bloc.add(ChangeVisibleWeekDate(date));

            // if (date.month != state.selectedMonth ||
            //     date.year != state.selectedYear) {
            //   bloc.add(LoadMonthlySchedule(month: date.month, year: date.year));
            // }

            bloc.add(ChangeFocusedDate(date));
          },
          onEdit: (item) {
            context.router.pushWidget(
              BlocProvider.value(
                value: bloc,
                child: AddScheduleScreen(initialItem: item, isEditing: true),
              ),
            );
          },
          onDelete: (item) {
            return _handleDelete(bloc, item.id);
          },
        );
    }
  }
}
