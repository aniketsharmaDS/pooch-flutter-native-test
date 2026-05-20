import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/images/app_image_cached_widget.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class TipsAndTrainingBottomSheet {
  static Future<void> show({
    required BuildContext context,
    required List<dynamic> carousels,
    required int initialPage,
  }) async {
    final pageController = PageController(initialPage: initialPage);

    final currentPageNotifier = ValueNotifier<int>(initialPage);

    await AppBottomSheet.show<void>(
      backgroundColor: AppColors.primarybackground,
      context: context,
      showCloseButton: false,

      /// Hide default title
      title: '',

      actionBackgroundColor: AppColors.white,

      actionsPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.s18.w,
        vertical: AppSpacing.s16.h,
      ),

      contentPadding: EdgeInsets.zero,

      /// ACTION BUTTON
      actions: [
        ValueListenableBuilder<int>(
          valueListenable: currentPageNotifier,
          builder: (_, currentPage, _) {
            final isLastPage = currentPage == carousels.length - 1;

            return AppButton(
              label: isLastPage ? 'Done' : 'Next',
              onPressed: () {
                if (isLastPage) {
                  Navigator.pop(context);
                } else {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
            );
          },
        ),
      ],

      /// CONTENT
      content: Padding(
        padding: EdgeInsets.all(AppSpacing.s16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// CUSTOM HEADER
            Stack(
              alignment: Alignment.center,
              children: [
                /// CENTER TITLE
                ValueListenableBuilder<int>(
                  valueListenable: currentPageNotifier,
                  builder: (_, currentPage, _) {
                    return AppText.h1(
                      '${currentPage + 1} of ${carousels.length}',
                      fontSize: AppFontSize.fs16,
                      color: AppColors.textPrimary,
                    );
                  },
                ),

                /// CUSTOM CLOSE BUTTON
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: EdgeInsets.all(AppSpacing.s4.w),
                      child: AppIcon(AppIcons.svg.generic.close),
                    ),
                  ),
                ),
              ],
            ),

            AppSpacing.s20.hBox,

            /// CAROUSEL
            SizedBox(
              height: 276.h,
              child: PageView.builder(
                controller: pageController,
                itemCount: carousels.length,
                onPageChanged: (index) {
                  currentPageNotifier.value = index;
                },
                itemBuilder: (_, index) {
                  final item = carousels[index];

                  final String imageUrl = item.image?.toString() ?? '';

                  final String title = item.title?.toString() ?? '';

                  final String description = item.description?.toString() ?? '';

                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.s20),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppRadiusSize.r12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// IMAGE
                        imageUrl.isEmpty
                            ? Container(
                                width: double.infinity,
                                height: 140.h,
                                decoration: BoxDecoration(
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.circular(
                                    AppRadiusSize.r12,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: AppIcon(AppIcons.svg.generic.poochTail),
                              )
                            : AppImageCachedWidget(
                                width: double.infinity,
                                imageUrl: imageUrl,
                                height: 140.h,
                                borderRadius: BorderRadius.circular(
                                  AppRadiusSize.r12,
                                ),
                              ),

                        AppSpacing.s16.hBox,

                        /// TITLE
                        AppText.bodyL(
                          title,
                          fontSize: AppFontSize.fs18,
                          color: AppColors.textPrimary,
                        ),

                        AppSpacing.s16.hBox,

                        /// DESCRIPTION
                        AppText.bodyS(
                          description,
                          fontSize: AppFontSize.fs12,
                          color: AppColors.p5_700,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
