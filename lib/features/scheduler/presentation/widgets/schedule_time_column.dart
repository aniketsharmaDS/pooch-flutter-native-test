import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class ScheduleTimeColumn extends StatelessWidget {
  const ScheduleTimeColumn({super.key, required this.hourHeight});

  final double hourHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      child: Column(
        children: List.generate(24, (index) {
          return SizedBox(
            height: hourHeight,
            child: Align(
              alignment: Alignment.topCenter,
              child: AppText.bodyS(
                fontSize: AppFontSize.fs10,
                '${index.toString().padLeft(2, '0')}:00',
                color: const Color(0XFF0D0D0D),
              ),
            ),
          );
        }),
      ),
    );
  }
}
