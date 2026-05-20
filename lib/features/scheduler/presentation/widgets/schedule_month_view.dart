import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/scheduler/presentation/widgets/schedule_calendar_cell.dart';

class ScheduleMonthView extends StatefulWidget {
  const ScheduleMonthView({
    super.key,
    required this.events,
    required this.onDateSelected,
    required this.onPageChanged,
    required this.onDayEventsTap,
    required this.selectedDate,
  });

  final List<CalendarEventData<Object?>> events;
  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<DateTime> onPageChanged;
  final DateTime selectedDate;
  final void Function(DateTime date, List<CalendarEventData<Object?>> events)
  onDayEventsTap;

  @override
  State<ScheduleMonthView> createState() => _ScheduleMonthViewState();
}

class _ScheduleMonthViewState extends State<ScheduleMonthView> {
  late final EventController<Object?> _controller;

  // DateTime selectedDate = DateTime.now();

  final List<String> _weekDays = const [
    'Su',
    'Mo',
    'Tu',
    'We',
    'Th',
    'Fr',
    'Sa',
  ];

  Widget _buildWeekHeader() {
    return Row(
      children: _weekDays
          .map((d) => Expanded(child: Center(child: AppText.h3(d))))
          .toList(),
    );
  }

  @override
  void initState() {
    super.initState();

    _controller = EventController<Object?>();

    _controller.addAll(widget.events);
  }

  @override
  void didUpdateWidget(covariant ScheduleMonthView oldWidget) {
    super.didUpdateWidget(oldWidget);

    _controller.removeWhere((_) => true);

    _controller.addAll(widget.events);
  }

  @override
  Widget build(BuildContext context) {
    // final controller = EventController<Object?>();

    // controller.addAll(widget.events);

    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          /// ✅ custom weekday header
          _buildWeekHeader(),

          const SizedBox(height: 8),

          /// ✅ calendar
          AspectRatio(
            aspectRatio: 7 / 6,
            child: MonthView<Object?>(
              key: ValueKey(
                '${widget.selectedDate.year}-${widget.selectedDate.month}',
              ),
              controller: _controller,

              monthViewStyle: MonthViewStyle(
                initialMonth: widget.selectedDate,
                showBorder: false,
                safeAreaOption: const SafeAreaOption(
                  maintainBottomViewPadding: true,
                ),
                cellAspectRatio: 1,
                hideDaysNotInMonth: true,
                showWeekTileBorder: false,
              ),

              monthViewBuilders: MonthViewBuilders(
                /// remove default header
                headerBuilder: (_) => const SizedBox.shrink(),

                onPageChange: (date, pageIndex) {
                  widget.onPageChanged(date);
                },

                /// remove built-in weekday row
                weekDayBuilder: (_) => const SizedBox.shrink(),

                cellBuilder:
                    (
                      DateTime date,
                      List<CalendarEventData<Object?>> events,
                      bool isToday,
                      bool isInMonth,
                      bool hideDaysNotInMonth,
                    ) {
                      final indicators = events
                          .map((e) => e.color)
                          .toSet()
                          .take(3)
                          .toList();

                      final isSelected =
                          date.year == widget.selectedDate.year &&
                          date.month == widget.selectedDate.month &&
                          date.day == widget.selectedDate.day;

                      return ScheduleCalendarCell(
                        day: date.day,
                        isCurrentMonth: isInMonth,
                        indicators: indicators,
                        isSelected: isSelected,
                        onTap: () {
                          // setState(() {
                          //   selectedDate = date;
                          // });

                          widget.onDateSelected(date);

                          widget.onDayEventsTap(date, events);
                        },
                      );
                    },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
