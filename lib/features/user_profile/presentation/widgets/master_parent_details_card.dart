import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/others/community/profile_avatar.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class MasterParentDetailsCard extends StatelessWidget {
  final String name;
  final String age;
  final String gender;
  final String email;
  final VoidCallback? onDeleteTap;
  final bool isDeleteLoading;
  final String profileImageUrl;

  const MasterParentDetailsCard({
    super.key,
    required this.name,
    required this.age,
    required this.gender,
    required this.email,
    this.onDeleteTap,
    this.isDeleteLoading = false,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: ProfileAvatar(networkImage: profileImageUrl, size: 90.w),
        ),
        const SizedBox(width: AppSpacing.s14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.h4(
                name,
                fontSize: AppFontSize.fs24,
                color: AppColors.p4_600,
              ),

              AppText.h4(
                age.isEmpty ? gender : '$age, $gender',
                fontSize: AppFontSize.fs14,
                color: AppColors.p4_600,
              ),
              const SizedBox(height: AppSpacing.s5),
              AppText.h4(
                email,
                fontSize: AppFontSize.fs14,
                color: AppColors.p4_600,
              ),
            ],
          ),
        ),
        AppCircleButton(
          shadowColor: AppColors.shadowSecodary,
          onTap: isDeleteLoading ? null : onDeleteTap,
          size: AppCircleButtonSize.large,
          icon: AppIcons.svg.generic.delete,
          iconSize: 16,
          bgColor: AppColors.background,
          isLoading: isDeleteLoading,
        ),
      ],
    );
  }
}
