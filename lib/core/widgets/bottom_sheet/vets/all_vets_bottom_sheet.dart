import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poochcare/core/widgets/list_items/vet_speciality_item_card.dart';
import 'package:poochcare/features/insight/data/models/clinic_details_response_model.dart';

class AllVetsBottomSheet extends StatelessWidget {
  final List<VetApiModel> specialities;
  final ValueChanged<VetApiModel>? onSpecialityTap;

  const AllVetsBottomSheet({
    super.key,
    required this.specialities,
    this.onSpecialityTap,
  });

  static Future<void> show({
    required BuildContext context,
    required List<VetApiModel> specialities,
    ValueChanged<VetApiModel>? onSpecialityTap,
  }) {
    return AppBottomSheet.show<void>(
      context: context,
      title: 'All Doctors',
      content: AllVetsBottomSheet(
        specialities: specialities,
        onSpecialityTap: onSpecialityTap,
      ),
      actions: const [],
      backgroundColor: const Color(0xFFFEF3E6),
      borderRadius: 24.r,
      contentPadding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
    ).then((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66CB9B62),
            offset: Offset(0, 2),
            blurRadius: 17,
            // spreadRadius: 0,
          ),
        ],
      ),
      child: GridView.builder(
        itemCount: specialities.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          mainAxisExtent: 50,
        ),
        itemBuilder: (context, index) {
          final speciality = specialities[index];
          return VetSpecialityItemCard(
            speciality: speciality,
            onTap: onSpecialityTap == null
                ? null
                : () => onSpecialityTap!(speciality),
          );
        },
      ),
    );
  }
}
