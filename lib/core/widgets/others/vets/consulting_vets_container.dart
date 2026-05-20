import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/widgets/bottom_sheet/vets/all_vets_bottom_sheet.dart';
import 'package:poochcare/core/widgets/headers/primary_widget_header.dart';
import 'package:poochcare/core/widgets/list_items/vet_speciality_item_card.dart';
import 'package:poochcare/features/insight/data/models/clinic_details_response_model.dart';

class ConsultingVetsContainer extends StatelessWidget {
  final List<VetApiModel> specialities;
  final String title;
  final VoidCallback? onViewAll;
  final ValueChanged<VetApiModel>? onSpecialityTap;

  const ConsultingVetsContainer({
    super.key,
    required this.specialities,
    this.title = 'Consulting Vets',
    this.onViewAll,
    this.onSpecialityTap,
  });

  @override
  Widget build(BuildContext context) {
    if (specialities.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: PrimaryWidgetHeader(
            removePadding: true,
            fontSize: AppFontSize.fs14,
            title: 'Consulting Vets',
            buttonTitle: 'View All',
            onButtonTap: () {
              _openViewAll(context);
            },
          ),
        ),
        SizedBox(height: 5.h),
        SizedBox(
          height: 60.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: 0.w,
              vertical: 5.h,
            ).copyWith(left: 13, right: 13),
            scrollDirection: Axis.horizontal,
            itemCount: specialities.length,
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(width: 7.w),
            itemBuilder: (context, index) {
              final speciality = specialities[index];
              return VetSpecialityItemCard(
                speciality: speciality,
                width: 155.w,
                onTap: onSpecialityTap == null
                    ? null
                    : () => onSpecialityTap!(speciality),
              );
            },
          ),
        ),
      ],
    );
  }

  void _openViewAll(BuildContext context) {
    AllVetsBottomSheet.show(
      context: context,
      specialities: specialities,
      onSpecialityTap: onSpecialityTap,
    );
  }
}
