import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poochcare/core/widgets/stepper/app_vertical_stepper.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';

class OrderTrackBottomSheet {
  static Future<void> show({
    required BuildContext context,
    required OrderItemModel order,
    required List<AppVerticalStepperItem> steps,
    required int currentStep,
    String title = 'Track your Order',
  }) {
    return AppBottomSheet.show(
      context: context,
      title: title,
      content: _TrackOrderContent(
        order: order,
        steps: steps,
        currentStep: currentStep,
      ),
      actions: const [],
      backgroundColor: AppColors.primarybackground,
      closeBtnBgColor: Colors.transparent,
      borderRadius: AppRadiusSize.r12,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.s16.w,
        vertical: AppSpacing.s12.h,
      ),
    );
  }
}

class _TrackOrderContent extends StatelessWidget {
  final OrderItemModel order;
  final List<AppVerticalStepperItem> steps;
  final int currentStep;

  const _TrackOrderContent({
    required this.order,
    required this.steps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.s12.w,
        vertical: AppSpacing.s14.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadiusSize.r12),
      ),
      child: SingleChildScrollView(
        child: AppVerticalStepper(items: steps, currentStep: currentStep),
      ),
    );
  }
}
