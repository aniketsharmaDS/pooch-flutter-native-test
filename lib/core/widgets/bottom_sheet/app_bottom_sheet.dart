import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/others/app_blur_overlay.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

enum HeaderVariant { titleInLeft, titleInCenter }

class AppBottomSheet {
  static Future<T?> show<T>({
    HeaderVariant? headerVariant = HeaderVariant.titleInCenter,
    required BuildContext context,
    required String title,
    required Widget content,
    required List<Widget>? actions,
    bool isDismissible = true,
    bool enableDrag = true,
    bool canPop = true,
    bool showCloseButton = true,
    Color? closeBtnBgColor = const Color(0xFFF5EFE3),
    double maxHeightFactor = 0.9,
    double blurStrength = 10,
    Color backgroundColor = AppColors.white,
    double borderRadius = 28,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.all(16),
    EdgeInsetsGeometry actionsPadding = const EdgeInsets.fromLTRB(
      20,
      8,
      20,
      16,
    ),
    bool showShadowAboveActions = false,
    double? initialHeightFactor,
    Color actionBackgroundColor = Colors.transparent,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: AppColors.transparent,
      barrierColor: AppColors.transparent,
      isScrollControlled: true,
      isDismissible: isDismissible,
      useSafeArea: true,
      enableDrag: enableDrag,
      builder: (sheetContext) {
        // final maxHeight =
        //     MediaQuery.sizeOf(sheetContext).height * maxHeightFactor;
        final screenHeight = MediaQuery.sizeOf(sheetContext).height;
        final maxHeight = screenHeight * maxHeightFactor;
        final hasFixedHeight = initialHeightFactor != null;
        final minHeight = hasFixedHeight
            ? screenHeight * initialHeightFactor
            : null;

        final bottomInset = MediaQuery.viewInsetsOf(sheetContext).bottom;

        return PopScope(
          canPop: canPop,
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(bottom: bottomInset),
            child: AppBlurOverlay(
              blurStrength: blurStrength,
              child: SafeArea(
                top: false,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: maxHeight,
                      minHeight: minHeight ?? 0,
                    ),
                    child: _BottomSheetLayout(
                      actionBackgroundColor: actionBackgroundColor,
                      showShadowAboveActions: showShadowAboveActions,
                      showTitleInLeft:
                          headerVariant == HeaderVariant.titleInLeft
                          ? true
                          : false,
                      title: title,
                      content: content,
                      actions: actions ?? [],
                      showCloseButton: showCloseButton,
                      closeBtnBgColor: closeBtnBgColor,
                      backgroundColor: backgroundColor,
                      borderRadius: borderRadius,
                      contentPadding: contentPadding,
                      actionsPadding: actionsPadding,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BottomSheetLayout extends StatelessWidget {
  const _BottomSheetLayout({
    required this.title,
    required this.content,
    required this.actions,
    required this.showCloseButton,
    required this.closeBtnBgColor,
    required this.backgroundColor,
    required this.borderRadius,
    required this.contentPadding,
    required this.actionsPadding,
    required this.showTitleInLeft,
    this.actionBackgroundColor = Colors.transparent,
    this.showShadowAboveActions = false,
  });
  final bool showTitleInLeft;

  final String title;
  final Widget content;
  final List<Widget> actions;
  final bool showCloseButton;
  final Color? closeBtnBgColor;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry actionsPadding;
  final bool showShadowAboveActions;
  final Color actionBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(borderRadius.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // SizedBox(
          //   height: 50.h,
          //   child: Stack(
          //     clipBehavior: Clip.none,
          //     children: [
          //       if (!showTitleInLeft)
          //         Align(
          //           child: Padding(
          //             padding: EdgeInsets.symmetric(
          //               horizontal: 60.w,
          //             ).copyWith(top: 18.h),
          //             child: AppText.h3(
          //               title,
          //               maxLines: 1,
          //               color: const Color(0xff260B01),
          //             ),
          //           ),
          //         )
          //       else
          //         Positioned(
          //           left: 25.w,
          //           top: 26.h,
          //           child: AppText.h3(
          //             title,
          //             maxLines: 1,
          //             color: const Color(0xff260B01),
          //           ),
          //         ),
          //       if (showCloseButton)
          //         Positioned(
          //           right: 15.w,
          //           top: 10.h,
          //           child: IconButton.filledTonal(
          //             style: IconButton.styleFrom(
          //               backgroundColor: showTitleInLeft
          //                   ? const Color(0xFFF5EEE8)
          //                   : AppColors.transparent,
          //               foregroundColor: const Color(0xFF8A6F63),
          //             ),
          //             onPressed: () => Navigator.of(context).pop(),
          //             icon: AppIcon(
          //               AppIcons.svg.generic.close,
          //               height: 15.w,
          //               width: 15.w,
          //             ),
          //           ),
          //         ),
          //     ],
          //   ),
          // ),
          if (title.isNotEmpty || showCloseButton)
            SizedBox(
              height: 50.h,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  if (title.isNotEmpty)
                    if (!showTitleInLeft)
                      Align(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 60.w,
                          ).copyWith(top: 18.h),
                          child: AppText.h3(
                            title,
                            maxLines: 1,
                            color: const Color(0xff260B01),
                          ),
                        ),
                      )
                    else
                      Positioned(
                        left: 25.w,
                        top: 26.h,
                        child: AppText.h3(
                          title,
                          maxLines: 1,
                          color: const Color(0xff260B01),
                        ),
                      ),

                  if (showCloseButton)
                    Positioned(
                      right: 15.w,
                      top: 10.h,
                      child: IconButton.filledTonal(
                        style: IconButton.styleFrom(
                          backgroundColor: showTitleInLeft
                              ? const Color(0xFFF5EEE8)
                              : AppColors.transparent,
                          foregroundColor: const Color(0xFF8A6F63),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        icon: AppIcon(
                          AppIcons.svg.generic.close,
                          height: 15.w,
                          width: 15.w,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          Flexible(
            child: SingleChildScrollView(
              padding: contentPadding,
              child: content,
            ),
          ),

          if (actions.isNotEmpty && showShadowAboveActions)
            Container(
              padding: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: 0.05,
                    ), // Very light shadow
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, -5), // Moves shadow to the TOP
                  ),
                ],
              ),
              child: Padding(
                padding: actionsPadding,
                child: Column(children: _withSpacing(actions, 10.h)),
              ),
            )
          else
            Container(
              color: actionBackgroundColor,
              padding: actionsPadding,
              child: Column(children: _withSpacing(actions, 10.h)),
            ),
        ],
      ),
    );
  }

  List<Widget> _withSpacing(List<Widget> widgets, double gap) {
    if (widgets.isEmpty) return const [];

    final spaced = <Widget>[];
    for (var i = 0; i < widgets.length; i++) {
      spaced.add(widgets[i]);
      if (i < widgets.length - 1) {
        spaced.add(SizedBox(height: gap));
      }
    }
    return spaced;
  }
}
