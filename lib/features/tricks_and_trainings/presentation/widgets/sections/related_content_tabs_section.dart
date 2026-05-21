import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/Tabs/app_default_tab_bar.dart';

class RelatedContentTabsSection extends StatelessWidget {
  final String leftTitle;
  final String rightTitle;

  final ValueChanged<int>? onTabChanged;

  const RelatedContentTabsSection({
    super.key,
    required this.leftTitle,
    required this.rightTitle,
    this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
      child: AppDefaultRouteTabs(
        tabNames: [leftTitle, rightTitle],
        isScrollable: true,
        showContent: false,

        onTabChanged: onTabChanged,

        /// Dummy children
        children: const [SizedBox.shrink(), SizedBox.shrink()],
      ),
    );
  }
}
