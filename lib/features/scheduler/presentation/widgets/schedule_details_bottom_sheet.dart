import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/scheduler/domain/ui_models/schedule_item_ui_model.dart';

class ScheduleDetailsBottomSheet {
  static Future<void> show({
    required BuildContext context,
    required DateTime date,
    required List<CalendarEventData<Object?>> events,
    ValueChanged<ScheduleItemUIModel>? onEdit,
    Future<void> Function(ScheduleItemUIModel item)? onDelete,
  }) async {
    final pageController = PageController();
    final currentIndex = ValueNotifier<int>(0);

    await AppBottomSheet.show<void>(
      context: context,
      title: '${date.day} ${_monthName(date.month)}, ${date.year}',
      backgroundColor: AppColors.primarybackground,
      showShadowAboveActions: true,
      content: StatefulBuilder(
        builder: (context, setModalState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),

                child: PageView.builder(
                  controller: pageController,
                  itemCount: events.length,
                  onPageChanged: (index) {
                    currentIndex.value = index;
                    setModalState(() {});
                  },
                  itemBuilder: (context, index) {
                    final event = events[index];

                    return Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: _EventCard(event: event),
                    );
                  },
                ),
              ),
              if (events.length > 1)
                Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(events.length, (index) {
                      final isActive = currentIndex.value == index;

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: EdgeInsets.symmetric(horizontal: 3.w),
                        width: isActive ? 18.w : 6.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.p1
                              : AppColors.black.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      );
                    }),
                  ),
                ),
            ],
          );
        },
      ),
      actions: [
        ValueListenableBuilder<int>(
          valueListenable: currentIndex,
          builder: (context, index, _) {
            final selectedItem = _selectedItem(events, index);
            if (selectedItem == null) {
              return const SizedBox.shrink();
            }

            final canEdit = onEdit != null && _canEdit(selectedItem);

            final deleteButton = AppButton(
              label: 'Delete',
              height: AppSize.cs48,
              backgroundColor: AppColors.s1_100,
              trailingIcon: AppIcon(
                AppIcons.svg.generic.delete,
                color: AppColors.white,
              ),
              onPressed: () async {
                final confirmed = await AppDialog.show<bool>(
                  icon: Lottie.asset(AppIcons.lottie.delete, repeat: false),
                  context: context,
                  title: 'Delete Schedule',
                  content:
                      'This action cannot be undone. Are you sure you want to delete this schedule?',
                  primaryLabel: 'Delete',
                  secondaryLabel: 'Cancel',
                  onPrimary: () async {
                    if (onDelete != null) {
                      await onDelete(selectedItem);
                    }
                    return true;
                  },
                );

                if (confirmed == true && context.mounted) {
                  Navigator.of(context).pop();
                }
              },
            );

            if (!canEdit) {
              return Row(children: [Expanded(child: deleteButton)]);
            }

            return Row(
              children: [
                Expanded(child: deleteButton),
                SizedBox(width: 12.w),
                Expanded(
                  child: AppButton(
                    label: 'Edit',
                    height: AppSize.cs48,
                    trailingIcon: AppIcon(
                      AppIcons.svg.generic.edit,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onEdit.call(selectedItem);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  static String _monthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return months[month];
  }

  static ScheduleItemUIModel? _selectedItem(
    List<CalendarEventData<Object?>> events,
    int index,
  ) {
    if (events.isEmpty) return null;

    final safeIndex = index.clamp(0, events.length - 1).toInt();
    final data = events[safeIndex].event;

    return data is ScheduleItemUIModel ? data : null;
  }

  static bool _canEdit(ScheduleItemUIModel item) {
    final now = DateTime.now();
    final type = item.type.toLowerCase();

    if (type == 'event') {
      final endDate = DateTime.tryParse(item.endDate);
      final endAt = endDate != null
          ? DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59)
          : item.startDateTime;

      return now.isBefore(endAt);
    }

    return now.isBefore(item.startDateTime);
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event});

  final CalendarEventData<Object?> event;

  @override
  Widget build(BuildContext context) {
    final data = event.event;

    if (data is! ScheduleItemUIModel) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: event.color.withValues(alpha: 0.18)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              children: [
                Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    color: event.color,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(child: AppText.h2(data.title)),
              ],
            ),

            /// CATEGORY
            if (data.taskCategory.isNotEmpty) ...[
              SizedBox(height: 16.h),
              _InfoTile(title: 'Category', value: data.taskCategory),
            ],

            /// TIME
            if (data.formattedTime.isNotEmpty) SizedBox(height: 16.h),
            _InfoTile(title: 'Time', value: data.formattedTime),

            /// PET TYPE
            if (data.petType.isNotEmpty) ...[
              SizedBox(height: 16.h),
              _InfoTile(title: 'Pet Name', value: data.petName),
            ],

            /// EVENT TYPE
            if (data.eventType.isNotEmpty) ...[
              SizedBox(height: 16.h),
              _InfoTile(title: 'Event Type', value: data.eventType),
            ],

            /// LOCATION
            if (data.location.isNotEmpty) ...[
              SizedBox(height: 16.h),
              _InfoTile(title: 'Location', value: data.location),
            ],

            /// NOTES
            if (data.notes.trim().isNotEmpty) ...[
              SizedBox(height: 20.h),

              AppText.support('Notes', color: AppColors.textSecondary),

              SizedBox(height: 6.h),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: AppColors.primarybackground,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: AppText.support(data.notes),
              ),
            ],
            // const _InfoTile(title: 'Duration', value: '1 Hour'),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.support(title, color: AppColors.textSecondary),
        SizedBox(height: 4.h),
        AppText.h3(value),
      ],
    );
  }
}
