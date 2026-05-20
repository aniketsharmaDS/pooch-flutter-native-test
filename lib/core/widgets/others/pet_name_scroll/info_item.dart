import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class InfoItem extends StatelessWidget {
  final String label;
  final String value;
  final String icon;

  const InfoItem({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: AppSize.cs35.csw,
          height: AppSize.cs35.csh,
          alignment: Alignment.center,
          child: AppIcon(
            icon,
            width: AppSize.cs26.csw,
            height: AppSize.cs32.csh,
          ),
        ),
        SizedBox(width: AppSpacing.s6.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.bodyS(
                label,
                color: AppColors.p4_400,
                fontSize: AppFontSize.fs12,
              ),
              SizedBox(height: AppSpacing.s2.h),
              AppText.h3(
                value,
                maxLines: 2,
                color: AppColors.p4_800,
                fontSize: AppFontSize.fs14,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
