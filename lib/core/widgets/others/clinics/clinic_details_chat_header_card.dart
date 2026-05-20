import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/others/clinics/clinic_details_card.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class ClinicDetailsChatHeaderCard extends StatelessWidget {
  final ClinicDetailsCardModel clinic;
  final VoidCallback? onCardTap;
  final VoidCallback? onVideoCallTap;
  final VoidCallback? onAudioCallTap;
  final bool enableVideoCall;

  const ClinicDetailsChatHeaderCard({
    super.key,
    required this.clinic,
    this.onCardTap,
    this.onVideoCallTap,
    this.onAudioCallTap,
    this.enableVideoCall = false,
  });

  bool get _isNetworkImage {
    final uri = Uri.tryParse(clinic.image);
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: SizedBox(
        width: AppSize.cs45.csw,
        height: AppSize.cs45.csw,
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
      width: AppSize.cs45.csw,
      height: AppSize.cs45.csw,
      color: const Color(0xFFF2F2F2),
      alignment: Alignment.center,
      child: AppIcon(size: 20.r, AppIcons.svg.generic.poochTail),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      borderRadius: BorderRadius.circular(AppRadiusSize.r16.rr),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadiusSize.r16.rr),
        onTap: onCardTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.transparent,
            borderRadius: BorderRadius.circular(AppRadiusSize.r16.rr),
          ),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildImage(),
              SizedBox(width: AppSpacing.s6.w),
              Expanded(
                child: SizedBox(
                  height: AppSize.cs45.csw,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: AppSpacing.s1.h),
                      AppText.h1(
                        clinic.name,
                        color: AppColors.p5,
                        fontSize: AppFontSize.fs16,
                        maxLines: 1,
                      ),
                      SizedBox(height: AppSpacing.s2.h),
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
                      SizedBox(height: AppSpacing.s1.h),
                    ],
                  ),
                ),
              ),
              SizedBox(width: AppSpacing.s6.w),
              if (enableVideoCall) ...[
                AppCircleButton(
                  visualSize: AppRadiusSize.r36.rr,
                  iconSize: AppRadiusSize.r16.rr,
                  onTap: onVideoCallTap,
                  bgColor: AppColors.white_50,
                  icon: AppIcons.svg.generic.videoCamera,
                  borderRadius: AppRadiusSize.r12.rr,
                ),
                AppCircleButton(
                  visualSize: AppRadiusSize.r36.rr,
                  iconSize: AppRadiusSize.r16.rr,
                  onTap: onAudioCallTap,
                  bgColor: AppColors.white_50,
                  icon: AppIcons.svg.generic.callPhone,
                  borderRadius: AppRadiusSize.r12.rr,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
