// import 'package:flutter/material.dart';
// import 'package:poochcare/core/theme/app_colors.dart';
// import 'package:poochcare/core/theme/app_radius_size.dart';
// import 'package:poochcare/core/theme/app_spacing.dart';
// import 'package:poochcare/core/widgets/texts/app_text.dart';
// import 'package:poochcare/features/scheduler/presentation/widgets/schedule_calendar_cell.dart';

// class ScheduleCalendarDayModel {
//   final DateTime date;
//   final bool isCurrentMonth;
//   final List<Color> indicators;

//   const ScheduleCalendarDayModel({
//     required this.date,
//     required this.isCurrentMonth,
//     this.indicators = const [],
//   });
// }

// class ScheduleMonthView extends StatelessWidget {
//   const ScheduleMonthView({
//     super.key,
//     required this.days,
//     required DateTime selectedDate,
//     required ValueChanged<DateTime> onDateSelected,
//   });

//   final List<ScheduleCalendarDayModel> days;

//   @override
//   Widget build(BuildContext context) {
//     const weekDays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

//     return Container(
//       margin: const EdgeInsets.all(AppSpacing.s11),
//       padding: const EdgeInsets.all(AppSpacing.s12),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(AppRadiusSize.r20),
//           topRight: Radius.circular(AppRadiusSize.r20),
//         ),
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child: Row(
//               children: weekDays
//                   .map(
//                     (e) => Expanded(
//                       child: Center(
//                         child: AppText.h3(e, color: AppColors.textPrimary),
//                       ),
//                     ),
//                   )
//                   .toList(),
//             ),
//           ),

//           const SizedBox(height: 12),

//           GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: days.length,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 7,
//               mainAxisSpacing: 2.h,
//               crossAxisSpacing: 1.w,
//             ),
//             itemBuilder: (context, index) {
//               final item = days[index];

//               return ScheduleCalendarCell(
//                 day: item.date.day,
//                 isCurrentMonth: item.isCurrentMonth,
//                 indicators: item.indicators,
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

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
  });

  final List<CalendarEventData<Object?>> events;
  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<DateTime> onPageChanged;
  final void Function(DateTime date, List<CalendarEventData<Object?>> events)
  onDayEventsTap;

  @override
  State<ScheduleMonthView> createState() => _ScheduleMonthViewState();
}

class _ScheduleMonthViewState extends State<ScheduleMonthView> {
  // late final EventController<Object?> _controller;

  DateTime selectedDate = DateTime.now();

  final List<String> _weekDays = const [
    'Su',
    'Mo',
    'Tu',
    'We',
    'Th',
    'Fr',
    'Sa',
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = EventController<Object?>();
  //   _controller.addAll(widget.events);
  // }

  // @override
  // void didUpdateWidget(covariant ScheduleMonthView oldWidget) {
  //   super.didUpdateWidget(oldWidget);

  //   if (oldWidget.events != widget.events) {
  //     _controller.removeWhere((_) => true);
  //     _controller.addAll(widget.events);
  //   }
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  Widget _buildWeekHeader() {
    return Row(
      children: _weekDays
          .map((d) => Expanded(child: Center(child: AppText.h3(d))))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = EventController<Object?>();

    controller.addAll(widget.events);

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
              controller: controller,

              monthViewStyle: const MonthViewStyle(
                showBorder: false,
                safeAreaOption: SafeAreaOption(maintainBottomViewPadding: true),
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
                          date.year == selectedDate.year &&
                          date.month == selectedDate.month &&
                          date.day == selectedDate.day;

                      return ScheduleCalendarCell(
                        day: date.day,
                        isCurrentMonth: isInMonth,
                        indicators: indicators,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            selectedDate = date;
                          });

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
