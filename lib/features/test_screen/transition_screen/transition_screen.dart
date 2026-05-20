import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/cards/message_shape_card.dart';
import 'package:poochcare/features/test_screen/transition_screen/widgets/close_missing_pooch_bottom.dart';
import 'package:poochcare/features/test_screen/transition_screen/widgets/no_match_found_bottom.dart';
import 'package:poochcare/features/test_screen/transition_screen/widgets/on_boarding_success_bottom.dart';
import 'package:poochcare/features/test_screen/transition_screen/widgets/order_cancelled_bottom.dart';
import 'package:poochcare/features/test_screen/transition_screen/widgets/pooch_will_be_home_soon_bottom.dart';
import 'package:poochcare/features/test_screen/transition_screen/widgets/retry_payment_bottom.dart';
import 'package:poochcare/features/test_screen/transition_screen/widgets/return_request_submitted_bottom.dart';
import 'package:poochcare/features/test_screen/transition_screen/widgets/we_are_here_with_you_bottom.dart';

enum TransitionScreenVariant {
  retryPayment,
  onBoardingSuccess,
  petAddedSuccess,
  returnRequestSubmitted,
  orderCancelled,
  noMatchFound,
  closeMissingPooch,
  poochWillBeHomeSoon,
  weAreHereWithYou,
}

@RoutePage()
class TransitionScreen extends StatelessWidget {
  final TransitionScreenVariant variant;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final VoidCallback? onTertiaryPressed;
  final String? petName;

  const TransitionScreen({
    super.key,
    required this.variant,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.onTertiaryPressed,
    this.petName,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    final title = getTitle(variant: variant);
    final description = getDescription(variant: variant);
    final lottie = getLottiePath(variant: variant);
    final leftLottiePosition = getLottieLeftPosition(variant: variant);
    final lottieTopPosition =
        variant == TransitionScreenVariant.closeMissingPooch ? -30.0 : -10.0;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          Column(
            children: [
              MessageShapeCard(
                imagePositionFromTop: lottieTopPosition,
                imagePositionFromLeft: leftLottiePosition,
                backgroundColor: const Color(0xFFFFE7B4),
                margin: EdgeInsets.symmetric(horizontal: 10.h),
                lottieAsset: lottie,
                headerTitle: title,
                headerDescription: description,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    24.w,
                    20.h,
                    24.w,
                    20.h + bottomInset,
                  ),
                  child: _TransitionBottomContent(
                    variant: variant,
                    onPrimaryPressed: onPrimaryPressed,
                    onSecondaryPressed: onSecondaryPressed,
                    onTertiaryPressed: onTertiaryPressed,
                    petName: petName ?? 'your pooch',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getTitle({required TransitionScreenVariant variant}) {
    switch (variant) {
      case TransitionScreenVariant.retryPayment:
        return 'Oops! Your\npayment did not\ngo through.';
      case TransitionScreenVariant.onBoardingSuccess:
        return 'Onboarding\nSuccessful';
      case TransitionScreenVariant.petAddedSuccess:
        return 'Pet Added\nSuccessfully';
      case TransitionScreenVariant.returnRequestSubmitted:
        return 'Return request\n submitted!';
      case TransitionScreenVariant.orderCancelled:
        return 'Your order has\nbeen cancelled';
      case TransitionScreenVariant.noMatchFound:
        return 'No Match found!';
      case TransitionScreenVariant.closeMissingPooch:
        return 'Paw-some!\nYour pooch is home';
      case TransitionScreenVariant.poochWillBeHomeSoon:
        return 'Don’t worry,\nthey’ll be home soon';
      case TransitionScreenVariant.weAreHereWithYou:
        return 'We’re Here\nWith You!';
    }
  }

  /// | Order Return | `-8.0` |
  /// | Dog Moving Tail | `10.0` |
  double? getLottieLeftPosition({required TransitionScreenVariant variant}) {
    switch (variant) {
      case TransitionScreenVariant.retryPayment:
        return null;
      case TransitionScreenVariant.onBoardingSuccess:
        return 10.0;
      case TransitionScreenVariant.petAddedSuccess:
        return 10.0;
      case TransitionScreenVariant.returnRequestSubmitted:
        return -8.0;
      case TransitionScreenVariant.orderCancelled:
        return null;
      case TransitionScreenVariant.noMatchFound:
        return null;
      case TransitionScreenVariant.closeMissingPooch:
        return null;
      case TransitionScreenVariant.poochWillBeHomeSoon:
        return null;
      case TransitionScreenVariant.weAreHereWithYou:
        return null;
    }
  }

  String getDescription({required TransitionScreenVariant variant}) {
    switch (variant) {
      case TransitionScreenVariant.retryPayment:
        return 'Retry your payment to buy Pooch.';
      case TransitionScreenVariant.onBoardingSuccess:
        return 'Your babies are in good hands';
      case TransitionScreenVariant.petAddedSuccess:
        return 'Your pet has been added successfully. You can now manage their profile and health details.';
      case TransitionScreenVariant.returnRequestSubmitted:
        return 'We’re processing your request. You’ll\n receive your refund details shortly.';
      case TransitionScreenVariant.orderCancelled:
        return 'We’re processing your refund and\nwill update you soon.';
      case TransitionScreenVariant.noMatchFound:
        return 'This scan didn’t find a\nmatch in our records.';
      case TransitionScreenVariant.closeMissingPooch:
        return '';
      case TransitionScreenVariant.poochWillBeHomeSoon:
        return 'Our pooch community is keeping an\neye out. Your little one will be back\nwith you soon.';
      case TransitionScreenVariant.weAreHereWithYou:
        return 'We’re sorry your pooch\n$petName is missing.';
    }
  }

  String getLottiePath({required TransitionScreenVariant variant}) {
    switch (variant) {
      case TransitionScreenVariant.retryPayment:
        return AppIcons.lottie.sadDog;
      case TransitionScreenVariant.onBoardingSuccess:
        return AppIcons.lottie.dogMovingTail;
      case TransitionScreenVariant.petAddedSuccess:
        return AppIcons.lottie.dogMovingTail;
      case TransitionScreenVariant.returnRequestSubmitted:
        return AppIcons.lottie.returnOrder;
      case TransitionScreenVariant.orderCancelled:
        return AppIcons.lottie.orderCancel;
      case TransitionScreenVariant.noMatchFound:
        return AppIcons.lottie.sadDog;
      case TransitionScreenVariant.closeMissingPooch:
        return AppIcons.lottie.sadDog;
      case TransitionScreenVariant.poochWillBeHomeSoon:
        return AppIcons.lottie.sadDog;
      case TransitionScreenVariant.weAreHereWithYou:
        return AppIcons.lottie.sadDog;
    }
  }
}

class _TransitionBottomContent extends StatelessWidget {
  final TransitionScreenVariant variant;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final VoidCallback? onTertiaryPressed;
  final String? petName;

  const _TransitionBottomContent({
    required this.variant,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.onTertiaryPressed,
    this.petName,
  });

  @override
  Widget build(BuildContext context) {
    return switch (variant) {
      TransitionScreenVariant.retryPayment => RetryPaymentBottom(
        onLaterPressed: onSecondaryPressed,
        onTryAgainPressed: onPrimaryPressed,
      ),
      TransitionScreenVariant.onBoardingSuccess => OnBoardingSuccessBottom(
        onAddAnotherPetPressed: onSecondaryPressed,
        onContinuePressed: onPrimaryPressed,
      ),
      TransitionScreenVariant.petAddedSuccess => OnBoardingSuccessBottom(
        promptText: 'Do you want to add another pet or continue to home?',
        continueLabel: 'Continue to Home',
        onAddAnotherPetPressed: onSecondaryPressed,
        onContinuePressed: onPrimaryPressed,
      ),
      TransitionScreenVariant.returnRequestSubmitted =>
        ReturnRequestSubmittedBottom(
          onTrackStatusPressed: onSecondaryPressed,
          onOkayPressed: onPrimaryPressed,
          onNeedHelpPressed: onTertiaryPressed,
        ),
      TransitionScreenVariant.orderCancelled => OrderCancelledBottom(
        onTrackStatusPressed: onSecondaryPressed,
        onOkayPressed: onPrimaryPressed,
        onNeedHelpPressed: onTertiaryPressed,
      ),
      TransitionScreenVariant.noMatchFound => NoMatchFoundBottom(
        onManualSearchPressed: onSecondaryPressed,
        onContactSheltersPressed: onPrimaryPressed,
      ),
      TransitionScreenVariant.closeMissingPooch => CloseMissingPoochBottom(
        onKeepOpenPressed: onSecondaryPressed,
        onCloseReportPressed: onPrimaryPressed,
      ),
      TransitionScreenVariant.poochWillBeHomeSoon => PoochWillBeHomeSoonBottom(
        onContinuePressed: onPrimaryPressed,
      ),
      TransitionScreenVariant.weAreHereWithYou => WeAreHereWithYouBottom(
        onViewPostPressed: onPrimaryPressed,
        petName: petName ?? 'your pooch',
      ),
    };
  }
}
