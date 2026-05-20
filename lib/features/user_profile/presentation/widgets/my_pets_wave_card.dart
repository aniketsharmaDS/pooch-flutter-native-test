import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/utils/validators.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/cards/app_wave_card.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/images/app_image_cached_widget.dart';
import 'package:poochcare/core/widgets/others/pet_name_scroll/info_item.dart';
import 'package:poochcare/core/widgets/others/pet_name_scroll/name_scroller.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/user_profile/domain/models/user_pet.dart';

class MyPetsWaveCard extends StatefulWidget {
  const MyPetsWaveCard({
    super.key,
    required this.pets,
    this.isDeleteInProgress = false,
    this.deletingPetId,
    this.onEditTap,
    this.onDeleteTap,
    this.onAddTap,
  });

  final List<UserPet> pets;
  final bool isDeleteInProgress;
  final String? deletingPetId;
  final ValueChanged<UserPet>? onEditTap;
  final ValueChanged<UserPet>? onDeleteTap;
  final VoidCallback? onAddTap;

  @override
  State<MyPetsWaveCard> createState() => _MyPetsWaveCardState();
}

class _MyPetsWaveCardState extends State<MyPetsWaveCard> {
  String? _selectedPetId;

  @override
  void didUpdateWidget(covariant MyPetsWaveCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.pets.isEmpty) {
      _selectedPetId = null;
      return;
    }

    final bool stillExists =
        _selectedPetId != null &&
        widget.pets.any((p) => p.id == _selectedPetId);
    if (!stillExists) {
      _selectedPetId = widget.pets.first.id;
    }
  }

  UserPet? get _selectedPet {
    if (widget.pets.isEmpty) return null;
    final id = _selectedPetId ?? widget.pets.first.id;
    return widget.pets.firstWhere(
      (p) => p.id == id,
      orElse: () => widget.pets.first,
    );
  }

  String _formatDob(String raw) {
    try {
      final dt = DateTime.parse(raw);
      const months = <String>[
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      final dd = dt.day.toString().padLeft(2, '0');
      final mm = months[dt.month - 1];
      final yy = (dt.year % 100).toString().padLeft(2, '0');
      return '$dd $mm $yy';
    } catch (_) {
      return raw;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pet = _selectedPet;
    final isSelectedPetDeleting =
        widget.isDeleteInProgress &&
        pet != null &&
        widget.deletingPetId == pet.id;

    return AppWaveCard(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.s6.w,
        vertical: AppSpacing.s18.h,
      ).copyWith(bottom: AppSpacing.s12.h),
      // notchHeight: 35,
      // notchWidth: 175,
      notchHeight: AppSpacing.s34.h,
      notchWidth: AppSpacing.s175.w,
      // variant: AppCardNotchVariant.topRight,
      actionWidget: Row(
        children: [
          if (widget.pets.isEmpty && widget.onAddTap != null)
            AppCircleButton(
              size: AppCircleButtonSize.large,
              icon: AppIcons.svg.generic.plusSign,
              iconSize: AppRadiusSize.r20.rr,
              bgColor: const Color(0xFFFFFEFD),
              onTap: widget.onAddTap,
              shadowColor: const Color(0xFFCB9B62).withValues(alpha: 0.4),
            )
          else ...[
            if (pet != null && pet.canDelete)
              AppCircleButton(
                size: AppCircleButtonSize.large,
                icon: AppIcons.svg.generic.delete,
                iconSize: AppRadiusSize.r20.rr,
                iconColor: AppColors.p4_300,
                bgColor: const Color(0xFFFFFEFD),
                onTap: isSelectedPetDeleting
                    ? null
                    : () {
                        widget.onDeleteTap?.call(pet);
                      },
                shadowColor: const Color(0xFFCB9B62).withValues(alpha: 0.4),
                isLoading: isSelectedPetDeleting,
              ),
            if (pet != null && pet.canEdit)
              AppCircleButton(
                size: AppCircleButtonSize.large,
                icon: AppIcons.svg.generic.edit,
                iconSize: AppRadiusSize.r20.rr,
                iconColor: AppColors.p4_300,
                bgColor: const Color(0xFFFFFEFD),
                onTap: () {
                  widget.onEditTap?.call(pet);
                },
                shadowColor: const Color(0xFFCB9B62).withValues(alpha: 0.4),
              ),
          ],
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
          if (widget.pets.isNotEmpty)
            NameScroller(
              items: widget.pets
                  .map((p) => NameScrollerItem(id: p.id, name: p.name))
                  .toList(),
              selectedId: pet?.id,
              onSelected: (item) {
                setState(() {
                  _selectedPetId = item.id;
                });
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
              // height: AppSpacing.s180.h,
              height: AppSize.cs180,
              // color: const Color(0xFFF6F0E6),
              // color: AppColors.background,
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.s20.w),
            child: Table(
              columnWidths: const {0: FlexColumnWidth(), 1: FlexColumnWidth()},
              children: [
                TableRow(
                  children: [
                    InfoItem(
                      label: 'Gender',
                      value: (pet?.gender ?? '').trim().isNotEmpty
                          ? Validators.capitalize(pet!.gender)
                          : '-',
                      icon: AppIcons.svg.generic.gender,
                    ),
                    InfoItem(
                      label: 'Size',
                      value: (pet?.size ?? '').trim().isNotEmpty
                          ? pet!.size!
                          : '-',
                      icon: AppIcons.svg.generic.paper,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    SizedBox(height: AppSpacing.s14.h), // spacing row
                    const SizedBox(),
                  ],
                ),
                TableRow(
                  children: [
                    InfoItem(
                      label: 'Birth date',
                      value: (pet?.dob ?? '').trim().isNotEmpty
                          ? _formatDob(pet!.dob)
                          : '-',
                      icon: AppIcons.svg.generic.birthdayCap,
                    ),
                    InfoItem(
                      label: 'Breed',
                      value: (pet?.breedName ?? '').trim().isNotEmpty
                          ? pet!.breedName!
                          : '-',
                      icon: AppIcons.svg.generic.dogCatGroup,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.s18.h),
        ],
      ),
    );
  }
}
