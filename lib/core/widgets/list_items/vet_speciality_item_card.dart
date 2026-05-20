import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/insight/data/models/clinic_details_response_model.dart';

class VetSpecialityItemCard extends StatelessWidget {
  final VetApiModel speciality;
  final VoidCallback? onTap;
  final double? width;

  const VetSpecialityItemCard({
    super.key,
    required this.speciality,
    this.onTap,
    this.width,
  });

  String getSpecialistIcon({String specialization = 'general'}) {
    if (specialization.toLowerCase().contains('bone')) {
      return AppIcons.svg.specialist.bone;
    } else if (specialization.toLowerCase().contains('eye')) {
      return AppIcons.svg.specialist.eye;
    } else if (specialization.toLowerCase().contains('care')) {
      return AppIcons.svg.specialist.petCare;
    } else if (specialization.toLowerCase().contains('skin')) {
      return AppIcons.svg.specialist.skin;
    } else if (specialization.toLowerCase().contains('general')) {
      return AppIcons.svg.specialist.stethoscope;
    } else if (specialization.toLowerCase().contains('dental')) {
      return AppIcons.svg.specialist.tooth;
    } else {
      return AppIcons.svg.specialist.stethoscope;
    }
  }

  @override
  Widget build(BuildContext context) {
    final icon = getSpecialistIcon(
      specialization: speciality.specialization.isNotEmpty
          ? speciality.specialization.first
          : 'general',
    );
    final card = Container(
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 9.5.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9E9),
        borderRadius: BorderRadius.circular(56.r),
        border: Border.all(color: const Color(0xFFFFECBC), width: 1.w),
      ),
      child: Row(
        children: [
          Container(
            width: 31,
            height: 31,
            decoration: const BoxDecoration(
              color: Color(0xFFFFECBC),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: AppIcon(icon),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.displayXL(
                  speciality.specialization.first.toUpperCase(),
                  // variant: AppTextVariant.noEllipsis,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFF260B01),
                    height: 1.1,
                    overflow: TextOverflow.visible,
                  ),
                ),
                AppText.support('Exp. ${speciality.experienceYears}'),
              ],
            ),
          ),
        ],
      ),
    );

    if (onTap == null) {
      return SizedBox(width: width, child: card);
    }

    return SizedBox(
      width: width,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(56),
          child: card,
        ),
      ),
    );
  }
}
