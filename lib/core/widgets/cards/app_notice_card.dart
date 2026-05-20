import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/widgets/bottom_sheet/invite_bottom_sheet/bullet_item.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class NoticeSectionModel {
  final String mainTitle;
  final List<String> pointers;

  const NoticeSectionModel({required this.mainTitle, required this.pointers});
}

class AppNoticeCard extends StatelessWidget {
  final String title;
  final List<NoticeSectionModel> sections;

  const AppNoticeCard({super.key, required this.title, required this.sections});

  static const Color _backgroundColor = Color(0xFFF6ECE6);
  static const Color _textColor = Color(0xff320E02);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.bodyM(title, color: _textColor),
          SizedBox(height: 4.h),
          ...sections.map((section) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.bodyS(
                  section.mainTitle,
                  color: _textColor,
                  maxLines: 2,
                ),
                ...section.pointers.map((pointer) => BulletItem(text: pointer)),
              ],
            );
          }),
        ],
      ),
    );
  }
}
