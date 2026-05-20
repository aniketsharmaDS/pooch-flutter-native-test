import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_font_size.dart';

import 'package:poochcare/core/widgets/texts/app_text.dart';

class ExpenseChartSection {
  final String title;
  final double amount;
  final Color color;

  const ExpenseChartSection({
    required this.title,
    required this.amount,
    required this.color,
  });
}

class ExpenseDonutChart extends StatelessWidget {
  const ExpenseDonutChart({
    super.key,
    required this.totalAmount,
    required this.sections,
  });

  final double totalAmount;
  final List<ExpenseChartSection> sections;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230.h,
      width: 230.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              startDegreeOffset: -90,

              ///visible gaps between slices
              sectionsSpace: 0,

              /// thicker donut
              centerSpaceRadius: 50.r,

              borderData: FlBorderData(show: false),
              pieTouchData: PieTouchData(enabled: false),

              sections: sections.map((section) {
                return PieChartSectionData(
                  value: section.amount,
                  color: section.color,

                  /// thicker arc for smoother look
                  radius: 45.r,

                  title: '',
                  showTitle: false,
                  borderSide: BorderSide.none,
                );
              }).toList(),
            ),
          ),

          /// CENTER TEXT (match screenshot exactly)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText.h1(
                'INR ${totalAmount.toInt()}',
                color: const Color(0xFF320E02),
                fontSize: AppFontSize.fs14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
