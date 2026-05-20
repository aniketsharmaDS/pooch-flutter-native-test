import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/headers/primary_widget_header.dart';
import 'package:poochcare/core/widgets/stepper/app_dot_indicator.dart';
import 'package:poochcare/features/tricks_and_trainings/domain/ui_models/tricks_and_training_ui_model.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/cards/tip_list_item_card.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/shimmers/tip_and_training_list_item_card_shimmer.dart';
import 'package:poochcare/router/app_router.dart';

class TipsSection extends StatefulWidget {
  final PrimaryWidgetHeaderVariant headerVariant;
  final List<TricksAndTrainingUIModel> tips;
  final bool isLoading;
  final String? error;
  final String? petId;

  const TipsSection({
    super.key,
    this.headerVariant = PrimaryWidgetHeaderVariant.standard,
    required this.tips,
    this.isLoading = false,
    this.error,
    this.petId,
  });

  @override
  State<TipsSection> createState() => _TipsSectionState();
}

class _TipsSectionState extends State<TipsSection> {
  final PageController _pageController = PageController(viewportFraction: 0.94);

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isLoading = widget.isLoading && widget.tips.isEmpty;
    final tips = widget.tips;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimaryWidgetHeader(
          title: 'Tips',
          buttonTitle: 'View All',
          onButtonTap: () {
            context.router.push(TipsListingRoute(petId: widget.petId));
          },
          variant: widget.headerVariant,
        ),

        /// 🔹 LOADING (shimmer PageView)
        if (isLoading)
          SizedBox(
            height: 86.h,
            child: PageView.builder(
              controller: _pageController,
              padEnds: false,
              itemCount: 3,
              itemBuilder: (_, _) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
                  child: const TipAndTrainingListItemCardShimmer(),
                );
              },
            ),
          )
        /// 🔹 ERROR
        else if (widget.error != null && tips.isEmpty)
          SizedBox(
            height: 86.h,
            child: Center(child: Text(widget.error!)),
          )
        /// 🔹 EMPTY
        else if (tips.isEmpty)
          SizedBox(
            height: 86.h,
            child: const Center(child: Text('No tips found')),
          )
        /// 🔹 SUCCESS
        else
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
                child: SizedBox(
                  height: 86.h,
                  child: PageView.builder(
                    controller: _pageController,
                    padEnds: false,
                    itemCount: tips.length,
                    onPageChanged: (index) {
                      setState(() => currentIndex = index);
                    },
                    itemBuilder: (_, index) {
                      final item = tips[index];

                      return Padding(
                        padding: EdgeInsets.only(right: AppSpacing.s8.w),
                        child: TipListItemCard(
                          imageUrl: item.thumbnail.isNotEmpty
                              ? item.thumbnail
                              : item.image,
                          title: item.title,
                          description: item.shortDescription,
                          onTap: () {
                            context.router.push(
                              TipDetailsRoute(contentId: item.id),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),

              AppSpacing.s12.hBox,

              if (tips.length > 1)
                AppDotIndicator(
                  itemCount: tips.length,
                  currentIndex: currentIndex,
                ),
            ],
          ),
      ],
    );
  }
}
