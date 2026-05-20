import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/list_items/pet_symptom_list_item_card.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class PoochSymptomsList extends StatelessWidget {
  final String title;
  final void Function(String symptom)? onTap;
  final List<PoochSymptomListItem>? symptoms;

  const PoochSymptomsList({
    super.key,
    this.title = 'Report Pooch symptoms',
    this.onTap,
    this.symptoms,
  });

  List<PoochSymptomListItem> _defaultSymptoms() {
    return [
      PoochSymptomListItem(
        title: 'Low Appetite',
        image: AppIcons.png.symptoms.lowAppetite,
      ),
      PoochSymptomListItem(
        title: 'Low Energy',
        image: AppIcons.png.symptoms.lowEnergy,
      ),
      PoochSymptomListItem(
        title: 'Dental Issue',
        image: AppIcons.png.symptoms.dentalIssue,
      ),
      PoochSymptomListItem(title: 'Fever', image: AppIcons.png.symptoms.fever),
      PoochSymptomListItem(
        title: 'Stomach Issue',
        image: AppIcons.png.symptoms.stomachIssue,
      ),
      PoochSymptomListItem(
        title: 'Shivering',
        image: AppIcons.png.symptoms.shivering,
      ),
      PoochSymptomListItem(
        title: 'Drinking Changes',
        image: AppIcons.png.symptoms.drinkingChanges,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final sectionSymptoms = symptoms ?? _defaultSymptoms();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: AppText.h2(title, color: const Color(0XFF3F3C36)),
        ),
        SizedBox(height: 15.h),
        SizedBox(
          height: 215.h,
          child: ListView.separated(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            scrollDirection: Axis.horizontal,
            itemCount: sectionSymptoms.length,
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(width: 12.w),
            itemBuilder: (BuildContext context, int index) {
              final item = sectionSymptoms[index];
              return PetSymptomListItemCard(item: item, onTap: onTap);
            },
          ),
        ),
      ],
    );
  }
}
