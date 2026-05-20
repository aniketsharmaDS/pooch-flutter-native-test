import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';

class WeekEventTile extends StatelessWidget {
  const WeekEventTile({
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
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon(AppIcons.svg.generic.clockFilled, size: 12),

          const SizedBox(width: 4),

          Flexible(
            child: Text(
              '$time $title',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10, color: Color(0xFF1D1B20)),
            ),
          ),
        ],
      ),
    );
  }
}
