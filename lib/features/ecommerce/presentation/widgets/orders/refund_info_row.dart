import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class RefundInfoRows extends StatefulWidget {
  final String? orderStatus;
  final String refundPolicy;

  const RefundInfoRows({
    super.key,
    this.orderStatus,
    required this.refundPolicy,
  });

  @override
  State<RefundInfoRows> createState() => _RefundInfoRowsState();
}

class _RefundInfoRowsState extends State<RefundInfoRows> {
  bool _isPolicyExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      // padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          // Refund policy row (expandable)
          InkWell(
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                _isPolicyExpanded = !_isPolicyExpanded;
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.h1(
                      'Refund Policy',
                      color: const Color(0xFF49454F),
                      fontSize: AppFontSize.fs14,
                    ),
                    Icon(
                      _isPolicyExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColors.textPrimary,
                      size: 20.w,
                    ),
                  ],
                ),
                if (_isPolicyExpanded) ...[
                  AppSpacing.s8.hBox,
                  AppText.support(
                    widget.refundPolicy,
                    color: const Color(0xFF49454F),
                    fontSize: AppFontSize.fs12,
                    maxLines: 5,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
