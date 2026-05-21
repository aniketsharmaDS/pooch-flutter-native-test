import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

/// ----------------------
/// MODEL
/// ----------------------
class SubscriptionPlan {
  final String title;
  final bool isBestValue;
  final String price;
  final bool isSelected;
  final bool isSubscribed;
  final List<String> features;

  SubscriptionPlan({
    required this.title,
    required this.isBestValue,
    required this.price,
    required this.isSelected,
    required this.isSubscribed,
    required this.features,
  });
}

/// ----------------------
/// VARIANT (NEW)
/// ----------------------
class SubscriptionPlanVariant {
  final List<Color> gradientColors;
  final Color titleColor;
  final Color infoBgColor;

  const SubscriptionPlanVariant({
    required this.gradientColors,
    required this.titleColor,
    required this.infoBgColor,
  });
}

/// Predefined variants
class SubscriptionPlanVariants {
  static const free = SubscriptionPlanVariant(
    gradientColors: [Color(0xFF26BB5D), Color(0xFF188C43)],
    titleColor: Color(0xFF188C43),
    infoBgColor: Color(0xFF0E5327),
  );

  static const monthly = SubscriptionPlanVariant(
    gradientColors: [Color(0xFFFFBC20), Color(0xFFFFDB88)],
    titleColor: Color(0xFFE7B123),
    infoBgColor: Color(0xFFB48A1B),
  );

  static const yearly = SubscriptionPlanVariant(
    gradientColors: [Color(0xFFFF8917), Color(0xFFFFD677)],
    titleColor: Color(0xFFF28A07),
    infoBgColor: Color(0xFF663A03),
  );
}

/// ----------------------
/// MAIN WIDGET
/// ----------------------

class ClinicSubscriptionPlanCard extends StatefulWidget {
  final SubscriptionPlan subscriptionPlan;
  final SubscriptionPlanVariant variant;
  final bool? isSelectable;
  final VoidCallback? onSelect;

  const ClinicSubscriptionPlanCard({
    super.key,
    required this.subscriptionPlan,
    required this.variant,
    this.isSelectable = true,
    this.onSelect,
  });

  @override
  State<ClinicSubscriptionPlanCard> createState() =>
      _ClinicSubscriptionPlanCardState();
}

class _ClinicSubscriptionPlanCardState extends State<ClinicSubscriptionPlanCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.subscriptionPlan.isSelected;
  }

  @override
  void didUpdateWidget(covariant ClinicSubscriptionPlanCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.subscriptionPlan.isSelected !=
        oldWidget.subscriptionPlan.isSelected) {
      _isSelected = widget.subscriptionPlan.isSelected;
    }
  }

  bool get _canExpand => widget.subscriptionPlan.features.length > 1;

  @override
  Widget build(BuildContext context) {
    final safeFeatures = widget.subscriptionPlan.features.isEmpty
        ? const ['Plan details are currently unavailable']
        : widget.subscriptionPlan.features;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: LinearGradient(
          colors: widget.variant.gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                _TopSection(
                  title: widget.subscriptionPlan.title,
                  isBestValue: widget.subscriptionPlan.isBestValue,
                  price: widget.subscriptionPlan.price,
                  isSelected: _isSelected,
                  isSubscribed: widget.subscriptionPlan.isSubscribed,
                  titleColor: widget.variant.titleColor,
                  onSelect: () {
                    if (!widget.isSelectable!) return;
                    setState(() {
                      _isSelected = !_isSelected;
                    });
                    if (widget.onSelect != null) {
                      widget.onSelect!();
                    }
                  },
                ),
                if (widget.subscriptionPlan.isSubscribed)
                  Positioned(
                    top: 2.h,
                    right: 2.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 9.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: Colors.transparent,
                              // width: 1.5,
                            ),
                          ),
                          child: Text(
                            'Subscribed',
                            style: TextStyle(
                              // fontFamily: Fonts.gilroySemibold,
                              fontSize: 12.sp,
                              color: Colors.black,
                              height: 1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            _InfoSection(
              primaryFeature: safeFeatures.first,
              otherFeatures: safeFeatures.skip(1).toList(),
              canExpand: _canExpand,
              isExpanded: _isExpanded,
              bgColor: widget.variant.infoBgColor,
              onToggle: () => setState(() => _isExpanded = !_isExpanded),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopSection extends StatelessWidget {
  final String title;
  final bool isBestValue;
  final String price;
  final bool isSelected;
  final bool isSubscribed;
  final Color titleColor;
  final VoidCallback? onSelect;

  const _TopSection({
    required this.title,
    required this.isBestValue,
    required this.price,
    required this.isSelected,
    required this.isSubscribed,
    required this.titleColor,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final buttonLabel = isSelected || isSubscribed ? 'Selected' : 'Select';

    return Container(
      color: Colors.white.withValues(alpha: 0.06),
      padding: EdgeInsets.fromLTRB(12.w, 5.h, 12.w, 0.h),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: SizedBox(
              height: 84.h,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        color: AppColors.white.withValues(alpha: 0.0),
                        child: AppIcon(AppIcons.png.nudges.poochHolder),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: 40.h,
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppText.displayXL(
                              title.toUpperCase(),
                              style: TextStyle(
                                fontSize: 32.sp,
                                color: titleColor,
                              ),
                            ),
                            if (isBestValue) ...[
                              AppText.displayL(
                                '(Best Value)',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: titleColor,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                AppText.h2(price),
                SizedBox(height: 3.h),
                AppButton(
                  width: 80.w,
                  label: buttonLabel,
                  onPressed: isSubscribed ? null : onSelect,
                  size: AppButtonSize.extraSmall,
                  height: 26.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  borderRadius: 8,
                  isPill: false,
                  backgroundColor: (isSelected && !isSubscribed)
                      ? AppColors.p2_50
                      : AppColors.buttonPrimaryBg,
                  textStyle: TextStyle(fontSize: 12.sp),
                  variant: !(isSelected)
                      ? AppButtonVariant.filled
                      : AppButtonVariant.outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final String primaryFeature;
  final List<String> otherFeatures;
  final bool canExpand;
  final bool isExpanded;
  final Color bgColor;
  final VoidCallback onToggle;

  const _InfoSection({
    required this.primaryFeature,
    required this.otherFeatures,
    required this.canExpand,
    required this.isExpanded,
    required this.bgColor,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: bgColor,
      padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: AppText.h4(
                  primaryFeature,
                  color: AppColors.white,
                  maxLines: 2,
                ),
              ),
              if (canExpand) ...[
                SizedBox(width: 10.w),
                AppButton(
                  onPressed: onToggle,
                  size: AppButtonSize.extraSmall,
                  width: null,
                  label: isExpanded ? 'Hide' : 'Details',
                  variant: AppButtonVariant.text,
                  trailingSvgAsset: isExpanded
                      ? AppIcons.svg.generic.chevronUp
                      : AppIcons.svg.generic.chevronRight,
                  height: 24.h,
                  foregroundColor: AppColors.white,
                  textStyle: TextStyle(fontSize: 12.sp),
                  padding: EdgeInsets.only(
                    top: 0.h,
                    bottom: 0.h,
                    right: 10.w,
                    left: 10.w,
                  ),
                ),
              ],
            ],
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: (canExpand && isExpanded)
                ? Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: otherFeatures
                          .map(
                            (feature) => Padding(
                              padding: EdgeInsets.only(bottom: 4.h),
                              child: AppText.bodyS(
                                '•   $feature',
                                color: AppColors.white,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
