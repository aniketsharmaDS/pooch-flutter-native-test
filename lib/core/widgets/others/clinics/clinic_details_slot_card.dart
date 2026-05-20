import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/theme/app_typography.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/others/clinics/clinic_details_card.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class ClinicDetailsSlotCard extends StatelessWidget {
  final ClinicDetailsCardModel clinic;
  final VoidCallback? onTap;

  const ClinicDetailsSlotCard({super.key, required this.clinic, this.onTap});

  bool get _isNetworkImage {
    final uri = Uri.tryParse(clinic.image);
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: SizedBox(
        width: AppSize.cs70.csw,
        height: AppSize.cs70.csw,
        child: _isNetworkImage
            ? CachedNetworkImage(
                imageUrl: clinic.image,
                fit: BoxFit.cover,
                placeholder: (BuildContext context, String url) =>
                    Container(color: const Color(0xFFF2F2F2)),
                errorWidget: (BuildContext context, Object error, _) =>
                    _buildErrorState(),
              )
            : Image.asset(
                clinic.image,
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
      width: AppSize.cs70.csw,
      height: AppSize.cs70.csw,
      color: const Color(0xFFF2F2F2),
      alignment: Alignment.center,
      child: AppIcon(size: 20.r, AppIcons.svg.generic.poochTail),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white_50,
      borderRadius: BorderRadius.circular(AppRadiusSize.r16.rr),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadiusSize.r16.rr),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white_50,
            borderRadius: BorderRadius.circular(AppRadiusSize.r16.rr),
          ),
          child: Row(
            crossAxisAlignment: clinic.status.isNotEmpty
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              _buildImage(),
              SizedBox(width: AppSpacing.s11.w),
              Expanded(
                child: SizedBox(
                  height: clinic.status.isNotEmpty
                      ? AppSize.cs74.csh
                      : AppSize.cs56.csh,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.h1(
                        clinic.name,
                        color: AppColors.p5,
                        fontSize: AppFontSize.fs16,
                        maxLines: 2,
                      ),
                      if (clinic.status.isNotEmpty) ...[
                        SizedBox(height: AppSpacing.s4.h),
                      ],
                      Row(
                        children: [
                          AppIcon(
                            AppIcons.svg.generic.location,
                            size: AppRadiusSize.r10.rr,
                            color: const Color(0xFF7F7F80),
                          ),
                          SizedBox(width: AppSpacing.s2.w),
                          Expanded(
                            child: AppText.h3(
                              clinic.location,
                              color: const Color(0xFF7F7F80),
                              fontSize: AppFontSize.fs10,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      if (clinic.status.isNotEmpty) ...[
                        SizedBox(height: AppSpacing.s2.h),
                        Expanded(
                          child: Row(
                            children: [
                              AppIcon(
                                AppIcons.svg.generic.clock,
                                size: AppRadiusSize.r10.rr,
                                color: const Color(0xFF7F7F80),
                              ),
                              SizedBox(width: AppSpacing.s2.w),
                              Flexible(
                                child: RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: clinic.status,
                                        style: AppTypography.h3.copyWith(
                                          color: AppColors.messageSuccess,
                                          fontSize: AppFontSize.fs10,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' • Close at ${clinic.closingTime}',
                                        style: AppTypography.h3.copyWith(
                                          color: const Color(0xFF7F7F80),
                                          fontSize: AppFontSize.fs10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: AppSpacing.s4.w),
                              AppIcon(
                                AppIcons.svg.generic.chevronDown,
                                size: AppRadiusSize.r10.rr,
                                color: const Color(0xFF343330),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              if (clinic.basePrice != null && clinic.basePrice!.isNotEmpty) ...[
                SizedBox(
                  height: AppSize.cs74.csh,
                  child: AppText.h1(
                    textAlign: TextAlign.start,
                    'Clinic visit\n Starts @${clinic.basePrice}',
                    color: AppColors.p2,
                    fontSize: AppFontSize.fs13,
                    maxLines: 3,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
