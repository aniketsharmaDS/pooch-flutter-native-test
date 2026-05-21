import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/headers/primary_widget_header.dart';
import 'package:poochcare/core/widgets/stepper/app_dot_indicator.dart';

class MoreLikeThisSection extends StatefulWidget {
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
  State<MoreLikeThisSection> createState() => _MoreLikeThisSectionState();
}

class _MoreLikeThisSectionState extends State<MoreLikeThisSection> {
  final PageController _pageController = PageController(viewportFraction: 0.92);

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PrimaryWidgetHeader(title: 'More Like This'),

        // AppSpacing.s16.hBox,
        SizedBox(
          height: widget.height ?? 220.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            itemCount: widget.itemCount,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: widget.itemBuilder(context, index),
              );
            },
          ),
        ),
        AppSpacing.s12.hBox,

        if (widget.itemCount > 1)
          AppDotIndicator(
            itemCount: widget.itemCount,
            currentIndex: currentIndex,
          ),
      ],
    );
  }
}
