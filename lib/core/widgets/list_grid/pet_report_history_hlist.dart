import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/list_items/medical_history_list_item_card.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class PetReportHistoryHlist extends StatefulWidget {
  final String title;
  final void Function(String symptom)? onTap;
  final void Function(String symptom)? onViewAllTap;
  final List<MedicalHistoryItem>? popularPets;

  const PetReportHistoryHlist({
    super.key,
    this.title = 'Recent Report & History',
    this.onTap,
    this.onViewAllTap,
    this.popularPets,
  });

  @override
  State<PetReportHistoryHlist> createState() => _PetReportHistoryHlistState();
}

class _PetReportHistoryHlistState extends State<PetReportHistoryHlist> {
  // ignore: avoid_redundant_argument_values
  final PageController _controller = PageController(viewportFraction: 1.0);

  int currentIndex = 0;

  List<MedicalHistoryItem> _defaultPets() {
    return [
      MedicalHistoryItem(
        type: ItemType.vaccination,
        title: 'Vaccination',
        data: MedicalData(
          recordId: 'record1',
          appointmentId: 'appointment1',
          title: 'Vaccination certificate',
          subtitle: 'Modern Vet clinic',
          dateTime: 'Nov 14th, 12:00 pm',
          documents: [],
        ),
      ),
      MedicalHistoryItem(
        type: ItemType.vaccination,
        title: 'Vaccination',
        data: MedicalData(
          recordId: 'record2',
          appointmentId: 'appointment2',
          title: 'Vaccination certificate',
          subtitle: 'Modern Vet clinic',
          dateTime: 'Nov 14th, 12:00 pm',
          documents: [],
        ),
      ),
      MedicalHistoryItem(
        type: ItemType.labReport,
        title: 'Lab Reports',
        data: MedicalData(
          recordId: 'record3',
          appointmentId: 'appointment3',
          title: 'CBC Report',
          subtitle: 'Zodiac lab',
          dateTime: 'Nov 14th, 12:00 pm',
          documents: [
            MedicalDocument(
              fileName: 'CBC_Report.pdf',
              fileSize: '256 KB',
              // localPath: 'testing/local/path/CBC_Report.pdf',
              onDownload: () async {
                await Future<dynamic>.delayed(const Duration(seconds: 1));
              },
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final popularPetsList = widget.popularPets ?? _defaultPets();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// HEADER
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppText.h2(widget.title, color: const Color(0XFF3F3C36)),
              ),
              AppButton(
                width: null,
                label: 'View All',
                size: AppButtonSize.xSmall,
                onPressed: () {
                  widget.onViewAllTap?.call(widget.title);
                },
                variant: AppButtonVariant.text,
                padding: EdgeInsets.only(right: 1.w, left: 10.w),
                trailingSvgAsset: AppIcons.svg.generic.chevronRight,
              ),
            ],
          ),
        ),

        SizedBox(height: 10.h),

        /// ✅ PAGE VIEW (SWIPE WORKS)
        SizedBox(
          height: 120.h, // VERY IMPORTANT
          child: PageView.builder(
            controller: _controller,
            itemCount: popularPetsList.length,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            itemBuilder: (context, index) {
              final item = popularPetsList[index];

              return Padding(
                padding: EdgeInsets.only(
                  right: 12.w, // 👈 SPACE BETWEEN CARDS
                ),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => widget.onTap?.call(item.title),
                  child: MedicalHistoryListItemCard(
                    viewType: ViewType.horizontal,
                    item: item,
                    onItemClick: () => widget.onTap?.call(item.title),
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 12.h),

        /// ✅ DOT INDICATOR
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(popularPetsList.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              height: 6.h,
              width: currentIndex == index ? 20.w : 6.w,
              decoration: BoxDecoration(
                color: currentIndex == index
                    ? const Color(0xFF4E342E)
                    : const Color(0xFF4E342E).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            );
          }),
        ),
      ],
    );
  }
}
