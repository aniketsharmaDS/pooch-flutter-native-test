import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/cards/app_wave_card.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/images/app_image_cached_widget.dart';
import 'package:poochcare/core/widgets/others/pet_name_scroll/name_scroller.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/home/presentation/widgets/score_card_widget.dart';
import 'package:poochcare/features/home/presentation/widgets/weekly_activity_card.dart';
import 'package:poochcare/features/user_profile/domain/models/user_pet.dart';

class HomePetsWaveCard extends StatelessWidget {
  const HomePetsWaveCard({
    super.key,
    required this.pets,
    required this.selectedPetId,
    this.healthScore = 0,
    this.nutritionScore = 0,
    this.weeklyActivityGoalsMet = '',
    this.onPetSelected,
    this.onEditTap,
    this.onDeleteTap,
    this.onAddTap,
  });

  final List<UserPet> pets;
  final String? selectedPetId;
  final double healthScore;
  final double nutritionScore;
  final String weeklyActivityGoalsMet;
  final ValueChanged<UserPet>? onPetSelected;
  final ValueChanged<UserPet>? onEditTap;
  final ValueChanged<UserPet>? onDeleteTap;
  final VoidCallback? onAddTap;

  UserPet? get _selectedPet {
    if (pets.isEmpty) return null;
    final id = selectedPetId ?? pets.first.id;
    return pets.firstWhere((p) => p.id == id, orElse: () => pets.first);
  }

  @override
  Widget build(BuildContext context) {
    final pet = _selectedPet;

    return AppWaveCard(
      isGlass: true,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.s6.w,
        vertical: AppSpacing.s18.h,
      ).copyWith(bottom: AppSpacing.s12.h),
      isElevated: true,
      notchHeight: AppSpacing.s32.h,
      backgroundColor: AppColors.transparent,
      notchWidth: AppSpacing.s100.w,
      actionWidget: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: AppSpacing.s8.w),
            child: AppCircleButton(
              size: AppCircleButtonSize.large,
              icon: AppIcons.svg.generic.plusSign,
              variant: AppCircleButtonVariant.secondary,
              iconSize: AppRadiusSize.r18.rr,
              iconColor: const Color(0xFF844F0F),
              onTap: onAddTap,
            ),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: AppSpacing.s3.w),
            child: AppText.h1('My pets', fontSize: AppFontSize.fs16),
          ),
          SizedBox(height: AppSpacing.s18.h),
          if (pets.isNotEmpty)
            NameScroller(
              items: pets
                  .map((p) => NameScrollerItem(id: p.id, name: p.name))
                  .toList(),
              selectedId: pet?.id,
              onSelected: (item) {
                final selected = pets.firstWhere(
                  (petItem) => petItem.id == item.id,
                  orElse: () => pets.first,
                );
                onPetSelected?.call(selected);
              },
            )
          else
            AppText.h1(
              'Pet not found',
              fontSize: AppFontSize.fs14,
              color: const Color(0xffD7BC97),
            ),
          SizedBox(height: AppSpacing.s10.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(18.r),
            child: Container(
              width: double.infinity,
              height: AppSize.cs180,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.p1_200, AppColors.background],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: (pet?.profilePicture ?? '').trim().isNotEmpty
                  ? AppImageCachedWidget(
                      width: double.infinity,
                      height: AppSize.cs180,
                      imageUrl: pet!.profilePicture!,
                    )
                  : Center(
                      child: AppIcon(
                        AppIcons.svg.generic.poochLogo,
                        width: 40.w,
                        height: 40.h,
                      ),
                    ),
            ),
          ),
          SizedBox(height: AppSpacing.s13.h),
          Row(
            children: [
              Expanded(
                child: ScoreCardWidget(
                  title: 'Health',
                  subtitle: 'Score',
                  score: healthScore,
                ),
              ),
              SizedBox(width: AppSpacing.s5.w),
              Expanded(
                child: ScoreCardWidget(
                  title: 'Nutrition',
                  subtitle: 'Score',
                  score: nutritionScore,
                ),
              ),
            ],
          ),

          SizedBox(height: AppSpacing.s13.h),
          WeeklyActivityCard(
            summaryText: weeklyActivityGoalsMet,
            days: [
              DayActivity(
                label: 'M',
                height: AppSize.cs60.csh,
                color: const Color(0xFFEE8031),
              ),
              DayActivity(
                label: 'T',
                height: AppSize.cs75.csh,
                color: const Color(0xFFF5C16B),
              ),
              DayActivity(
                label: 'W',
                height: AppSize.cs95.csh,
                color: const Color(0xFFF9D885),
              ),
            ],
          ),

          SizedBox(height: AppSpacing.s18.h),
        ],
      ),
    );
  }
}
