import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class PriceSummarySection extends StatelessWidget {
  final String? title;
  final int itemCount;
  final List<PriceSummaryRow> rows;

  const PriceSummarySection({
    super.key,
    this.title,
    required this.itemCount,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.white_50,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.h1(
            title ?? 'Price Details ($itemCount items)',
            color: const Color(0xFF260B01),
            fontSize: 18.sp,
          ),
          SizedBox(height: 14.h),
          ..._buildRows(),
        ],
      ),
    );
  }

  List<Widget> _buildRows() {
    final widgets = <Widget>[];

    for (var i = 0; i < rows.length; i++) {
      final row = rows[i];

      if (row.isTotal && widgets.isNotEmpty) {
        widgets.add(SizedBox(height: 18.h));
      } else if (i > 0) {
        widgets.add(SizedBox(height: 10.h));
      }

      widgets.add(
        _buildRow(
          row.title,
          row.value,
          isTotal: row.isTotal,
          titleColor: row.titleColor,
          valueColor: row.valueColor,
        ),
      );
    }

    return widgets;
  }

  Widget _buildRow(
    String title,
    String value, {
    bool isTotal = false,
    Color? titleColor,
    Color? valueColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: isTotal
              ? AppText.h1(
                  title,
                  color: titleColor ?? AppColors.p4_900,
                  // style: const TextStyle(fontWeight: FontWeight.w600),
                )
              : AppText.h4(
                  title,
                  color: titleColor ?? AppColors.p5_400,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
        ),
        isTotal
            ? AppText.h1(
                value,
                color: valueColor ?? AppColors.p4_900,
                // style: const TextStyle(fontWeight: FontWeight.w600),
              )
            : AppText.h4(
                value,
                color: valueColor ?? AppColors.p5_400,
                style: const TextStyle(fontWeight: FontWeight.w400),
              ),
      ],
    );
  }
}

class PriceSummaryRow {
  final String title;
  final String value;
  final bool isTotal;
  final Color? titleColor;
  final Color? valueColor;

  const PriceSummaryRow({
    required this.title,
    required this.value,
    this.isTotal = false,
    this.titleColor,
    this.valueColor,
  });
}
