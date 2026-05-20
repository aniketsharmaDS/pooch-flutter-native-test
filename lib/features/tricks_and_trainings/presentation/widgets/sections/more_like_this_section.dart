import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/headers/primary_widget_header.dart';

class MoreLikeThisSection extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final double? height;

  const MoreLikeThisSection({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PrimaryWidgetHeader(title: 'More Like This'),

        // AppSpacing.s16.hBox,
        SizedBox(
          height: height ?? 220.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
            itemCount: itemCount,
            separatorBuilder: (_, _) => AppSpacing.s12.wBox,
            itemBuilder: itemBuilder,
          ),
        ),
      ],
    );
  }
}
