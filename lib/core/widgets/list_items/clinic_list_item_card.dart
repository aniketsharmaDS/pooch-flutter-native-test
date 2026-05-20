import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class ClinicListItemModel {
  final String clinicName;
  final String? image;
  final int? vetCount;
  final int? years;
  final String? minConsultationFree;
  final String? city;
  final String id;
  final String clinicId;
  final String petId;
  final String planId;
  final String subscriptionId;

  ClinicListItemModel({
    this.image = '',
    this.vetCount = 1,
    this.years = 1,
    this.minConsultationFree,
    this.city,
    required this.clinicName,
    required this.id,
    required this.clinicId,
    required this.petId,
    required this.planId,
    required this.subscriptionId,
  });

  // The toJson method
  Map<String, dynamic> toJson() {
    return {
      'clinic_name': clinicName,
      'image': image,
      'vet_count': vetCount,
      'years': years,
      'min_consultation_free': minConsultationFree,
      'city': city,
      'id': id,
      'pet_id': petId,
    };
  }
}

class ClinicListItemCard extends StatelessWidget {
  final ClinicListItemModel clinic;
  final VoidCallback? onTap;
  final VoidCallback? onBookNow;

  const ClinicListItemCard({
    super.key,
    required this.clinic,
    this.onTap,
    this.onBookNow,
  });

  @override
  Widget build(BuildContext context) {
    final ctaCallback = onBookNow ?? onTap;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: SizedBox(
            height: 70.h,
            child: Row(
              children: [
                _ClinicImage(
                  image: clinic.image ?? '',
                  width: 70.w,
                  height: 70.h,
                  borderRadius: 10.r,
                ),
                SizedBox(width: 11.w),
                Expanded(
                  child: _ClinicContent(
                    name: clinic.clinicName,
                    experience:
                        '${clinic.vetCount} Vets, ${(clinic.years ?? 0).toInt() > 0 ? (clinic.years ?? 0).toInt() : ''} yrs',
                    location: clinic.city ?? '',
                    price: clinic.minConsultationFree ?? '',
                    onPressed: ctaCallback,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ClinicImage extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final double borderRadius;

  const _ClinicImage({
    required this.image,
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  bool get _isNetworkImage {
    final uri = Uri.tryParse(image);
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
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

class _ClinicContent extends StatelessWidget {
  final String name;
  final String experience;
  final String location;
  final String price;
  final VoidCallback? onPressed;

  const _ClinicContent({
    required this.name,
    required this.experience,
    required this.location,
    required this.price,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.h1(
                    name,
                    maxLines: 2,
                    fontSize: AppFontSize.fs14,
                    style: const TextStyle(height: 1.1),
                  ),
                  AppText.bodyS(
                    experience,
                    color: const Color(0xFF666667),
                    fontSize: 10.sp,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            AppText.h4(price, color: const Color(0xFFF28A07), fontSize: 14.sp),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            AppButton(
              width: null,
              variant: AppButtonVariant.text,
              label: 'Book Now',
              size: AppButtonSize.small,
              height: 22.h,
              onPressed: onPressed,
              padding: EdgeInsets.only(
                left: 10.w,
                right: 5.w,
                top: 0.h,
                bottom: 0.h,
              ),
              trailingSvgAsset: AppIcons.svg.generic.chevronRight,
            ),
          ],
        ),
      ],
    );
  }
}
