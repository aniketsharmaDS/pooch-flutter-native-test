import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class ScheduleEventTile extends StatelessWidget {
  const ScheduleEventTile({
    super.key,
    required this.title,
    required this.time,
    required this.color,
  });

  final String title;
  final String time;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s10,
        vertical: AppSpacing.s8,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadiusSize.r8),
      ),
      child: Row(
        children: [
          AppIcon(AppIcons.svg.generic.clockFilled, size: 12),

          const SizedBox(width: 6),

          AppText.support(time, color: const Color(0XFF1D1B20)),

          const SizedBox(width: 12),

          Expanded(
            child: AppText.support(
              title,
              maxLines: 1,
              color: const Color(0XFF1D1B20),
            ),
          ),
        ],
      ),
    );
  }
}
