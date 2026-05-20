import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/checkbox/app_checkbox.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/community/data/models/pet_shelter_model.dart';

class PetShelterListItemCard extends StatelessWidget {
  final PetShelterModel item;
  final bool isSelected;
  final ValueChanged<bool> onSelectionChanged;
  final VoidCallback onTap;

  const PetShelterListItemCard({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onSelectionChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppSpacing.s12.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.s12.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.s12.w,
            vertical: AppSpacing.s10.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSpacing.s12.r),
          ),
          child: SizedBox(
            height: AppSpacing.s70.h,
            child: Row(
              children: [
                // Checkbox
                AppCheckbox(
                  value: isSelected,
                  onChanged: (val) => onSelectionChanged(val ?? false),
                  size: AppSpacing.s16.r,
                  borderColor: AppColors.primary,
                  checkColor: Colors.white,
                  padding: EdgeInsets.zero,
                ),
                AppSpacing.s10.wBox,
                // Image
                _PetShelterImage(
                  image: '',
                  width: AppSpacing.s70.w,
                  height: AppSpacing.s70.h,
                  borderRadius: AppSpacing.s10.r,
                ),
                AppSpacing.s12.wBox,
                // Content
                Expanded(
                  child: _PetShelterContent(
                    name: item.shelterName,
                    // experience: clinic.experience,
                    experience: '20+ yrs experience',
                    location: item.address,
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

class _PetShelterImage extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final double borderRadius;

  const _PetShelterImage({
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
        size: AppSpacing.s20.r,
        color: const Color(0xFF8F8F90),
      ),
    );
  }
}

class _PetShelterContent extends StatelessWidget {
  final String name;
  final String experience;
  final String location;

  const _PetShelterContent({
    required this.name,
    required this.experience,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.h1(
          name,
          style: TextStyle(fontSize: AppFontSize.fs14),
          color: const Color(0xFF404041),
          maxLines: 1,
        ),
        AppSpacing.s1.hBox,
        AppText.support(
          experience,
          color: const Color(0xFF666667),
          fontSize: AppFontSize.fs10,
        ),
        AppSpacing.s4.hBox,
        Row(
          children: [
            AppIcon(
              AppIcons.svg.generic.location,
              size: AppSpacing.s10.r,
              color: const Color(0xFF7F7F80),
            ),
            AppSpacing.s2.wBox,
            Expanded(
              child: AppText.h3(
                location,
                color: const Color(0xFF7F7F80),
                fontSize: AppFontSize.fs10,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
