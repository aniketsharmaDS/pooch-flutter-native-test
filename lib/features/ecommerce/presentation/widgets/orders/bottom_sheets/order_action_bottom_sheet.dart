import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/stepper/app_horizontal_stepper.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/cancellation_tracking_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';
import 'package:poochcare/features/ecommerce/data/types/orders/orders.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/need_help_button.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/order_item_basic_card.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/order_refund_info_row.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/refund_info_row.dart';

/// Unified Cancellation Bottom Sheet - handles both confirmation and status views
class OrderActionBottomSheet {
  static Future<void> show({
    required BuildContext context,
    required OrderActionBottomSheetMode mode,
    required OrderItemModel order,
    required String refundAmount,
    required String refundPolicy,
    required String selectedReason,
    List<CancellationTrackingModel>? tracking,
    String? otherReasonText,
    List<String> uploadedImages = const [],
    String? cancellationFee,
    VoidCallback? onConfirm,
    int currentStep = 0,
    String? orderStatus,
  }) {
    final content = mode == OrderActionBottomSheetMode.confirm
        ? _ConfirmCancellationContent(
            order: order,
            refundAmount: refundAmount,
            refundPolicy: refundPolicy,
            selectedReason: selectedReason,
            otherReasonText: otherReasonText,
            uploadedImages: uploadedImages,
            cancellationFee: cancellationFee,
            onConfirm: onConfirm,
          )
        : _CancellationStatusContent(
            order: order,
            refundAmount: refundAmount,
            refundPolicy: refundPolicy,
            tracking: tracking!,
            // currentStep: currentStep,
            orderStatus: orderStatus,
          );

    final title = mode == OrderActionBottomSheetMode.confirm
        ? 'Confirm Cancellation'
        : 'Cancellation Status';

    return AppBottomSheet.show(
      context: context,
      title: title,
      content: content,
      actions: const [],
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      // backgroundColor: Theme.of(context).colorScheme.primary,
      backgroundColor: const Color(0xFFFEF3E6),
      borderRadius: 12.r,
    );
  }
}

/// ======================================================
/// CONFIRM RETURN CONTENT
/// ======================================================

class _ConfirmCancellationContent extends StatelessWidget {
  final OrderItemModel order;
  final String refundAmount;
  final String refundPolicy;
  final String selectedReason;
  final String? otherReasonText;
  final List<String> uploadedImages;
  final String? cancellationFee;
  final VoidCallback? onConfirm;

  const _ConfirmCancellationContent({
    required this.order,
    required this.refundAmount,
    required this.refundPolicy,
    required this.selectedReason,
    this.otherReasonText,
    this.uploadedImages = const [],
    this.cancellationFee,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // final lang = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
          AppText.bodyM(
            'Do you really want to cancel this order?\nYou will be charged a cancellation fee.',
            fontSize: AppFontSize.fs16,
            color: const Color(0xFF461A02),
          ),
          AppSpacing.s16.hBox,

          OrderItemBasicCard(order: order),
          AppSpacing.s16.hBox,

          // Info note card
          Container(
            padding: EdgeInsets.all(AppSpacing.s10.w),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3E6),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.h3(
                  'Please Note',
                  fontSize: AppFontSize.fs14,
                  color: AppColors.textPrimary,
                ),
                AppSpacing.s8.hBox,
                AppText.bodyS(
                  'Post request approval you will receive refunded amount',
                  color: AppColors.textPrimary,
                  maxLines: 2,
                ),
              ],
            ),
          ),
          AppSpacing.s16.hBox,

          // Refund amount row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.h1(
                'Refund amount',
                fontSize: AppFontSize.fs14,
                color: const Color(0xFF49454F),
              ),
              AppText.h1(
                refundAmount,
                fontSize: AppFontSize.fs16,
                color: const Color(0xFF49454F),
              ),
            ],
          ),
          AppSpacing.s12.hBox,

          // Divider
          const Divider(thickness: 1, color: Color(0xFFA7A7A8)),
          AppSpacing.s16.hBox,

          // Refund info
          RefundInfoRows(
            // refundAmount: refundAmount,
            refundPolicy: refundPolicy,
          ),
          AppSpacing.s24.hBox,
          AppButton(
            label: 'Confirm Cancellations',
            height: AppSize.cs48.h,
            onPressed: onConfirm,
          ),
          AppSpacing.s6.hBox,
          // Need help
          NeedHelpButton(orderId: order.orderId, itemId: order.itemId),
          AppSpacing.s20.hBox,
        ],
      ),
    );
  }
}

/// ======================================================
/// RETURN STATUS CONTENT
/// ======================================================

class _CancellationStatusContent extends StatelessWidget {
  final OrderItemModel order;
  final String refundAmount;
  final String refundPolicy;
  // final int currentStep;
  final String? orderStatus;
  final List<CancellationTrackingModel> tracking;

  const _CancellationStatusContent({
    required this.order,
    required this.refundAmount,
    required this.refundPolicy,
    required this.tracking,
    // required this.currentStep,
    this.orderStatus,
  });

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // final lang = AppLocalizations.of(context)!;

    // final step = mapCancellationStep(order.cancellationStatus);

    final review = tracking.any((e) => e.type == 'review')
        ? tracking.firstWhere((e) => e.type == 'review')
        : null;

    final decision = tracking.any((e) => e.type == 'decision')
        ? tracking.firstWhere((e) => e.type == 'decision')
        : null;

    final decisionValue = decision?.decision?.toLowerCase();

    int step = 0;

    if (decisionValue == 'approved' || decisionValue == 'rejected') {
      step = 2;
    } else if (review != null) {
      step = 1;
    } else {
      step = 0;
    }

    String getStatusMessage() {
      if (decisionValue == 'approved') {
        return 'Your cancellation request has been approved. Refund will be processed shortly.';
      }

      if (decisionValue == 'rejected') {
        return review?.adminNotes != null && review!.adminNotes!.isNotEmpty
            ? 'Your request was not approved.\nReason: ${review.adminNotes}'
            : 'Your cancellation request was not approved.';
      }

      if (review != null) {
        return review.adminNotes != null && review.adminNotes!.isNotEmpty
            ? 'Your request is under review.\nNote: ${review.adminNotes}'
            : 'Your cancellation request is under review.';
      }

      return 'Your cancellation request has been submitted.';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
          AppText.bodyM(
            'Please see the status of your request below',
            maxLines: 2,
            fontSize: AppFontSize.fs16,
            color: const Color(0xFF461A02),
          ),
          SizedBox(height: 24.h),

          // Horizontal stepper
          // AppHorizontalStepper(
          //   steps: const [
          //     'Request\nRaised',
          //     'Been\nReviewed',
          //     'Request\nApproved',
          //     // 'Payment\nRefunded',
          //   ],
          //   currentStep: currentStep,
          // ),
          AppHorizontalStepper(
            steps: [
              'Request\nRaised',
              'Under\nReview',
              decisionValue == 'rejected'
                  ? 'Request\nRejected'
                  : 'Request\nApproved',
            ],
            currentStep: step,
          ),
          SizedBox(height: 24.h),

          // Note card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3E6),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.h3(
                  'Please Note',
                  fontSize: AppFontSize.fs14,
                  color: const Color(0xFF49454F),
                ),
                SizedBox(height: 8.h),
                AppText.bodyS(
                  getStatusMessage(),
                  color: const Color(0xFF1B1B1B),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Refund amount row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.h4('Refund amount', color: const Color(0xFF1B1B1B)),
              AppText.h3(refundAmount, color: const Color(0xFF1B1B1B)),
            ],
          ),
          SizedBox(height: 12.h),
          // Divider
          Divider(thickness: 1.h, color: const Color(0xFFA7A7A8)),
          SizedBox(height: 16.h),

          // Refund info
          OrderRefundInfoRow(
            orderStatus: orderStatus,
            refundAmount: refundAmount,
            refundPolicy: refundPolicy,
          ),
          SizedBox(height: 60.h),
          // Need help
          // NeedHelpButton(order: order),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

// How to Use
/**
 
void _openTrackOrderSheet() {
    final dummyOrder = _buildDummyOrder();

    final steps = [
      VerticalStepperItem(
        title: "Ordered Sat, 4th Nov '26",
        events: const [
          VerticalStepperEvent(
            text: 'Your order has been placed',
            timestamp: "Sat, 4th Nov '26 - 12:00 PM",
          ),
        ],
      ),
      VerticalStepperItem(
        title: "Ready to leave Tue 6th Nov '26",
        events: const [
          VerticalStepperEvent(
            text: 'Seller has processed your order',
            timestamp: "Sat, 4th Nov '26 - 12:00 PM",
          ),
          VerticalStepperEvent(
            text: 'Your pooch has been picked up',
            timestamp: "Sat, 4th Nov '26 - 12:00 PM",
          ),
        ],
      ),
      VerticalStepperItem(
        title: "Shipped Tue 6th Nov '26",
        events: const [
          VerticalStepperEvent(
            text: 'Your pooch has been shipped',
            timestamp: "Sat, 4th Nov '26 - 12:00 PM",
          ),
          VerticalStepperEvent(text: 'Yet to reach hub nearest you'),
          VerticalStepperEvent(text: 'Yet to be delivered'),
        ],
      ),
      const VerticalStepperItem(
        title: 'Expected to reach your door step by\nTomorrow',
      ),
    ];

    TrackOrderBottomSheet.show(
      context: context,
      order: dummyOrder,
      steps: steps,
      currentStep: 2,
    );
  }

 */
