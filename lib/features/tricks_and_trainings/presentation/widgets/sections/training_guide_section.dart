import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/headers/primary_widget_header.dart';
import 'package:poochcare/core/widgets/stepper/app_dot_indicator.dart';
import 'package:poochcare/features/tricks_and_trainings/domain/ui_models/tricks_and_training_ui_model.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/cards/training_list_item_card.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/shimmers/tip_and_training_list_item_card_shimmer.dart';
import 'package:poochcare/router/app_router.dart';

class TrainingGuideSection extends StatefulWidget {
  final PrimaryWidgetHeaderVariant headerVariant;
  final List<TricksAndTrainingUIModel> trainings;
  final String? petId;
  final bool isLoading;
  final String? error;

  const TrainingGuideSection({
    super.key,
    this.headerVariant = PrimaryWidgetHeaderVariant.standard,
    required this.trainings,
    this.petId,
    this.isLoading = false,
    this.error,
  });

  @override
  State<TrainingGuideSection> createState() => _TrainingGuideSectionState();
}

class _TrainingGuideSectionState extends State<TrainingGuideSection> {
  final PageController _pageController = PageController(viewportFraction: 0.92);

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isLoading = widget.isLoading && widget.trainings.isEmpty;
    final trainings = widget.trainings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimaryWidgetHeader(
          title: 'Training Guide',
          buttonTitle: 'View All',
          onButtonTap: () {
            context.router.push(TrainingsListingRoute(petId: widget.petId));
          },
          variant: widget.headerVariant,
        ),

        /// 🔹 LOADING (shimmer PageView)
        if (isLoading)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
            child: SizedBox(
              height: 86.h,
              child: PageView.builder(
                controller: _pageController,
                padEnds: false,
                itemCount: 3,
                itemBuilder: (_, _) => const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: TipAndTrainingListItemCardShimmer(),
                ),
              ),
            ),
          )
        /// 🔹 ERROR
        else if (widget.error != null && trainings.isEmpty)
          SizedBox(
            height: 86.h,
            child: Center(child: Text(widget.error!)),
          )
        /// 🔹 EMPTY
        else if (trainings.isEmpty)
          SizedBox(
            height: 86.h,
            child: const Center(child: Text('No trainings found')),
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
                    itemCount: trainings.length,
                    padEnds: false,
                    onPageChanged: (index) {
                      setState(() => currentIndex = index);
                    },
                    itemBuilder: (_, index) {
                      final item = trainings[index];

                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: TrainingListItemCard(
                          imageUrl: item.thumbnail.isNotEmpty
                              ? item.thumbnail
                              : item.image,
                          title: item.title,
                          description: item.shortDescription,
                          steps: '7 Step',
                          onTap: () {
                            context.router.push(
                              TrainingDetailsRoute(contentId: item.id),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),

              AppSpacing.s12.hBox,

              if (trainings.length > 1)
                AppDotIndicator(
                  itemCount: trainings.length,
                  currentIndex: currentIndex,
                ),
            ],
          ),
      ],
    );
  }
}
