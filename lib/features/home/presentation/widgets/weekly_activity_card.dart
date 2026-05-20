import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/cards/app_glass_card.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class WeeklyActivityCard extends StatelessWidget {
  final List<DayActivity> days;
  final String summaryText;

  const WeeklyActivityCard({
    super.key,
    required this.days,
    this.summaryText = 'Average 3 sessions\nper day observed',
  });

  @override
  Widget build(BuildContext context) {
    return AppGlassCard(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.s16.w),
        child: Row(
          children: [
            /// Left Text Section (takes remaining space)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppText.bodyL('Weekly', fontSize: 16),
                      const SizedBox(width: 4),
                      AppText.bodyL(
                        'Activity',
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  AppText.support(summaryText, fontSize: 14, maxLines: 2),
                ],
              ),
            ),

            /// Right Bars Section (only takes needed width)
            Row(
              mainAxisSize: MainAxisSize.min, // important
              children: days
                  .map(
                    (day) => Padding(
                      padding: EdgeInsets.only(left: AppSpacing.s4.w),
                      child: _DayBar(day: day),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),

        // Row(
        //   children: [
        //     /// Left Text Section
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Row(
        //           children:  [
        //             AppText.bodyL('Weekly', fontSize: 16,),
        //             const SizedBox(width: 4),
        //             AppText.bodyL('Activity', fontSize: 16,color: Colors.grey),
        //           ],
        //         ),
        //         const SizedBox(height: 8),
        //         AppText.support('Average 3 sessions per day observed', fontSize: 14,),
        //       ],
        //     ),
        //     const Spacer(),
        //     /// Right Bars Section
        //     Row(
        //       children: days
        //           .map((day) => Padding(
        //                 padding: EdgeInsets.only(left: AppSpacing.s4.w),
        //                 child: _DayBar(day: day),
        //               ))
        //           .toList(),
        //     )
        //   ],
        // ),
      ),
    );
  }
}

/// Model for each day
class DayActivity {
  final String label;
  final double height;
  final Color color;

  DayActivity({required this.label, required this.height, required this.color});
}

/// Individual Bar Widget
class _DayBar extends StatelessWidget {
  final DayActivity day;

  const _DayBar({required this.day});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: AppSize.cs40.csw,
          height: day.height,
          decoration: BoxDecoration(
            color: day.color,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            day.label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
