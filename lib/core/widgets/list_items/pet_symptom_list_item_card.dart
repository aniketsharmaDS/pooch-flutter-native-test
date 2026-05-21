import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/insight/data/models/symptom_response.dart';

class PoochSymptomListItem {
  final String title;
  final String image;

  const PoochSymptomListItem({required this.title, required this.image});
}

class PetSymptomListItemCard extends StatelessWidget {
  final PoochSymptomListItem item;
  final SymptomType symptomsData;
  final void Function(SymptomType symptom)? onTap;

  const PetSymptomListItemCard({
    super.key,
    required this.item,
    this.onTap,
    required this.symptomsData,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap == null ? null : () => onTap!(symptomsData),
        borderRadius: BorderRadius.circular(10.r),
        child: Ink(
          width: 141.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            gradient: const LinearGradient(
              colors: [Color(0xFFF4DA9C), Color(0xFFE9C46F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Column(
              children: [
                SizedBox(
                  height: 180.h,
                  width: double.infinity,
                  child: AppIcon(symptomsData.imageUrl, fit: BoxFit.cover),
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 8.h,
                      ),
                      child: AppText.h4(
                        symptomsData.title,
                        color: AppColors.textSecondary,
                      ),

                      // Text(
                      //   item.title,
                      //   textAlign: TextAlign.center,
                      //   maxLines: 1,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: TextStyle(
                      //     fontSize: 14.sp,
                      //     // fontFamily: Fonts.gilroySemibold,
                      //     color: const Color(0xFF1B1B1B),
                      //   ),
                      // ),
                    ),
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
