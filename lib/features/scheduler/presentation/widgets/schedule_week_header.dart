import 'package:flutter/material.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class ScheduleWeekHeader extends StatelessWidget {
  const ScheduleWeekHeader({super.key, required this.weekDates});

  final List<DateTime> weekDates;

  @override
  Widget build(BuildContext context) {
    const weekDays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

    return Row(
      children: [
        const SizedBox(width: 52),

        Expanded(
          child: Row(
            children: List.generate(weekDates.length, (i) {
              return Expanded(
                child: Column(
                  children: [
                    AppText.h3(weekDays[i]),
                    const SizedBox(height: 4),
                    AppText.bodyS('${weekDates[i].day}'),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
