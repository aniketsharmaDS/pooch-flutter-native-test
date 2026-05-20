import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/scheduler/domain/ui_models/schedule_item_ui_model.dart';
// import 'package:poochcare/features/scheduler/presentation/widgets/schedule_week_header.dart';

class ScheduleWeekView extends StatelessWidget {
  const ScheduleWeekView({
    super.key,
    required this.events,
    required this.selectedDate,
    required this.onPageChange,
    this.onEdit,
    this.onDelete,
    this.onEventTap,
    this.showMonth = false,
  });

  final List<CalendarEventData<Object?>> events;

  final DateTime selectedDate;
  final ValueChanged<DateTime> onPageChange;
  final ValueChanged<ScheduleItemUIModel>? onEdit;
  final Future<void> Function(ScheduleItemUIModel item)? onDelete;
  final ValueChanged<CalendarEventData<Object?>>? onEventTap;
  final bool showMonth;

  EventController<Object?> _buildController() {
    final controller = EventController<Object?>();

    controller.addAll(events);

    return controller;
  }

  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final controller = _buildController();
    // final startOfWeek = selectedDate.subtract(
    //   Duration(days: selectedDate.weekday - 1),
    // );
    // final weekDates = List.generate(
    //   7,
    //   (i) => startOfWeek.add(Duration(days: i)),
    // );

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),

      child: Column(
        children: [
          // ScheduleWeekHeader(weekDates: weekDates),

          // const SizedBox(height: 12),
          Expanded(
            child: WeekView<Object?>(
              controller: controller,
              weekDayBuilder: (date) {
                final short = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
                return SizedBox.expand(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText.h3(short[date.weekday % 7]),
                      const SizedBox(height: 4),
                      AppText.bodyS(date.day.toString()),
                    ],
                  ),
                );
              },
              startDay: WeekDays.sunday,

              heightPerMinute: 0.9,

              backgroundColor: Colors.white,

              onPageChange: (date, pageIndex) {
                onPageChange(date);
              },

              // weekTitleHeight: 0,
              timeLineWidth: 35,

              // weekNumberBuilder: (_) => const SizedBox.shrink(),

              // headerBuilder: (_) => const SizedBox.shrink(),

              ///  remove built-in weekday row
              weekNumberBuilder: (date) {
                if (!showMonth) return const SizedBox.shrink();
                return Center(
                  child: AppText.bodyM(
                    '${date.year}\n${_monthName(date.month)}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                );
              },
              weekTitleBackgroundColor: AppColors.transparent,

              weekPageHeaderBuilder: (_, _) => const SizedBox.shrink(),

              eventTileBuilder: (date, events, boundary, start, end) {
                final event = events.first;

                return GestureDetector(
                  onTap: () {
                    onEventTap?.call(event);
                  },
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 2,
                        vertical: 1,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: event.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: event.color.withValues(alpha: 0.4),
                        ),
                      ),

                      /// IMPORTANT
                      constraints: const BoxConstraints(
                        minHeight: 24,
                        maxHeight: 32,
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
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          if (events.length > 1)
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                '+${events.length - 1}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },

              timeLineBuilder: (date) {
                return Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Text(
                    '${date.hour.toString().padLeft(2, '0')}:00',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
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
