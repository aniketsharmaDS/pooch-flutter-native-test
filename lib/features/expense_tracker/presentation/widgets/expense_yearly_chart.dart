import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class ExpenseBarData {
  final String month;
  final double amount;
  final Color color;

  const ExpenseBarData({
    required this.month,
    required this.amount,
    required this.color,
  });
}

class ExpenseYearlyChart extends StatelessWidget {
  const ExpenseYearlyChart({super.key, required this.data, required this.year});

  final List<ExpenseBarData> data;
  final int year;

  @override
  Widget build(BuildContext context) {
    final maxAmount = data.isEmpty
        ? 0
        : data.map((e) => e.amount).reduce((a, b) => a > b ? a : b);
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText.h1(
          'Monthly Expenses for $year',
          fontSize: AppFontSize.fs16,
          color: const Color(0xFF3F3C36),
        ),

        AppSpacing.s15.hBox,

        SizedBox(
          height: 240.h,
          child: BarChart(
            BarChartData(
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipPadding: EdgeInsets.zero,
                  tooltipMargin: 2.h,
                  getTooltipColor: (_) => Colors.transparent,
                  fitInsideHorizontally: true,
                  fitInsideVertically: true,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final item = data[group.x.toInt()];

                    return BarTooltipItem(
                      '${item.amount.toInt()}',
                      TextStyle(
                        color: item.color,
                        fontSize: AppFontSize.fs11,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
              ),
              alignment: BarChartAlignment.spaceAround,
              maxY: maxAmount * 1.2,
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(
                  // sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  // sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  // sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: AppText.bodyS(data[value.toInt()].month),
                      );
                    },
                  ),
                ),
              ),
              barGroups: List.generate(data.length, (index) {
                final item = data[index];

                return BarChartGroupData(
                  x: index,
                  showingTooltipIndicators: const [0],
                  barRods: [
                    BarChartRodData(
                      toY: item.amount,
                      width: 14.w,
                      borderRadius: BorderRadius.circular(3.r),
                      color: item.color,
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
