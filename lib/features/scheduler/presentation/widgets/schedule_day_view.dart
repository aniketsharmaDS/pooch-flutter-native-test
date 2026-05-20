// import 'package:flutter/material.dart';
// import 'package:poochcare/features/scheduler/presentation/widgets/schedule_day_header.dart';
// import 'package:poochcare/features/scheduler/presentation/widgets/schedule_event_tile.dart';
// import 'package:poochcare/features/scheduler/presentation/widgets/schedule_time_column.dart';

// class ScheduleEventModel {
//   final String title;
//   final DateTime startTime;
//   final DateTime endTime;
//   final Color color;

//   const ScheduleEventModel({
//     required this.title,
//     required this.startTime,
//     required this.endTime,
//     required this.color,
//   });
// }

// class ScheduleDayView extends StatelessWidget {
//   const ScheduleDayView({
//     super.key,
//     required this.events,
//     required this.selectedDate,
//   });

//   final List<ScheduleEventModel> events;
//   final DateTime selectedDate;

//   static const double hourHeight = 80;

//   double _top(DateTime time) =>
//       ((time.hour * 60 + time.minute) / 60) * hourHeight;

//   double _height(DateTime start, DateTime end) =>
//       (end.difference(start).inMinutes / 60) * hourHeight;

//   @override
//   Widget build(BuildContext context) {
//     final dayEvents = events.where((event) {
//       return event.startTime.year == selectedDate.year &&
//           event.startTime.month == selectedDate.month &&
//           event.startTime.day == selectedDate.day;
//     }).toList();

//     return Container(
//       margin: const EdgeInsets.all(16),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Column(
//         children: [
//           /// HEADER
//           ScheduleDayHeader(date: selectedDate),

//           const SizedBox(height: 16),

//           /// BODY
//           Expanded(
//             child: SingleChildScrollView(
//               child: SizedBox(
//                 height: 24 * hourHeight,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     /// TIME COLUMN
//                     const ScheduleTimeColumn(hourHeight: hourHeight),

//                     /// GRID + EVENTS
//                     Expanded(
//                       child: Stack(
//                         children: [
//                           /// GRID BACKGROUND
//                           Column(
//                             children: List.generate(24, (index) {
//                               return Container(
//                                 height: hourHeight,
//                                 decoration: const BoxDecoration(
//                                   border: Border(
//                                     top: BorderSide(color: Color(0xFFEAEAEA)),
//                                   ),
//                                 ),
//                               );
//                             }),
//                           ),

//                           /// EVENTS (HEIGHT = DURATION)
//                           ...dayEvents.map((event) {
//                             final top = _top(event.startTime);

//                             final height = _height(
//                               event.startTime,
//                               event.endTime,
//                             );

//                             return Positioned(
//                               top: top,
//                               left: 4,
//                               right: 4,
//                               child: SizedBox(
//                                 height: height.clamp(20, double.infinity),
//                                 child: ScheduleEventTile(
//                                   title: event.title,
//                                   time:
//                                       '${event.startTime.hour}:${event.startTime.minute.toString().padLeft(2, '0')}',
//                                   color: event.color,
//                                 ),
//                               ),
//                             );
//                           }),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/features/scheduler/domain/ui_models/schedule_item_ui_model.dart';
import 'package:poochcare/features/scheduler/presentation/widgets/schedule_day_header.dart';
import 'package:poochcare/features/scheduler/presentation/widgets/schedule_details_bottom_sheet.dart';

class ScheduleDayView extends StatelessWidget {
  const ScheduleDayView({
    super.key,
    required this.controller,
    required this.selectedDate,
    required this.onPageChange,
    this.onEdit,
    this.onDelete,
  });

  final EventController<Object?> controller;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onPageChange;
  final ValueChanged<ScheduleItemUIModel>? onEdit;
  final Future<void> Function(ScheduleItemUIModel item)? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          ScheduleDayHeader(date: selectedDate),

          const SizedBox(height: 12),

          /// DAY VIEW
          Expanded(
            child: DayView<Object?>(
              controller: controller,

              initialDay: selectedDate,

              backgroundColor: Colors.white,

              onPageChange: (date, pageIndex) {
                onPageChange(date);
              },

              hourIndicatorSettings: const HourIndicatorSettings(
                color: Color(0xFFEAEAEA),
              ),

              dayTitleBuilder: (_) => const SizedBox(),

              timeLineBuilder: (date) {
                return Container(
                  width: 50,
                  alignment: Alignment.topCenter,
                  child: Text(
                    '${date.hour.toString().padLeft(2, '0')}:00',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                );
              },

              eventTileBuilder:
                  (date, events, boundry, startDuration, endDuration) {
                    return GestureDetector(
                      onTap: () {
                        ScheduleDetailsBottomSheet.show(
                          context: context,

                          date: date,

                          events: events,
                          onEdit: onEdit,
                          onDelete: onDelete,
                        );
                      },
                      child: Column(
                        children: events.map((event) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),

                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 6,
                            ),

                            decoration: BoxDecoration(
                              color: event.color.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(10),
                            ),

                            child: Row(
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: event.color,
                                    shape: BoxShape.circle,
                                  ),
                                ),

                                const SizedBox(width: 6),

                                Expanded(
                                  child: Text(
                                    event.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
            ),
          ),
        ],
      ),
    );
  }
}
