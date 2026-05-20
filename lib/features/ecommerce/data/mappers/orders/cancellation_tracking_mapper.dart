import 'package:poochcare/core/widgets/stepper/app_vertical_stepper.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_details_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';
import 'package:poochcare/features/ecommerce/domain/utils/tracking_utils.dart';

class CancellationTrackingMapper {
  static (List<AppVerticalStepperItem>, int) map({
    required OrderDetailModel order,
    required OrderItemModel item,
  }) {
    // 🔥 paste your existing _mapCancellationFlow body

    final status = item.cancellationStatus?.toLowerCase();
    final steps = <AppVerticalStepperItem>[];

    final tracking = order.cancellationTracking;

    /// 🔹 Extract data
    final request = tracking.firstWhere((e) => e.type == 'request');

    final review = tracking.any((e) => e.type == 'review')
        ? tracking.firstWhere((e) => e.type == 'review')
        : null;

    final decision = tracking.any((e) => e.type == 'decision')
        ? tracking.firstWhere((e) => e.type == 'decision')
        : null;

    final decisionValue = decision?.decision?.toLowerCase();

    /// 🔹 timestamps (NO wrong fallback)
    final requestTs =
        request.requestedAt ?? request.createdAt ?? order.createdAt;
    final reviewTs = review?.reviewedAt;
    final decisionTs = decision?.decidedAt;

    final refundInitiatedAt = decision?.refundInitiatedAt;
    final completedAt = decision?.completedAt;

    /// 🔹 messages
    final requestText =
        'We’ve received your cancellation request.\n'
        'Reason: ${TrackingUtils.formatReason(request.reason)}';

    final reviewText = review != null
        ? (review.adminNotes != null && review.adminNotes!.isNotEmpty
              ? 'Our team is reviewing your request.\nNote: ${review.adminNotes}'
              : 'Our team is reviewing your request. We’ll update you shortly.')
        : 'Your request will be reviewed shortly.';

    String decisionText;

    if (decision != null) {
      if (decision.decision == 'approved') {
        final refund = request.refundAmount ?? '0';
        decisionText =
            'Your cancellation has been approved.\n'
            'Refund of ₹$refund will be processed shortly.';
      } else {
        decisionText =
            'Your request couldn’t be approved.\n'
            'Please contact support if needed.';
      }
    } else {
      decisionText = 'We’ll notify you once a decision is made.';
    }

    /// 🔥 STEP INDEX (UPDATED)
    int currentStep = 1;

    // if (status == 'request_raised' || status == 'pending') {
    //   currentStep = 1;
    // } else if (status == 'been_reviewed') {
    //   currentStep = 2;
    // } else if (status == 'approved') {
    //   if (completedAt != null) {
    //     currentStep = 5;
    //   } else if (refundInitiatedAt != null) {
    //     currentStep = 4;
    //   } else {
    //     currentStep = 3;
    //   }
    // } else if (decisionValue == 'approved' || decisionValue == 'rejected') {
    //   currentStep = 3;
    // }

    /// 🔥 FINAL DECISION FIRST (highest priority)
    if (decisionValue == 'approved') {
      if (completedAt != null) {
        currentStep = 5;
      } else if (refundInitiatedAt != null) {
        currentStep = 4;
      } else {
        currentStep = 3;
      }
    } else if (decisionValue == 'rejected') {
      currentStep = 3;
    }
    /// 🔹 REVIEW
    else if (review != null) {
      currentStep = 2;
    }
    /// 🔹 REQUEST (default)
    else {
      currentStep = 1;
    }

    /// ===============================
    /// 1️⃣ ORDERED
    /// ===============================
    steps.add(
      AppVerticalStepperItem(
        title: 'Ordered ${TrackingUtils.formatTitleDate(order.createdAt)}',
        events: [
          AppVerticalStepperEvent(
            text: 'Your order has been placed',
            timestamp: TrackingUtils.format(order.createdAt),
          ),
        ],
      ),
    );

    /// ===============================
    /// 2️⃣ REQUEST RAISED
    /// ===============================
    steps.add(
      AppVerticalStepperItem(
        title: 'Cancellation Request Raised',
        events: [
          AppVerticalStepperEvent(
            text: requestText,
            timestamp: TrackingUtils.format(requestTs),
          ),
        ],
      ),
    );

    /// ===============================
    /// 3️⃣ UNDER REVIEW
    /// ===============================
    steps.add(
      AppVerticalStepperItem(
        title: 'Cancellation Request Under Review',
        events: currentStep >= 2
            ? [
                AppVerticalStepperEvent(
                  text: reviewText,
                  timestamp: reviewTs != null
                      ? TrackingUtils.format(reviewTs)
                      : '',
                ),
              ]
            : [AppVerticalStepperEvent(text: reviewText, timestamp: '')],
      ),
    );

    /// ===============================
    /// 4️⃣ DECISION
    /// ===============================
    if (currentStep >= 2) {
      final isApproved = decisionValue == 'approved';
      final isRejected = decisionValue == 'rejected';

      String title;

      if (isApproved) {
        title = 'Cancellation Request Approved';
      } else if (isRejected) {
        title = 'Cancellation Request Rejected';
      } else {
        title = 'Cancellation Decision Pending';
      }

      steps.add(
        AppVerticalStepperItem(
          title: title,
          events: decisionValue != null && decisionTs != null
              ? [
                  AppVerticalStepperEvent(
                    text: decisionText,
                    timestamp: TrackingUtils.format(decisionTs),
                  ),
                ]
              : [],
        ),
      );
    }

    /// ===============================
    /// 5️⃣ REFUND INITIATED (🔥 NEW)
    /// ===============================
    if (status == 'approved') {
      steps.add(
        AppVerticalStepperItem(
          title: 'Refund Initiated',
          events: refundInitiatedAt != null
              ? [
                  AppVerticalStepperEvent(
                    text:
                        'Your refund has been initiated. It may take 5-7 business days to reflect in your account.',
                    timestamp: TrackingUtils.format(refundInitiatedAt),
                  ),
                ]
              : [
                  const AppVerticalStepperEvent(
                    text: 'Refund will be initiated shortly.',
                    timestamp: '',
                  ),
                ],
        ),
      );
    }

    /// ===============================
    /// 6️⃣ REFUND COMPLETED (🔥 NEW)
    /// ===============================
    if (completedAt != null) {
      steps.add(
        AppVerticalStepperItem(
          title: 'Refund Completed',
          events: [
            AppVerticalStepperEvent(
              text: 'Refund has been successfully credited.',
              timestamp: TrackingUtils.format(completedAt),
            ),
          ],
        ),
      );
    }

    return (steps, currentStep);
  }
}
