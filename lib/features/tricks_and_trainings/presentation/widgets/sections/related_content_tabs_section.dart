import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/Tabs/app_default_tab_bar.dart';

class RelatedContentTabsSection extends StatelessWidget {
  final String leftTitle;
  final String rightTitle;

  final Widget leftScreen;
  final Widget rightScreen;

  final VoidCallback? onLeftTabTap;

  final VoidCallback? onRightTabTap;

  const RelatedContentTabsSection({
    super.key,
    required this.leftTitle,
    required this.rightTitle,
    required this.leftScreen,
    required this.rightScreen,
    this.onLeftTabTap,
    this.onRightTabTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
        child: AppDefaultRouteTabs(
          tabNames: [leftTitle, rightTitle],
          isScrollable: true,
          children: [leftScreen, rightScreen],
          onTabChanged: (value) {
            if (value == 0) {
              onLeftTabTap?.call();
            } else {
              onRightTabTap?.call();
            }
          },
        ),
      ),
    );
  }
}
