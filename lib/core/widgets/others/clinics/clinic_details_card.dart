import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class ClinicDetailsCardModel {
  final String id;
  final String name;
  final String image;
  final String vetCount;
  final String experience;
  final String location;
  final String status;
  final String closingTime;
  final String? basePrice;

  const ClinicDetailsCardModel({
    required this.id,
    required this.name,
    required this.image,
    required this.vetCount,
    required this.experience,
    required this.location,
    required this.status,
    required this.closingTime,
    this.basePrice,
  });
}

class ClinicDetailsCard extends StatelessWidget {
  final ClinicDetailsCardModel clinic;
  final VoidCallback? onTap;
  final List<String> operatingSchedule;

  const ClinicDetailsCard({
    super.key,
    required this.operatingSchedule,
    required this.clinic,
    this.onTap,
  });

  bool get _isNetworkImage {
    final uri = Uri.tryParse(clinic.image);
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: SizedBox(
        width: 140.w,
        height: 140.w,
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
      height: 140.h,
      color: const Color(0xFFF2F2F2),
      alignment: Alignment.center,
      child: AppIcon(size: 20.r, AppIcons.svg.generic.poochTail),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// IMAGE
              _buildImage(),
              SizedBox(width: 16.w),

              /// CONTENT
              Expanded(
                child: Column(
                  children: [
                    /// CLINIC NAME
                    AppText.h1(
                      clinic.name,
                      color: const Color(0xFF404041),
                      fontSize: AppFontSize.fs16,
                      maxLines: 2,
                    ),
                    SizedBox(height: 10.h),

                    /// BULLET POINTS (VETS & EXPERIENCE)
                    _BulletPoint(
                      text: clinic.vetCount,
                      color: const Color(0xFF404041),
                    ),
                    _BulletPoint(
                      text: clinic.experience,
                      color: const Color(0xFF404041),
                    ),
                    SizedBox(height: 10.h),

                    /// LOCATION
                    Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          AppIcon(
                            AppIcons.svg.generic.location,
                            size: 10.r,
                            color: const Color(0xFF7F7F80),
                          ),
                          SizedBox(width: 2.w),
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
                    ),
                    SizedBox(height: 10.h),

                    Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          AppIcon(
                            AppIcons.svg.generic.clock,
                            size: 10.r,
                            color: const Color(0xFF7F7F80),
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: Row(
                              children: [
                                AppText.h3(
                                  clinic.status,
                                  color: clinic.status == 'open'
                                      ? AppColors.messageSuccess
                                      : AppColors.textFieldErrorText,
                                  fontSize: 10.sp,
                                  maxLines: 1,
                                ),
                                MenuAnchor(
                                  reservedPadding: EdgeInsets.zero,

                                  builder: (context, controller, child) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (controller.isOpen) {
                                          controller.close();
                                        } else {
                                          controller.open();
                                        }
                                      },
                                      child: AppText.h3(
                                        ' . Close at ${clinic.closingTime}',
                                        color: const Color(0xFF7F7F80),
                                        fontSize: 10.sp,
                                        maxLines: 1,
                                      ),
                                    );
                                  },
                                  menuChildren: List.generate(
                                    operatingSchedule.length,
                                    (index) {
                                      return MenuItemButton(
                                        onPressed: () {},
                                        child: AppText.bodyS(
                                          operatingSchedule[index],
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                SizedBox(width: 8.w),
                                AppIcon(
                                  AppIcons.svg.generic.chevronDown,
                                  size: 10.r,
                                  color: const Color(0xFF343330),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;
  final Color color;

  const _BulletPoint({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '•',
          style: TextStyle(
            fontSize: 10.sp,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: AppText.bodyS(
            text,
            color: color,
            fontSize: AppFontSize.fs12,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
