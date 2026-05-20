import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/utils/app_extensions/price_formatter_extension.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/insight/data/models/clinic_api_model.dart';

class ClinicGridItemCard extends StatelessWidget {
  final ClinicApiModel clinic;
  final VoidCallback? onTap;
  final VoidCallback? onSubscribe;
  final double? width;

  const ClinicGridItemCard({
    super.key,
    required this.clinic,
    this.onTap,
    this.onSubscribe,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final ctaCallback = onSubscribe ?? onTap;

    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: onTap,
        child: Container(
          width: width ?? 160.w,
          padding: EdgeInsets.symmetric(horizontal: 10.w).copyWith(top: 9.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ClinicImage(
                image: clinic.clinicImage,
                width: double.infinity,
                height: 132.h,
                borderRadius: 16.r,
                showPopularBadge: true,
              ),
              SizedBox(height: 12.h),
              _ClinicInfo(
                name: clinic.clinicName,
                experience: 'Years of service: ${clinic.years}',
                location: clinic.city,
              ),
              SizedBox(height: 6.h),
              _ClinicPriceCTA(
                price: getMinimumPrice(minimumprice: clinic.minConsultationFee),
                ctaText: 'Subscribe',
                onPressed: ctaCallback,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String getMinimumPrice({required String minimumprice}) {
  final data = double.tryParse(minimumprice)?.formatPrice();
  return data != null ? 'Starts @INR $data' : '';
}

class _ClinicImage extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final double borderRadius;
  final bool showPopularBadge;

  const _ClinicImage({
    required this.image,
    required this.width,
    required this.height,
    required this.borderRadius,
    this.showPopularBadge = false,
  });

  bool get _isNetworkImage {
    final uri = Uri.tryParse(image);
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        children: [
          SizedBox(
            width: width,
            height: height,
            child: _isNetworkImage
                ? CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,
                    placeholder: (BuildContext context, String url) =>
                        Container(color: const Color(0xFFF2F2F2)),
                    errorWidget: (BuildContext context, Object error, _) =>
                        _buildErrorState(),
                  )
                : Image.asset(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (
                          BuildContext context,
                          Object error,
                          StackTrace? stackTrace,
                        ) => _buildErrorState(),
                  ),
          ),
          if (showPopularBadge)
            Positioned(
              top: 8.h,
              left: 8.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 9.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: AppText.support('Popular', color: AppColors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Container(
      color: const Color(0xFFF2F2F2),
      alignment: Alignment.center,
      child: Icon(
        Icons.broken_image_outlined,
        size: 20.r,
        color: const Color(0xFF8F8F90),
      ),
    );
  }
}

class _ClinicInfo extends StatelessWidget {
  final String name;
  final String experience;
  final String location;

  const _ClinicInfo({
    required this.name,
    required this.experience,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.h4(name, color: const Color(0xFF404041)),
        SizedBox(height: 1.h),
        AppText.bodyS(
          experience,
          color: const Color(0xFF666667),
          fontSize: 10.sp,
        ),
        SizedBox(height: 6.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start, // 👈 key change
          children: [
            AppIcon(
              AppIcons.svg.generic.location,
              size: 13.r,
              color: const Color(0xFF7F7F80),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: AppText.h3(
                location,
                color: const Color(0xFF7F7F80),
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ClinicPriceCTA extends StatelessWidget {
  final String price;
  final String ctaText;
  final VoidCallback? onPressed;

  const _ClinicPriceCTA({
    required this.price,
    required this.ctaText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        AppText.h3(price, color: const Color(0xFFF28A07)),
        SizedBox(height: 15.h),
        AppButton(
          disableRippleEffect: true,
          removePadding: true,
          width: null,
          variant: AppButtonVariant.text,
          label: ctaText,
          size: AppButtonSize.small,
          height: 24.h,
          onPressed: onPressed,
          padding: EdgeInsets.zero,
          trailingSvgAsset: AppIcons.svg.generic.chevronRight,
        ),
      ],
    );
  }
}
