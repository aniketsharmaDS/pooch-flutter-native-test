import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/utils/validators.dart';
import 'package:poochcare/core/widgets/appbar/pooch_app_bar.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/others/app_profile_avatar.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/user_profile/domain/models/user_profile.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({
    super.key,
    this.profile,
    this.onAvatarEditTap,
    this.onAddParentTap,
  });

  final UserProfile? profile;
  final VoidCallback? onAvatarEditTap;
  final VoidCallback? onAddParentTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: SizedBox(
        height: AppSize.cs260.h,
        width: MediaQuery.sizeOf(context).width,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            BackgroundImage(imageUrl: profile?.profilePicture),
            const BlurEffectWidget(),
            Positioned(
              right: -100,
              left: 0,
              bottom: 25,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.bodyM(
                      profile?.name ?? 'User Name',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                      fontSize: AppFontSize.fs24,
                      color: AppColors.white,
                    ),
                    AppSpacing.s4.hBox,
                    AppText.bodyM(
                      _buildContactText(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                      fontSize: AppFontSize.fs14,
                      color: const Color(0xFFE4E0D8),
                    ),
                    AppText.bodyM(
                      _buildAgeGenderText(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                      fontSize: AppFontSize.fs14,
                      color: const Color(0xFFE4E0D8),
                    ),
                    AppSpacing.s21.hBox,
                    AppButton(
                      onPressed: onAddParentTap,
                      size: AppButtonSize.extraSmall,
                      padding: EdgeInsets.zero,
                      variant: AppButtonVariant.text,
                      width: null,
                      foregroundColor: AppColors.white,
                      label: 'Add Another Parent',
                      trailingIcon: AppIcon(
                        AppIcons.svg.generic.plusSign,
                        size: 14.w,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -AppSpacing.s32.h,
              left: AppSpacing.s20.w,
              child: GestureDetector(
                onTap: onAvatarEditTap,
                child: AppProfileAvatar(
                  imageUrl: profile?.profilePicture.trim(),
                  actionIcon: AppIcons.svg.generic.edit,
                  actionSize: AppIconSize.is24,
                  onTapAvatar: onAvatarEditTap,
                  actionPosition: ActionPosition.rightCenter,
                ),
              ),
            ),
            const PoochAppBar(
              userName: '',
              glassEffect: true,
              welcomeText: 'Welcome 👋🏻',
              variant: PoochAppBarVariant.secondary,
            ),
          ],
        ),
      ),
    );
  }

  String _buildContactText() {
    if (profile == null) {
      return 'N/A';
    }

    final String email = profile?.email.trim() ?? '';
    if (email.isNotEmpty) {
      return email;
    }

    final String phone = profile?.phone.trim() ?? '';
    if (phone.isNotEmpty) {
      final String rawCountryCode = profile?.countryCode.trim() ?? '';
      final String countryCode = rawCountryCode.isEmpty
          ? ''
          : rawCountryCode.startsWith('+')
          ? rawCountryCode
          : '+$rawCountryCode';
      return countryCode.isNotEmpty ? '$countryCode $phone' : phone;
    }

    return 'N/A';
  }

  String _buildAgeGenderText() {
    if (profile == null) {
      return 'Age, Gender';
    }

    final String gender = (profile?.gender ?? '').trim().isEmpty
        ? 'Gender'
        : Validators.capitalize(profile!.gender);
    final String ageLabel = _buildAgeLabel(profile?.dateOfBirth);

    if (ageLabel.isEmpty) {
      return gender;
    }

    return '$ageLabel, $gender';
  }

  String _buildAgeLabel(String? rawDateOfBirth) {
    final DateTime? dob = _parseDateOfBirth(rawDateOfBirth);
    if (dob == null) {
      return '';
    }

    final DateTime now = DateTime.now();
    final bool hasBirthdayPassed =
        now.month > dob.month || (now.month == dob.month && now.day >= dob.day);
    final int years = now.year - dob.year - (hasBirthdayPassed ? 0 : 1);

    if (years > 0) {
      return '$years ${years == 1 ? 'yr' : 'yrs'}';
    }

    int months = (now.year - dob.year) * 12 + (now.month - dob.month);
    if (now.day < dob.day) {
      months -= 1;
    }

    if (months > 0) {
      return '$months ${months == 1 ? 'mo' : 'mos'}';
    }

    final int days = now.difference(dob).inDays;
    if (days <= 0) {
      return '0 d';
    }
    if (days < 7) {
      return '$days ${days == 1 ? 'd' : 'ds'}';
    }

    final int weeks = (days / 7).floor();
    return '$weeks ${weeks == 1 ? 'wk' : 'wks'}';
  }

  DateTime? _parseDateOfBirth(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      return null;
    }

    final String value = raw.trim();

    try {
      return DateTime.parse(value);
    } catch (_) {
      // Try dd/MM/yyyy or dd-MM-yyyy
      final RegExp pattern = RegExp(r'^(\d{2})[\/\-](\d{2})[\/\-](\d{4})$');
      final RegExpMatch? match = pattern.firstMatch(value);
      if (match == null) {
        return null;
      }

      final int day = int.tryParse(match.group(1) ?? '') ?? 0;
      final int month = int.tryParse(match.group(2) ?? '') ?? 0;
      final int year = int.tryParse(match.group(3) ?? '') ?? 0;
      if (day <= 0 || month <= 0 || year <= 0) return null;

      try {
        return DateTime(year, month, day);
      } catch (_) {
        return null;
      }
    }
  }
}

class BlurEffectWidget extends StatelessWidget {
  const BlurEffectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.only(
        bottomLeft: Radius.circular(100.r),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          height: 260.h,
          clipBehavior: Clip.hardEdge,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100.r)),
            color: Colors.black.withValues(alpha: 0.2),
          ),
        ),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key, this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final bool hasImage = imageUrl?.trim().isNotEmpty == true;
    final String path = hasImage
        ? imageUrl!.trim()
        : AppIcons.png.profile.userProfileBg;

    return Container(
      height: AppSize.cs260.h,
      clipBehavior: Clip.hardEdge,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100.r)),
        // color: Colors.grey.withValues(alpha: 0.2),
      ),
      child: AppIcon(path, fit: BoxFit.cover),
    );
  }
}
