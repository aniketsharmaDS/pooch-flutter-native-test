import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class OrderRefundInfoRow extends StatefulWidget {
  final String? orderStatus;
  final String refundAmount;
  final String refundPolicy;

  const OrderRefundInfoRow({
    super.key,
    this.orderStatus,
    required this.refundAmount,
    required this.refundPolicy,
  });

  @override
  State<OrderRefundInfoRow> createState() => _OrderRefundInfoRowState();
}

class _OrderRefundInfoRowState extends State<OrderRefundInfoRow> {
  bool _isPolicyExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Refund amount row
        if (widget.orderStatus == 'approved')
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.h4('Refund amount', color: const Color(0xFF1B1B1B)),
              AppText.h3(widget.refundAmount, color: const Color(0xFF1B1B1B)),
            ],
          ),
        // SizedBox(height: 24.h),

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
                  AppText.h4('Refund Policy', color: const Color(0xFF1B1B1B)),
                  AppIcon(
                    AppIcons.svg.generic.chevronDown,
                    size: 20.w,
                    color: const Color(0xFF1B1B1B),
                  ),
                ],
              ),
              if (_isPolicyExpanded) ...[
                SizedBox(height: 8.h),
                AppText.bodyM(
                  widget.refundPolicy,
                  color: const Color(0xFF1B1B1B),
                  maxLines: 10,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
